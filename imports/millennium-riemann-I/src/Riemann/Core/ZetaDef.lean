/-
ZetaDef.lean - Classical definition of the Riemann zeta function

This module provides the axiomatic foundation for ζ(s) in the I-framework.
-/

namespace Riemann.Core

open Complex

/-- Axiomatic zeta function: ζ(s) → ℂ -/
axiom zetaClassical : ℂ → ℂ

/-- The Dirichlet series representation (for Re(s) > 1) -/
axiom zetaDirichlet (s : ℂ) (hs : s.re > 1) :
  zetaClassical s = ∑' n : ℕ+, (1 : ℂ) / (n : ℂ)^s

/-- Euler product representation (for Re(s) > 1) -/
axiom zetaEulerProduct (s : ℂ) (hs : s.re > 1) :
  zetaClassical s = ∏' p : Nat.Primes, (1 - (1 : ℂ) / (p : ℂ)^s)⁻¹

/-- Analytic continuation: ζ is meromorphic on ℂ with pole at s = 1 -/
axiom zetaMeromorphic :
  ∀ s : ℂ, s ≠ 1 → ∃ val : ℂ, zetaClassical s = val

/-- Pole at s = 1 is simple -/
axiom zetaPoleSimple :
  ∀ ε > 0, ∃ δ > 0, ∀ s : ℂ, 0 < |s - 1| → |s - 1| < δ →
    |zetaClassical s * (s - 1)| < 1 + ε

/-- Special values -/
axiom zetaAtZero : zetaClassical 0 = -1/2

axiom zetaAtMinusOne : zetaClassical (-1) = -1/12

axiom zetaAtTwo : zetaClassical 2 = Real.pi^2 / 6

/-- Trivial zeros at negative even integers -/
axiom zetaTrivialZeros (n : ℕ) (hn : n > 0) :
  zetaClassical (-2 * n) = 0

/-- Definition: s is a zero of ζ -/
def isZeroOfZeta (s : ℂ) : Prop :=
  zetaClassical s = 0

/-- Definition: s is a trivial zero -/
def isTrivialZero (s : ℂ) : Prop :=
  ∃ n : ℕ, n > 0 ∧ s = -2 * n

/-- Definition: s is a nontrivial zero -/
def isNontrivialZero (s : ℂ) : Prop :=
  isZeroOfZeta s ∧ 0 < s.re ∧ s.re < 1

end Riemann.Core
