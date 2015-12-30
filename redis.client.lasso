<?lasso
/////////////////////////////////////////////////////////
//
//	Redis client cache
//
/////////////////////////////////////////////////////////

define redis(host::string = '127.0.0.1', port::integer = 6379, password::string = '') => {
	// Check client cache
	local(redis) := redis_clients->find(#host + ':' + #port) ? return #redis

	// Otherwise create new client
	#redis = redis_client(#host,#port,#password)

	// Store in cache
	redis_clients->insert(#host + ':' + #port = #redis)	

	// Return client
	return #redis

}

/////////////////////////////////////////////////////////
//
//	Redis client type
//
/////////////////////////////////////////////////////////

define redis_client => type {

	data 
		public host,
		public port,
		private pipe,
		private subscribed,
		private net
	
	public oncreate(host::string = '127.0.0.1', port::integer = 6379, password::string = '') => {

		// Set host and port
		.host = #host
		.port = #port

		// Auth when password
		#password ? .AUTH(#password)

		// Store connections for closure
		web_request ? redis_connections->insert(self)

		// Invoke and close when block 
		givenblock ? .dowithclose(givenblock)

	}

	public net => {
		.'net' ? return .'net'

		local(net) = net_tcp

		// Open connection
		#net->connect(.host,.port,1)
		? return .'net' := #net
		| fail(-1,'Unable to connect to Redis on ' + .host + ':' + .port) 

	}

	// Collate params
	public call(command::string, ...rest) => .call(#command,#rest || staticarray)

	public call(command::string, params::staticarray) => {

		// Commands to send
		local(
			cmds = #command->split(' '),
			gb   = givenblock,
			result
		) 

		// Deal with pub/sub
		.subscribed && (:'SUBSCRIBE', 'PSUBSCRIBE', 'UNSUBSCRIBE', 'PUNSUBSCRIBE') !>> #command
		? fail(-1, 'Once subscribed only the following commands can be called: SUBSCRIBE, PSUBSCRIBE, UNSUBSCRIBE and PUNSUBSCRIBE')


		.subscribed ? #gb = .subscriptions->find(params->first)

		// Process params
		with p in #params do {

			match(#p->type) => {
				case(::keyword,::pair)
					// Convert keywords / pairs to params
					if(#p->value->isa(::void)) => {
						// Do nothing
					else(#p->value->isa(::boolean))
						// Upper case flags and replace underscores with dashes
						#p->value ? #cmds->insert(#p->name->uppercase & replace('_','-') & )
					else 
						#cmds->insert(#p->name->asstring)
						#cmds->insert(#p->value->asstring)
					}
				case
					// all opts are sent to server as strings
					#cmds->insert(#p->asstring)
			}
		}

		handle_error => protect => {
			debug('error' = #cmds)
		}

		// Issue command
		.write(#cmds)

		! .pipe
		? return (
			// If capture supplied invoke and return it
			#gb ? #gb(.result) | .result
		) 
	}


	public write(p::array)  => .write(resp_encode(#p))
	public write(p::string) => .write(#p->asbytes)
	public write(p::bytes)  => .net->writebytes(#p)

	public read => {
		local(
			out = bytes,
			i = 0
		)

		while(!#out->endswith('\r\n')) => {
			#out->append(
				.net->readSomeBytes(1024 * 1024,1)
			)
		}
		return #out 
	}


	public close => if(.'net') => {
		.'net'->close 
		.'net' = null 
	}
	public dowithclose => {
		givenblock->invoke(self)
		.close
	}

	public result  => resp_decode(.read->asstring)
	public results => {
		local(result) = .result
		
		return (
			// Always return a static array (even if 1x result)
			#result->isa(::staticarray) 
			? #result 
			| (:#result)
		)
	}
	
	public unsub(command::string,keys::staticarray) => {
		.pipeline => {
			with key in #keys 
			where #key
			do {
				.subscriptions->remove(#key)
				.call(#command,#key)
			}

			! .subscriptions->size
			? .subscribed = false 
		}
	}

	public sub(command::string,keys::staticarray) => {
		local(gb) = givenblock
		#gb->isnota(::capture) ? fail(-1, #command + ' requires capture as the => givenblock, this will receive the message')

		.subscribed = true 

		.pipeline => {
			with key in #keys 
			where #key
			do {
				.subscriptions->insert(#key = #gb)
				.call(#command,#key)
			}
		}
	}

	public pipeline=(p::capture) => .pipeline => pair(givenblock = #p)

	public pipeline => {
		local(
			results,
			p = givenblock
		)

		// Call back is not a requirement
		#p->isa(::capture) ? #p = pair(#p = void)

		#p->isnota(::pair) 
		? fail(-1,'givenblock must be a capture, or pair of captures, received ' + #p->type)

		#p->first->isnota(::capture) 
		? fail(-1,'givenblock must be a capture, or pair of captures, first value was a ' + #p->type)

		#p->second && #p->second->isnota(::capture) 
		? fail(-1,'givenblock must be a capture, or a pair of captures, second value was a ' + #p->type)

		// Flag that we're piping
		.pipe = true 
		handle => { .pipe = false }

		// Make calls
		#p->first->invoke(self)

		// Grab results
		#results = .results 

		#p->second 
		? return #p->second->invoke(:#results) 
		| return #results  

	}
}
// 
define redis_clients => {
	if(var(__redis__clients__)->isnota(::map)) => {
		$__redis__clients__ = map
	} 
	return $__redis__clients__
}

define redis_connections => {
	if(var(__redis__connections__)->isnota(::array)) => {
		$__redis__connections__ = array

		// Queue closure of connections
		web_request ? define_atend({redis_close_connections})
	} 
	return $__redis__connections__
}

define redis_close_connections => redis_connections->foreach => { #1->close }




?>
