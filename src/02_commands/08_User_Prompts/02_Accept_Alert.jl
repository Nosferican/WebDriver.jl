# Command: Accept Alert
"""
    accept(session::Session)::Nothing

Accepts the currently displayed alert dialog.

!!! note

    This command uses the JSON Wire Protocol instead of the current W3c WebDriver API.
"""
function accept(session::Session)::Nothing
    @unpack addr, id = session
    response = HTTP.post(
        "$addr/session/$id/accept_alert",
        [("Content-Type" => "application/json; charset=utf-8")],
    )
    @assert response.status == 200
end
