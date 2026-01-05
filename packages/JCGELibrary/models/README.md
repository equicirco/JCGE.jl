# Models

Add one directory per model submodule:

- `StandardCGE/StandardCGE.jl` defining `module StandardCGE ... end`
- `StandardCGE/data/` for any model-specific inputs
- Export `model()` as the minimal required API.
