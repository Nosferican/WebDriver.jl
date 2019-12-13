# Command: Add Cookie
function cookie!(session::Session, cookie::Cookie)
    @unpack addr, id = session
    response = HTTP.post("$addr/session/$id/cookie",
                         [("Content-Type" => "application/json")],
                         JSON3.write("cookie" => cookie))
    @assert response.status == 200
    nothing
end