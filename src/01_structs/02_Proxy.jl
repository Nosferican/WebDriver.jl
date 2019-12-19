"""
	Proxy(proxyType::AbstractString;
          proxyAutoconfigUrl::Union{Nothing, AbstractString} = nothing,
          ftpProxy::Union{Nothing, AbstractString} = nothing,
          httpProxy::Union{Nothing, AbstractString} = nothing,
          noProxy::Union{Nothing, AbstractVector{<:AbstractString}} = nothing,
          sslProxy::Union{Nothing, AbstractString} = nothing,
          socksProxy::Union{Nothing, AbstractString} = nothing,
          socksVersion::Union{Nothing, Integer} = nothing)::Proxy

The proxy configuration capability is a JSON Object nested within the primary capabilities.
According to the [W3C](https://www.w3.org/TR/webdriver/#proxy).
"""
struct Proxy{pAU <: Union{Nothing, AbstractString},
			 ftpP <: Union{Nothing, AbstractString},
			 httpP <: Union{Nothing, AbstractString},
			 nP <: Union{Nothing, AbstractVector{<:AbstractString}},
			 sslP <: Union{Nothing, AbstractString},
			 sP <: Union{Nothing, AbstractString},
			 sV <: Union{Nothing, Integer}
			 }
	proxyType::String
	proxyAutoconfigUrl::pAU
	ftpProxy::ftpP
	httpProxy::httpP
	noProxy::nP
	sslProxy::sslP
	socksProxy::sP
	socksVersion::sV
	function Proxy(proxyType::AbstractString;
				   proxyAutoconfigUrl::Union{Nothing, AbstractString} = nothing,
				   ftpProxy::Union{Nothing, AbstractString} = nothing,
				   httpProxy::Union{Nothing, AbstractString} = nothing,
				   noProxy::Union{Nothing, AbstractVector{<:AbstractString}} = nothing,
				   sslProxy::Union{Nothing, AbstractString} = nothing,
				   socksProxy::Union{Nothing, AbstractString} = nothing,
				   socksVersion::Union{Nothing, Integer} = nothing)::Proxy
		proxyType ∈ ["pac", "direct", "autodetect", "system", "manual"] ||
            throw(ArgumentError("""valid proxyType values: "pac", "direct", "autodetect", "system", or "manual"."""))
        proxyType == "pac" && isnothing(proxyAutoconfigUrl) && throw(ArgumentError("proxyAutoconfigUrl must be provided for proxyType pac"))
        if !isnothing(socksProxy)
            isnothing(socksVersion) && throw(ArgumentError("socksVersion must be provided for socksProxy"))
            0 ≤ socksVersion ≤ 255 || throw(ArgumentError("valid values for socksVersion: any integer between 0 and 255 inclusive."))
        end
		new{typeof(proxyAutoconfigUrl),
			typeof(ftpProxy),
			typeof(httpProxy),
			typeof(noProxy),
			typeof(sslProxy),
			typeof(socksProxy),
			typeof(socksVersion)}(proxyType, proxyAutoconfigUrl, ftpProxy, httpProxy, noProxy, sslProxy, socksProxy, socksVersion)
	end
end
summary(io::IO, obj::Proxy) = println(io, "Proxy")
function show(io::IO, obj::Proxy)
	print(io, summary(obj))
end
