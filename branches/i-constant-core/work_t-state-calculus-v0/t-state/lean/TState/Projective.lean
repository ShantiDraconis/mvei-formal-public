import Mathlib.Basic.Real.Basic

namespace TState

/-- Real projective line with one ideal point.
This is intentionally distinct from the signed analytic horizons. -/
inductive ProjectiveReal where
  | finite (x : ℝ)
  | infinity

namespace ProjectiveReal

noncomputable def reciprocal : ProjectiveReal → ProjectiveReal
  | .finite x => if x = 0 then .infinity else .finite x⁻¹
  | .infinity => .finite 0

@[simp] theorem reciprocal_infinity :
    reciprocal .infinity = .finite 0 := rfl

@[simp] theorem reciprocal_zero :
    reciprocal (.finite 0) = .infinity := by
  simp [reciprocal]

theorem reciprocal_nonzero (x : ℝ) (hx : x ≠ 0) :
    reciprocal (.finite x) = .finite x⁻¹ := by
  simp [reciprocal, hx]

@[simp] theorem reciprocal_involutive (x : ProjectiveReal) :
    reciprocal (reciprocal x) = x := by
  cases x with
  | infinity => simp [reciprocal]
  | finite x =>
      by_cases hx : x = 0
      · subst x
        simp [reciprocal]
      · simp [reciprocal, hx]

end ProjectiveReal
end TState
