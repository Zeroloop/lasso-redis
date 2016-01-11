<?lasso
      
// Stop listening for messages posted to the given channels
define redis_client->unsubscribe()   
	=> .unsub('UNSUBSCRIBE', params)
	=> givenblock

define redis_client->unsubscribe(channel, ...channels) 
	=> .unsub('UNSUBSCRIBE', params) 
	=> givenblock

// Listen for messages published to the given channels
define redis_client->subscribe(channel, ...channels) 
	=> .sub('SUBSCRIBE', params)
	=> givenblock

// Listen for messages published to channels matching the given patterns
define redis_client->psubscribe(pattern, ...) 
	=> .sub('PSUBSCRIBE', params)
	=> givenblock

// Stop listening for messages posted to channels matching the given patterns
define redis_client->punsubscribe(pattern, ...) 
	=> .unsub('PUNSUBSCRIBE', params)
	=> givenblock
 
// Append a value to a key
define redis_client->append(key, value) 
	=> .call('APPEND', params)
	=> givenblock

// Authenticate to the server
define redis_client->auth(password) 
	=> .call('AUTH', params)
	=> givenblock

// Asynchronously rewrite the append-only file
define redis_client->bgrewriteaof() 
	=> .call('BGREWRITEAOF', params)
	=> givenblock

// Asynchronously save the dataset to disk
define redis_client->bgsave() 
	=> .call('BGSAVE', params)
	=> givenblock

// Count set bits in a string
define redis_client->bitcount(key)                             
	=> .call('BITCOUNT', params)
	=> givenblock

define redis_client->bitcount(key, start::integer, end::integer) 
	=> .call('BITCOUNT', params)
	=> givenblock

// Perform bitwise operations between strings
define redis_client->bitop(operation, destkey, key, ...keys) 
	=> .call('BITOP', params)
	=> givenblock

// Find first bit set or clear in a string
define redis_client->bitpos(key, bit::integer)                
	=> .call('BITPOS', params)
	=> givenblock

define redis_client->bitpos(key, start::integer, end::integer) 
	=> .call('BITPOS', params)
	=> givenblock

// Remove and get the first element in a list, or block until one is available
define redis_client->blpop(key::string, ...timeout) 
	=> .call('BLPOP', params)
	=> givenblock

// Remove and get the last element in a list, or block until one is available
define redis_client->brpop(key::string, ...timeout) 
	=> .call('BRPOP', params)
	=> givenblock

// Pop a value from a list, push it to another list and return it; or block until one is available
define redis_client->brpoplpush(source, destination, timeout::integer) 
	=> .call('BRPOPLPUSH', params)
	=> givenblock

