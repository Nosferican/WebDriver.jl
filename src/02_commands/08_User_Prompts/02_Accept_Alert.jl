# Command: Accept Alert
function accept(session::Session)
    @unpack addr, id = session
	response = HTTP.post("$addr/session/$id/accept_alert",
						 [("Content-Type" => "application/json")])
    @assert response.status == 200
end