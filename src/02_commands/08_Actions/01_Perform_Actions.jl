# Command: Perform Actions
# """
#     actions!(session::Session, actions::AbstractVector)
# """
# function actions!(session::Session, actions::AbstractVector)
#     @unpack addr, id = session
#     x = try
#     response = HTTP.post("$addr/session/$id/actions",
#                          [("Content-Type" => "application/json; charset=utf-8")],
#                          JSON3.write("parameters" => "moveto!Element($(hoverOver.id))"))
#     catch err
#         err
#     end
#     @assert response.status == 200
#     nothing
# end
