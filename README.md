# lasso-redis — Redis Client for Lasso 9

```lasso
redis->set('hello','world')
redis->get('hello')
// world
```

By default the client will use 127.0.0.1:6379 — you can specify connection details like so:

```lasso
redis('10.0.0.1',6379,'MegaPassword')
```

And for convenience create a handler:

```lasso
define redis_01 => redis('10.0.0.1',6379)
```

Connections
===========

Client connections are automatically reused on a thread level — all connections will be automatically closed at the end of the web request. Use `->close` to close a connection manually or `redis_close_connections` to close all connections.

To force a new connection use `redis_client` like so:

```lasso
local(redis) = redis_client('10.0.0.1',6379)
#redis->ping
#redis->close 
```

Connections can be closed automatically if invoked with a capture like so:

```lasso
redis => {
	#1->set('hello','world')
}
```

Commands
========
As of December 2015 the full set of commands for Redis 3.0.6 are supported. See [redis.io/commands](http://redis.io/commands) for a complete reference. The signatures and descriptions are also available here: [redis.commands.lasso](./redis.commands.lasso)

Unsupported commands can be made like so:

```lasso
redis->call('NEWCOMMAND','key','value',3)
```

Pipelining
==========

You can pipeline requests like so:

```lasso 
// Pipe results to second capture
redis->pipeline => {
	#1->ping
	#1->ping
	#1->ping
} = {
	#1
	#2
	#3
} 
```

```lasso 
// Return piped results
local(results) = redis->pipeline => {
					#1->ping
					#1->ping
					#1->ping
			 	 }
```


Pubsub
======
Write description here.

```lasso 
// Subscribe to channels
local(redis) = redis 

#redis->subscribe('thisChannel') => {
    stdoutnl('this channel received: ' + #1)
}

// Send an example message
split_thread => {
	sleep(500)
	redis->publish('thisChannel','Hello!')
}

// Listen for 1 response
#redis->listen(1)
```

```lasso
// Listen indefinitely (blocks current Lasso thread)
#redis->listen 
```

```lasso
// Bind a capture to listen to all messages received by client (in addition to any subscribe captures)
#redis->listen => {
    local(
        msg     = #1,
        channel = #2
    )

    stdoutnl('Channel ' + #2 + ' received: ' + #1)
}
```

Connected clients can be gracefully disconnected with a __CLOSE_CONNECTION__ message (open for discussion).

```lasso
// Close clients listening to thisChannel
redis->publish('thisChannel','__CLOSE_CONNECTION__')
```

Redis Pipe (non-blocking)
=========================
Write description here.

```lasso
// This is non-blocking
local(pipe) = redis_pipe => redis->subscribe('example') => {
                                stdoutnl('PIPED: ' + #1)
                            }

// Example messages
split_thread => {
    sleep(500)
    local(r) = redis
    #r->publish('example','Hello 1') 
    #r->publish('example','Hello 2') 
    #r->publish('example','Hello 3') 
    #r->publish('example','Hello 4') 
    #r->publish('example','Hello 5') 
    #r->close
}

// Poll the pipe for messages
loop(10) => {^
  sleep(100)
  #pipe->tryread '\n' 
^}

// Do some more stuff

// Close the pipe
#pipe->close
```

```lasso
// Each pipe has an UUID
#pipe->id + '\n'

// All pipes are stored in 
redis_pipes 

// All open pipes can be closed with 
close_redis_pipes
```

Installation
============
Place zip file in your LassoApps folder and restart Lasso / the instance.

