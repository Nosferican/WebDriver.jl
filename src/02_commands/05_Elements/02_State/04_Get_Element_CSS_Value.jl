# Command: Get Element CSS Value
"""
    element_css(element::Element, value::AbstractString)

Get Element CSS Value
"""
function element_css(element::Element, value::AbstractString)
    @unpack addr, id = element.session
    element_id = element.id
    response = HTTP.get(
        "$addr/session/$id/element/$element_id/css/$value",
        [("Content-Type" => "application/json; charset=utf-8")],
    )
    @assert response.status == 200
    JSON3.read(response.body).value
end
