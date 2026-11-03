import Lake
open Lake DSL

package «riemann-energy-torus» where
  version := v!"0.1.0"

@[default_target]
lean_lib «Riemann» where
  srcDir := "."

lean_lib «Util» where
  srcDir := "."
