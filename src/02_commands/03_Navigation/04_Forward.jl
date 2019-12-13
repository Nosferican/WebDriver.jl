# Command Forward
function forward!(session::Session)
	@unpack addr, id = session
	response = HTTP.post("$addr/session/$id/forward",
						 [("Content-Type" => "application/json")])
	@assert response.status == 200
	nothing
end