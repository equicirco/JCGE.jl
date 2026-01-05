# Development Guide (AGENTS)

## Scope
Describe what belongs in this package and what does not.

## Public API
- Keep the exported surface minimal.
- Document every exported type/function in the README or docstrings.
- Breaking changes are allowed until v0.1; after that, follow semver.

## Dependency rules
- Avoid upward dependencies (extensions must not be depended on by core packages).
- Prefer pure Julia types/functions where possible.
- JuMP is allowed only in kernel and packages that explicitly build equations.

## Testing
- Unit tests must run with: `julia --project=. -e 'using Pkg; Pkg.test()'`.
- Add regression tests for calibration and benchmark replication as soon as available.

## Milestones
- [ ] Establish minimal types and validation (if applicable)
- [ ] Add first usable API surface
- [ ] Add representative tests
- [ ] Add one minimal usage snippet in README

## RunSpec contract (v0.1)

### Required fields
- `RunSpec.name::String`
- `RunSpec.model::ModelSpec`
- `RunSpec.closure::ClosureSpec`
- `RunSpec.scenario::ScenarioSpec`

### ModelSpec required fields
- `ModelSpec.sets::Sets`
- `ModelSpec.mappings::Mappings`
- `ModelSpec.blocks::Vector{<:AbstractBlock}` (may be temporarily `Vector{Any}` during early refactors)

### Optional fields (explicitly NOT required for v0.1)
- data references (SAM paths, satellite accounts, concordances)
- units/currency/base year metadata
- solver configuration
- output/report configuration


## Scenario delta rules (v0.1)
- `ScenarioSpec` is a **delta** relative to the baseline model configuration.
- `ScenarioSpec.shocks` must not duplicate baseline content; it only records changes.
- Shock keys must be **namespaced** to avoid collisions, e.g.:
  - `:tax.vat.new`
  - `:subsidy.repair`
  - `:sigma.use_appliances`


## Block protocol rules (v0.1)
- `build!(block, ctx, spec)` must be **purely additive**:
  - register variables and equations in `ctx`
  - must not solve the model
- Blocks must not read files directly; they consume inputs from `spec` (and `data` when introduced).
- Every equation added by a block must be registered with at least:
  - `block` tag (`Symbol`)
  - `tag` (`Symbol`)
- No “hidden equations”: all model-defining constraints must go through the registry.
