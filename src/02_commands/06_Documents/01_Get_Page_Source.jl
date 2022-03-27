# Command: Get Page Source
"""
    source(session::Session)::String

The Get Page Source command returns a string serialization of the DOM of the current browsing context active document.
"""
function source(session::Session)::String
    @unpack addr, id = session
    response =
        HTTP.get("$addr/session/$id/source", [("Content-Type" => "application/json; charset=utf-8")])
    @assert response.status == 200
    JSON3.read(response.body).value
end
