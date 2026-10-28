import Mathlib

namespace FiniteScale

/-- Finite resource comparison; not equality of complexity classes. -/
def EffectiveClose (clock epsilon : ℝ) (N k : ℕ) : Prop :=
  0 < clock ∧ 0 ≤ epsilon ∧
    ∀ n : ℕ, n ≤ N →
      |((2 : ℝ) ^ n - (n : ℝ) ^ k) / clock| ≤ epsilon

/-- The sharp truncation projector retains exactly N coordinates. -/
def retained (N : ℕ) : Finset ℕ := Finset.range N

theorem retained_card (N : ℕ) : (retained N).card = N := by
  simp [retained]

def thresholdIndicator (threshold value : ℝ) : Bool :=
  decide (threshold ≤ value)

theorem thresholdIndicator_true_iff (threshold value : ℝ) :
    thresholdIndicator threshold value = true ↔ threshold ≤ value := by
  simp [thresholdIndicator]

/-- Closed form for the constant-forcing linear model e'=-a*e-b. -/
def linearFlow (a b e0 t : ℝ) : ℝ :=
  (e0 + b / a) * Real.exp (-a * t) - b / a

theorem linearFlow_initial (a b e0 : ℝ) (ha : a ≠ 0) :
    linearFlow a b e0 0 = e0 := by
  simp [linearFlow, ha]

/-- The limiting offset of the constant-forcing model is negative. -/
theorem linearFlow_offset_negative (a b : ℝ) (ha : 0 < a) (hb : 0 < b) :
    -(b / a) < 0 := by
  positivity

end FiniteScale
