# Command: Delete Cookie
"""
    delete!(session::Session, cookie::AbstractString)::Nothing

If cookie = "", delete all cookies. Otherwise, delete cookie matching the "cookie" name.
"""
function delete!(session::Session, cookie::AbstractString)::Nothing
    @unpack addr, id = session
    if isempty(cookie)
        response = HTTP.delete(
            "$addr/session/$id/cookie",
            [("Content-Type" => "application/json; charset=utf-8")],
        )
        @assert response.status == 200
    else
        response = HTTP.delete(
            "$addr/session/$id/cookie/$(escapeuri(cookie))",
            [("Content-Type" => "application/json; charset=utf-8")],
        )
        @assert response.status == 200
    end
    nothing
end
