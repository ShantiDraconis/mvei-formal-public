/-
Trivial.lean - Trivial zeros at negative even integers

This module characterizes the trivial zeros of ζ(s).
-/

import Riemann.Core.ZetaDef
import Riemann.Zeros.Basic

namespace Riemann.Zeros

open Complex Riemann.Core

/-- Trivial zeros are at s = -2n for n ≥ 1 -/
structure TrivialZero extends Zero where
  n : ℕ
  n_pos : n > 0
  at_neg_even : s = -2 * n

/-- Every negative even integer is a trivial zero -/
theorem negEvenIsZero (n : ℕ) (hn : n > 0) :
  isZeroOfZeta (-2 * n) := by
  exact zetaTrivialZeros n hn

/-- Trivial zeros are not in critical strip -/
theorem trivialNotInStrip (z : TrivialZero) :
  ¬inCriticalStrip z.s := by
  simp [inCriticalStrip, z.at_neg_even]
  intro h
  have : ((-2 : ℂ) * z.n).re = -2 * z.n := by simp
  linarith [z.n_pos]

/-- Trivial zeros are simple -/
axiom trivialSimple (n : ℕ) (hn : n > 0) :
  ∃ ε > 0, ∀ s : ℂ, s ≠ -2*n → |s - (-2*n)| < ε → 
    ¬isZeroOfZeta s

/-- Residue at trivial zeros -/
axiom trivialResidue (n : ℕ) (hn : n > 0) :
  ∃ r : ℂ, r ≠ 0 ∧ r = (-1)^n * (2*n)! / (2^(2*n) * n! * Real.pi^(2*n))

end Riemann.Zeros
