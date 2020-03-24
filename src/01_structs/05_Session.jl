"""
	Session

This is a web session.

```jldoctest
julia> capabilities = Capabilities("chrome")
Remote WebDriver Capabilities
browserName: chrome
julia> wd = RemoteWebDriver(capabilities, host = ENV["WEBDRIVER_HOST"], port = parse(Int, ENV["WEBDRIVER_PORT"]))
Remote WebDriver
julia> session = Session(wd)
Session
julia> isa(session, Session)
true
julia> delete!(session);

```
"""
struct Session{D<:Object}
    addr::String
    id::String
    attrs::D
    function Session(wd::RemoteWebDriver)
        @unpack addr = wd
        response = HTTP.post(
            "$(wd.addr)/session",
            [("Content-Type" => "application/json")],
            JSON3.write(Dict("desiredCapabilities" => wd.capabilities, wd.kw...)),
        )
        @assert response.status == 200
        json = JSON3.read(response.body)
        new{typeof(json.value)}(addr, json.sessionId, json.value)
    end
end
broadcastable(obj::Session) = Ref(obj)
summary(io::IO, obj::Session) = println(io, "Session")
function show(io::IO, obj::Session)
    print(io, summary(obj))
end
