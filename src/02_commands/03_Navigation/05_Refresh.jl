# Command: Refresh
function refresh!(session::Session)
	@unpack addr, id = session
	response = HTTP.post("$addr/session/$id/timeouts",
						 [("Content-Type" => "application/json")])
	@assert response.status == 200
	nothing
end