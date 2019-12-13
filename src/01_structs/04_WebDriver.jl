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
  Session Timeouts -- script: 30000, pageLoad: 300000, implicit: 0
  unhandledPromptBehavior: dismiss and notify
julia> wd = RemoteWebDriver(capabilities, host = "selenium")
RemoteWebDriver{Capabilities{Nothing,Nothing,Nothing,Nothing}}("http://selenium:4444/wd/hub", Remote WebDriver Capabilities
  browserName: chrome
  Session Timeouts -- script: 30000, pageLoad: 300000, implicit: 0
  unhandledPromptBehavior: dismiss and notify
, Dict{String,Union{Int64, String}}())
```
"""
struct RemoteWebDriver{C <: Capabilities}
	addr::String
	capabilities::C
	kw::Dict{String, Union{Int, String}}
	function RemoteWebDriver(capabilities::Capabilities;
							 host::AbstractString = "localhost",
							 port::Integer = 4444,
							 path::AbstractString = "/wd/hub",
							 kwargs...
							 )::RemoteWebDriver
		addr = URI(scheme = "http",
				   host = host,
				   port = port,
                   path = path)
		isvalid(addr) || throw(ArgumentError("$addr is invalid"))
		addr = string(addr)
		kw = Dict{String, Union{Int, String}}(string(k) => isa(v, Bool) ? string(v) : v for (k, v) ∈ kwargs if !isnothing(v))
		new{typeof(capabilities)}(addr, capabilities, kw)
	end
end