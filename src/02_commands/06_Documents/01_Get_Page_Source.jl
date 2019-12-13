# Command: Get Page Source
function source(session::Session)
    @unpack addr, id = session
	response = HTTP.get("$addr/session/$id/source",
						[("Content-Type" => "application/json")])
    @assert response.status == 200
    JSON3.read(response.body).value::String
end