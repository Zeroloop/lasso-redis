<?lasso
// Store connections in remote threads

! ::redis_pipes->istype 
? define redis_pipes => thread {
    parent map
    public oncreate => ..oncreate 

    public close => {
        with key in .keys 
        let redis_pipe = .find(#key)
        do {
            .remove(#key)
            #redis_pipe->close 
        }
    }
}

define close_redis_pipes => {
    with key in redis_pipes->keys 
    let redis = redis_pipes->find(#key)
    where #redis
    do {
       redis_pipes->remove(#key)
       #redis->close 
    }
}


// Initiates redis thread and returns read and write sockets
define redis_pipe => type {

    data 
        public id,
        public read_pipe,
        public write_pipe,
        public redis

    public oncreate => {
        .id = lasso_uniqueid 

        .redis = givenblock

        local(pipe) = .split_thread(.redis)

        .write_pipe = #pipe->first
        .read_pipe = #pipe->second

        // Store FD
        redis_pipes->insert(.id = self)
    }

    public close => {
        // Remove FD
        redis_pipes->remove(.id)
        protect => {
            .write('close')
        }
    }

    public read          => .read_pipe->readObject
    public tryread       => .read_pipe->tryReadObject
    public write(p::any) => .write_pipe->writeobject(#p)

    public split_thread(redis::redis_client) 
        => split_thread => {
        
        local(
            write_pipe = #1->first,
            read_pipe  = #1->second
        )

        while(true) => {
            // Write response to thread
            #redis->listen(1) => {
                #write_pipe->writeobject(#1 || '')
            }

            // Check for close command
            #read_pipe->tryReadObject == 'close' 
            ? #redis->close && abort 
        }
    }
}
?>