# Command: Get Element Rect
"""
    rect(element::Element)::NamedTuple{(:width, :height, :x, :y),NTuple{4,Int64}}

The Get Element Rect command returns the dimensions and coordinates of the given web element.
The returned value is a dictionary with the following members:
- x: X axis position of the top-left corner of the web element relative to the current browsing context’s document element in CSS pixels.
- y: Y axis position of the top-left corner of the web element relative to the current browsing context’s document element in CSS pixels.
- height: Height of the web element’s bounding rectangle in CSS pixels.
- width: Width of the web element’s bounding rectangle in CSS pixels.
"""
function rect(element::Element)::NamedTuple{(:width, :height, :x, :y),NTuple{4,Int64}}
    @unpack addr, id = element.session
    element_id = element.id
	response = HTTP.get("$addr/session/$id/element/$element_id/rect",
                        [("Content-Type" => "application/json")])
    @assert response.status == 200
    output = JSON3.read(response.body).value
	(width = output.width, height = output.height, x = output.x, y = output.y)::NamedTuple{(:width, :height, :x, :y),NTuple{4,Int64}}
end
