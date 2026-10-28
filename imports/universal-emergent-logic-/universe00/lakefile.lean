import Lake
open Lake DSL

package «universe00» where
  -- Classical error-based framework for Millennium Prize Problems
  -- No non-classical logic, no relaxed equality, no undefined symbols
  -- Every proof is measured by error vector convergence

def moreServerArgs := #[
  "-Dpp.unicode.fun=true", -- pretty-prints `fun a ↦ b`
  "-Dpp.proofs.withType=false"
]

lean_lib «Universe00» where
  -- Core: Fundamental types and structures
  -- Problems: Millennium Prize Problem reformulations
  -- Examples: Concrete ledger instances
  globs := #[.andSubmodules `Universe00]
  moreLeanArgs := moreServerArgs

@[default_target]
lean_exe «universe00» where
  root := `Main
  moreLinkArgs := #[
    "-L./.lake/packages/mathlib/build/lib",
    "-lInit"
  ]
  version := v!"0.1.0"

require mathlib from git
  "https://github.com/leanprover-community/mathlib4.git"

@[default_target]
lean_lib «Universe00» where
  roots := #[`Universe00]
