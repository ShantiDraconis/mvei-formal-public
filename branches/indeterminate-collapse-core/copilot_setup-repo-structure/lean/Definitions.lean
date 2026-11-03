/-
  Definitions.lean — Core Type Definitions
  Indeterminate Collapse Core, v1.0.0

  Imports Axioms and defines the structural types used throughout the framework:
  State, IndeterminateState, Transformation, and their key properties.
-/

import «lean».Axioms

/-! # State and IndeterminateState -/

/-- A State is any IState value over a base type.
    States may be Known (determinate) or Indeterminate (mapped to I). -/
def State (α : Type) := IState α

/-- An IndeterminateState is a State that equals I -/
def IndeterminateState (α : Type) (s : State α) : Prop :=
  s = IState.I

/-- Alias: a state is determinate if it is Known -/
def DeterminateState {α : Type} (s : State α) : Prop :=
  ∃ x : α, s = IState.Known x

/-! # Transformation -/

/-- A Transformation from type α to type β maps IState values to IState values -/
def Transformation (α β : Type) := IState α → IState β

/-- Lift a total function f : α → β to a Transformation,
    propagating I under Axiom 4. -/
def liftTransformation {α β : Type} (f : α → β) : Transformation α β
  | IState.Known x    => IState.Known (f x)
  | IState.Indeterminate => IState.I

/-! # Key Properties of Transformations -/

/-- Identity preservation: a transformation T preserves known values -/
def IdentityPreserving {α β : Type} (T : Transformation α β) : Prop :=
  ∀ (x : α), T (IState.Known x) = IState.Known (T (IState.Known x) |>.extract)
  where
    IState.extract {β : Type} : IState β → β
      | IState.Known y    => y
      | IState.Indeterminate => sorry  -- extract is partial on I

/-- Simplified identity preservation: transformation does not map Known to I -/
def IdentityPreserving' {α β : Type} (T : Transformation α β) : Prop :=
  ∀ (x : α), ∃ (y : β), T (IState.Known x) = IState.Known y

/-- Consistency: a transformation does not introduce new indeterminate states
    where the input was determinate -/
def Consistent {α β : Type} (T : Transformation α β) : Prop :=
  ∀ (s : State α), DeterminateState s → DeterminateState (T s)

/-- I-propagating: a transformation maps I to I (required by Axiom 4) -/
def IPropagating {α β : Type} (T : Transformation α β) : Prop :=
  T IState.I = IState.I

/-- Stable: a transformation that is both I-propagating and identity-preserving -/
def Stable {α β : Type} (T : Transformation α β) : Prop :=
  IPropagating T ∧ IdentityPreserving' T

/-! # Collapse Structure -/

/-- A CollapseMap carries a Problem into its IState Prop -/
structure CollapseMap where
  map    : Problem → IState Prop
  col_I  : ∀ P, Problem.isUnknown P → map P = IState.I
  col_K  : ∀ P, Problem.isKnown P  → map P = IState.Known P.statement

/-! # Propagation Structure -/

/-- Propagation: applying T to an indeterminate state keeps it indeterminate -/
def Propagates {α β : Type} (T : Transformation α β) : Prop :=
  ∀ (s : State α), IndeterminateState α s → IndeterminateState β (T s)

/-! # Useful Lemmas -/

/-- liftTransformation is I-propagating -/
theorem liftTransformation_propagates {α β : Type} (f : α → β) :
    IPropagating (liftTransformation f) := rfl

/-- liftTransformation is identity-preserving -/
theorem liftTransformation_identityPreserving {α β : Type} (f : α → β) :
    IdentityPreserving' (liftTransformation f) :=
  fun x => ⟨f x, rfl⟩

/-- liftTransformation is Stable -/
theorem liftTransformation_stable {α β : Type} (f : α → β) :
    Stable (liftTransformation f) :=
  ⟨liftTransformation_propagates f, liftTransformation_identityPreserving f⟩

/-- liftTransformation propagates indeterminate states -/
theorem liftTransformation_propagatesI {α β : Type} (f : α → β) :
    Propagates (liftTransformation f) :=
  fun s hs => by simp [IndeterminateState, liftTransformation, hs]
