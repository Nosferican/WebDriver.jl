# Command: Move To
"""
    moveto!(session::Session; x::Integer = 0, y::Integer = 0)
    moveto!(element::Element; x::Integer = 0, y::Integer = 0)

Move the mouse by an offset of the specificed element.

!!! note

    This command uses the JSON Wire Protocol instead of the current W3c WebDriver API.
"""
function moveto!(session::Session; x::Integer = 0, y::Integer = 0)
    @unpack addr, id = session
    response = HTTP.post(
        "$addr/session/$id/moveto!",
        [("Content-Type" => "application/json; charset=utf-8")],
        JSON3.write(Dict("x" => x, "y" => y)),
    )
    @assert response.status == 200
    nothing
end
function moveto!(element::Element; x::Integer = 0, y::Integer = 0)
    @unpack addr, id = element.session
    response = HTTP.post(
        "$addr/session/$id/moveto",
        [("Content-Type" => "application/json; charset=utf-8")],
        JSON3.write(Dict("element" => element.id, "x" => x, "y" => y)),
    )
    @assert response.status == 200
    nothing
end
