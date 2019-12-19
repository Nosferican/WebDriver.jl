# Command: Element Send Keys
"""
    clear!(element::Element)::Nothing

The Element Send Keys command scrolls into view the form control element and then sends the provided keys to the element.
In case the element is not keyboard-interactable, an element not interactable error is returned.

!!! note

    Keyboard keys are not implemented yet.
"""
function element_keys!(element::Element, value::AbstractString)::Nothing
    @unpack addr, id = element.session
    element_id = element.id
	response = HTTP.post("$addr/session/$id/element/$element_id/value",
						 [("Content-Type" => "application/json")],
                         JSON3.write("value" => split(value, "")))
    @assert response.status == 200
end
