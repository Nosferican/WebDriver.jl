# Command: Get Element Attribute
"""
    element_attr(element::Element, attribute::AbstractString)

Get Element Attribute.
"""
function element_attr(element::Element, attribute::AbstractString)
    script!(
        element.session,
        "return arguments[0].getAttribute(arguments[1]);",
        element,
        attribute
        )
end
