"""
    WebDriver

[Repository](https://github.com/Nosferican/WebDriver.jl)
"""
module WebDriver
    for (root, dirs, files) ∈ walkdir(joinpath(@__DIR__))
        foreach(file -> include(joinpath(root, file)), filter!(file -> occursin(r"^\d{2}_\w+\.jl$", file), files))
    end
end
