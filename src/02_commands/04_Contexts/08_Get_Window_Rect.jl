# Command: Get Window Rect
"""
	rect(session::Session; window::AbstractString = "current")::NamedTuple
Return window's dimensions in pixels.
"""
function rect(session::Session, window::AbstractString = "current")
    @unpack addr, id = session
	response = HTTP.get("$addr/session/$id/window/$window/size",
                        [("Content-Type" => "application/json")])
	@assert response.status == 200
	output = JSON3.read(response.body).value
	(width = output.width, height = output.height, x = output.x, y = output.y)::NamedTuple{(:width, :height, :x, :y),NTuple{4,Int64}}
end