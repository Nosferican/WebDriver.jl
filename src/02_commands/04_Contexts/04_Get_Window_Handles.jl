# Command: Get Window Handles
function window_handles(session::Session)
    @unpack addr, id = session
    response = HTTP.get("$addr/session/$id/window_handles",
                        [("Content-Type" => "application/json")])
	@assert response.status == 200
	convert(Vector{String}, JSON3.read(response.body).value)::Vector{String}
end