using Test
using JCGEExamples
using JCGEExamples.StandardCGE
using JCGEExamples.SimpleCGE
using JCGEExamples.LargeCountryCGE
using JCGEExamples.TwoCountryCGE
using JCGEKernel
using JuMP
using Ipopt
import MathOptInterface as MOI

@testset "JCGEExamples" begin
    sam_path = joinpath(StandardCGE.datadir(), "sam_2_2.csv")
    spec = StandardCGE.model(sam_path=sam_path)
    @test spec.name == "StandardCGE"

    lrg_sam = joinpath(LargeCountryCGE.datadir(), "sam_2_2.csv")
    lrg_spec = LargeCountryCGE.model(sam_path=lrg_sam)
    @test lrg_spec.name == "LargeCountryCGE"

    two_spec = TwoCountryCGE.model()
    @test two_spec.name == "TwoCountryCGE"
end

if get(ENV, "JCGE_SOLVE_TESTS", "0") == "1"
    @testset "JCGEExamples.Solve" begin
        sam_path = joinpath(StandardCGE.datadir(), "sam_2_2.csv")
        spec = StandardCGE.model(sam_path=sam_path)
        result = JCGEKernel.run!(spec; optimizer=Ipopt.Optimizer, dataset_id="standard_cge_test")
        status = MOI.get(result.context.model, MOI.TerminationStatus())
        @test status in (MOI.OPTIMAL, MOI.LOCALLY_SOLVED, MOI.FEASIBLE_POINT)

        spec_simple = SimpleCGE.model()
        result_simple = JCGEKernel.run!(spec_simple; optimizer=Ipopt.Optimizer, dataset_id="simple_cge_test")
        status_simple = MOI.get(result_simple.context.model, MOI.TerminationStatus())
        @test status_simple in (MOI.OPTIMAL, MOI.LOCALLY_SOLVED, MOI.FEASIBLE_POINT)

        lrg_sam = joinpath(LargeCountryCGE.datadir(), "sam_2_2.csv")
        spec_large = LargeCountryCGE.model(sam_path=lrg_sam)
        result_large = JCGEKernel.run!(spec_large; optimizer=Ipopt.Optimizer, dataset_id="large_country_cge_test")
        status_large = MOI.get(result_large.context.model, MOI.TerminationStatus())
        @test status_large in (MOI.OPTIMAL, MOI.LOCALLY_SOLVED, MOI.FEASIBLE_POINT)

        spec_two = TwoCountryCGE.model()
        result_two = JCGEKernel.run!(spec_two; optimizer=Ipopt.Optimizer, dataset_id="two_country_cge_test")
        status_two = MOI.get(result_two.context.model, MOI.TerminationStatus())
        @test status_two in (MOI.OPTIMAL, MOI.LOCALLY_SOLVED, MOI.FEASIBLE_POINT)
    end
end

if get(ENV, "JCGE_COMPARE_STANDARD", "0") == "1"
    @testset "JCGEExamples.Compare.StandardCGE" begin
        using Pkg
        Pkg.add("StandardCGE")
        import StandardCGE as StdCGE

        sam_path = joinpath(StandardCGE.datadir(), "sam_2_2.csv")
        sam_table = StdCGE.load_sam_table(sam_path)
        std_model, _, _ = StdCGE.solve_model(sam_table; optimizer_attributes=Dict("print_level" => 0))
        std_obj = JuMP.objective_value(std_model)
        std_Xp = JuMP.value.(std_model[:Xp])

        spec = StandardCGE.model(sam_path=sam_path)
        result = JCGEKernel.run!(spec; optimizer=Ipopt.Optimizer, dataset_id="standard_cge_compare")
        ours_model = result.context.model
        ours_obj = JuMP.objective_value(ours_model)
        goods = spec.model.sets.commodities
        ours_Xp = [JuMP.value(result.context.variables[Symbol("Xp_", g)]) for g in goods]

        @test isfinite(std_obj)
        @test isfinite(ours_obj)
        @test isapprox.(ours_Xp, std_Xp; rtol=1e-5, atol=1e-6) |> all
    end
end
