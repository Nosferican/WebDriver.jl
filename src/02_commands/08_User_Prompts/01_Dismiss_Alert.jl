# Command: Dismiss Alert
"""
    dismiss(session::Session)::Nothing

Dismisses the currently displayed alert dialog.

!!! note

    This command uses the JSON Wire Protocol instead of the current W3c WebDriver API.
"""
function dismiss(session::Session)
    @unpack addr, id = session
	response = HTTP.post("$addr/session/$id/dismiss_alert",
						 [("Content-Type" => "application/json")])
    @assert response.status == 200
end
