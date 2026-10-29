import Lake
open Lake DSL

package «mishkan-iii-core» where
  -- add package configuration options here

lean_lib «MishkanIII» where
  -- add library configuration options here
  roots := #[`MishkanIII]

@[default_target]
lean_exe «mishkan-iii-core» where
  root := `Main
