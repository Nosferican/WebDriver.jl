# Command: Switch to Window
function window!(session::Session, handle::AbstractString)
    @unpack addr, id = session
	response = HTTP.post("$addr/session/$id/window",
                         [("Content-Type" => "application/json")],
                         JSON3.write("handle" => handle))
	@assert response.status == 200
	JSON3.read(response.body).value
end