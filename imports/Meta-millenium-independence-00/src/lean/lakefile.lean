import Lake
open Lake DSL

package «MetaMillennium» where
  -- add package configuration options here

lean_lib «MetaMillennium» where
  -- add library configuration options here

@[default_target]
lean_exe «meta-millennium» where
  root := `Main
