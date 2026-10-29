import Lake
open Lake DSL

package «mishkan-iii-core» where
  -- Project metadata
  version := "1.0.0-yeshu"
  -- Additional package configuration options can go here

lean_lib «MishkanCore» where
  -- Library configuration
  roots := #[`MishkanCore]

@[default_target]
lean_exe «mishkan» where
  root := `Main
  -- Executable configuration
