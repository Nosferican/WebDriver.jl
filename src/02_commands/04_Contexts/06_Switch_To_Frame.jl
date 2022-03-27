# Command: Switch to Frame
"""
    frame!(frame::Element)::Nothing

The Switch To Frame command is used to select the current top-level browsing context or a child browsing context of the current browsing context to use as the current browsing context for subsequent commands.
"""
function frame! end
# function frame!(session::Session)::Nothing
#     @unpack addr, id = session
#     response = HTTP.post(
#         "$addr/session/$id/frame",
#         [("Content-Type" => "application/json; charset=utf-8")],
#         JSON3.write(Dict("id" => nothing))),
#     )
#     @assert response.status == 200
# end
function frame!(frame::Element)::Nothing
    @unpack addr, id = frame.session
    response = HTTP.post(
        "$addr/session/$id/frame",
        [("Content-Type" => "application/json; charset=utf-8")],
        JSON3.write(Dict("id" => ("ELEMENT" => frame.id))),
    )
    @assert response.status == 200
end
