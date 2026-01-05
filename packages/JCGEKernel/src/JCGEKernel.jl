module JCGEKernel

export KernelContext, register_variable!, register_equation!, list_equations

"Minimal kernel context with registries."
mutable struct KernelContext
    variables::Dict{Symbol,Any}
    equations::Vector{NamedTuple}
end

KernelContext() = KernelContext(Dict{Symbol,Any}(), NamedTuple[])

"Register a variable handle under a symbolic name."
function register_variable!(ctx::KernelContext, name::Symbol, handle)
    ctx.variables[name] = handle
    return handle
end

"Register an equation with tags and an opaque payload."
function register_equation!(ctx::KernelContext; tag::Symbol, block::Symbol, payload)
    push!(ctx.equations, (tag=tag, block=block, payload=payload))
    return nothing
end

list_equations(ctx::KernelContext) = ctx.equations

end # module
