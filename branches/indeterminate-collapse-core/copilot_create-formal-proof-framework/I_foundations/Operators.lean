/-
  I_foundations/Operators.lean

  Symbolic operators, composition, closure, and invariants for the
  Operational Indeterminacy framework.

  Depends on: Axioms.lean, Definitions.lean

  License: MIT
  Author: Indeterminate Collapse Core Project
-/

import I_foundations.Axioms
import I_foundations.Definitions

/-! ## 1. Lifted arithmetic operators -/

/-- Lifted addition: Det+Det = Det, anything else = Indet. -/
def opAdd {α : Type} [Add α] : OpState α → OpState α → OpState α
  | OpState.Det x, OpState.Det y => OpState.Det (x + y)
  | _,             _             => OpState.Indet

/-- Lifted multiplication: Det*Det = Det, anything else = Indet. -/
def opMul {α : Type} [Mul α] : OpState α → OpState α → OpState α
  | OpState.Det x, OpState.Det y => OpState.Det (x * y)
  | _,             _             => OpState.Indet

/-- Lifted negation: -Det x = Det (-x), -Indet = Indet. -/
def opNeg {α : Type} [Neg α] : OpState α → OpState α
  | OpState.Det x => OpState.Det (-x)
  | OpState.Indet => OpState.Indet

/-! ## 2. Composition of transformations -/

/-- Sequential composition of two transformations. -/
def compT {α β γ : Type} (T : Transformation α β) (U : Transformation β γ) :
    Transformation α γ :=
  fun s => U (T s)

/-- Identity transformation. -/
def idT {α : Type} : Transformation α α := id

/-- Constant transformation sending every state to the indeterminate. -/
def constIndet {α β : Type} : Transformation α β := fun _ => OpState.Indet

/-! ## 3. Closure properties -/

/-- The set of transformations that preserve indeterminacy is closed under
    sequential composition. -/
theorem compT_preserves_indet {α β γ : Type}
    (T : Transformation α β) (U : Transformation β γ)
    (hT : Propagates T) (hU : Propagates U) :
    Propagates (compT T U) := by
  unfold Propagates compT
  rw [hT]
  exact hU

/-- The identity transformation propagates indeterminacy. -/
theorem idT_propagates {α : Type} : Propagates (idT (α := α)) := by
  unfold Propagates idT id
  rfl

/-- The constant-Indet transformation trivially propagates. -/
theorem constIndet_propagates {α β : Type} :
    Propagates (constIndet (α := α) (β := β)) := by
  unfold Propagates constIndet
  rfl

/-! ## 4. Invariants -/

/-- A predicate P is an invariant of transformation T when
    P s implies P (T s) for all s. -/
def IsInvariant {α : Type} (P : OpState α → Prop) (T : Transformation α α) : Prop :=
  ∀ s, P s → P (T s)

/-- "Is indeterminate" is an invariant of every indet-preserving transformation. -/
theorem isIndet_invariant_of_propagating {α : Type} (T : Transformation α α)
    (hT : Propagates T) :
    IsInvariant IsIndeterminate T := by
  intro s hs
  cases s with
  | Det x => exact absurd hs id
  | Indet =>
    unfold Propagates at hT
    rw [hT]
    exact trivial

/-- Collapse is an invariant of every transformation: Collapse ∘ T = Collapse. -/
theorem collapse_invariant {α : Type} (T : Transformation α α) (s : OpState α) :
    Collapse (T s) = Collapse s := by
  unfold Collapse
  rfl

/-! ## 5. Notes

  Operators are lifted from the base type using the "absorbing element" rule:
  any operation involving an indeterminate operand yields an indeterminate result.
  This models the semantic firewall: classical arithmetic cannot pierce the
  indeterminate boundary.

  Composition, identity, and constant transformations form a monoid under compT,
  with idT as the unit.  The invariant results show that indeterminacy is a
  fixed-point property of any valid (indet-preserving) transformation.
-/
