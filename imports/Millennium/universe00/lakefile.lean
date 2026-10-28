import Lake
open Lake DSL

package «universe00» where
  -- add package configuration options here

lean_lib «Universe00» where
  -- add library configuration options here

@[default_target]
lean_exe «universe00» where
  root := `Main
  -- Supports the whole executable, not just the `Main` module
