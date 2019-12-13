# Command: Back
function back!(session::Session)
	@unpack addr, id = session
	response = HTTP.post("$addr/session/$id/back",
						 [("Content-Type" => "application/json")])
	@assert response.status == 200
	nothing
end