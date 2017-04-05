<?lasso
with file in (:
	'redis.client.lasso',
	'redis.commands.lasso',
	'redis.threads.lasso',
	'resp_decode.lasso',
	'resp_encode.lasso' 
) do  {
	local(s) = micros
	handle => {
		stdoutnl(
			error_msg + ' (' + ((micros - #s) * 0.000001)->asstring(-precision=3) + ' seconds)'
		)
	}
	
	stdout('\t' + #file + ' - ')

	lassoapp_include_current(#file)	
}
?>
