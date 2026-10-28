import Lake
open Lake DSL
package «EmergentTheta»

package «HEU» where
  moreLeanArgs := #[]

require mathlib from git
  "https://github.com/leanprover-community/mathlib4" @ "v4.8.0"

@[default_target]
target heu : Unit := do
  Lean.Compiler.compile #[`HEU.BasicDefs, `HEU.ArithmeticSystems, `HEU.EmergentOperators, `HEU.AxiomsHEU, `HEU.MainTheorems]
