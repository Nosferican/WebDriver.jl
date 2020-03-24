# Command: Get Active Element
"""
	active_element(session::Session)::Element

Get Active Element
"""
function active_element(session::Session)::Element
    @unpack addr, id = session
    response = HTTP.post(
        "$addr/session/$id/element/active",
        [("Content-Type" => "application/json")],
    )
    @assert response.status == 200
    Element(session, first(values(JSON3.read(response.body).value)))
end
