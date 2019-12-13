# Command: Maximize Window
"""
	maximize!(session::Session; window::AbstractString = "current")::Dict{String,Int}
Maximize the window based on window handle (defaults to current).
Returns Rect oof window.
!!! note
	This command is implemented using the JSON Wire Protocol.
"""
function maximize!(session::Session; window::AbstractString = "current")
	@unpack addr, id = session
	response = HTTP.post("$addr/session/$id/window/$window/maximize",
                         [("Content-Type" => "application/json")])
	@assert response.status == 200
	Dict{Symbol,Int}(JSON3.read(response.body).value)
end