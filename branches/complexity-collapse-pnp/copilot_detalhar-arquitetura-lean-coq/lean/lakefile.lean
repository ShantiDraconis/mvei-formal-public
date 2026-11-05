import Lake
open Lake DSL

package «complexity-collapse-pnp» where
  -- add package configuration options here

lean_lib «ComplexityTheory» where
  -- add library configuration options here

@[default_target]
lean_exe «complexity-collapse-pnp» where
  root := `Main
