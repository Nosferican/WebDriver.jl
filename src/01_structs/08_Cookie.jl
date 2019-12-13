"""
    Cookie(obj)::Cookie
    Cookie(name::AbstractString, value;
           path::AbstractString = "/",
           domain::Union{Nothing, AbstractString} = nothing,
           secure::Bool = false,
           httpOnly::Bool = false,
           expiry::Union{Nothing, Integer, DateTime} = nothing)::Cookie

A cookie per [W3C](https://www.w3.org/TR/webdriver/#cookies).
"""
struct Cookie{V <: Union{AbstractString, Number},
              D <: Union{Nothing, AbstractString},
              E <: Union{Nothing, Integer}}
    name::String
    value::V
    path::String
    domain::D
    secure::Bool
    httpOnly::Bool
    expiry::E
    function Cookie(name::AbstractString, value;
                    path::AbstractString = "/",
                    domain::Union{Nothing, AbstractString} = nothing,
                    secure::Bool = false,
                    httpOnly::Bool = false,
                    expiry::Union{Nothing, Integer, DateTime} = nothing)::Cookie
        expiry = isa(expiry, DateTime) ? datetime2unix(expiry) : expiry
        new{typeof(value), typeof(domain), typeof(expiry)}(name, value, path, domain, secure, httpOnly, expiry)
    end
    function Cookie(obj)::Cookie
        (haskey(obj, "name") && haskey(obj, "value")) ||
            throw(ArgumentError("name and value keys are required."))
        Cookie(obj.name, obj.value,
               path = get(obj, "path", "/"),
               domain = get(obj, "domain", nothing),
               secure = get(obj, "secure", false),
               httpOnly = get(obj, "httpOnly", false),
               expiry = get(obj, "expiry", nothing))
    end
end
JSON3.StructType(::Type{<:Cookie}) = JSON3.Struct()
JSON3.omitempties(::Type{<:Cookie}) = (:domain, :expiry)