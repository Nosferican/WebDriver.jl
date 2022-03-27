# Command: Switch to Window
"""
    window!(session::Session, handle::AbstractString)

The window handle associated with the current top-level browsing context.
"""
function window!(session::Session, handle::AbstractString)
    @unpack addr, id = session
    response = HTTP.post(
        "$addr/session/$id/window",
        [("Content-Type" => "application/json; charset=utf-8")],
        JSON3.write("handle" => handle),
    )
    @assert response.status == 200
    JSON3.read(response.body).value
end
