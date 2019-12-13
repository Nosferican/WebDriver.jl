"""
	Session

This is a web session.

```jldoctest
julia> capabilities = Capabilities("chrome")
Remote WebDriver Capabilities
  browserName: chrome
  Session Timeouts -- script: 30000, pageLoad: 300000, implicit: 0
  unhandledPromptBehavior: dismiss and notify
julia> wd = RemoteWebDriver(capabilities, host = "selenium")
RemoteWebDriver{Capabilities{Nothing,Nothing,Nothing,Nothing}}("http://selenium:4444/wd/hub", Remote WebDriver Capabilities
  browserName: chrome
  Session Timeouts -- script: 30000, pageLoad: 300000, implicit: 0
  unhandledPromptBehavior: dismiss and notify
, Dict{String,Union{Int64, String}}())
julia> session = Session(wd);

julia> isa(session, Session)
true
```
"""
struct Session{D <: Object}
	addr::String
	id::String
	attrs::D
	function Session(wd::RemoteWebDriver)
		@unpack addr = wd
		response = HTTP.post("$(wd.addr)/session",
	                         [("Content-Type" => "application/json")],
							 JSON3.write(Dict("desiredCapabilities" => wd.capabilities,
											   wd.kw...)))
		@assert response.status == 200
		json = JSON3.read(response.body)
		new{typeof(json.value)}(addr, json.sessionId, json.value)
	end
end
broadcastable(obj::Session) = Ref(obj)