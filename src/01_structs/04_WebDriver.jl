"""
	RemoteWebDriver(capabilities::Capabilities;
                    host::AbstractString = "localhost",
                    port::Integer = 4444,
                    path::AbstractString = "/wd/hub",
					kwargs...)::RemoteWebDriver

Specifies a remote web driver according to [W3C](https://www.w3.org/TR/webdriver).

```jldoctest
julia> capabilities = Capabilities("chrome")
Remote WebDriver Capabilities
browserName: chrome
julia> wd = RemoteWebDriver(capabilities, host = ENV["WEBDRIVER_HOST"], port = parse(Int, ENV["WEBDRIVER_PORT"]))
Remote WebDriver
julia> status(wd) # Ready to accept new sessions?
true
```
"""
struct RemoteWebDriver{C<:Capabilities}
    addr::String
    capabilities::C
    kw::Dict{String,Union{Int,String}}
    function RemoteWebDriver(
        capabilities::Capabilities;
        host::AbstractString = "localhost",
        port::Integer = 4444,
        path::AbstractString = "",
        kwargs...,
    )::RemoteWebDriver
        addr = URI(scheme = "http", host = host, port = port, path = path)
        isvalid(addr) || throw(ArgumentError("$addr is invalid"))
        addr = string(addr)
        kw = Dict{String,Union{Int,String}}(
            string(k) => isa(v, Bool) ? string(v) : v for (k, v) ∈ kwargs if !isnothing(v)
        )
        new{typeof(capabilities)}(addr, capabilities, kw)
    end
end
summary(io::IO, obj::RemoteWebDriver) = println(io, "Remote WebDriver")
function show(io::IO, obj::RemoteWebDriver)
    print(io, summary(obj))
end
