import Lake
open Lake DSL

-- Package uses kebab-case for filesystem/URL compatibility
-- Library uses PascalCase for Lean module naming convention
package «mishkan-iii-core» where
  -- add package configuration options here

lean_lib «MishkanIiiCore» where
  -- add library configuration options here
  roots := #[`core]

@[default_target]
lean_exe «mishkan-iii-core» where
  root := `Main
