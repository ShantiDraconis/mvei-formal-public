import Lake
open Lake DSL

package «t-state»

require mathlib from git
  "https://github.com/leanprover-community/mathlib4" @ "v4.34.0"

@[default_target]
lean_lib TState where
  srcDir := "lean"
