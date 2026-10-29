import Lake
open Lake DSL

package «millennium-riemann» where
  -- add package configuration options here

lean_lib «MillenniumRiemann» where
  -- add library configuration options here

@[default_target]
lean_exe «millennium-riemann» where
  root := `Main

require mathlib from git
  "https://github.com/leanprover-community/mathlib4.git"
