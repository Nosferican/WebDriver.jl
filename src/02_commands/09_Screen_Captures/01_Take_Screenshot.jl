# Command: Take Screenshot
function screenshot(session::Session)::Vector{UInt8}
    @unpack addr, id = session
	response = HTTP.get("$addr/session/$id/screenshot",
                        [("Content-Type" => "application/json")])
    @assert response.status == 200
    JSON3.read(response.body).value
end
function screenshot(element::Element)::Vector{UInt8}
    @unpack addr, id = element.session
	response = HTTP.get("$addr/session/$id/element/$(element.id)/screenshot",
                        [("Content-Type" => "application/json")])
    @assert response.status == 200
    JSON3.read(response.body).value
end