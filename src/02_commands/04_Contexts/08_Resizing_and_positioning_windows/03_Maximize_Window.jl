# Command: Maximize Window
"""
	maximize!(session::Session; window::AbstractString = "current")::Dict{String,Int}

The Maximize Window command invokes the window manager-specific "maximize" operation, if any, on the window containing the current top-level browsing context.
This typically increases the window to the maximum available size without going full-screen.

!!! note

    This command is implemented using the JSON Wire Protocol.
"""
function maximize!(session::Session; window::AbstractString = "current")
    @unpack addr, id = session
    response = HTTP.post(
        "$addr/session/$id/window/$window/maximize",
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
