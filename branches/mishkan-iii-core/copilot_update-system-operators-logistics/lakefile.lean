import Lake
open Lake DSL

package «mishkan-iii-core» where
  -- add package configuration options here
  version := "1.0.0"

lean_lib MishkanIII where
  -- Main library with all modules under MishkanIII namespace
  roots := #[`MishkanIII]
  globs := #[.submodules `MishkanIII]

require mathlib from git
  "https://github.com/leanprover-community/mathlib4.git"
