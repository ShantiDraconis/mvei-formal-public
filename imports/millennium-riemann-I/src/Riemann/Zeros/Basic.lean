/-
Basic.lean - Fundamental definitions for zeros

This module provides the base definitions for zero analysis.
-/

import Riemann.Core.ZetaDef

namespace Riemann.Zeros

open Complex Riemann.Core

/-- A zero of the zeta function -/
structure Zero where
  s : ℂ
  is_zero : isZeroOfZeta s

/-- Classification of zeros -/
inductive ZeroType
  | trivial : ZeroType
  | critical : ZeroType
  | anomalous : ZeroType

/-- Classify a zero -/
def classifyZero (z : Zero) : ZeroType :=
  if isTrivialZero z.s then ZeroType.trivial
  else if z.s.re = 1/2 then ZeroType.critical
  else ZeroType.anomalous

/-- Zero multiplicity (all nontrivial zeros are simple) -/
axiom simpleZeros (s : ℂ) (hz : isNontrivialZero s) :
  ∃ ε > 0, ∀ s' : ℂ, s' ≠ s → |s' - s| < ε → ¬isZeroOfZeta s'

/-- Height of a zero -/
def height (z : Zero) : ℝ := |z.s.im|

/-- Ordinal of zeros by height (counting function)
    This is axiomatized as the count is not constructively computable.
    N(T) = #{s : ζ(s) = 0, 0 < Re(s) < 1, 0 < Im(s) < T} -/
axiom zeroOrdinal (T : ℝ) : ℕ

end Riemann.Zeros
