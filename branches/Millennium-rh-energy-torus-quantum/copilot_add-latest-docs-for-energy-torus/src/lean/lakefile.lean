import Lake
open Lake DSL

package «riemann» where
  version := v!"0.1.0"

lean_lib «Riemann» where
  roots := #[`Riemann]

lean_lib «Util» where
  roots := #[`Util]

@[default_target]
lean_exe «riemann» where
  root := `Main

require mathlib from git
  "https://github.com/leanprover-community/mathlib4.git"
