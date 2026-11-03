/-
  I_foundations/States.lean

  Models for classical, indeterminate, transformed, and transitioning states.

  Depends on: Axioms.lean, Definitions.lean

  License: MIT
  Author: Indeterminate Collapse Core Project
-/

import I_foundations.Axioms
import I_foundations.Definitions

/-! ## 1. Classical (determinate) states -/

/-- A classical state is simply a determinate OpState. -/
def ClassicalState (α : Type) := { s : OpState α // IsDeterminate s }

/-- Construct a ClassicalState from a value. -/
def mkClassical {α : Type} (x : α) : ClassicalState α :=
  ⟨OpState.Det x, trivial⟩

/-- Recover the value from a classical state. -/
def ClassicalState.val' {α : Type} (cs : ClassicalState α) : α :=
  detValue cs.val cs.property

/-! ## 2. Indeterminate state -/

/-- The canonical indeterminate state at type α. -/
def TheIndetState (α : Type) : { s : OpState α // IsIndeterminate s } :=
  ⟨OpState.Indet, trivial⟩

/-- There is exactly one indeterminate state at each type. -/
theorem indet_unique {α : Type}
    (s t : { s : OpState α // IsIndeterminate s }) : s = t := by
  obtain ⟨sv, sp⟩ := s
  obtain ⟨tv, tp⟩ := t
  cases sv with
  | Det x => exact absurd sp id
  | Indet =>
    cases tv with
    | Det x => exact absurd tp id
    | Indet => rfl

/-! ## 3. Transformed states -/

/-- A transformed state is the image of a source state under a transformation. -/
structure TransformedState {α β : Type} (T : Transformation α β) where
  source : OpState α
  result : OpState β
  eq     : T source = result

/-- Construct a transformed state by applying T to s. -/
def applyT {α β : Type} (T : Transformation α β) (s : OpState α) :
    TransformedState T :=
  ⟨s, T s, rfl⟩

/-- If the source is indeterminate and T propagates, so is the result. -/
theorem transformedIndet {α β : Type} (T : Transformation α β)
    (hT : Propagates T) (ts : TransformedState T)
    (h : IsIndeterminate ts.source) : IsIndeterminate ts.result := by
  cases hSource : ts.source with
  | Det x => cases ts.source <;> simp_all [IsIndeterminate]
  | Indet =>
    have : ts.result = OpState.Indet := by
      rw [← ts.eq, hSource]
      exact hT
    rw [this]
    exact trivial

/-! ## 4. Transitions between states -/

/-- A step is a single application of a transformation witnessed concretely. -/
def Step {α : Type} (T : Transformation α α) (s : OpState α) : OpState α :=
  T s

/-- Iterated application of a transformation (n steps). -/
def iterT {α : Type} (T : Transformation α α) : Nat → OpState α → OpState α
  | 0,   s => s
  | n+1, s => iterT T n (T s)

/-- If T propagates, then any iterate of T also propagates indeterminacy. -/
theorem iterT_propagates {α : Type} (T : Transformation α α)
    (hT : Propagates T) (n : Nat) :
    Propagates (iterT T n) := by
  induction n with
  | zero =>
    unfold Propagates iterT
    rfl
  | succ n ih =>
    unfold Propagates iterT
    rw [hT]
    exact ih

/-! ## 5. Notes

  This module distinguishes four levels of state:

  1. ClassicalState  — a concrete, determinate OpState wrapping a known value.
  2. TheIndetState   — the unique indeterminate state (up to propositional equality).
  3. TransformedState — the image of any source state under a transformation.
  4. Step / iterT    — discrete dynamics: one or many steps of a transformation.

  The uniqueness theorem for indeterminate states (`indet_unique`) and the
  iterate-propagation theorem (`iterT_propagates`) are the key results
  exported to Propagation.lean and Stability.lean.
-/
