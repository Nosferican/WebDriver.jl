push!(LOAD_PATH, joinpath("..", "src"))

using Documenter, WebDriver

DocMeta.setdocmeta!(WebDriver,
                    :DocTestSetup,
                    :(using WebDriver;
                      ENV["WEBDRIVER_HOST"] = get(ENV, "WEBDRIVER_HOST", "selenium");
                      ENV["WEBDRIVER_PORT"] = get(ENV, "WEBDRIVER_PORT", "4444")),
                    recursive = true)

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
