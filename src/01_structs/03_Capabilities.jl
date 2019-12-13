# TODO
# Add browser specific options
"""
	Capabilities(browserName::AbstractString;
                 browserVersion::AbstractString = "",
                 platformName::AbstractString = "",
                 acceptInsecureCerts::Union{Nothing, Bool} = nothing,
                 pageLoadStrategy::AbstractString = "",
                 proxy::Union{Nothing, Proxy} = nothing,
                 setWindowRect::Union{Nothing, Bool} = nothing,
                 timeouts::Timeouts = Timeouts(),
                 strictFileInteractability::Union{Nothing, Bool} = nothing,
                 unhandledPromptBehavior::AbstractString = "dismiss and notify"
                 )::Capabilities

According to [W3C](https://www.w3.org/TR/webdriver/#dfn-extension-capability).
	
# Example

```jldoctest
julia> capabilities = Capabilities("chrome")
Remote WebDriver Capabilities
  browserName: chrome
  Session Timeouts -- script: 30000, pageLoad: 300000, implicit: 0
  unhandledPromptBehavior: dismiss and notify
```
"""
struct Capabilities{aIC <: Union{Nothing, Bool},
					P <: Union{Nothing, Proxy},
					sWR <: Union{Nothing, Bool},
					sFI <: Union{Nothing, Bool}}
	browserName::String
	browserVersion::String
	platformName::String
	acceptInsecureCerts::aIC
	pageLoadStrategy::String
	proxy::P
	setWindowRect::sWR
	timeouts::Timeouts
	strictFileInteractability::sFI
	unhandledPromptBehavior::String
	function Capabilities(browserName::AbstractString;
						  browserVersion::AbstractString = "",
						  platformName::AbstractString = "",
						  acceptInsecureCerts::Union{Nothing, Bool} = nothing,
						  pageLoadStrategy::AbstractString = "",
						  proxy::Union{Nothing, Proxy} = nothing,
						  setWindowRect::Union{Nothing, Bool} = nothing,
						  timeouts::Timeouts = Timeouts(),
						  strictFileInteractability::Union{Nothing, Bool} = nothing,
						  unhandledPromptBehavior::AbstractString = "dismiss and notify"
						  )
		new{typeof(acceptInsecureCerts),
			typeof(proxy),
			typeof(setWindowRect),
			typeof(strictFileInteractability)
			}(browserName, browserVersion, platformName, acceptInsecureCerts, pageLoadStrategy, proxy, setWindowRect, timeouts, strictFileInteractability,
			  unhandledPromptBehavior)
	end
end
summary(io::IO, obj::Capabilities) = println(io, "Remote WebDriver Capabilities")
function show(io::IO, obj::Capabilities)
	print(io, summary(obj))
	println(io, "  browserName: $(obj.browserName)")
	println(io, "  $(obj.timeouts)")
	for pn ∈ (pn for pn ∈ propertynames(obj) if pn ∉ [:browserName, :timeouts])
		value = getproperty(obj, pn)
		isnothing(value) || value == "" || println(io, "  $pn: $(getproperty(obj, pn))")
	end
end
JSON3.StructType(::Type{<:Capabilities}) = JSON3.Struct()
JSON3.omitempties(::Type{<:Capabilities}) = fieldnames(Capabilities)