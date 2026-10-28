/-
CriticalStrip.lean - Properties of the critical strip 0 < Re(s) < 1

This module defines the critical strip and critical line.
-/

import Riemann.Core.ZetaDef

namespace Riemann.Core

open Complex

/-- The critical strip: 0 < Re(s) < 1 -/
def inCriticalStrip (s : ℂ) : Prop :=
  0 < s.re ∧ s.re < 1

/-- The critical line: Re(s) = 1/2 -/
def onCriticalLine (s : ℂ) : Prop :=
  s.re = (1 : ℝ) / 2

/-- Off the critical line -/
def offCriticalLine (s : ℂ) : Prop :=
  inCriticalStrip s ∧ s.re ≠ (1 : ℝ) / 2

/-- Distance from critical line -/
def distanceFromLine (s : ℂ) : ℝ :=
  |s.re - (1 : ℝ) / 2|

/-- Critical line is axis of symmetry -/
theorem criticalLineSymmetry (s : ℂ) (hs : inCriticalStrip s) :
  inCriticalStrip (1 - s) := by
  constructor
  · simp only [Complex.sub_re, Complex.one_re]
    linarith [hs.2]
  · simp only [Complex.sub_re, Complex.one_re]
    linarith [hs.1]

/-- Zero-free regions (Hadamard-de la Vallée Poussin) -/
axiom zeroFreeRegion :
  ∃ c > 0, ∀ s : ℂ, s.re ≥ 1 - c / Real.log (|s.im| + 2) →
    ¬isZeroOfZeta s

/-- All nontrivial zeros are in critical strip -/
axiom nontrivialInStrip (s : ℂ) (hz : isNontrivialZero s) :
  inCriticalStrip s

end Riemann.Core
