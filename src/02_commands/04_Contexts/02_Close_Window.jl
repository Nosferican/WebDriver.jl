# Command: Close Window
"""
	window_close!(session::Session)::Nothing

The window handle associated with the current top-level browsing context.
"""
function window_close!(session::Session)::Nothing
	@unpack addr, id = session
	response = HTTP.delete("$addr/session/$id/window",
						   [("Content-Type" => "application/json")])
	@assert response.status == 200
	nothing
end
