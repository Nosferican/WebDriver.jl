# Command: Switch to Frame
function frame!(session::Session, frame::AbstractString)
    @unpack addr, id = session
	response = HTTP.post("$addr/session/$id/frame/parent",
                         [("Content-Type" => "application/json")],
                         JSON3.write(Dict("id" => ("ELEMENT" => frame.id))))
	@assert response.status == 200
	nothing
end
function frame!(frame::Element)
    @unpack addr, id = frame.session
	response = HTTP.post("$addr/session/$id/frame",
                         [("Content-Type" => "application/json")],
                         JSON3.write(Dict("id" => ("ELEMENT" => frame.id))))
	@assert response.status == 200
end