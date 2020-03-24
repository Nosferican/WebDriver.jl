# Command: Get Element Tag Name
"""
    element_tag(element::Element)::String

Get Element Tag Name.
"""
function element_tag(element::Element)::String
    @unpack addr, id = element.session
    element_id = element.id
    response = HTTP.get(
        "$addr/session/$id/element/$element_id/name",
        [("Content-Type" => "application/json")],
    )
    @assert response.status == 200
    JSON3.read(response.body).value
end
