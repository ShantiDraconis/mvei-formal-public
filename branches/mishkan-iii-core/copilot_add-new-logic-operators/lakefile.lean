import Lake
open Lake DSL

package «mishkan-iii-core» where
  -- add package configuration options here

require mathlib from git
  "https://github.com/leanprover-community/mathlib4.git" @ "v4.3.0-rc2"

@[default_target]
lean_lib MishkanCore where
  roots := #[`Core]
  globs := #[.submodules `Core]
