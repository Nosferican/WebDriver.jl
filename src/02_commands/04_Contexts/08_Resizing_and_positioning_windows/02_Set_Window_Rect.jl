# Command: Set Window Rect
"""
    rect!(session::Session;
          window::AbstractString = "current",
          width::Union{Nothing, Real} = nothing,
          height::Union{Nothing, Real} = nothing
         )::NamedTuple{(:width, :height, :x, :y),NTuple{4,Int64}}

The Set Window Rect command alters the size and the position of the operating system window corresponding to the current top-level browsing context.
"""
function rect!(session::Session;
               window::AbstractString = "current",
               width::Union{Nothing, Real} = nothing,
               height::Union{Nothing, Real} = nothing
               )::NamedTuple{(:width, :height, :x, :y),NTuple{4,Int64}}
    original = rect(session, window)
               window = "current"
    @unpack addr, id = session
    width = 500
    height = nothing
    x = nothing
    y = nothing
	response = HTTP.post("$addr/session/$id/window/$window/size",
                         [("Content-Type" => "application/json")],
                         JSON3.write(Dict("width" => width,
                                          "height" => height)))
    @assert response.status == 200
    output = JSON3.read(response.body).value
	(width = output.width, height = output.height, x = output.x, y = output.y)
end