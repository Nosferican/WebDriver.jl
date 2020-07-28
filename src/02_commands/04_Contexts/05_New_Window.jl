# Command: New Window
"""
    window!(session::Session)

Create a new top-level browsing context.
"""
function window!(session::Session)
    @unpack addr, id = session
    response =
        HTTP.post("$addr/session/$id/window/new", [("Content-Type" => "application/json")])
    @assert response.status == 200
    result = JSON3.read(response.body, NamedTuple)
    @assert result.status == 0
    (type = result.value["type"], handle = result.value["handle"])
end
