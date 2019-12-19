# Command: Set Timeouts
"""
    timeouts!(session::Session, timeouts::Timeouts)::Nothing
Sets the timeouts.
"""
function timeouts!(session::Session, timeouts::Timeouts)::Nothing
    @unpack addr, id = session
	response = HTTP.post("$addr/session/$id/timeouts",
                         [("Content-Type" => "application/json")],
                         JSON3.write(timeouts))
	@assert response.status == 200
    JSON3.read(response.body).value
    nothing
end
