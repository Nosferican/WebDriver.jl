# Command: Close Window 
function window_close!(session::Session)
	@unpack addr, id = session
	response = HTTP.delete("$addr/session/$id/window",
						   [("Content-Type" => "application/json")])
	@assert response.status == 200
	JSON3.read(response.body).value
end