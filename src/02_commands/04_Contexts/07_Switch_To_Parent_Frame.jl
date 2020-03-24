# Command: Switch to Patent Frame
"""
	parent_frame!(session::Session)::Nothing

The Switch to Parent Frame command sets the current browsing context for future commands to the parent of the current browsing context.
"""
function parent_frame!(session::Session)
    @unpack addr, id = session
    response = HTTP.post(
        "$addr/session/$id/frame/parent",
        [("Content-Type" => "application/json")],
    )
    @assert response.status == 200
end
