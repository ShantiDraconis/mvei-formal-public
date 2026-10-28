import Lake
open Lake DSL

package «hodge» where
  version := v!"0.1.0"
  keywords := #["mathematics", "hodge-conjecture", "algebraic-geometry"]
  description := "Formalization of the Hodge Conjecture"

-- Pin to a specific Mathlib version for reproducible builds
require mathlib from git
  "https://github.com/leanprover-community/mathlib4.git" @ "v4.12.0"

@[default_target]
lean_lib Hodge where
  srcDir := "src"
