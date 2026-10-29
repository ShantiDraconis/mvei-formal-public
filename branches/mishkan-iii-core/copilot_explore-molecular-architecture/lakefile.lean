import Lake
open Lake DSL

package «mishkan-iii-core» where
  -- add package configuration options here

lean_lib Core where
  -- add library configuration options here
  roots := #[`Core]
  globs := #[.submodules `Core]

@[default_target]
lean_exe «mishkan-iii-core» where
  root := `Main
