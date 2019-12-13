# Command: Get Title
function document_title(session::Session)
	@unpack addr, id = session
	response = HTTP.get("$addr/session/$id/title",
						[("Content-Type" => "application/json")])
	@assert response.status == 200
	JSON3.read(response.body).value
end