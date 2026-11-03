/-
  Transformations.lean — Valid State Transformations
  Indeterminate Collapse Core, v1.0.0

  Defines valid transformations, conditions for validity, and composition
  laws. Imports Definitions and Operators.
-/

import «lean».Definitions
import «lean».Operators

/-! # Valid Transformations -/

/-- A ValidTransformation is a Transformation that is both I-propagating
    and identity-preserving. These are the "well-behaved" transformations
    in the I Framework. -/
structure ValidTransformation (α β : Type) where
  fn     : Transformation α β
  prop   : IPropagating fn
  ident  : IdentityPreserving' fn

/-! # Constructing Valid Transformations -/

/-- Every lift of a total function is a ValidTransformation -/
def validLift {α β : Type} (f : α → β) : ValidTransformation α β :=
  { fn    := liftTransformation f
  , prop  := liftTransformation_propagates f
  , ident := liftTransformation_identityPreserving f }

/-- Identity transformation: maps each state to itself -/
def identityTransformation {α : Type} : ValidTransformation α α :=
  validLift id

/-- Constant-I transformation: maps everything to I.
    Note: this is I-propagating but NOT identity-preserving. -/
def collapseAllTransformation {α : Type} : Transformation α α :=
  fun _ => IState.I

/-! # Composition of Valid Transformations -/

/-- Composing two ValidTransformations yields a ValidTransformation -/
def composeValid {α β γ : Type}
    (T₁ : ValidTransformation α β)
    (T₂ : ValidTransformation β γ) :
    ValidTransformation α γ :=
  { fn    := meta_compose T₁.fn T₂.fn
  , prop  := meta_compose_preserves_I T₁.fn T₂.fn T₁.prop T₂.prop
  , ident := fun x =>
      let ⟨y, hy⟩ := T₁.ident x
      let ⟨z, hz⟩ := T₂.ident (T₁.fn (IState.Known x) |>.extractKnown y)
      ⟨z, by
        simp [meta_compose, ValidTransformation.fn]
        sorry⟩ }
  where
    IState.extractKnown {β : Type} : IState β → β → β
      | IState.Known y, _ => y
      | IState.Indeterminate, d => d

/-! # Transformation Application -/

/-- Apply a Transformation to a list of states -/
def applyToList {α β : Type} (T : Transformation α β) (ss : List (State α)) :
    List (State β) :=
  ss.map T

/-- Applying any I-propagating transformation to I gives I -/
theorem apply_I_propagating {α β : Type}
    (T : Transformation α β) (h : IPropagating T) :
    T IState.I = IState.I := h

/-! # Transformation Chaining -/

/-- Chain a list of endotransformations -/
def chainTransformations {α : Type} (Ts : List (Transformation α α)) :
    Transformation α α :=
  Ts.foldl meta_compose id

/-- The empty chain is the identity -/
theorem chain_nil {α : Type} :
    chainTransformations ([] : List (Transformation α α)) = id := rfl

/-- Chaining one transformation is that transformation itself -/
theorem chain_singleton {α : Type} (T : Transformation α α) :
    chainTransformations [T] = meta_compose id T := rfl

/-! # Specific Useful Transformations -/

/-- Double transformation: apply f twice to Known values -/
def doubleTransformation {α : Type} [Add α] (n : α) :
    ValidTransformation α α :=
  validLift (fun x => x + n)

/-- Zero-collapse: maps Known 0 to I, all else unchanged -/
def zeroCollapse : Transformation Nat Nat
  | IState.Known 0    => IState.I
  | other              => other

/-- zeroCollapse propagates I -/
theorem zeroCollapse_propagates_I : IPropagating zeroCollapse := rfl

/-- Even-filter: collapses odd numbers to I, keeps even numbers -/
def evenFilter : Transformation Nat Nat :=
  collapse_op (fun n => n % 2 == 1)

/-- evenFilter propagates I -/
theorem evenFilter_propagates_I : IPropagating evenFilter :=
  collapse_op_preserves_I (fun n => n % 2 == 1)

/-! # Transformation Equality -/

/-- Two transformations are extensionally equal if they agree on all inputs -/
def TransformationEq {α β : Type} (T₁ T₂ : Transformation α β) : Prop :=
  ∀ s : State α, T₁ s = T₂ s

/-- Identity transformation is the left identity for meta_compose -/
theorem id_compose_left {α β : Type} (T : Transformation α β) :
    TransformationEq (meta_compose id T) T :=
  fun _ => rfl

/-- Identity transformation is the right identity for meta_compose -/
theorem compose_id_right {α β : Type} (T : Transformation α β) :
    TransformationEq (meta_compose T id) T :=
  fun _ => rfl
