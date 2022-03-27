# Get All Cookies
"""
    cookies(session::Session)::Vector{Cookie}

The Get Page Source command returns a string serialization of the DOM of the current browsing context active document.
"""
function cookies(session::Session)::Vector{Cookie}
    @unpack addr, id = session
    response =
        HTTP.get("$addr/session/$id/cookie", [("Content-Type" => "application/json; charset=utf-8")])
    @assert response.status == 200
    convert(Vector{Cookie}, Cookie.(JSON3.read(response.body).value))
end
