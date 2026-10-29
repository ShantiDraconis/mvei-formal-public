/-
Copyright (c) 2025 Riemann Energy Proofline Contributors. All rights reserved.
Released under MIT license.
-/

import Mathlib.Analysis.Complex.Basic

/-!
# The Critical Strip

This file defines the critical strip and related regions.

## Main definitions

* `criticalStrip` - The region 0 < Re(s) < 1
* `criticalLine` - The line Re(s) = 1/2
-/

namespace Riemann

/-- The critical strip: 0 < Re(s) < 1 -/
def criticalStrip : Set ℂ :=
  {s : ℂ | 0 < s.re ∧ s.re < 1}

/-- The critical line: Re(s) = 1/2 -/
def criticalLine : Set ℂ :=
  {s : ℂ | s.re = 1/2}

/-- The critical line is contained in the critical strip -/
theorem criticalLine_subset_criticalStrip :
    criticalLine ⊆ criticalStrip := by
  intro s hs
  simp [criticalLine, criticalStrip] at *
  constructor
  · linarith [hs]
  · linarith [hs]

/-- Points in the critical strip are nonzero -/
theorem criticalStrip_ne_zero (s : ℂ) (hs : s ∈ criticalStrip) :
    s ≠ 0 := by
  intro h
  rw [h] at hs
  simp [criticalStrip] at hs

/-- Reflection maps the critical strip to itself -/
theorem criticalStrip_symmetric (s : ℂ) :
    s ∈ criticalStrip ↔ (1 - s) ∈ criticalStrip := by
  simp [criticalStrip, Complex.sub_re]
  constructor <;> intro ⟨h1, h2⟩ <;> constructor <;> linarith

end Riemann
