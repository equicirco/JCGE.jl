using Documenter

makedocs(
    sitename = "JCGE",
    format = Documenter.HTML(
        prettyurls = get(ENV, "CI", "false") == "true",
        inventory_version = "dev",
        assets = [
            "assets/logo-theme.js",
            "assets/logo.css",
        ],
    ),
    pages = [
        "Home" => "index.md",
        "Project" => "project.md",
        "Getting Started" => "getting-started.md",
        "Packages" => "packages.md",
        "Guides" => [
            "Modeling" => "guides/modeling.md",
            "Running Models" => "guides/running.md",
            "Blocks" => "guides/blocks.md",
            "Calibration" => "guides/calibration.md",
            "Output & Reporting" => "guides/output.md",
            "Imports" => "guides/imports.md",
        ],
        "Contact & Citation" => "contact.md",
    ],
)

deploydocs(
    repo = "github.com/equicirco/JCGE.org.git",
    branch = "gh-pages",
    devbranch = "main",
    versions = nothing,
)
