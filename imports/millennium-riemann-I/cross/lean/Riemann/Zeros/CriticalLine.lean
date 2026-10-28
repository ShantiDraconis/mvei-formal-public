/-
Critical zeros: zeros on the critical line Re(s) = 1/2.

These are the expected zeros according to the Riemann Hypothesis.
-/

import Riemann.Zeros.Nontrivial

namespace Riemann.Zeros

open Complex

/-- A critical zero is a nontrivial zero on the critical line -/
structure CriticalZero extends NontrivialZero where
  on_line : onCriticalLine s

/-- Critical zeros satisfy the critical line property -/
theorem critical_zero_on_line (z : CriticalZero) :
  z.s.re = (1 : ℝ) / 2 := z.on_line

/-- All critical zeros are nontrivial zeros -/
def CriticalZero.toNontrivialZero (z : CriticalZero) : NontrivialZero :=
  z.toNontrivialZero

/-- Every critical zero satisfies isCriticalZero predicate -/
theorem critical_zero_is_critical (z : CriticalZero) :
  isCriticalZero z.toNontrivialZero := by
  unfold isCriticalZero onCriticalLine
  exact z.on_line

/-- Distance from critical line is zero for critical zeros -/
theorem critical_zero_distance (z : CriticalZero) :
  distanceFromCriticalLine z.s = 0 := by
  unfold distanceFromCriticalLine
  simp [z.on_line]
  norm_num

end Riemann.Zeros
