# Command: Accept Alert
function alert_text(session::Session)::String
    @unpack addr, id = session
	response = HTTP.get("$addr/session/$id/alert_text",
                         [("Content-Type" => "application/json")])
    @assert response.status == 200
    JSON3.read(response.body).value
end