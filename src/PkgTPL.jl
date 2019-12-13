"""
    PkgTPL

[Repository](https://github.com/Nosferican/PkgTPL.jl)
"""
module PkgTPL
    for (root, dirs, files) ∈ walkdir(joinpath(@__DIR__))
        foreach(file -> include(joinpath(root, file)), filter!(file -> occursin(r"^\d{2}_\w+\.jl$", file), files))
    end
end
