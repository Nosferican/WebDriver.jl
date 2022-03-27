# Command: Take Screenshot
"""
    screenshot(session::Session)::String
    screenshot(element::Element)::String
    screenshot(source::Union{Session, Element}, sink::Union{AbstractString, IO})

Take Screenshot and optionally saves it.
"""
function screenshot end

function screenshot(session::Session)::String
    @unpack addr, id = session
    response =
        HTTP.get("$addr/session/$id/screenshot", [("Content-Type" => "application/json; charset=utf-8")])
    @assert response.status == 200
    JSON3.read(response.body).value
end
function screenshot(element::Element)::String
    @unpack addr, id = element.session
    response = HTTP.get(
        "$addr/session/$id/element/$(element.id)/screenshot",
        [("Content-Type" => "application/json; charset=utf-8")],
    )
    @assert response.status == 200
    JSON3.read(response.body).value
end
screenshot(source::Union{Session, Element}, sink::Union{AbstractString, IO}) =
    write(sink, base64decode(source))
