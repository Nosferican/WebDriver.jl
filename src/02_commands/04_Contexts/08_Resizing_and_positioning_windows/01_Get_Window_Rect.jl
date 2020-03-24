# Command: Get Window Rect
"""
	rect(session::Session; window::AbstractString = "current")::NamedTuple{(:width, :height, :x, :y),NTuple{4,Int64}}

The Get Window Rect command returns the size and position on the screen of the operating system window corresponding to the current top-level browsing context.
"""
function rect(
    session::Session,
    window::AbstractString = "current",
)::NamedTuple{(:width, :height, :x, :y),NTuple{4,Int64}}
    @unpack addr, id = session
    response = HTTP.get(
        "$addr/session/$id/window/$window/size",
        [("Content-Type" => "application/json")],
    )
    @assert response.status == 200
    output = JSON3.read(response.body).value
    (
        width = output.width,
        height = output.height,
        x = output.x,
        y = output.y,
    )::NamedTuple{(:width, :height, :x, :y),NTuple{4,Int64}}
end
