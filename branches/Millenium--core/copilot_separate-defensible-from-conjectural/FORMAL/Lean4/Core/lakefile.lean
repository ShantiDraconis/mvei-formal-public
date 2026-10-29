-- FORMAL/Lean4/Core/lakefile.lean
-- Lean 4 project configuration for the Millennium Core formal library.

import Lake
open Lake DSL

package «millennium-core» where
  name := "millennium-core"
  version := "0.1.0"

require mathlib from git
  "https://github.com/leanprover-community/mathlib4" @ "v4.14.0"

lean_lib «MillenniumCore» where
  roots := #[`MillenniumCore]
