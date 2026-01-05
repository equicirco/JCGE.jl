using Test
using JCGELibrary
using JCGELibrary.StandardCGE

@testset "JCGELibrary" begin
    sam_path = joinpath(StandardCGE.datadir(), "sam_2_2.csv")
    spec = StandardCGE.model(sam_path=sam_path)
    @test spec.name == "StandardCGE"
end
