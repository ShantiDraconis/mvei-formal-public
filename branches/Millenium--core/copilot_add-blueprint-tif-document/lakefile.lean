import Lake
open Lake DSL

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
