module StandardCGE

using JCGECore
using JCGEKernel
using JCGEBlocks

export model

"Return a minimal runnable RunSpec for StandardCGE (placeholder wiring)."
function model()
    sets = JCGECore.Sets([:c1], [:a1], [:lab], [:hh])
    mappings = JCGECore.Mappings(Dict(:a1 => :c1))
    blocks = Any[JCGEBlocks.DummyBlock(:standard)]
    ms = JCGECore.ModelSpec(blocks, sets, mappings)
    closure = JCGECore.ClosureSpec(:CPI)
    scenario = JCGECore.ScenarioSpec(:baseline, Dict{Symbol,Any}())
    spec = JCGECore.RunSpec("StandardCGE", ms, closure, scenario)
    JCGECore.validate(spec)
    return spec
end

end # module
