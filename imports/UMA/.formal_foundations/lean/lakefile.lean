import Lake
open Lake DSL

package «universe00» where
  -- add package configuration options here

lean_lib Universe00 where
  roots := #[`Universe00]
  globs := #[.andSubmodules `Universe00]

lean_lib NavierStokes where
  roots := #[`NavierStokes]

lean_lib YangMills where
  roots := #[`YangMills]

require mathlib from git
  "https://github.com/leanprover-community/mathlib4.git"
