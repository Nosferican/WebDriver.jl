"""
    Element(session::Session, location_strategy::AbstractString, value::AbstractString)::Element
    Element(element::Element, location_strategy::AbstractString, value::AbstractString)::Element

Finds an element based on a session or element.
May use a location strategy from "css selector", "link text", "partial link text", "tag name" or "xpath".
"""
struct Element
    session::Session
    id::String
    Element(session::Session, id::AbstractString) = new(session, id)
    # Return Element
    Element(element::Element, id::AbstractString) = new(element.session, id)
    # Command: Find Element
    function Element(session::Session, location_strategy::AbstractString, value::AbstractString)::Element
        location_strategy ∈ ["css selector", "link text", "partial link text", "tag name", "xpath"] ||
            throw(ArgumentError("""location_strategy must be "css selector", "link text", "partial link text", "tag name" or "xpath"."""))
        @unpack addr, id = session
        # location_strategy = "xpath"
        # value = "//select[@id='selecttype']"
	    response = HTTP.post("$addr/session/$id/element",
                             [("Content-Type" => "application/json")],
                             JSON3.write(Dict("using" => location_strategy,
                                              "value" => value)))
	    @assert response.status == 200
	    new(session, first(values(JSON3.read(response.body).value)))
    end
    # Command: Find Element from Element
    function Element(element::Element, location_strategy::AbstractString, value::AbstractString)::Element
        location_strategy ∈ ["css selector", "link text", "partial link text", "tag name", "xpath"] ||
            throw(ArgumentError("""location_strategy must be "css selector", "link text", "partial link text", "tag name" or "xpath"."""))
        @unpack addr, id = element.session
        element_id = element.id
	    response = HTTP.post("$addr/session/$id/element/$element_id/element",
                             [("Content-Type" => "application/json")],
                             JSON3.write(Dict("using" => location_strategy,
                                              "value" => value)))
	    @assert response.status == 200
        new(element.session, first(values(JSON3.read(response.body).value)))
    end
end
broadcastable(obj::Element) = Ref(obj)
summary(io::IO, obj::Element) = println(io, "Element")
function show(io::IO, obj::Element)
	print(io, summary(obj))
end
