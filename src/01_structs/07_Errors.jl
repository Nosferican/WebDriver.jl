"""
    WDError <: Exception
A Web Driver Exception.
"""
struct WDError <: Exception
    status::Int
    error::String
    message::String
    function WDError(err::StatusError)
        json = JSON3.read(err.response.body)
        new(err.status, json.error, json.message)
    end
end
