import Lake
open Lake DSL

package «zero-engine-00» where
  -- add package configuration options here

lean_lib «ZeroEngine» where
  -- add library configuration options here
  srcDir := "src/formal_verification"
  roots := #[`ZeroEngine]

@[default_target]
lean_exe «zero-engine-00» where
  root := `Main
  -- Enables the use of the Lean interpreter by the executable (e.g.,
  -- `runFrontend`) at the expense of increased binary size on Linux.
  -- Remove this line if you do not need such functionality.
  supportInterpreter := true
