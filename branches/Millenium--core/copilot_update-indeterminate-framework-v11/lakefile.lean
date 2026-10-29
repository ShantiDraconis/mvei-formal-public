import Lake
open Lake DSL

package «Millenium-core» where
  name := "Millenium-core"

lean_lib «Core» where
  roots := #[`Core]
package "TIF" where
  name := "TIF"
  version := "0.1.0"

lean_lib «TIF» where
  srcDir := "."
  roots := #[`Core]
package «TIF» where
  name := "TIF"
  version := "0.1.0"
  keywords := #["mathematics", "logic", "indeterminate", "formalization"]
  description := "The Indeterminate Framework (TIF): a formal mathematical framework for reasoning about indeterminate expressions such as 0/0, ∞-∞, and related forms."

lean_lib «Core» where
  roots := #[`Core.Syntax, `Core.States, `Core.Semantics,
             `Core.Rewrite, `Core.Collapse, `Core.Conservativity]
  globs := #[.submodules `Core]

lean_lib «Toy» where
  roots := #[`Toy.Algebraic, `Toy.Boolean, `Toy.Linear,
             `Toy.Analytic, `Toy.Complexity]
  globs := #[.submodules `Toy]
package «millenium-core» where
  name := "millenium-core"
  version := "0.1.0"

require mathlib from git
  "https://github.com/leanprover-community/mathlib4" @ "v4.14.0"

lean_lib «Core» where
  roots := #[`Core]

lean_lib «Modules» where
  roots := #[`Modules]

@[default_target]
lean_exe «millenium-core» where
  root := `Main
package «Millenium-core» where
  name := "Millenium-core"

require mathlib from git
  "https://github.com/leanprover-community/mathlib4.git" @ "v4.14.0"

lean_lib «TIF» where
  roots := #[`TIF]
