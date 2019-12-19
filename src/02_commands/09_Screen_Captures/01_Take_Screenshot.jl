# Command: Take Screenshot
"""
    screenshot(session::Session)::String
    screenshot(element::Element)::String

Take Screenshot.
"""
function screenshot end

function screenshot(session::Session)::String
    @unpack addr, id = session
	response = HTTP.get("$addr/session/$id/screenshot",
                        [("Content-Type" => "application/json")])
    @assert response.status == 200
    JSON3.read(response.body).value
end
function screenshot(element::Element)::String
    @unpack addr, id = element.session
	response = HTTP.get("$addr/session/$id/element/$(element.id)/screenshot",
                        [("Content-Type" => "application/json")])
    @assert response.status == 200
    JSON3.read(response.body).value
end
