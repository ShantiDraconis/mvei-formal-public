import Lake
open Lake DSL

package mishkanIIICore where
  -- add package configuration options here

lean_lib Core where
  roots := #[`Core]
  -- add library configuration options here

@[default_target]
lean_exe mishkanIIICore where
  root := `Main
