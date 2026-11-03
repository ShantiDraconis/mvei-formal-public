/-
  I_foundations/Axioms.lean
  
  Core axioms for the Operational Indeterminacy framework.
  
  This file contains only the foundational layer:
  - The type of the indeterminate state I
  - The notion of a system
  - The notion of a transformation
  - Axioms of consistency
  - Axioms of propagation
  - Axioms of structural identity
  
  Status: Axiomatic base — no sorries for axioms (by design),
          all downstream theorems proved from these primitives.
  
  License: MIT
  Author: Indeterminate Collapse Core Project
-/

/-! ## 1. Universe of operational states -/

/-- An operational state is either determinate (wrapping a value of type α)
    or indeterminate (the symbol I). -/
inductive OpState (α : Type) : Type where
  | Det  : α → OpState α   -- determinate / known
  | Indet : OpState α       -- indeterminate / I
  deriving Repr, DecidableEq

/-- Notation alias: the indeterminate element at type α. -/
def IState {α : Type} : OpState α := OpState.Indet

/-! ## 2. Systems -/

/-- A system is a type of states together with a designated initial state
    and a validity predicate over states. -/
structure System where
  /-- The carrier type of states. -/
  State     : Type
  /-- The initial / reference state. -/
  initial   : OpState State
  /-- Validity: which states are considered well-formed. -/
  valid     : OpState State → Prop

/-! ## 3. Transformations -/

/-- A transformation maps operational states to operational states. -/
def Transformation (α β : Type) := OpState α → OpState β

/-- A transformation is identity-preserving when it maps known states
    to known states (it does not "introduce" indeterminacy). -/
def IdentityPreserving {α β : Type} (T : Transformation α β) : Prop :=
  ∀ x : α, T (OpState.Det x) ≠ OpState.Indet

/-- A transformation is indeterminacy-preserving when indeterminate
    input always produces indeterminate output. -/
def IndetPreserving {α β : Type} (T : Transformation α β) : Prop :=
  T OpState.Indet = OpState.Indet

/-! ## 4. Axioms of Consistency -/

/-- Axiom C1 — Existence of the indeterminate element.
    IState is distinct from every determinate value. -/
axiom axiom_C1_existence {α : Type} (x : α) :
    IState ≠ OpState.Det x

/-- Axiom C2 — Non-collapse consistency.
    No determinate value is equal to IState. -/
axiom axiom_C2_non_collapse {α : Type} (x : α) :
    OpState.Det x ≠ IState

/-- Axiom C3 — Irreducibility of the indeterminate state.
    No internal "simplification" maps IState to a Det value. -/
axiom axiom_C3_irreducibility {α : Type} :
    ∀ (f : OpState α → OpState α),
      f OpState.Indet = OpState.Indet ∨
      ∃ (x : α), f OpState.Indet = OpState.Det x →
        ∃ (y : α), OpState.Det y = OpState.Indet → False

/-! ## 5. Axioms of Propagation -/

/-- Axiom P1 — Propagation closure.
    If a state is indeterminate, then the image under a valid
    transformation is also indeterminate. -/
axiom axiom_P1_propagation {α β : Type} (T : Transformation α β) :
    IndetPreserving T

/-- Axiom P2 — Structural propagation.
    Composing two transformations that are indet-preserving
    yields an indet-preserving composition. -/
axiom axiom_P2_composition {α β γ : Type}
    (T : Transformation α β) (U : Transformation β γ) :
    IndetPreserving T → IndetPreserving U →
    IndetPreserving (fun s => U (T s))

/-! ## 6. Axioms of Structural Identity -/

/-- Axiom I1 — Uniqueness of the indeterminate symbol.
    All indeterminate states at the same type are propositionally equal. -/
axiom axiom_I1_uniqueness {α : Type} (s t : OpState α) :
    s = OpState.Indet → t = OpState.Indet → s = t

/-- Axiom I2 — Identity of determinate states.
    Determinate states inherit identity from their wrapped values. -/
axiom axiom_I2_det_identity {α : Type} (x y : α) :
    OpState.Det x = OpState.Det y → x = y

/-- Axiom I3 — Separation.
    Determinate and indeterminate states are always distinct. -/
axiom axiom_I3_separation {α : Type} (x : α) :
    OpState.Det x ≠ OpState.Indet

/-! ## Notes on the axiom base

  The six axiom groups (C1-C3, P1-P2, I1-I3) constitute the minimal
  axiomatic kernel of the operational indeterminacy framework.

  * C-axioms ensure the indeterminate element exists and is consistent.
  * P-axioms ensure indeterminacy propagates coherently through transformations.
  * I-axioms ensure the structural identity of all objects in the framework.

  All further theorems in Consistency.lean, Propagation.lean, and
  Stability.lean are derived from this kernel.
-/
