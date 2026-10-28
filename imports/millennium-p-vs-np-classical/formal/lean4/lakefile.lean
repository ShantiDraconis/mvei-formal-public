import Lake
open Lake DSL

package PvsNP where
  -- Package configuration
  leanOptions := #[
    ⟨`autoImplicit, false⟩
  ]

@[default_target]
lean_lib PvsNP where
  -- Library configuration
  globs := #[.submodules `PvsNP]

require mathlib from git
  "https://github.com/leanprover-community/mathlib4.git"
