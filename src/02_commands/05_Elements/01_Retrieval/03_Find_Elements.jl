# Command: Find Elements
"""
    Elements(session::Session, location_strategy::AbstractString, value::AbstractString)::Vector{Element}

Find Elements

See also: [`Element`](@ref)
"""
function Elements(
    session::Session,
    location_strategy::AbstractString,
    value::AbstractString,
)::Vector{Element}
    location_strategy ∈
    ["css selector", "link text", "partial link text", "tag name", "xpath"] ||
    throw(ArgumentError("""location_strategy must be "css selector", "link text", "partial link text", "tag name" or "xpath"."""))
    @unpack addr, id = session
    response = HTTP.post(
        "$addr/session/$id/elements",
        [("Content-Type" => "application/json")],
        JSON3.write(Dict("using" => location_strategy, "value" => value)),
    )
    @assert response.status == 200
    Element.(session, first(values(node)) for node in JSON3.read(response.body).value)
end
