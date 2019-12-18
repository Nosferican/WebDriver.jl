# Command: Is Element Selected
function isselected(element::Element)
	@unpack addr, id = session
	element_id = element.id
	response = HTTP.get("$addr/session/$id/element/$element_id/active",
						[("Content-Type" => "application/json")])
	@assert response.status == 200
	JSON3.read(response.body).value
end
