# Command: Is Element Enabled
"""
    isenabled(element::Element)::Bool

Is Element Enabled.
"""
function isenabled(element::Element)::Bool
    @unpack addr, id = element.session
    element_id = element.id
    response = HTTP.get(
        "$addr/session/$id/element/$element_id/enabled",
        [("Content-Type" => "application/json; charset=utf-8")],
    )
    @assert response.status == 200
    JSON3.read(response.body).value
end
