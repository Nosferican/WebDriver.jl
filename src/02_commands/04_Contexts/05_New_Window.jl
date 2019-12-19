# Command: New Window
"""
    window!(session::Session)

Create a new top-level browsing context.
"""
function window!(session::Session)
    @unpack addr, id = session
    response = HTTP.post("$addr/session/$id/window",
                         [("Content-Type" => "application/json")])
    @assert response.status == 200
    JSON3.read(response.body).value
end
