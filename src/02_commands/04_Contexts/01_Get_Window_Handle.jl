# Command: Get Window Handle
"""
	window_handle(session::Session)::String

The window handle associated with the current top-level browsing context.
"""
function window_handle(session::Session)::String
    @unpack addr, id = session
    response = HTTP.get(
        "$addr/session/$id/window_handle",
        [("Content-Type" => "application/json; charset=utf-8")],
    )
    @assert response.status == 200
    convert(String, JSON3.read(response.body).value)
end
