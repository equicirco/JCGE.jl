using Test
using JCGELibrary
using JCGELibrary.StandardCGE

@testset "JCGELibrary" begin
    spec = StandardCGE.model()
    @test spec.name == "StandardCGE"
end
