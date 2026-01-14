# Julia Computable General Equilibrium Framework

```@raw html
<picture>
  <source srcset="assets/jcge_logo_dark.png" media="(prefers-color-scheme: dark)">
  <img src="assets/jcge_logo_light.png" alt="JCGE" style="max-width: 320px; height: auto;">
</picture>
```

JCGE is a modular, block-based framework for Computable General Equilibrium (CGE)
modeling in Julia. This documentation is the entry point for the project: it describes
architecture, workflows, and package boundaries. Each package is developed and
documented independently, and is intended to live in the Julia General Registry.

## What this repo is

- Project overview and architecture
- Cross-package guides for modeling, calibration, and output
- A stable reference to how the ecosystem fits together

## What this repo is not

- A single monolithic package
- The source of truth for package-level APIs (each package has its own docs)

## Quick start

Install the packages you need:

```julia
import Pkg
Pkg.add([
    "JCGECore",
    "JCGEBlocks",
    "JCGERuntime",
    "JCGECalibrate",
    "JCGEOutput",
])
```

Run an example model:

```julia
using JCGEExamples
result = JCGEExamples.StandardCGE.solve()
```

For MCP models, PATHSolver is required. See the Imports guide for license setup.

## Architecture snapshot

- **JCGECore**: RunSpec, sections, sets, mappings, scenarios, and validation
- **JCGEBlocks**: reusable CGE building blocks (production, households, markets)
- **JCGERuntime**: compile and solve RunSpecs with solver backends
- **JCGECalibrate**: calibration from SAM and parameter derivation
- **JCGEOutput**: equation rendering and results containers
- **JCGEExamples**: reference models and ports of published CGE models
- **JCGEImportData**: canonical IO/SAM schema and adapters
- **JCGEImportMPSGE**: MPSGE.jl importer

Continue with the package overview and guides for detail.
