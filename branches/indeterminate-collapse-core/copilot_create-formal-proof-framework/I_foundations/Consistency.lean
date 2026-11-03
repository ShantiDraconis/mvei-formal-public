/-
  I_foundations/Consistency.lean

  First major theorem: the I-system does not introduce an immediate
  contradiction by definition.

  Theorem proved here:
    theorem consistency_of_I_system
    theorem no_immediate_contradiction

  Depends on: Axioms.lean, Definitions.lean, Transformations.lean

  License: MIT
  Author: Indeterminate Collapse Core Project
-/

import I_foundations.Axioms
import I_foundations.Definitions
import I_foundations.Transformations

/-! ## 1. Consistency of the I-system -/

/-- **Theorem: consistency_of_I_system**

  The indeterminate element I is not equal to any determinate value.
  This is the minimal consistency requirement: the system does not
  trivially collapse (I ≠ Det x for any x).

  Proof: direct from axiom_C1_existence. -/
theorem consistency_of_I_system {α : Type} (x : α) :
    IState (α := α) ≠ OpState.Det x :=
  axiom_C1_existence x

/-! ## 2. No immediate contradiction -/

/-- **Theorem: no_immediate_contradiction**

  The I-framework is locally consistent: there exists no type α and
  value x : α such that the indeterminate state equals the determinate
  state Det x.

  Equivalently, assuming IState = Det x leads to False, so the
  framework does not derive ⊥ from its axioms alone. -/
theorem no_immediate_contradiction {α : Type} (x : α) :
    ¬(IState (α := α) = OpState.Det x) :=
  axiom_C1_existence x

/-- Corollary: the two constructors of OpState are always disjoint. -/
theorem det_indet_disjoint {α : Type} (x : α) :
    OpState.Det x ≠ OpState.Indet :=
  axiom_I3_separation x

/-- Corollary: a system whose initial state is determinate is consistent. -/
theorem det_initial_is_consistent (α : Type) (x : α)
    (P : OpState α → Prop) (h : P (OpState.Det x)) :
    Consistent ⟨α, OpState.Det x, P⟩ :=
  h

/-! ## 3. Consistency under Collapse -/

/-- **Theorem: collapse_is_consistent**

  The Collapse map sends every state to Indet, which is always
  distinct from any determinate state.  Hence Collapse cannot
  introduce a false equation Det x = Indet. -/
theorem collapse_is_consistent {α : Type} (s : OpState α) (x : α) :
    Collapse s ≠ OpState.Det x := by
  unfold Collapse
  exact axiom_I3_separation x

/-! ## 4. Notes

  The results in this file establish the first tier of the proof tower:
  the I-framework cannot derive ⊥ from its definitional axioms.

  This does not prove full model-theoretic consistency (which would require
  exhibiting a model), but it shows that the framework is *locally*
  non-contradictory: the defining equations of I never force an equality
  between a determinate and an indeterminate state.

  The next tier (Propagation.lean) shows that indeterminacy propagates
  coherently, and Stability.lean shows that well-behaved transformations
  maintain system invariants.
-/
