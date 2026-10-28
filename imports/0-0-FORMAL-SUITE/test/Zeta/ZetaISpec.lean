/-
  test/Zeta/ZetaISpec.lean

  Test specifications for the Zeta/I formalization.
  Verifies domain structures, critical line properties, and collapse lemmas.

  This file contains no `sorry` statements.
-/

import FormalSuite.Zeta.ZetaIFormal
import FormalSuite.Zeta.CollapseLemmaRH

/-!
# Zeta I Tests

This module provides test cases for the zeta formalization,
verifying:
- Critical strip and line definitions
- Reflection symmetry
- Collapse conditions
-/

namespace FormalSuite.Test.ZetaI

open FormalSuite.Zeta
open Complex

/-!
## Critical Strip Tests
-/

/-- Test: 1/2 + 0i is in the critical strip. -/
example : (⟨1/2, 0⟩ : ℂ) ∈ CriticalStrip := by
  rw [mem_criticalStrip_iff]
  constructor <;> norm_num

/-- Test: 1/2 + i is in the critical strip. -/
example : (⟨1/2, 1⟩ : ℂ) ∈ CriticalStrip := by
  rw [mem_criticalStrip_iff]
  constructor <;> norm_num

/-- Test: 0 + 0i is not in the critical strip. -/
example : (⟨0, 0⟩ : ℂ) ∉ CriticalStrip := by
  rw [mem_criticalStrip_iff]
  push_neg
  intro h
  linarith

/-!
## Critical Line Tests
-/

/-- Test: 1/2 + 0i is on the critical line. -/
example : (⟨1/2, 0⟩ : ℂ) ∈ CriticalLine := by
  rw [mem_criticalLine_iff]
  rfl

/-- Test: Critical line parameterization. -/
example (t : ℝ) : criticalLineParam t ∈ CriticalLine := by
  exact criticalLineParam_mem t

/-- Test: Critical line is in critical strip. -/
example : CriticalLine ⊆ CriticalStrip := by
  exact criticalLine_subset_strip

/-!
## Reflection Tests
-/

/-- Test: Reflection is an involution. -/
example (s : ℂ) : reflection (reflection s) = s := by
  exact reflection_reflection s

/-- Test: Reflection of 1/2 has real part 1/2. -/
example : (reflection ⟨1/2, 1⟩).re = 1/2 := by
  simp [reflection]

/-- Test: Critical line is preserved by reflection. -/
example (s : ℂ) (hs : s ∈ CriticalLine) : reflection s ∈ CriticalLine := by
  exact FormalSuite.Zeta.Collapse.reflection_preserves_critical_line hs

/-!
## Collapse Condition Tests
-/

/-- Test: Trivial collapse condition works. -/
example (s : ℂ) (hs : s ∈ CriticalLine) :
    FormalSuite.Zeta.Collapse.CollapseCondition.trivial.condition s := hs

/-- Test: I-idempotence condition on critical line. -/
example : FormalSuite.Zeta.Collapse.CollapseCondition.I_idempotence.condition ⟨1/2, 5⟩ := by
  unfold FormalSuite.Zeta.Collapse.CollapseCondition.I_idempotence
  simp only
  simp [reflection]

/-!
## I-Normalization Tests
-/

/-- Test: I-normalization is identity. -/
example (s : ℂ) : FormalSuite.Zeta.Collapse.I_normalization_trivial s = rfl := rfl

end FormalSuite.Test.ZetaI