// Kill the connection of a client
define redis_client->client_kill(ip::string, port::integer) 
	=> .call('CLIENT KILL',#ip + ':' + #port)
	=> givenblock
          
define redis_client->client_kill(-id = '', -type = '',-addr = '', -skipme::boolean = true) 
	=> .call('CLIENT KILL', params)
	=> givenblock  

// Get the list of client connections
define redis_client->client_list() 
	=> .call('CLIENT LIST', params)
	=> givenblock

// Get the current connection name
define redis_client->client_getname() 
	=> .call('CLIENT GETNAME', params)
	=> givenblock

// Stop processing commands from clients for some time
define redis_client->client_pause(timeout::integer) 
	=> .call('CLIENT PAUSE', params)
	=> givenblock

// Set the current connection name
define redis_client->client_setname(connectionname::string) 
	=> .call('CLIENT SETNAME', params)
	=> givenblock

// Assign new hash slots to receiving node
define redis_client->cluster_addslots(slot, ...slots) 
	=> .call('CLUSTER ADDSLOTS', params)
	=> givenblock

// Return the number of failure reports active for a given node
define redis_client->cluster_count(nodeid) 
	=> .call('CLUSTER COUNT', params)
	=> givenblock

define redis_client->cluster_count(FAILURE_REPORTS::keyword, nodeid) 
	=> .call('CLUSTER COUNT', params)
	=> givenblock

// Return the number of local keys in the specified hash slot
define redis_client->cluster_countkeysinslot(slot) 
	=> .call('CLUSTER COUNTKEYSINSLOT', params)
	=> givenblock

// Set hash slots as unbound in receiving node
define redis_client->cluster_delslots(slot, ...slots) 
	=> .call('CLUSTER DELSLOTS', params)
	=> givenblock

// Forces a slave to perform a manual failover of its master.
define redis_client->cluster_failover(-FORCE::boolean = false, -TAKEOVER::boolean = false) 
	=> .call('CLUSTER FAILOVER', params)
	=> givenblock

// Remove a node from the nodes table
define redis_client->cluster_forget(nodeid) 
	=> .call('CLUSTER FORGET', params)
	=> givenblock

// Return local key names in the specified hash slot
define redis_client->cluster_getkeysinslot(slot, count) 
	=> .call('CLUSTER GETKEYSINSLOT', params)
	=> givenblock

// Provides info about Redis Cluster node state
define redis_client->cluster_info() 
	=> .call('CLUSTER INFO', params)
	=> givenblock

// Returns the hash slot of the specified key
define redis_client->cluster_keyslot(key) 
	=> .call('CLUSTER KEYSLOT', params)
	=> givenblock

// Force a node cluster to handshake with another node
define redis_client->cluster_meet(ip::string, port::integer) 
	=> .call('CLUSTER MEET', params)
	=> givenblock

// Get Cluster config for the node
define redis_client->cluster_nodes() 
	=> .call('CLUSTER NODES', params)
	=> givenblock

// Reconfigure a node as a slave of the specified master node
define redis_client->cluster_replicate(nodeid) 
	=> .call('CLUSTER REPLICATE', params)
	=> givenblock

// Reset a Redis Cluster node
define redis_client->cluster_reset(hard_or_soft::string) 
	=> .call('CLUSTER RESET', params)
	=> givenblock

// Forces the node to save cluster state on disk
define redis_client->cluster_saveconfig() 
	=> .call('CLUSTER SAVECONFIG', params)
	=> givenblock

// Set the configuration epoch in a new node
define redis_client->cluster_set_config_epoch(epoch) 
	=> .call('CLUSTER SET CONFIG EPOCH', params)
	=> givenblock

// Bind an hash slot to a specific node
define redis_client->cluster_setslot(slot, command, nodeid) 
	=> .call('CLUSTER SETSLOT', params)
	=> givenblock

// List slave nodes of the specified master node
define redis_client->cluster_slaves(nodeid) 
	=> .call('CLUSTER SLAVES', params)
	=> givenblock

// Get array of Cluster slot to node mappings
define redis_client->cluster_slots() 
	=> .call('CLUSTER SLOTS', params)
	=> givenblock

// Get array of Redis command details
define redis_client->command() 
	=> .call('COMMAND', params)
	=> givenblock

// Get total number of Redis commands
define redis_client->command_count() 
	=> .call('COMMAND COUNT', params)
	=> givenblock

// Extract keys given a full Redis command
define redis_client->command_getkeys() 
	=> .call('COMMAND GETKEYS', params)
	=> givenblock

// Get array of specific Redis command details
define redis_client->command_info(command::string, ...commands) 
	=> .call('COMMAND INFO', params)
	=> givenblock

// Get the value of a configuration parameter
define redis_client->config_get(parameter) 
	=> .call('CONFIG GET', params)
	=> givenblock

// Rewrite the configuration file with the in memory configuration
define redis_client->config_rewrite() 
	=> .call('CONFIG REWRITE', params)
	=> givenblock

define redis_client->config_set(p::pair) 
	=> .call('CONFIG SET',#p->name,#p->value)
	=> givenblock

// Set a configuration parameter to the given value
define redis_client->config_set(parameter, value) 
	=> .call('CONFIG SET', params)
	=> givenblock

// Reset the stats returned by INFO
define redis_client->config_resetstat() 
	=> .call('CONFIG RESETSTAT', params)
	=> givenblock

// Return the number of keys in the selected database
define redis_client->dbsize() 
	=> .call('DBSIZE', params)
	=> givenblock

// Get debugging information about a key
define redis_client->debug_object(key) 
	=> .call('DEBUG OBJECT', params)
	=> givenblock 
 
// Make the server crash
define redis_client->debug_segfault() 
	=> .call('DEBUG SEGFAULT', params)
	=> givenblock

// Decrement the integer value of a key by one
define redis_client->decr(key) 
	=> .call('DECR', params)
	=> givenblock

// Decrement the integer value of a key by the given number
define redis_client->decrby(key, decrement) 
	=> .call('DECRBY', params)
	=> givenblock

// Delete a key
define redis_client->del(key, ...keys) 
	=> .call('DEL', params)
	=> givenblock

// Discard all commands issued after MULTI
define redis_client->discard() 
	=> .call('DISCARD', params)
	=> givenblock

// Return a serialized version of the value stored at the specified key.
define redis_client->dump(key) 
	=> .call('DUMP', params)
	=> givenblock

// Echo the given string
define redis_client->echo(message) 
	=> .call('ECHO', params)
	=> givenblock

// Execute a Lua script server side
define redis_client->eval(command) 
	=> .call('EVAL', params)
	=> givenblock
	
define redis_client->eval(script, keys::staticarray, params::staticarray) 
	=> .call('EVAL',(:#script,#keys->size) + #keys + #params)
	=> givenblock

// Execute a Lua script server side
define redis_client->evalsha(command) 
	=> .call('EVALSHA', params)
	=> givenblock

define redis_client->evalsha(script, keys::staticarray, params::staticarray) 
	=> .call('EVALSHA',(:#script,#keys->size) + #keys + #params)
	=> givenblock

// Execute all commands issued after MULTI
define redis_client->exec() 
	=> .call('EXEC', params)
	=> givenblock

// Determine if a key exists
define redis_client->exists(key, ...keys) 
	=> .call('EXISTS', params)
	=> givenblock

// Set a keys time to live in seconds
define redis_client->expire(key, seconds) 
	=> .call('EXPIRE', params)
	=> givenblock

// Set the expiration for a key as a UNIX timestamp
define redis_client->expireat(key, timestamp) 
	=> .call('EXPIREAT', params)
	=> givenblock

// Remove all keys from all databases
define redis_client->flushall() 
	=> .call('FLUSHALL', params)
	=> givenblock

// Remove all keys from the current database
define redis_client->flushdb() 
	=> .call('FLUSHDB', params)
	=> givenblock

// Add one or more geospatial items in the geospatial index represented using a sorted set
define redis_client->geoadd(key, longitude, latitude, member, ...rest) 
	=> .call('GEOADD', params)
	=> givenblock

// Returns members of a geospatial index as standard geohash strings
define redis_client->geohash(key, member, ...members) 
	=> .call('GEOHASH', params)
	=> givenblock

// Returns longitude and latitude of members of a geospatial index
define redis_client->geopos(key, member, ...members) 
	=> .call('GEOPOS', params)
	=> givenblock

// Returns the distance between two members of a geospatial index
define redis_client->geodist(key, member1, member2, m_km_mi_ft) 
	=> .call('GEODIST', params)
	=> givenblock

// Query a sorted set representing a geospatial index to fetch members matching a given maximum distance from a point
define redis_client->georadius(key, longitude, latitude, radius, m_km_mi_ft, -WITHCOORD = false, -WITHDIST = false, -WITHHASH = false, -COUNT::integer=0) 
	=> .call('GEORADIUS', params)
	=> givenblock

// Query a sorted set representing a geospatial index to fetch members matching a given maximum distance from a member
define redis_client->georadiusbymember(key, member, radius, m_km_mi_ft, -WITHCOORD = false, -WITHDIST = false, -WITHHASH = false, -COUNT::integer=0) 
	=> .call('GEORADIUSBYMEMBER', params)
	=> givenblock

// Get the value of a key
define redis_client->get(key) 
	=> .call('GET', params)
	=> givenblock

// Returns the bit value at offset in the string value stored at key
define redis_client->getbit(key, offset) 
	=> .call('GETBIT', params)
	=> givenblock

// Get a substring of the string stored at a key
define redis_client->getrange(key, start, end) 
	=> .call('GETRANGE', params)
	=> givenblock

// Set the string value of a key and return its old value
define redis_client->getset(key, value) 
	=> .call('GETSET', params)
	=> givenblock

// Delete one or more hash fields
define redis_client->hdel(key, field, ...fields) 
	=> .call('HDEL', params)
	=> givenblock

// Determine if a hash field exists
define redis_client->hexists(key, field) 
	=> .call('HEXISTS', params)
	=> givenblock

// Get the value of a hash field
define redis_client->hget(key, field) 
	=> .call('HGET', params)
	=> givenblock

// Get all the fields and values in a hash
define redis_client->hgetall(key) 
	=> .call('HGETALL', params)
	=> givenblock

// Increment the integer value of a hash field by the given number
define redis_client->hincrby(key, field, increment::integer) 
	=> .call('HINCRBY', params)
	=> givenblock

// Increment the float value of a hash field by the given amount
define redis_client->hincrbyfloat(key, field, increment::integer) 
	=> .call('HINCRBYFLOAT', params)
	=> givenblock

// Get all the fields in a hash
define redis_client->hkeys(key) 
	=> .call('HKEYS', params)
	=> givenblock

// Get the number of fields in a hash
define redis_client->hlen(key) 
	=> .call('HLEN', params)
	=> givenblock

// Get the values of all the given hash fields
define redis_client->hmget(key, field, ...fields) 
	=> .call('HMGET', params)
	=> givenblock

// Set multiple hash fields to multiple values
define redis_client->hmset(key, field, value, ...fieldsvalues) 
	=> .call('HMSET', params)
	=> givenblock

// Set the string value of a hash field
define redis_client->hset(key, field, value) 
	=> .call('HSET', params)
	=> givenblock

// Set the value of a hash field, only if the field does not exist
define redis_client->hsetnx(key, field, value) 
	=> .call('HSETNX', params)
	=> givenblock

// Get the length of the value of a hash field
define redis_client->hstrlen(key, field) 
	=> .call('HSTRLEN', params)
	=> givenblock

// Get all the values in a hash
define redis_client->hvals(key) 
	=> .call('HVALS', params)
	=> givenblock 

// Increment the integer value of a key by one
define redis_client->incr(key) 
	=> .call('INCR', params)
	=> givenblock

// Increment the integer value of a key by the given amount
define redis_client->incrby(key, increment::integer) 
	=> .call('INCRBY', params)
	=> givenblock

// Increment the float value of a key by the given amount
define redis_client->incrbyfloat(key, increment::integer) 
	=> .call('INCRBYFLOAT', params)
	=> givenblock

// Get information and statistics about the server
define redis_client->info(section::string = '') 
	=> .call('INFO', params)
	=> givenblock

// Find all keys matching the given pattern
define redis_client->keys(pattern) 
	=> .call('KEYS', params)
	=> givenblock

// Get the UNIX time stamp of the last successful save to disk
define redis_client->lastsave() 
	=> .call('LASTSAVE', params)
	=> givenblock

// Get an element from a list by its index
define redis_client->lindex(key, index) 
	=> .call('LINDEX', params)
	=> givenblock

// Insert an element before or after another element in a list
define redis_client->linsert(key, BEFORE_or_AFTER, pivot, value) 
	=> .call('LINSERT', params)
	=> givenblock

// Get the length of a list
define redis_client->llen(key) 
	=> .call('LLEN', params)
	=> givenblock

// Remove and get the first element in a list
define redis_client->lpop(key) 
	=> .call('LPOP', params)
	=> givenblock

// Prepend one or multiple values to a list
define redis_client->lpush(key, value, ...values) 
	=> .call('LPUSH', params)
	=> givenblock

// Prepend a value to a list, only if the list exists
define redis_client->lpushx(key, value) 
	=> .call('LPUSHX', params)
	=> givenblock
  
// Get a range of elements from a list
define redis_client->lrange(key, start, stop) 
	=> .call('LRANGE', params)
	=> givenblock

// Remove elements from a list
define redis_client->lrem(key, count, value) 
	=> .call('LREM', params)
	=> givenblock

// Set the value of an element in a list by its index
define redis_client->lset(key, index, value) 
	=> .call('LSET', params)
	=> givenblock

// Trim a list to the specified range
define redis_client->ltrim(key, start, stop) 
	=> .call('LTRIM', params)
	=> givenblock

// Get the values of all the given keys
define redis_client->mget(key, ...keys) 
	=> .call('MGET', params)
	=> givenblock

// Atomically transfer a key from a Redis instance to another one.
define redis_client->migrate(host, port, key, destinationdb, timeout, -COPY = false, -REPLACE = false) 
	=> .call('MIGRATE', params)
	=> givenblock

// Listen for all requests received by the server in real time
define redis_client->monitor() 
	=> .call('MONITOR', params)
	=> givenblock

// Move a key to another database
define redis_client->move(key, db) 
	=> .call('MOVE', params)
	=> givenblock

// Set multiple keys to multiple values
define redis_client->mset(key, value, ...key_values) 
	=> .call('MSET', params)
	=> givenblock

// Set multiple keys to multiple values, only if none of the keys exist
define redis_client->msetnx(key, value, ...key_values) 
	=> .call('MSETNX', params)
	=> givenblock

// Mark the start of a transaction block
define redis_client->multi() 
	=> .call('MULTI', params)
	=> givenblock

// Inspect the internals of Redis objects
define redis_client->object(subcommand, argument, ...arguments) 
	=> .call('OBJECT', params)
	=> givenblock

// Remove the expiration from a key
define redis_client->persist(key) 
	=> .call('PERSIST', params)
	=> givenblock

// Set a key's time to live in milliseconds
define redis_client->pexpire(key, milliseconds::integer) 
	=> .call('PEXPIRE', params)
	=> givenblock

// Set the expiration for a key as a UNIX timestamp specified in milliseconds
define redis_client->pexpireat(key, millisecondsunix::integer) 
	=> .call('PEXPIREAT', params)
	=> givenblock

// Adds the specified elements to the specified HyperLogLog.
define redis_client->pfadd(key, element, ...elements) 
	=> .call('PFADD', params)
	=> givenblock

// Return the approximated cardinality of the set(s) observed by the HyperLogLog at key(s).
define redis_client->pfcount(key, ...keys) 
	=> .call('PFCOUNT', params)
	=> givenblock

// Merge N different HyperLogLogs into a single one.
define redis_client->pfmerge(destkey, sourcekey, ...sourcekeys) 
	=> .call('PFMERGE', params)
	=> givenblock

// Ping the server
define redis_client->ping() 
	=> .call('PING', params)
	=> givenblock

// Set the value and expiration in milliseconds of a key
define redis_client->psetex(key, milliseconds, value) 
	=> .call('PSETEX', params)
	=> givenblock

// Inspect the state of the Pub/Sub subsystem
define redis_client->pubsub(subcommand, argument, ...arguments) 
	=> .call('PUBSUB', params)
	=> givenblock

// Get the time to live for a key in milliseconds
define redis_client->pttl(key) 
	=> .call('PTTL', params)
	=> givenblock

// Post a message to a channel
define redis_client->publish(channel, message) 
	=> .call('PUBLISH', params)
	=> givenblock

// Close the connection
define redis_client->quit() 
	=> .call('QUIT', params)
	=> givenblock

// Return a random key from the keyspace
define redis_client->randomkey() 
	=> .call('RANDOMKEY', params)
	=> givenblock

// Enables read queries for a connection to a cluster slave node
define redis_client->readonly() 
	=> .call('READONLY', params)
	=> givenblock

// Disables read queries for a connection to a cluster slave node
define redis_client->readwrite() 
	=> .call('READWRITE', params)
	=> givenblock

// Rename a key
define redis_client->rename(key, newkey) 
	=> .call('RENAME', params)
	=> givenblock

// Rename a key, only if the new key does not exist
define redis_client->renamenx(key, newkey) 
	=> .call('RENAMENX', params)
	=> givenblock

// Create a key using the provided serialized value, previously obtained using DUMP.
define redis_client->restore(key, ttl, serializedvalue, -REPLACE = false) 
	=> .call('RESTORE', params)
	=> givenblock

// Return the role of the instance in the context of replication
define redis_client->role() 
	=> .call('ROLE', params)
	=> givenblock

// Remove and get the last element in a list
define redis_client->rpop(key) 
	=> .call('RPOP', params)
	=> givenblock

// Remove the last element in a list, prepend it to another list and return it
define redis_client->rpoplpush(source, destination) 
	=> .call('RPOPLPUSH', params)
	=> givenblock

// Append one or multiple values to a list
define redis_client->rpush(key, value, ...values) 
	=> .call('RPUSH', params)
	=> givenblock

// Append a value to a list, only if the list exists
define redis_client->rpushx(key, value) 
	=> .call('RPUSHX', params)
	=> givenblock

// Add one or more members to a set
define redis_client->sadd(key, member, ...members) 
	=> .call('SADD', params)
	=> givenblock

// Synchronously save the dataset to disk
define redis_client->save() 
	=> .call('SAVE', params)
	=> givenblock

// Get the number of members in a set
define redis_client->scard(key) 
	=> .call('SCARD', params)
	=> givenblock

// Check existence of scripts in the script cache.
define redis_client->script_exists(script, ...scripts) 
	=> .call('SCRIPT EXISTS', params)
	=> givenblock

// Remove all the scripts from the script cache.
define redis_client->script_flush() 
	=> .call('SCRIPT FLUSH', params)
	=> givenblock

// Kill the script currently in execution.
define redis_client->script_kill() 
	=> .call('SCRIPT KILL', params)
	=> givenblock

// Load the specified Lua script into the script cache.
define redis_client->script_load(script) 
	=> .call('SCRIPT LOAD', params)
	=> givenblock

// Subtract multiple sets
define redis_client->sdiff(key, ...keys) 
	=> .call('SDIFF', params)
	=> givenblock

// Subtract multiple sets and store the resulting set in a key
define redis_client->sdiffstore(destination, key, ...keys) 
	=> .call('SDIFFSTORE', params)
	=> givenblock

// Change the selected database for the current connection
define redis_client->select(index) 
	=> .call('SELECT', params)
	=> givenblock

// Set the string value of a key
define redis_client->set(key, value, -EX::integer = 0, -PX::integer = 0, -NX::boolean = false, -XX::boolean = false) 
	=> .call('SET', params)
	=> givenblock 

// Sets or clears the bit at offset in the string value stored at key
define redis_client->setbit(key, offset, value) 
	=> .call('SETBIT', params)
	=> givenblock

// Set the value and expiration of a key
define redis_client->setex(key, seconds, value) 
	=> .call('SETEX', params)
	=> givenblock

// Set the value of a key, only if the key does not exist
define redis_client->setnx(key, value) 
	=> .call('SETNX', params)
	=> givenblock

// Overwrite part of a string at key starting at the specified offset
define redis_client->setrange(key, offset, value) 
	=> .call('SETRANGE', params)
	=> givenblock

// Synchronously save the dataset to disk and then shut down the server
define redis_client->shutdown(-NOSAVE::boolean = false, -SAVE::boolean = false) 
	=> .call('SHUTDOWN', params)
	=> givenblock

// Intersect multiple sets
define redis_client->sinter(key, ...keys) 
	=> .call('SINTER', params)
	=> givenblock

// Intersect multiple sets and store the resulting set in a key
define redis_client->sinterstore(destination, key, ...keys) 
	=> .call('SINTERSTORE', params)
	=> givenblock

// Determine if a given value is a member of a set
define redis_client->sismember(key, member) 
	=> .call('SISMEMBER', params)
	=> givenblock

// Make the server a slave of another instance, or promote it as master
define redis_client->slaveof(host, port) 
	=> .call('SLAVEOF', params)
	=> givenblock

// Manages the Redis slow queries log
define redis_client->slowlog(subcommand, argument = '') 
	=> .call('SLOWLOG', params)
	=> givenblock

// Get all the members in a set
define redis_client->smembers(key) 
	=> .call('SMEMBERS', params)
	=> givenblock

// Move a member from one set to another
define redis_client->smove(source, destination, member) 
	=> .call('SMOVE', params)
	=> givenblock

// Sort the elements in a list, set or sorted set
define redis_client->sort(key, -BY::string = '', -LIMIT::string = '', -GET::string = '', -ASC::boolean = false, -DESC::boolean = false, -ALPHA::boolean = false, ...options) 
	=> .call('SORT', params)
	=> givenblock

// Remove and return one or multiple random members from a set
define redis_client->spop(key)                
	=> .call('SPOP', params)
	=> givenblock

define redis_client->spop(key, count::integer) 
	=> .call('SPOP', params)
	=> givenblock

// Get one or multiple random members from a set
define redis_client->srandmember(key)               
	=> .call('SRANDMEMBER', params)
	=> givenblock

define redis_client->srandmember(key, count::integer) 
	=> .call('SRANDMEMBER', params)
	=> givenblock

// Remove one or more members from a set
define redis_client->srem(key, member, ...members) 
	=> .call('SREM', params)
	=> givenblock

// Get the length of the value stored in a key
define redis_client->strlen(key) 
	=> .call('STRLEN', params)
	=> givenblock

// Add multiple sets
define redis_client->sunion(key, ...keys) 
	=> .call('SUNION', params)
	=> givenblock

// Add multiple sets and store the resulting set in a key
define redis_client->sunionstore(destination, key, ...keys) 
	=> .call('SUNIONSTORE', params)
	=> givenblock

// Internal command used for replication
define redis_client->sync() 
	=> .call('SYNC', params)
	=> givenblock

// Return the current server time
define redis_client->time() 
	=> .call('TIME', params)
	=> givenblock

// Get the time to live for a key
define redis_client->ttl(key) 
	=> .call('TTL', params)
	=> givenblock

// Determine the type stored at key
define redis_client->gettype(key) 
	=> .call('TYPE', params)
	=> givenblock

// Forget about all watched keys
define redis_client->unwatch() 
	=> .call('UNWATCH', params)
	=> givenblock

// Wait for the synchronous replication of all the write commands sent in the context of the current connection
define redis_client->wait(numslaves, timeout) 
	=> .call('WAIT', params)
	=> givenblock

// Watch the given keys to determine execution of the MULTI/EXEC block
define redis_client->watch(key, ...keys) 
	=> .call('WATCH', params)
	=> givenblock

// Add one or more members to a sorted set, or update its score if it already exists
define redis_client->zadd(key, score, member,...score_members) 
	=> .call('ZADD', params)
	=> givenblock

define redis_client->zadd(key,-NX = false,-XX=false,-CH=false, -INCR = false, ...score_members) 
	=> .call('ZADD', params)
	=> givenblock

// Get the number of members in a sorted set
define redis_client->zcard(key) 
	=> .call('ZCARD', params)
	=> givenblock

// Count the members in a sorted set with scores within the given values
define redis_client->zcount(key, min, max) 
	=> .call('ZCOUNT', params)
	=> givenblock

// Increment the score of a member in a sorted set
define redis_client->zincrby(key, increment, member) 
	=> .call('ZINCRBY', params)
	=> givenblock

// Intersect multiple sorted sets and store the resulting sorted set in a new key
define redis_client->zinterstore(destination, numkeys, key, ...keys) 
	=> .call('ZINTERSTORE', params)
	=> givenblock

// Count the number of members in a sorted set between a given lexicographical range
define redis_client->zlexcount(key, min, max) 
	=> .call('ZLEXCOUNT', params)
	=> givenblock

// Return a range of members in a sorted set, by index
define redis_client->zrange(key, start, stop, -WITHSCORES = false) 
	=> .call('ZRANGE', params)
	=> givenblock

// Return a range of members in a sorted set, by lexicographical range
define redis_client->zrangebylex(key, min, max, -LIMIT = '') 
	=> .call('ZRANGEBYLEX', params)
	=> givenblock     

// Return a range of members in a sorted set, by lexicographical range, ordered from higher to lower strings.
define redis_client->zrevrangebylex(key, max, min, LIMIT = '') 
	=> .call('ZREVRANGEBYLEX', params)
	=> givenblock

// Return a range of members in a sorted set, by score
define redis_client->zrangebyscore(key, min, max, -WITHSCORES = false, -LIMIT = '') 
	=> .call('ZRANGEBYSCORE', params)
	=> givenblock

// Determine the index of a member in a sorted set
define redis_client->zrank(key, member) 
	=> .call('ZRANK', params)
	=> givenblock

// Remove one or more members from a sorted set
define redis_client->zrem(key, member, ...members) 
	=> .call('ZREM', params) 
	=> givenblock

// Remove all members in a sorted set between the given lexicographical range
define redis_client->zremrangebylex(key, min, max) 
	=> .call('ZREMRANGEBYLEX', params)
	=> givenblock

// Remove all members in a sorted set within the given indexes
define redis_client->zremrangebyrank(key, start, stop) 
	=> .call('ZREMRANGEBYRANK', params)
	=> givenblock
 
// Remove all members in a sorted set within the given scores
define redis_client->zremrangebyscore(key, min, max) 
	=> .call('ZREMRANGEBYSCORE', params)
	=> givenblock

// Return a range of members in a sorted set, by index, with scores ordered from high to low
define redis_client->zrevrange(key, start, stop, -WITHSCORES = false) 
	=> .call('ZREVRANGE', params)
	=> givenblock

// Return a range of members in a sorted set, by score, with scores ordered from high to low
define redis_client->zrevrangebyscore(key, max, min, -WITHSCORES = false, -LIMIT = '') 
	=> .call('ZREVRANGEBYSCORE', params)
	=> givenblock

// Determine the index of a member in a sorted set, with scores ordered from high to low
define redis_client->zrevrank(key, member) 
	=> .call('ZREVRANK', params)
	=> givenblock

// Get the score associated with the given member in a sorted set
define redis_client->zscore(key, member) 
	=> .call('ZSCORE', params)
	=> givenblock

// Add multiple sorted sets and store the resulting sorted set in a new key
define redis_client->zunionstore(destination, numkeys, key, -WEIGHTS = '', -AGGREGATE = '') 
	=> .call('ZUNIONSTORE', params)
	=> givenblock

// Incrementally iterate the keys space
define redis_client->scan(cursor, -MATCH = '', -COUNT::integer = 0) 
	=> .call('SCAN', params)
	=> givenblock

// Incrementally iterate Set elements
define redis_client->sscan(key, cursor, -MATCH = '', -COUNT::integer = 0) 
	=> .call('SSCAN', params)
	=> givenblock

// Incrementally iterate hash fields and associated values
define redis_client->hscan(key, cursor, -MATCH = '', -COUNT::integer = 0) 
	=> .call('HSCAN', params)
	=> givenblock

// Incrementally iterate sorted sets elements and associated scores
define redis_client->zscan(key, cursor, -MATCH = '', -COUNT::integer = 0) 
	=> .call('ZSCAN', params)
	=> givenblock

?>