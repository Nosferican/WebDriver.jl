# Command: Back
"""
	back!(session::Session)

This command causes the browser to traverse one step backward in the joint session history of the current top-level browsing context.
This is equivalent to pressing the back button in the browser chrome or invoking window.history.back.
"""
function back!(session::Session)
    @unpack addr, id = session
    response = HTTP.post("$addr/session/$id/back", [("Content-Type" => "application/json")])
    @assert response.status == 200
    nothing
end
