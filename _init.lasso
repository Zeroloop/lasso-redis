<?lasso
with file in (:
	'redis.client.lasso',
	'redis.commands.lasso',
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

	// allow relative includes
	self->filename !>> '/instances/'
	? library(include_path + #file)
	| lassoapp_include(#file)	
}
?>