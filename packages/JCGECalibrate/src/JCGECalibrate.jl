module JCGECalibrate

export rho_from_sigma, sigma_from_rho
export calibrate_ces_share_scale

"Convert CES elasticity sigma to rho (rho = (sigma - 1)/sigma)."
rho_from_sigma(sigma::Real) = (sigma - 1) / sigma

"Convert CES rho back to sigma (sigma = 1/(1-rho))."
sigma_from_rho(rho::Real) = 1 / (1 - rho)

"""
Calibrate CES share/scale parameters (placeholder).
Return a NamedTuple so callers can evolve without breaking.
"""
function calibrate_ces_share_scale(; shares::AbstractVector, scale::Real=1.0)
    return (α = collect(shares), A = scale)
end

end # module
