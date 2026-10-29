import Lake
open Lake DSL

package «mishkan-iii-core» where
  -- add package configuration options here

lean_lib «MishkanIII» where
  -- add library configuration options here

@[default_target]
lean_lib «Core» where
  globs := [.submodules `Core]
