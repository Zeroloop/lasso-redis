<?lasso
/////////////////////////////////////////////////////////
//
//  RESP.decode — http://redis.io/topics/protocol
//
/////////////////////////////////////////////////////////

define resp_decode => type {

    data
        private raw,
        private i = 0

    public oncreate(p::string) => .consume(#p)
    public oncreate(p0::string,p1::string,...) => (with p in params select .consume(#p))->asstaticarray
    
    public consume(p::string) => {

        local(out) = array

        // Dealing with lines reduces iterations
        .raw = #p->split('\r\n')->asstaticarray
        .i = 1
        
        // Deal with multiple responses (pipeline)
        while(.i < .raw->size) => {
            #out->insert(
                .consume_line    
            )
        }
        
        return (
            // Return sole result or all results
            #out->size == 1 
            ?   #out->first 
            |   #out->asstaticarray
        )
    }

    public consume_line(p::string = .raw->get(.i++)) => {
        match(#p->get(1)) => {
            case('$') return .consume_string(#p)
            case('+') return .consume_simple(#p)
            case('*') return .consume_array(#p)
            case(':') return .consume_integer(#p)
            case('-') return .consume_error(#p)
        }
    }    

    public consume_integer(p::string) => {
        return integer(#p->sub(2,20))
    }

    public consume_simple(p::string) => {
        return #p->sub(2,1024)
    }

    public consume_error(p::string) => {
        local(error) = #p->sub(2,1024)
        // Throw the error
        fail(-1,#error)
    }

    public consume_string(p::string) => {
        // Establish size
        local(
            size = integer(#p->sub(2,20)),
            out 
        )

        // Deal with null values
        #size == -1 ? return null

        // Grab first component
        #out = .raw->get(.i++)->asbytes
        
        // Check for carrage returns in string
        #out->size < #size
        ? { 
            #out->append('\r\n')
            #out->append(.raw->get(.i++))
            #out->size < #size ? currentcapture->restart 
        }()

        // Return string
        return #out->asstring 
    }

    public consume_array(p::string) => {
        local(
            // Establish size
            size = integer(#p->sub(2,40)),
            out = array
        )

        while(#size--) => {
            #out->insert(.consume_line)  
        }

        // Return array
        return #out
    }
}
?>
