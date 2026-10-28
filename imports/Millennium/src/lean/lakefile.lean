import Lake
open Lake DSL

package Millennium where
  version := v!"0.1.0"
  leanOptions := #[
    ⟨`autoImplicit, false⟩
  ]

@[default_target]
lean_lib Millennium where
  roots := #[`Millennium]

require mathlib from git
  "https://github.com/leanprover-community/mathlib4" @ "master"
