# Minimal integration test: can load library model and build a kernel context.

using Pkg
Pkg.activate(joinpath(@__DIR__, "..", "..", "packages", "JCGELibrary"))
Pkg.instantiate()

using JCGECore
using JCGEKernel
using JCGEBlocks
using JCGELibrary
using JCGELibrary.StandardCGE

sam_path = joinpath(StandardCGE.datadir(), "sam_2_2.csv")
spec = StandardCGE.model(sam_path=sam_path)

ctx = JCGEKernel.KernelContext()
for block in spec.model.blocks
    JCGECore.build!(block, ctx, spec)
end

@assert !isempty(ctx.variables)
@assert !isempty(ctx.equations)

println("Loaded StandardCGE model spec type: ", typeof(spec))
println("Built kernel context with variables: ", length(ctx.variables), " equations: ", length(ctx.equations))
