# Command: Get Element Text
"""
    element_text(element::Element)::String

The Get Element Text command intends to return an element’s text "as rendered".
An element's rendered text is also used for locating a elements by their link text and partial link text.
"""
function element_text(element::Element)::String
    @unpack addr, id = element.session
    element_id = element.id
    response = HTTP.get(
        "$addr/session/$id/element/$element_id/text",
        [("Content-Type" => "application/json; charset=utf-8")],
    )
    @assert response.status == 200
    JSON3.read(response.body).value
end
