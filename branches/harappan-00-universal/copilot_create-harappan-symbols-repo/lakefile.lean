import Lake
open Lake DSL

package «harappan» where
  -- add package configuration options here

lean_lib «Harappan» where
  -- add library configuration options here
  srcDir := "src/lean"

@[default_target]
lean_exe «harappan» where
  root := `Main
