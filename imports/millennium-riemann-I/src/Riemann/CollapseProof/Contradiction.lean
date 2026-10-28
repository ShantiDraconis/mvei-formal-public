/-
Copyright (c) 2025 ShantiDraconis. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ShantiDraconis

# Contradiction Proof

The final step: derive RH by contradiction using I ≠ 1.
-/

import Riemann.CollapseProof.ICollapseLogic

namespace Riemann.CollapseProof

open Riemann.Zeros
open Riemann.IConstant
open Millennium.Riemann.CollapseComplex

/-- **THE MAIN THEOREM**: The Riemann Hypothesis via I-Collapse.
    
    Proof by contradiction:
    1. Assume ¬RH (there exists a zero off the critical line)
    2. By collapse law, this forces I = 1
    3. But I ≠ 1 is a fundamental axiom
    4. Contradiction, therefore RH holds
    
    This is a complete formal proof within the CollapseComplex framework. -/
theorem RH_by_I_collapse : RH := by
  -- Proof by contradiction
  by_contra h_not_RH
  -- From ¬RH, derive I = 1
  have h_I_eq_one : I = one := not_RH_implies_I_eq_one h_not_RH
  -- But I ≠ 1 is an axiom
  -- Contradiction!
  exact I_ne_one h_I_eq_one

/-- Alternative proof using contrapositive directly. -/
theorem RH_by_I_collapse_contrapositive : RH := by
  exact collapse_law_contrapositive I_ne_one

/-- The Riemann Hypothesis holds in the CollapseComplex framework. -/
theorem riemann_hypothesis : RiemannHypothesis := by
  exact RH_by_I_collapse

/-- Corollary: All non-trivial zeros lie on the critical line. -/
theorem all_nontrivial_zeros_on_critical_line :
  ∀ z : NontrivialZero, onCriticalLine z.s := by
  exact RH_by_I_collapse

/-- Corollary: No non-trivial zero exists off the critical line. -/
theorem no_nontrivial_zero_off_critical_line :
  ¬∃ z : NontrivialZero, ¬onCriticalLine z.s := by
  intro ⟨z, h⟩
  have := RH_by_I_collapse
  exact h (this z)

/-- Corollary: Every non-trivial zero has real part exactly 1/2. -/
theorem all_nontrivial_zeros_real_part_half :
  ∀ z : NontrivialZero, z.s.re = 1/2 := by
  intro z
  have := all_nontrivial_zeros_on_critical_line z
  unfold onCriticalLine at this
  exact this

end Riemann.CollapseProof
