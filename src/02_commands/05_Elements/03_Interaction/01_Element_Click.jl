# Element Click
"""
    click!(element::Element)::Nothing

The Element Click command scrolls into view the element if it is not already pointer-interactable, and clicks its in-view center point.
If the element’s center point is obscured by another element, an element click intercepted error is returned. If the element is outside the viewport, an element not interactable error is returned.
"""
function click!(element::Element)::Nothing
    @unpack addr, id = element.session
    element_id = element.id
	response = HTTP.post("$addr/session/$id/element/$element_id/click",
                         [("Content-Type" => "application/json")])
    @assert response.status == 200
end
