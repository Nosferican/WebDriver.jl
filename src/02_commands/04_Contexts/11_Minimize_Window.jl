# Command: Minimize Window
function minimize!(session::Session; window::AbstractString = "current")
	window = "current"
	@unpack addr, id = session
	response = HTTP.post("$addr/session/$id/window/$window/minimize",
						 [("Content-Type" => "application/json")])
	@assert response.status == 200
	Dict{Symbol,Int}(JSON3.read(x.response.body).value)
end