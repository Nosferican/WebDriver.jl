# Command: Get Element Text
function element_text(element::Element)
    @unpack addr, id = element.session
    element_id = element.id
	response = HTTP.get("$addr/session/$id/element/$element_id/text",
                        [("Content-Type" => "application/json")])
	@assert response.status == 200
	JSON3.read(response.body).value
end