# Command: Send Alert Text
function alert_text!(session::Session, text::AbstractString)
    @unpack addr, id = session
    response = HTTP.post("$addr/session/$id/alert_text",
                         [("Content-Type" => "application/json")],
                         JSON3.write(Dict("text" => text)))
    @assert response.status == 200
end