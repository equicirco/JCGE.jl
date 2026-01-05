module JCGEBlocks

using JCGECore
using JCGEKernel

export DummyBlock
export StandardCGEBlock

"Minimal example block used to validate end-to-end wiring."
struct DummyBlock <: JCGECore.AbstractBlock
    name::Symbol
end

function JCGECore.build!(block::DummyBlock, ctx::JCGEKernel.KernelContext, spec::JCGECore.RunSpec)
    JCGEKernel.register_variable!(ctx, Symbol(block.name, :_x), 1.0)
    JCGEKernel.register_equation!(ctx; tag=:dummy_eq, block=block.name, payload="x==1 (placeholder)")
    return nothing
end

struct StandardCGEBlock <: JCGECore.AbstractBlock
    name::Symbol
    sam_table::Any
    start::Any
    params::Any
end

function var_name(block::StandardCGEBlock, base::Symbol, idxs::Symbol...)
    if isempty(idxs)
        return Symbol(string(block.name), "_", base)
    end
    return Symbol(string(block.name), "_", base, "_", join(string.(idxs), "_"))
end

function register_var!(ctx::JCGEKernel.KernelContext, block::StandardCGEBlock, base::Symbol, idxs::Symbol...)
    name = var_name(block, base, idxs...)
    JCGEKernel.register_variable!(ctx, name, (base=base, indices=idxs))
    return nothing
end

function register_eq!(ctx::JCGEKernel.KernelContext, block::StandardCGEBlock, tag::Symbol, idxs::Symbol...)
    JCGEKernel.register_equation!(ctx; tag=tag, block=block.name, payload=(indices=idxs))
    return nothing
end

function JCGECore.build!(block::StandardCGEBlock, ctx::JCGEKernel.KernelContext, spec::JCGECore.RunSpec)
    # Placeholder registry wiring for the StandardCGE port.
    goods = spec.model.sets.commodities
    factors = spec.model.sets.factors

    for i in goods
        register_var!(ctx, block, :Y, i)
        register_var!(ctx, block, :Z, i)
        register_var!(ctx, block, :Xp, i)
        register_var!(ctx, block, :Xg, i)
        register_var!(ctx, block, :Xv, i)
        register_var!(ctx, block, :E, i)
        register_var!(ctx, block, :M, i)
        register_var!(ctx, block, :Q, i)
        register_var!(ctx, block, :D, i)
        register_var!(ctx, block, :py, i)
        register_var!(ctx, block, :pz, i)
        register_var!(ctx, block, :pq, i)
        register_var!(ctx, block, :pe, i)
        register_var!(ctx, block, :pm, i)
        register_var!(ctx, block, :pd, i)
        register_var!(ctx, block, :Tz, i)
        register_var!(ctx, block, :Tm, i)
    end

    for h in factors
        register_var!(ctx, block, :pf, h)
    end

    register_var!(ctx, block, :epsilon)
    register_var!(ctx, block, :Sp)
    register_var!(ctx, block, :Sg)
    register_var!(ctx, block, :Td)

    for h in factors, i in goods
        register_var!(ctx, block, :F, h, i)
    end

    for i in goods, j in goods
        register_var!(ctx, block, :X, i, j)
    end

    for i in goods
        register_eq!(ctx, block, :eqpy, i)
        register_eq!(ctx, block, :eqY, i)
        register_eq!(ctx, block, :eqpzs, i)
        register_eq!(ctx, block, :eqTz, i)
        register_eq!(ctx, block, :eqTm, i)
        register_eq!(ctx, block, :eqXg, i)
        register_eq!(ctx, block, :eqXv, i)
        register_eq!(ctx, block, :eqXp, i)
        register_eq!(ctx, block, :eqpe, i)
        register_eq!(ctx, block, :eqpm, i)
        register_eq!(ctx, block, :eqpqs, i)
        register_eq!(ctx, block, :eqM, i)
        register_eq!(ctx, block, :eqD, i)
        register_eq!(ctx, block, :eqpzd, i)
        register_eq!(ctx, block, :eqE, i)
        register_eq!(ctx, block, :eqDs, i)
        register_eq!(ctx, block, :eqpqd, i)
    end

    for h in factors, i in goods
        register_eq!(ctx, block, :eqF, h, i)
    end

    for i in goods, j in goods
        register_eq!(ctx, block, :eqX, i, j)
    end

    register_eq!(ctx, block, :eqTd)
    register_eq!(ctx, block, :eqSp)
    register_eq!(ctx, block, :eqSg)
    register_eq!(ctx, block, :eqepsilon)

    for h in factors
        register_eq!(ctx, block, :eqpf, h)
    end

    return nothing
end

end # module
