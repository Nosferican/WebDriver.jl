# Element Click
function click!(element::Element)
    @unpack addr, id = element.session
    element_id = element.id
	response = HTTP.post("$addr/session/$id/element/$element_id/click",
                         [("Content-Type" => "application/json")])
    @assert response.status == 200
    JSON3.read(response.body).value
    nothing
end