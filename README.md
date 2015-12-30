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

Client connections are automatically reused on a thread level — all connections will automatically closed at the end of the web request. Use `->close` to close a connection manually or `redis_close_connections` to close all connections.

To force a new connection use `redis_client` like so:

```lasso
local(redis) = redis_client('10.0.0.1',6379)
#redis->echo
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
As of December 2015 the full set of commands for Redis 3.0.6 are supported. The signatures and descriptions	avilable here: [redis.commands.lasso](./redis.commands.lasso)

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
	#1->echo
	#1->echo
	#1->echo
} = {
	#1
	#2
	#3
} 
```

```lasso 
// Return piped results
local(results) = redis->pipeline => {
					#1->echo
					#1->echo
					#1->echo
			 	 }
```


Pubsub
======






