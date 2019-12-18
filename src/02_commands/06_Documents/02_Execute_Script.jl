# Command: Execute Script
"""
    script!(session::Session, script::AbstractString, args...; async::Bool = false)
Executes JavaScript (sync / async)
!!! note
    This command uses the JSON Wire Protocol instead of the current W3c WebDriver API.
"""
function script!(session::Session, _script::AbstractString, args...; async::Bool = false)
    # args = (selecttype, "Selenium IDE")
    # _script = "arguments[0].value = arguments[1];"
    # async = false
    # println(JSON3.write(Dict("script" => _script,
    # "args" => [ isa(arg, Element) ? "Element" => [arg.id] : arg for arg ∈ args ])))
    @unpack addr, id = session
    response = HTTP.post("$addr/session/$id/execute$(async ? "_async" : "")",
                         [("Content-Type" => "application/json")],
                         JSON3.write(Dict("script" => _script,
                                     "args" => [ isa(arg, Element) ? "ELEMENT" => arg.id : arg for arg ∈ args ])))
    @assert response.status == 200
    JSON3.read(response.body).value
end