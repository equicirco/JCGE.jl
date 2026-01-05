module JCGEBlocks

using JCGECore
using JCGEKernel

export DummyBlock

"Minimal example block used to validate end-to-end wiring."
struct DummyBlock <: JCGECore.AbstractBlock
    name::Symbol
end

function JCGECore.build!(block::DummyBlock, ctx::JCGEKernel.KernelContext, spec::JCGECore.RunSpec)
    JCGEKernel.register_variable!(ctx, Symbol(block.name, :_x), 1.0)
    JCGEKernel.register_equation!(ctx; tag=:dummy_eq, block=block.name, payload="x==1 (placeholder)")
    return nothing
end

end # module
