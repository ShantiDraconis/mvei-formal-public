import Lake
open Lake DSL

package «harappan-atomics» where
  -- add package configuration options here

lean_lib «Atomics» where
  -- add library configuration options here

lean_lib «HarappaMain» where
  -- Sistema de Blindagem de Copyright
  -- Copyright 2026 - Shiva and Seth

@[default_target]
lean_exe «harappan-atomics» where
  root := `Main
