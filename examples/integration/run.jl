# Minimal integration test: can load library model and build a kernel context.

using JCGECore
using JCGEKernel
using JCGEBlocks
using JCGELibrary
using JCGELibrary.StandardCGE

spec = StandardCGE.model()

ctx = JCGEKernel.KernelContext()
for block in spec.model.blocks
    JCGECore.build!(block, ctx, spec)
end

@assert !isempty(ctx.variables)
@assert !isempty(ctx.equations)

println("Loaded StandardCGE model spec type: ", typeof(spec))
println("Built kernel context with variables: ", length(ctx.variables), " equations: ", length(ctx.equations))
