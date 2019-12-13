# Command: Naviagte to
function navigate!(session::Session, url::AbstractString)
	try
		isvalid(URI(url))
		@unpack addr, id = session
		response = HTTP.post("$addr/session/$id/url",
						 	 [("Content-Type" => "application/json")],
							  """{"url": "$url"}""")
		nothing
	catch
		throw(ArgumentError("url does not seem valid: $url"))
	end
end