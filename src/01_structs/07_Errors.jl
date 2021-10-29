"""
    WDError <: Exception
A Web Driver Exception.
"""
struct WDError <: Exception
    status::Int
    error::String
    message::String
end

function WDError(err::StatusError)
    json = JSON3.read(err.response.body)
    WDError(err.status, json.error, json.message)
end
