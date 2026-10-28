-- lakefile.lean
-- Lean 4 Project Configuration for Cryptographic Logic Foundations
-- Author: Tiago Fagliari / Shanti Draconis

import Lake
open Lake DSL

package «cryptographic-logic-foundations» where
  version := "0.1.0"
  -- Add any package-wide configuration here

require mathlib from git
  "https://github.com/leanprover-community/mathlib4.git"

@[default_target]
lean_lib «CryptographicLogicFoundations» where
  -- Add library configuration here
  roots := #[`Riemann, `Complexity, `NavierStokes]
