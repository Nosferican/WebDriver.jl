# Command: Accept Alert
"""
    alert_text(session::Session)::String

Gets the text of the currently displayed JavaScript alert(), confirm(), or prompt() dialog.

!!! note

    This command uses the JSON Wire Protocol instead of the current W3c WebDriver API.
"""
function alert_text(session::Session)::String
    @unpack addr, id = session
    response =
        HTTP.get("$addr/session/$id/alert_text", [("Content-Type" => "application/json; charset=utf-8")])
    @assert response.status == 200
    JSON3.read(response.body).value
end
