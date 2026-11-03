/-
  I_foundations/Transformations.lean

  Validity, identity-preservation, and consistency-preservation
  of transformations in the Operational Indeterminacy framework.

  Depends on: Axioms.lean, Definitions.lean, States.lean

  License: MIT
  Author: Indeterminate Collapse Core Project
-/

import I_foundations.Axioms
import I_foundations.Definitions
import I_foundations.States

/-! ## 1. Valid transformations -/

/-- A transformation is valid within a system when it maps every
    system-valid state to a system-valid state. -/
def ValidTransformation (sys : System) (T : Transformation sys.State sys.State) : Prop :=
  ∀ s : OpState sys.State, sys.valid s → sys.valid (T s)

/-! ## 2. Identity-preservation -/

/-- A transformation preserves identity when it maps every determinate
    state to some (possibly different) determinate state. -/
def PreservesIdentity {α β : Type} (T : Transformation α β) : Prop :=
  ∀ x : α, ∃ y : β, T (OpState.Det x) = OpState.Det y

/-- The identity transformation preserves identity. -/
theorem idT_preserves_identity {α : Type} :
    PreservesIdentity (idT (α := α)) := by
  intro x
  exact ⟨x, rfl⟩

/-- Composition of identity-preserving transformations preserves identity. -/
theorem comp_preserves_identity {α β γ : Type}
    (T : Transformation α β) (U : Transformation β γ)
    (hT : PreservesIdentity T) (hU : PreservesIdentity U) :
    PreservesIdentity (compT T U) := by
  intro x
  obtain ⟨y, hy⟩ := hT x
  obtain ⟨z, hz⟩ := hU y
  exact ⟨z, by unfold compT; rw [hy, hz]⟩

/-! ## 3. Consistency-preservation -/

/-- A transformation preserves consistency when it maps a consistent
    system to a system that remains consistent under the transformation. -/
def PreservesConsistency (sys : System) (T : Transformation sys.State sys.State) : Prop :=
  Consistent sys → Consistent { sys with initial := T sys.initial }

/-- Any valid transformation preserves consistency. -/
theorem valid_preserves_consistency (sys : System)
    (T : Transformation sys.State sys.State)
    (hV : ValidTransformation sys T) :
    PreservesConsistency sys T := by
  intro hC
  exact hV sys.initial hC

/-! ## 4. Conditions for a valid transition -/

/-- A concrete transition is valid in a system when both source and target
    states are system-valid. -/
def ValidTransition (sys : System) {T : Transformation sys.State sys.State}
    (tr : Transition T) : Prop :=
  sys.valid tr.source ∧ sys.valid tr.target

/-- Construct a valid transition from a valid transformation and a valid source. -/
def mkValidTransition (sys : System) (T : Transformation sys.State sys.State)
    (hV : ValidTransformation sys T) (s : OpState sys.State) (hs : sys.valid s) :
    { tr : Transition T // ValidTransition sys tr } :=
  ⟨⟨s, T s, rfl⟩, hs, hV s hs⟩

/-! ## 5. Conditions under which a transformation is well-behaved -/

/-- A transformation is well-behaved when it is simultaneously
    identity-preserving and indeterminacy-propagating. -/
def WellBehaved {α : Type} (T : Transformation α α) : Prop :=
  PreservesIdentity T ∧ Propagates T

/-- The identity transformation is well-behaved. -/
theorem idT_wellBehaved {α : Type} : WellBehaved (idT (α := α)) :=
  ⟨idT_preserves_identity, idT_propagates⟩

/-- Composition of well-behaved transformations is well-behaved. -/
theorem comp_wellBehaved {α : Type}
    (T U : Transformation α α)
    (hT : WellBehaved T) (hU : WellBehaved U) :
    WellBehaved (compT T U) :=
  ⟨comp_preserves_identity T U hT.1 hU.1,
   compT_preserves_indet T U hT.2 hU.2⟩

/-! ## 6. Notes

  A transformation is "valid" (operational) in this framework when it
  satisfies all three properties simultaneously:

  * **Validity** (within a system): maps valid states to valid states.
  * **Identity-preservation**: does not silently create indeterminacy
    from determinate inputs.
  * **Indet-propagation**: does not silently resolve indeterminate inputs.

  Together these give the WellBehaved predicate, which is the minimal
  requirement for a transformation to be used as a proof-relevant step
  in Consistency.lean and Propagation.lean.
-/
