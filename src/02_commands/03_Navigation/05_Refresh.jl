# Command: Refresh
"""
	refresh!(session::Session)

This command causes the browser to reload the page in the current top-level browsing context.
"""
function refresh!(session::Session)
    @unpack addr, id = session
    response =
        HTTP.post("$addr/session/$id/timeouts", [("Content-Type" => "application/json; charset=utf-8")])
    @assert response.status == 200
    nothing
end
