# Command: Element Clear
"""
    clear!(element::Element)::Nothing

Element Clear
"""
function clear!(element::Element)::Nothing
    @unpack addr, id = element.session
    element_id = element.id
    response = HTTP.post(
        "$addr/session/$id/element/$element_id/clear",
        [("Content-Type" => "application/json; charset=utf-8")],
    )
    @assert response.status == 200
end
