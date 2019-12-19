# Command: Send Alert Text
"""
    alert_text!(session::Session, text::AbstractString)::Nothing

Sends keystrokes to a JavaScript prompt() dialog.

!!! note

    This command uses the JSON Wire Protocol instead of the current W3c WebDriver API.
"""
function alert_text!(session::Session, text::AbstractString)::Nothing
    @unpack addr, id = session
    response = HTTP.post("$addr/session/$id/alert_text",
                         [("Content-Type" => "application/json")],
                         JSON3.write(Dict("text" => text)))
    @assert response.status == 200
end
