# Command: Set Timeouts
function timeouts!(session::Session, timeouts::Timeouts)
    @unpack addr, id = session
	response = HTTP.post("$addr/session/$id/timeouts",
                         [("Content-Type" => "application/json")],
                         JSON3.write(timeouts))
	@assert response.status == 200
	JSON3.read(response.body).value
end