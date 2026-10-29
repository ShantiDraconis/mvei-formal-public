import Lake
open Lake DSL

package «mishkan-iii-core» where
  -- add package configuration options here

lean_lib Thesis where
  -- add library configuration options here

@[default_target]
lean_exe «mishkan-iii-core» where
  root := `Main
