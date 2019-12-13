# Get All Cookies
function cookies(session::Session)
    @unpack addr, id = session
    response = HTTP.get("$addr/session/$id/cookie",
                        [("Content-Type" => "application/json")])
    @assert response.status == 200
    convert(Vector{Cookie}, Cookie.(JSON3.read(response.body).value))::Vector{Cookie}
end