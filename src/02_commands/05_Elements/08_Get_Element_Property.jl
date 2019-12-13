# Command: Get Element Property
function property(element::Element, property::AbstractString)
    @unpack addr, id = element.session
    element_id = element.id
	response = HTTP.get("$addr/session/$id/element/$element_id/property/$property",
                        [("Content-Type" => "application/json")])
	@assert response.status == 200
	JSON3.read(response.body).value
end