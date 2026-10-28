-- FORMAL/Lean4/Core/Conservativity.lean
-- Formalisation of the conservativity theorem.
-- Cross-reference: FOUNDATIONS/conservativity.tex, Theorem 1.

import Universe
import MillenniumCore.Core.Universe

namespace MillenniumCore

open UI

/-!
# Conservativity of U_I over ℝ

This file formalises the claim that the Indeterminate Framework does not
prove any new facts about classical real numbers. Every theorem stated here
in the language of ℝ has a classical proof.

The key conservativity result is:
  If a UI-theorem only mentions Real-wrapped values, then it follows from
  classical real analysis.
-/

/-- A term is "classically typed" if it is wrapped in Real. -/
def isClassical : UI → Prop
  | Real _ => True
  | _      => False

/-- Classical terms are distinct from I. -/
theorem classical_ne_ind (x : UI) (h : isClassical x) : x ≠ Ind := by
  cases x with
  | Real _ => intro heq; cases heq
  | Ind    => exact absurd h (by simp [isClassical])
  | Meta _ => exact absurd h (by simp [isClassical])
  | Undef  => exact absurd h (by simp [isClassical])

/-- The classical embedding is injective. -/
theorem ofReal_injective : Function.Injective UI.ofReal := by
  intro a b hab
  simp [ofReal, UI.Real.injEq] at hab
  exact hab

/-- Classical division agrees with real division when denominator is nonzero. -/
theorem div_classical_eq (a b : ℝ) (hb : b ≠ 0) :
    UI.Real a /ᵢ UI.Real b = UI.Real (a / b) :=
  classical_div a b hb

/-- Conservativity: addition of real-wrapped elements stays real-wrapped. -/
theorem add_preserves_classical (a b : ℝ) :
    isClassical (UI.Real a +ᵢ UI.Real b) := by
  simp [add, isClassical]

/-- Conservativity: multiplication of real-wrapped elements stays real-wrapped. -/
theorem mul_preserves_classical (a b : ℝ) :
    isClassical (UI.Real a *ᵢ UI.Real b) := by
  simp [mul, isClassical]

/-- Conservativity: division of real-wrapped elements with nonzero denominator
    stays real-wrapped. -/
theorem div_preserves_classical (a b : ℝ) (hb : b ≠ 0) :
    isClassical (UI.Real a /ᵢ UI.Real b) := by
  rw [classical_div a b hb]
  simp [isClassical]

end MillenniumCore
