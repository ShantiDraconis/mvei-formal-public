import Lake
open Lake DSL

package «mishkan-iii-core» where
  version := v!"0.1.0"
  -- add package configuration options here

lean_lib «MishkanCore» where
  -- add library configuration options here

@[default_target]
lean_exe «mishkan-iii-core» where
  root := `Main
