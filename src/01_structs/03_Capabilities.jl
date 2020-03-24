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
```
"""
struct Capabilities{
    aIC<:Union{Nothing,Bool},
    P<:Union{Nothing,Proxy},
    sWR<:Union{Nothing,Bool},
    sFI<:Union{Nothing,Bool},
}
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
    function Capabilities(
        browserName::AbstractString;
        browserVersion::AbstractString = "",
        platformName::AbstractString = "",
        acceptInsecureCerts::Union{Nothing,Bool} = nothing,
        pageLoadStrategy::AbstractString = "",
        proxy::Union{Nothing,Proxy} = nothing,
        setWindowRect::Union{Nothing,Bool} = nothing,
        timeouts::Timeouts = Timeouts(),
        strictFileInteractability::Union{Nothing,Bool} = nothing,
        unhandledPromptBehavior::AbstractString = "dismiss and notify",
    )
        new{
            typeof(acceptInsecureCerts),
            typeof(proxy),
            typeof(setWindowRect),
            typeof(strictFileInteractability),
        }(
            browserName,
            browserVersion,
            platformName,
            acceptInsecureCerts,
            pageLoadStrategy,
            proxy,
            setWindowRect,
            timeouts,
            strictFileInteractability,
            unhandledPromptBehavior,
        )
    end
end
summary(io::IO, obj::Capabilities) = println(io, "Remote WebDriver Capabilities")
function show(io::IO, obj::Capabilities)
    print(io, summary(obj))
    println(io, "browserName: $(obj.browserName)")
end
JSON3.StructType(::Type{<:Capabilities}) = JSON3.Struct()
omitempties(::Type{<:Capabilities}) = fieldnames(Capabilities)
