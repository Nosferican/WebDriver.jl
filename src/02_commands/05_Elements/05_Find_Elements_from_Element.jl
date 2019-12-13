# Command: Find Elements from Element
function elements(element::Element, location_strategy::AbstractString, value::AbstractString)
    location_strategy ∈ ["css selector", "link text", "partial link text", "tag name", "xpath"] ||
        throw(ArgumentError("""location_strategy must be "css selector", "link text", "partial link text", "tag name" or "xpath"."""))
    @unpack addr, id = session
    element_id = element.id
	response = HTTP.post("$addr/session/$id/element/$element_id/elements",
                         [("Content-Type" => "application/json")],
                         JSON3.write(Dict("using" => location_strategy,
                                          "value" => value)))
	@assert response.status == 200
	Element.(session, first(values(node)) for node ∈ JSON3.read(response.body).value)
end