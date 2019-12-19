# Command: Naviagte to
"""
	navigate!(session::Session, url::AbstractString)

The command causes the user agent to navigate the current top-level browsing context to a new location.
"""
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
