# Command: Get Element Attribute
"""
    element_attr(element::Element, attribute::AbstractString)

Get Element Attribute.
"""
function element_attr(element::Element, attribute::AbstractString)
    @unpack addr, id = element.session
    element_id = element.id
	response = HTTP.get("$addr/session/$id/element/$element_id/attribute/$attribute",
                        [("Content-Type" => "application/json")])
	@assert response.status == 200
	JSON3.read(response.body).value
end
