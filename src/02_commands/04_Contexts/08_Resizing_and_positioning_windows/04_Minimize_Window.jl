# Command: Minimize Window
"""
	minimize!(session::Session; window::AbstractString = "current")::NamedTuple{(:width, :height, :x, :y),NTuple{4,Int64}}

The Minimize Window command invokes the window manager-specific "minimize" operation, if any, on the window containing the current top-level browsing context.
This typically hides the window in the system tray.

!!! note

    This command is implemented using the JSON Wire Protocol.
"""
function minimize!(
    session::Session;
    window::AbstractString = "current",
)::NamedTuple{(:width, :height, :x, :y),NTuple{4,Int64}}
    window = "current"
    @unpack addr, id = session
    response = HTTP.post(
        "$addr/session/$id/window/$window/minimize",
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
