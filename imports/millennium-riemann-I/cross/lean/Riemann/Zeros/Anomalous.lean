/-
Anomalous zeros: zeros off the critical line.

These are treated as "singularities" or "defects" in the 
vertical symmetry of the zeta function.
-/

import Riemann.Zeros.Nontrivial
import Riemann.Zeros.CriticalLine

namespace Riemann.Zeros

open Complex

/-- An anomalous zero is a nontrivial zero off the critical line -/
structure AnomalousZero extends NontrivialZero where
  off_line : offCriticalLine s

/-- Anomalous zeros are not on the critical line -/
theorem anomalous_zero_off_line (z : AnomalousZero) :
  z.s.re ≠ (1 : ℝ) / 2 := z.off_line

/-- All anomalous zeros are nontrivial zeros -/
def AnomalousZero.toNontrivialZero (z : AnomalousZero) : NontrivialZero :=
  z.toNontrivialZero

/-- Every anomalous zero satisfies isAnomalousZero predicate -/
theorem anomalous_zero_is_anomalous (z : AnomalousZero) :
  isAnomalousZero z.toNontrivialZero := by
  unfold isAnomalousZero offCriticalLine
  exact z.off_line

/-- Anomalous zeros have nonzero distance from critical line -/
theorem anomalous_zero_distance_pos (z : AnomalousZero) :
  distanceFromCriticalLine z.s > 0 := by
  unfold distanceFromCriticalLine
  simp
  exact abs_pos.mpr (sub_ne_zero.mpr z.off_line)

/-- Anomalous zeros are either left or right of the critical line -/
theorem anomalous_zero_side (z : AnomalousZero) :
  z.s.re < (1 : ℝ) / 2 ∨ z.s.re > (1 : ℝ) / 2 := by
  have h := z.off_line
  omega

/-- An anomalous zero to the left -/
def anomalousLeft (z : AnomalousZero) : Prop :=
  z.s.re < (1 : ℝ) / 2

/-- An anomalous zero to the right -/
def anomalousRight (z : AnomalousZero) : Prop :=
  z.s.re > (1 : ℝ) / 2

/-- Every anomalous zero is either left or right -/
theorem anomalous_left_or_right (z : AnomalousZero) :
  anomalousLeft z ∨ anomalousRight z := by
  exact anomalous_zero_side z

end Riemann.Zeros
