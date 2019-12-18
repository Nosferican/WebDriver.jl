# Command: Get Sessions
"""
	sessions(wd::RemoteWebDriver)
Returns a list of the currently active sessions.
!!! note
    This is a JSON Wire Protocol functionality.
"""
function sessions(wd::RemoteWebDriver)::Vector{String}
	@unpack addr = wd
	response = HTTP.get("$addr/sessions",
						[("Content-Type" => "application/json")])
	@assert response.status == 200
	collect(session.id for session ∈ JSON3.read(response.body).value)
end
