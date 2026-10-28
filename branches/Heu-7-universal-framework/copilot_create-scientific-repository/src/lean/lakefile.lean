import Lake
open Lake DSL

package HEU where
  version := v!"1.0.0"
  leanOptions := #[
    ⟨`pp.unicode.fun, true⟩,
    ⟨`autoImplicit, false⟩
  ]

@[default_target]
lean_lib HEU where
  srcDir := "HEU"
  globs := #[.submodules `HEU]

require mathlib from git
  "https://github.com/leanprover-community/mathlib4" @ "v4.3.0"
