import Lake
open Lake DSL

package «p-vs-np-formalization» {
  -- add package configuration options here
}

require mathlib from git
  "https://github.com/leanprover-community/mathlib4.git"

@[default_target]
lean_lib «PvsNP» {
  -- add library configuration options here
}
