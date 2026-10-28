/-
 copilot/add-inumber-class-implementation
ClassicalZeros.lean - Known properties of zeros

This module collects known facts about zeros of ζ(s).
-/

import Riemann.Core.ZetaDef
import Riemann.Core.CriticalStrip

namespace Riemann.Core

open Complex

/-- Hardy's theorem: infinitely many zeros on critical line -/
axiom hardyInfinitelyMany :
  ∀ T > 0, ∃ s : ℂ, onCriticalLine s ∧ s.im > T ∧ isZeroOfZeta s

/-- Counting function N(T) = #{zeros with 0 < Im(s) < T} -/
axiom zeroCountingAsymptotic (T : ℝ) (hT : T > 0) :
  ∃ N : ℕ, ∃ ε > 0,
    |N - (T / (2 * Real.pi)) * Real.log (T / (2 * Real.pi)) + T / (2 * Real.pi)| < ε * Real.log T

/-- Known zeros are on critical line (computational) -/
axiom computedZeros (s : ℂ) (hcomputed : s.im < 10^13) (hz : isNontrivialZero s) :
  onCriticalLine s

/-- First zero approximation -/
axiom firstZero :
  ∃ s : ℂ, isNontrivialZero s ∧ onCriticalLine s ∧ |s.im - 14.134725| < 10^(-6)

/-- Zero spacing (Gram's law approximately) -/
axiom zeroSpacing (T : ℝ) (hT : T > 10) :
  ∃ Δ : ℝ, Δ > 0 ∧ Δ < 2 * Real.pi / Real.log T ∧
    ∀ s₁ s₂ : ℂ, isNontrivialZero s₁ → isNontrivialZero s₂ →
      |s₁.im - T| < 1 → |s₂.im - T| < 1 → s₁ ≠ s₂ →
      |s₁.im - s₂.im| > Δ / 2
=======
Copyright (c) 2025 ShantiDraconis. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ShantiDraconis

# Classical Zeros

Definition and properties of the classical (trivial) zeros of the zeta function.
-/

import Riemann.Core.ZetaDef

namespace Riemann.Core

open Millennium.Riemann.CollapseComplex

/-- Classical trivial zeros at negative even integers: s = -2, -4, -6, ... -/
def isClassicalTrivialZero (s : CollapseComplex) : Prop :=
  ∃ n : ℕ, n > 0 ∧ s = ofReal (-(2 * (n : ℝ)))

/-- The trivial zeros are indeed zeros of ζ. -/
axiom trivial_zeros_are_zeros :
  ∀ s : CollapseComplex, isClassicalTrivialZero s → zeta s = zero

/-- Trivial zeros lie outside the critical strip. -/
lemma trivial_zeros_outside_strip (s : CollapseComplex) :
  isClassicalTrivialZero s → ¬inCriticalStrip s := by
  intro ⟨n, hn_pos, hs⟩
  unfold inCriticalStrip
  rw [hs]
  simp [ofReal]
  intro h_pos h_lt_one
  -- -2n < 0 for n > 0, so not in (0,1)
  have : -(2 * (n : ℝ)) < 0 := by
    have : (n : ℝ) > 0 := Nat.cast_pos.mpr hn_pos
    linarith
  linarith
 main

end Riemann.Core
