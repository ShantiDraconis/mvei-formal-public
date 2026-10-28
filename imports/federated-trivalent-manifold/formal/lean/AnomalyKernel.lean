import Mathlib.Data.Real.Basic
import Mathlib.Tactic

namespace AnomalyKernel

def seffSquared (alpha beta t e : ℝ) : ℝ :=
  (alpha * t ^ 2 - beta * e ^ 2) ^ 2

def wRate (alpha beta epsilon t e : ℝ) : ℝ :=
  seffSquared alpha beta t e + epsilon

/-- The defined rate is strictly positive when the regulator is positive.
    This is an algebraic model property, not a theorem about OS availability. -/
theorem wRate_positive
    (alpha beta epsilon t e : ℝ) (hEpsilon : 0 < epsilon) :
    0 < wRate alpha beta epsilon t e := by
  unfold wRate seffSquared
  nlinarith [sq_nonneg (alpha * t ^ 2 - beta * e ^ 2)]

/-- Exact symbolic derivative of the declared squared potential with respect
    to e, represented as an identity of algebraic expressions. -/
theorem partial_e_identity (alpha beta t e : ℝ) :
    -4 * beta * e * (alpha * t ^ 2 - beta * e ^ 2) =
      4 * beta ^ 2 * e ^ 3 - 4 * alpha * beta * t ^ 2 * e := by
  ring

/-- The affine clock lemma proves only strict monotonicity of this function. -/
theorem affineClock_strictMono (W0 epsilon : ℝ) (hEpsilon : 0 < epsilon) :
    StrictMono (fun t : ℝ => W0 + epsilon * t) := by
  intro t1 t2 hTime
  nlinarith

end AnomalyKernel
