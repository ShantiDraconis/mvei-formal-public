import Mathlib
import UMI_RH.NBAnchor

namespace UMI_RH

-- Canonical invariant
def I_RH : ℝ := d^2

/-- Equivalence RH ↔ I_RH = 0, using the anchored distance characterization. -/
theorem RH_equiv_I : RH ↔ I_RH = 0 := by
  have hsq : (I_RH = 0) ↔ (d = 0) := by
    simpa [I_RH] using (sq_eq_zero_iff (a := d))
  simpa [hsq] using NB_BD_anchor

end UMI_RH
