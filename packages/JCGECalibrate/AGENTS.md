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
