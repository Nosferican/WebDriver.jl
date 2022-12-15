# Command: Get Element Property
"""
    element_property(element::Element, property::AbstractString)

Get Element Property.
"""
function element_property(element::Element, property::AbstractString)
    script!(
        element.session,
        "return arguments[0][arguments[1]];",
        element,
        property
        )
end
