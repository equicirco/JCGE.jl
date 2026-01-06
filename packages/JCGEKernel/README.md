# JCGEKernel

JuMP-facing kernel for building and solving models.

## Responsibilities
- Variable and constraint registries, naming, equation tagging
- Closure mechanisms and numerics (initialization, scaling hooks)
- Diagnostics and standardized result extraction

## Dependencies
- Should depend on JCGECore (and optionally JCGECalibrate for helpers)

## Warm starts and scenario chaining
To emulate GAMS-style “solve, tweak, solve”, capture the solved state and reuse it
as starting values (optionally carrying over bounds and fixed vars).

```julia
result = JCGEKernel.run!(spec; optimizer=Ipopt.Optimizer)
state = JCGEKernel.snapshot_state(result)

spec2 = JCGEBlocks.apply_start(spec2, state.start;
    lower=state.lower, upper=state.upper, fixed=state.fixed)
result2 = JCGEKernel.run!(spec2; optimizer=Ipopt.Optimizer)
```

You can also use the shortcut:
```julia
result2 = JCGEBlocks.rerun!(spec2; from=result, optimizer=Ipopt.Optimizer)
```
