# Command: Dismiss Alert
function dismiss(session::Session)
    @unpack addr, id = session
	response = HTTP.post("$addr/session/$id/dismiss_alert",
						 [("Content-Type" => "application/json")])
    @assert response.status == 200
end