# Command: Get Named Cookie
"""
    cookie(session::Session, cookie::AbstractString)::Cookie

Get Named Cookie.
"""
function cookie(session::Session, cookie::AbstractString)
    # x = "WhoIsAwesome"
    @unpack addr, id = session
    response = HTTP.get(
        "$addr/session/$id/cookie/$(escapeuri(cookie))",
        [("Content-Type" => "application/json; charset=utf-8")],
    )
    @assert response.status == 200
    JSON3.read(response.body).value
end
