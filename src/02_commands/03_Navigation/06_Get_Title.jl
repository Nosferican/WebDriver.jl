# Command: Get Title
"""
	document_title(session::Session)::String

This command returns the document title of the current top-level browsing context, equivalent to calling document.title.
"""
function document_title(session::Session)::String
    @unpack addr, id = session
    response = HTTP.get("$addr/session/$id/title", [("Content-Type" => "application/json; charset=utf-8")])
    @assert response.status == 200
    JSON3.read(response.body).value
end
