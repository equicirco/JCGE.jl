# JCGEKernel

JuMP-facing kernel for building and solving models.

## Responsibilities
- Variable and constraint registries, naming, equation tagging
- Closure mechanisms and numerics (initialization, scaling hooks)
- Diagnostics and standardized result extraction

## Dependencies
- Should depend on JCGECore (and optionally JCGECalibrate for helpers)
