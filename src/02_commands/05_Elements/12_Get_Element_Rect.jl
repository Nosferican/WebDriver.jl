# Command: Get Element Rect
"""
    rect(element::Element)::NamedTuple
Return the size of the element in pixels.
"""
function rect(element::Element)
    @unpack addr, id = element.session
    element_id = element.id
	response = HTTP.get("$addr/session/$id/element/$element_id/rect",
                        [("Content-Type" => "application/json")])
    @assert response.status == 200
    output = JSON3.read(response.body).value
	(width = output.width, height = output.height, x = output.x, y = output.y)::NamedTuple{(:width, :height, :x, :y),NTuple{4,Int64}}
end
