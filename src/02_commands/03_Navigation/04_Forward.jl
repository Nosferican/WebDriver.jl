# Command Forward
"""
	forward!(session::Session)

This command causes the browser to traverse one step forwards in the joint session history of the current top-level browsing context.
"""
function forward!(session::Session)
    @unpack addr, id = session
    response =
        HTTP.post("$addr/session/$id/forward", [("Content-Type" => "application/json; charset=utf-8")])
    @assert response.status == 200
    nothing
end
