# JCGEExamples

A package that bundles **model definitions** (as submodules) for the JCGE ecosystem.

## What belongs here
- Named model modules implemented as Julia submodules.
- Model constructors returning a **spec** or **builder object** (recommended: `RunSpec`/`ModelSpec` + optional default scenarios).
- Small toy datasets that are safe to ship in-repo (optional), under `models/<ModelName>/data/`.

## What does NOT belong here
- Core framework code (data model, calibration, kernel, generic blocks): those stay in `JCGECore`, `JCGECalibrate`, `JCGEKernel`, `JCGEBlocks`, `JCGECircular`.
- Large, licensed, or country SAM datasets unless distribution rights are clear.
- Solver-specific configuration that is not part of the model definition.

## Expected user-facing usage
Typical usage should look like:

- `using JCGEExamples`
- `using JCGEExamples.<ModelName>`
- `spec = <ModelName>.model()` (returns a spec/object that the framework can build/run)

## Folder layout
- `src/`: package module entrypoint
- `models/<ModelName>/`: module file and all model-specific resources
  - `models/<ModelName>/<ModelName>.jl`: model submodule
  - `models/<ModelName>/data/`: optional small benchmark inputs
  - `models/<ModelName>/docs/`: optional model notes and documentation

## Models
- `StandardCGE`: Chapter 6 (STDCGE, SEQ=276)
- `SimpleCGE`: Chapter 5 (SPLCGE, SEQ=275)
- `LargeCountryCGE`: Chapter 10.2 (LRGCGE, SEQ=277)
- `TwoCountryCGE`: Chapter 10.3 (TWOCGE, SEQ=278)
- `MonopolyCGE`: Chapter 10.4 (MONCGE, SEQ=279)
- `QuotaCGE`: Chapter 10.5 (QUOCGE, SEQ=280)
- `ScaleEconomyCGE`: Chapter 10.6 (IRSCGE, SEQ=281)
- `DynCGE`: Recursive-dynamic model (DYNCGE, SEQ=410, Japanese edition)

## Optional solve tests (CI)
Solver-based tests are gated behind `JCGE_SOLVE_TESTS=1` and are run via a manual GitHub Actions workflow:
- Workflow: `.github/workflows/solve-tests.yml`
- Trigger: workflow_dispatch only

## Optional StandardCGE.jl comparison
A separate manual workflow compares results against the external `StandardCGE.jl` package:
- Workflow: `.github/workflows/compare-standardcge.yml`
- Env flags: `JCGE_SOLVE_TESTS=1`, `JCGE_COMPARE_STANDARD=1`
