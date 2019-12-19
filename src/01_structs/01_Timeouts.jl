"""
	Timeouts

According to the [W3C](https://www.w3.org/TR/webdriver/#timeouts).

```jldoctest
julia> Timeouts(script = 50_000, pageLoad = 100_000, implicit = 5)
Session Timeouts -- script: 50000, pageLoad: 100000, implicit: 5
```
"""
struct Timeouts
	script::Int
	pageLoad::Int
	implicit::Int
	function Timeouts(;script::Integer = 30_000,
					   pageLoad::Integer = 300_000,
					   implicit::Integer = 0)
		script > 0 || throw(ArgumentError("script timeout should be a positive integer"))
		pageLoad > 0 || throw(ArgumentError("pageLoad timeout should be a positive integer"))
		implicit ≥ 0 || throw(ArgumentError("implicit timeout should be a non-negative integer"))
		new(script, pageLoad, implicit)
	end
end
summary(io::IO, obj::Timeouts) = print(io, "Session Timeouts")
function show(io::IO, obj::Timeouts)
	print(io, summary(obj))
	print(io, " -- script: $(obj.script), pageLoad: $(obj.pageLoad), implicit: $(obj.implicit)")
end
JSON3.StructType(::Type{Timeouts}) = JSON3.Struct()
