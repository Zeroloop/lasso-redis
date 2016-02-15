<?lasso
/////////////////////////////////////////////////////////
//
//	RESP.encode — http://redis.io/topics/protocol
//
/////////////////////////////////////////////////////////

define resp_encode => type {
    public oncreate(p::any) => .encode(#p)
    public oncreate(p::any,p2::any,...) => .encode(params)
    
    public encode(p::null) => '$-1\r\n'
    public encode(p::void) => '$-1\r\n'
    public encode(p::string) => '$' + #p->asbytes->size + '\r\n' + #p + '\r\n'
    public encode(p::integer) => ':' + #p + '\r\n'
    public encode(p::trait_finiteForEach) => '*' + #p->size + '\r\n' + (with i in #p select .encode(#i) )->join('')
}
?>