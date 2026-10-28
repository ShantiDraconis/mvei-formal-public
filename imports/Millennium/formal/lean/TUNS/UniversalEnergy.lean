/-
UniversalEnergy.lean

Universal energy functional in TUNS.
-/

import TUNS.Framework
import Mathlib.Data.Real.Basic

namespace TUNS

/-- Energy functional on a framework -/
structure Energy (F : Framework) where
  /-- Energy value for each configuration -/
  value : F.X → ℝ
  /-- Energy is non-negative -/
  nonneg : ∀ x : F.X, 0 ≤ value x

/-- Universal energy construction -/
structure UniversalEnergy where
  /-- Energy for each framework -/
  energies : (F : Framework) → Energy F
  /-- Universal bound on energy -/
  universal_bound : ℝ
  /-- All energies are bounded -/
  bounded : ∀ (F : Framework) (x : F.X), 
            (energies F).value x ≤ universal_bound

end TUNS
