# Command: Switch to Patent Frame
function parent_frame!(session::Session)
    @unpack addr, id = session
	response = HTTP.post("$addr/session/$id/frame/parent",
                         [("Content-Type" => "application/json")])
	@assert response.status == 200
	nothing
end