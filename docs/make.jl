push!(LOAD_PATH, joinpath("..", "src"))

using Documenter, PkgTPL

DocMeta.setdocmeta!(PkgTPL, :DocTestSetup, :(using PkgTPL), recursive = true)

makedocs(sitename = "PkgTPL",
         modules = [PkgTPL],
         pages = [
             "Home" => "index.md",
             "API" => "api.md"
         ]
)

deploydocs(
    repo   = "github.com/Nosferican/PkgTPL.jl.git",
    push_preview = true
)
