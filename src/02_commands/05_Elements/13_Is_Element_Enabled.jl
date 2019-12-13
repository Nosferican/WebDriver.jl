# Command: Is Element Enabled
function isenabled(element::Element)
    @unpack addr, id = element.session
    element_id = element.id
	response = HTTP.get("$addr/session/$id/element/$element_id/enabled",
                        [("Content-Type" => "application/json")])
    @assert response.status == 200
    JSON3.read(response.body).value
end