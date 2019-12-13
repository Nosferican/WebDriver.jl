# Command: Get Current URL
function current_url(session::Session)
	@unpack addr, id = session
	response = HTTP.get("$addr/session/$id/url",
						[("Content-Type" => "application/json")])
	@assert response.status == 200
	JSON3.read(response.body).value
end