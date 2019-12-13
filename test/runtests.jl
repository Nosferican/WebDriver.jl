using Test, Documenter, PkgTPL
DocMeta.setdocmeta!(PkgTPL, :DocTestSetup, :(using PkgTPL), recursive = true)

@testset "PkgTPL" begin
    doctest(PkgTPL)
end
