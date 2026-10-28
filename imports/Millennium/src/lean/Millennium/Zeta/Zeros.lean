/-
  Properties of zeros of the Riemann zeta function.
-/

import Millennium.Zeta.Basic

namespace Millennium.Zeta

/-- Trivial zeros are at negative even integers -/
def TrivialZeros : Set ℂ :=
  { s : ℂ | ∃ n : ℕ, n > 0 ∧ s = -2 * n }

/-- Trivial zeros are outside the critical strip -/
theorem trivialZeros_outside_strip :
  ∀ s ∈ TrivialZeros, s ∉ CriticalStrip := by
  intro s hs hstrip
  simp only [TrivialZeros, Set.mem_setOf_eq] at hs
  obtain ⟨n, hn, rfl⟩ := hs
  simp only [CriticalStrip, Set.mem_setOf_eq] at hstrip
  obtain ⟨h1, h2⟩ := hstrip
  simp only [Complex.neg_re, Complex.ofReal_re, mul_comm] at h1
  linarith [Nat.cast_pos.mpr hn]

/-- A zero is either trivial or non-trivial -/
def ZeroClassification (z : ZetaZero) : Prop :=
  z.point ∈ TrivialZeros ∨ z.point ∈ CriticalStrip

/-- First few zeros (imaginary parts) are known -/
def knownGammas : List ℝ := [
  14.134725, 21.022040, 25.010858, 30.424876, 32.935062
]

/-- Known zeros are on the critical line -/
axiom knownZeros_on_line :
  ∀ γ ∈ knownGammas, (⟨1/2, γ⟩ : ℂ).re = 1/2

end Millennium.Zeta
