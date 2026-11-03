/-
  I_foundations/Propagation.lean

  Second major theorem: indeterminate states propagate through
  transformations without causing a logical collapse.

  Theorems proved here:
    theorem propagation_preserves_structure
    theorem closure_under_transformation

  Depends on: Axioms.lean, Definitions.lean, States.lean, Operators.lean

  License: MIT
  Author: Indeterminate Collapse Core Project
-/

import I_foundations.Axioms
import I_foundations.Definitions
import I_foundations.States
import I_foundations.Operators

/-! ## 1. Core propagation theorem -/

/-- **Theorem: propagation_preserves_structure**

  If T is an indet-preserving (Propagating) transformation, then
  applying T to an indeterminate state yields an indeterminate state.
  Indeterminacy is therefore *structurally preserved*, not erased. -/
theorem propagation_preserves_structure {α β : Type}
    (T : Transformation α β)
    (hT : Propagates T) :
    T OpState.Indet = OpState.Indet :=
  hT

/-! ## 2. Closure under transformation -/

/-- **Theorem: closure_under_transformation**

  The collection of indeterminate states is closed under any
  propagating transformation: if s is indeterminate and T propagates,
  then T s is also indeterminate. -/
theorem closure_under_transformation {α β : Type}
    (T : Transformation α β)
    (hT : Propagates T)
    (s : OpState α)
    (hs : IsIndeterminate s) :
    IsIndeterminate (T s) := by
  cases s with
  | Det x => exact absurd hs id
  | Indet  =>
    rw [hT]
    exact trivial

/-! ## 3. Sequential closure -/

/-- Composition of two propagating transformations is still propagating. -/
theorem seq_closure {α β γ : Type}
    (T : Transformation α β) (U : Transformation β γ)
    (hT : Propagates T) (hU : Propagates U) :
    Propagates (compT T U) :=
  compT_preserves_indet T U hT hU

/-- Every finite iterate of a propagating transformation propagates. -/
theorem iter_closure {α : Type} (T : Transformation α α)
    (hT : Propagates T) (n : Nat) :
    Propagates (iterT T n) :=
  iterT_propagates T hT n

/-! ## 4. Propagation in lifted operators -/

/-- Lifted addition propagates indeterminacy on the left. -/
theorem opAdd_propagates_left {α : Type} [Add α] (t : OpState α) :
    opAdd OpState.Indet t = OpState.Indet := by
  unfold opAdd
  rfl

/-- Lifted addition propagates indeterminacy on the right. -/
theorem opAdd_propagates_right {α : Type} [Add α] (s : OpState α) :
    opAdd s OpState.Indet = OpState.Indet := by
  unfold opAdd
  cases s <;> rfl

/-- Lifted multiplication propagates indeterminacy on the left. -/
theorem opMul_propagates_left {α : Type} [Mul α] (t : OpState α) :
    opMul OpState.Indet t = OpState.Indet := by
  unfold opMul
  rfl

/-! ## 5. No logical collapse during propagation -/

/-- **Theorem: propagation_no_collapse**

  Propagating an indeterminate state through T never forces an
  equality between Indet and Det: the framework does not collapse
  logically as a result of propagation. -/
theorem propagation_no_collapse {α β : Type}
    (T : Transformation α β)
    (hT : Propagates T)
    (x : β) :
    T OpState.Indet ≠ OpState.Det x := by
  rw [hT]
  exact axiom_I3_separation x

/-! ## 6. Notes

  Propagation.lean provides the second tier of the proof tower.

  The key insight is that indeterminacy is a *fixed-point property*
  of any valid transformation: once a state enters the indeterminate
  regime, no transformation in the I-framework can silently resolve it
  to a determinate value.

  This is the formal counterpart of the conceptual claim that "I cannot
  be simplified away by standard operations."

  The next tier (Stability.lean) shows that this propagation property,
  combined with a system-level validity predicate, yields a stable
  dynamical picture.
-/
