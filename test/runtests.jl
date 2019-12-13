using Test, Documenter, WebDriver
DocMeta.setdocmeta!(WebDriver, :DocTestSetup, :(using WebDriver), recursive = true)

@testset "WebDriver" begin
    doctest(WebDriver)
end
