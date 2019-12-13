# Command: Get Window Handle
function window_handle(session::Session)
	@unpack addr, id = session
	response = HTTP.get("$addr/session/$id/window_handle",
						[("Content-Type" => "application/json")])
	@assert response.status == 200
	convert(String, JSON3.read(response.body).value)
end