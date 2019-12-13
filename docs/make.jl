push!(LOAD_PATH, joinpath("..", "src"))

using Documenter, WebDriver

DocMeta.setdocmeta!(WebDriver, :DocTestSetup, :(using WebDriver), recursive = true)

makedocs(sitename = "WebDriver",
         modules = [WebDriver],
         pages = [
             "Home" => "index.md",
             "API" => "api.md"
         ]
)

deploydocs(
    repo   = "github.com/Nosferican/WebDriver.jl.git",
    push_preview = true
)
