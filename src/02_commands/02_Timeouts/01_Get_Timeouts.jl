# Command: Get Timeouts
"""
	timeouts(session::Session)
Get the timeouts according to [webdriver2](https://w3c.github.io/webdriver/#get-timeouts).
Currently not supported by Selenium.
"""
function timeouts(session::Session)
    @unpack addr, id = session
    response =
        HTTP.get("$addr/session/$id/timeouts", [("Content-Type" => "application/json; charset=utf-8")])
    @assert response.status == 200
    JSON3.read(response.body).status
end
