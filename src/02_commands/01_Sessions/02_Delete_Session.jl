# Command: Delete Session
"""
	delete!(session::Session)
Deletes the session from the Remote Driver.
"""
function delete!(session::Session)
	try
		@unpack addr, id = session
		response = HTTP.delete("$addr/session/$id",
							   [("Content-Type" => "application/json")])
		@assert response.status == 200
		@assert JSON3.read(response.body).status == 0
		id
	catch err
		throw(WDError(err))
	end
end
