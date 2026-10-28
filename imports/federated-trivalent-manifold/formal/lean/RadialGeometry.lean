import Mathlib.Data.Real.Basic
import Mathlib.Tactic

namespace RadialGeometry

/-- Squared radius of the midpoint of a generic reflected pair. -/
def rc2 (gamma : ℝ) : ℝ := gamma ^ 2 + 1 / 4

/-- Squared modulus of `1/2 + delta + i gamma`, written over the reals. -/
def rPlus2 (delta gamma : ℝ) : ℝ := rc2 gamma + delta + delta ^ 2

/-- Squared modulus of `1/2 - delta + i gamma`, written over the reals. -/
def rMinus2 (delta gamma : ℝ) : ℝ := rc2 gamma - delta + delta ^ 2

def parityDefect (delta gamma : ℝ) : ℝ :=
  (rPlus2 delta gamma + rMinus2 delta gamma) / 2 - rc2 gamma

def radialWeight (delta gamma : ℝ) : ℝ :=
  2 * delta ^ 2 / (rPlus2 delta gamma * rMinus2 delta gamma)

theorem radius_difference (delta gamma : ℝ) :
    (rPlus2 delta gamma - rMinus2 delta gamma) / 2 = delta := by
  simp [rPlus2, rMinus2, rc2]
  ring

theorem parity_defect_eq_square (delta gamma : ℝ) :
    parityDefect delta gamma = delta ^ 2 := by
  simp [parityDefect, rPlus2, rMinus2, rc2]
  ring

theorem parity_defect_nonnegative (delta gamma : ℝ) :
    0 ≤ parityDefect delta gamma := by
  rw [parity_defect_eq_square]
  exact sq_nonneg delta

theorem radial_weight_nonnegative (delta gamma : ℝ)
    (hdenom : 0 < rPlus2 delta gamma * rMinus2 delta gamma) :
    0 ≤ radialWeight delta gamma := by
  unfold radialWeight
  exact div_nonneg (by positivity) (le_of_lt hdenom)

end RadialGeometry
