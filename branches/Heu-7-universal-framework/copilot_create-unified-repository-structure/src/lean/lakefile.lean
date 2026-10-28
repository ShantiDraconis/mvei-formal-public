import Lake
open Lake DSL

package «heu» where
  version := v!"0.1.0"
  keywords := #["mathematics", "millennium-problems", "ordinals", "ZFC"]
  leanOptions := #[
    ⟨`pp.unicode.fun, true⟩
  ]

require mathlib from git
  "https://github.com/leanprover-community/mathlib4"

@[default_target]
lean_lib «HEU» where
  srcDir := "HEU"
