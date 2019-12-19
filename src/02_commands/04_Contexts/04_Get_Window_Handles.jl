# Command: Get Window Handles
"""
    window_handles(session::Session)::Vector{String}

Switching window will select the current top-level browsing context used as the target for all subsequent commands.
In a tabbed browser, this will typically make the tab containing the browsing context the selected tab.
"""
function window_handles(session::Session)::Vector{String}
    @unpack addr, id = session
    response = HTTP.get("$addr/session/$id/window_handles",
                        [("Content-Type" => "application/json")])
	@assert response.status == 200
	convert(Vector{String}, JSON3.read(response.body).value)::Vector{String}
end
