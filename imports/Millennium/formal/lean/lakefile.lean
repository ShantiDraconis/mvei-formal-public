import Lake
open Lake DSL

package «tuns» where
  -- Package configuration

require mathlib from git
  "https://github.com/leanprover-community/mathlib4.git"

@[default_target]
lean_lib «TUNS» where
  -- Library configuration
  globs := #[.submodules `TUNS]

lean_lib «Problems» where
  -- Problems library
  globs := #[.submodules `TUNS.Problems]
