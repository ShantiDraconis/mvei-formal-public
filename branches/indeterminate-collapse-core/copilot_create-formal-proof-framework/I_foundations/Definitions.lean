/-
  I_foundations/Definitions.lean

  Formal definitions for the Operational Indeterminacy framework.

  Depends on: Axioms.lean

  License: MIT
  Author: Indeterminate Collapse Core Project
-/

import I_foundations.Axioms

/-! ## Core type definitions -/

/-- An indeterminate state: the element I at some carrier type. -/
def IndeterminateState (α : Type) : OpState α := OpState.Indet

/-- An operational state: any element of OpState, including Det and Indet. -/
abbrev OperationalState := OpState

/-- Collapse: maps an OpState to the indeterminate element,
    discarding any determinate information. -/
def Collapse {α : Type} (_ : OpState α) : OpState α := OpState.Indet

/-- Transition between two operational states.
    A transition is a pair (source, target) with a witness that the
    transformation T maps source to target. -/
structure Transition {α β : Type} (T : Transformation α β) where
  source : OpState α
  target : OpState β
  witness : T source = target

/-- A transformation is IdentityPreserving when it maps each determinate
    state to a (possibly different) determinate state. -/
def IsIdentityPreserving {α β : Type} (T : Transformation α β) : Prop :=
  ∀ x : α, ∃ y : β, T (OpState.Det x) = OpState.Det y

/-- Consistency of a system: the system's initial state is well-formed. -/
def Consistent (sys : System) : Prop := sys.valid sys.initial

/-- Stability of a transformation within a system:
    valid states map to valid states. -/
def Stable (sys : System) (T : Transformation sys.State sys.State) : Prop :=
  ∀ s : OpState sys.State, sys.valid s → sys.valid (T s)

/-- Propagation of indeterminacy: a transformation propagates I when
    the indeterminate input always produces an indeterminate output. -/
def Propagates {α β : Type} (T : Transformation α β) : Prop :=
  T OpState.Indet = OpState.Indet

/-! ## Derived notions -/

/-- A state is determinate if it is of the form Det x. -/
def IsDeterminate {α : Type} : OpState α → Prop
  | OpState.Det _  => True
  | OpState.Indet  => False

/-- A state is indeterminate if it equals Indet. -/
def IsIndeterminate {α : Type} : OpState α → Prop
  | OpState.Det _  => False
  | OpState.Indet  => True

/-- Extract the value from a determinate state (partial). -/
def detValue {α : Type} : (s : OpState α) → IsDeterminate s → α
  | OpState.Det x, _ => x
  | OpState.Indet, h => absurd h id

/-- Two systems are structurally equivalent when their validity predicates
    agree on all operational states of the same carrier type. -/
def SystemEquiv (S T : System) [h : S.State = T.State] : Prop :=
  ∀ s : OpState S.State, S.valid s ↔ T.valid (h ▸ s)

/-! ## Notes

  These definitions translate the conceptual vocabulary of the framework
  into Lean 4 terms that can be used in proofs:

  * `IndeterminateState` and `OperationalState` formalise the state model.
  * `Collapse` formalises the information-erasing mapping Problem → I.
  * `Transition` records a witnessed step of a transformation.
  * `IsIdentityPreserving`, `Consistent`, `Stable`, `Propagates` are the
    central predicates used in the main theorems (Consistency.lean,
    Propagation.lean, Stability.lean).
-/
