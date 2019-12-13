# Command: Element Send Keys
function element_keys!(element::Element, value::AbstractString)
    @unpack addr, id = element.session
    element_id = element.id
	response = HTTP.post("$addr/session/$id/element/$element_id/value",
						 [("Content-Type" => "application/json")],
                         JSON3.write("value" => split(value, "")))
    @assert response.status == 200
    JSON3.read(response.body).value
end