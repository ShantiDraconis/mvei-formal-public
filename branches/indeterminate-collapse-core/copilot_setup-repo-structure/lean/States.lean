/-
  States.lean — Concrete State Examples
  Indeterminate Collapse Core, v1.0.0

  Defines the state space and provides concrete examples of IState values.
  Imports Definitions (which imports Axioms).
-/

import «lean».Definitions

/-! # Numeric State Examples -/

/-- A known integer state -/
def knownInt (n : Int) : State Int := IState.Known n

/-- The indeterminate integer state -/
def indeterminateInt : State Int := IState.I

/-- Known natural number state -/
def knownNat (n : Nat) : State Nat := IState.Known n

/-- Indeterminate natural state -/
def indeterminateNat : State Nat := IState.I

/-! # Propositional State Examples -/

/-- Known true proposition state -/
def knownTrue : State Prop := IState.Known True

/-- Known false proposition state -/
def knownFalse : State Prop := IState.Known False

/-- Indeterminate proposition state — models unknown mathematical truths -/
def indeterminateProp : State Prop := IState.I

/-! # Named Research Problem States -/

/-- Represents the Riemann Hypothesis as a state.
    The hypothesis is in the indeterminate domain: its truth value is unknown.
    We model it as I in the I Framework. -/
def riemannHypothesisState : State Prop := IState.I

/-- Represents the P vs NP question as a state.
    Whether P = NP is unknown, so it collapses to I. -/
def pVsNPState : State Prop := IState.I

/-- Represents the Yang-Mills Mass Gap as a state.
    Existence of the mass gap is unknown, so it collapses to I. -/
def yangMillsState : State Prop := IState.I

/-- Represents the Goldbach Conjecture as a state.
    Currently unproven, so it collapses to I. -/
def goldbachState : State Prop := IState.I

/-! # State Space Enumeration -/

/-- A finite state space over a small domain {0, 1, 2} ∪ {I} -/
def FiniteStateSpace : List (State Nat) :=
  [IState.Known 0, IState.Known 1, IState.Known 2, IState.I]

/-- The indeterminate state appears in the finite space -/
theorem I_in_FiniteStateSpace : IState.I ∈ FiniteStateSpace :=
  List.mem_cons.mpr (Or.inr (List.mem_cons.mpr
    (Or.inr (List.mem_cons.mpr (Or.inr (List.mem_singleton.mpr rfl))))))

/-- Number of elements in the finite state space -/
theorem FiniteStateSpace_length : FiniteStateSpace.length = 4 := rfl

/-! # State Classification -/

/-- Check if a state is indeterminate (returns true iff s = I) -/
def isIndeterminate {α : Type} [DecidableEq α] (s : State α) : Bool :=
  match s with
  | IState.Indeterminate => true
  | IState.Known _       => false

/-- Check if a state is known (returns true iff s = Known x for some x) -/
def isKnown {α : Type} [DecidableEq α] (s : State α) : Bool :=
  !isIndeterminate s

/-- isIndeterminate returns true for I -/
theorem isIndeterminate_I {α : Type} [DecidableEq α] :
    isIndeterminate (IState.I : State α) = true := rfl

/-- isIndeterminate returns false for Known values -/
theorem isIndeterminate_known {α : Type} [DecidableEq α] (x : α) :
    isIndeterminate (IState.Known x) = false := rfl

/-- isKnown returns false for I -/
theorem isKnown_I {α : Type} [DecidableEq α] :
    isKnown (IState.I : State α) = false := rfl

/-- isKnown returns true for Known values -/
theorem isKnown_known {α : Type} [DecidableEq α] (x : α) :
    isKnown (IState.Known x) = true := rfl

/-! # State Extraction -/

/-- Safely extract the value from a Known state with a default -/
def extractWithDefault {α : Type} (s : State α) (default : α) : α :=
  match s with
  | IState.Known x    => x
  | IState.Indeterminate => default

/-- Extract always returns the default for I -/
theorem extract_I_default {α : Type} (d : α) :
    extractWithDefault IState.I d = d := rfl

/-- Extract always returns the value for Known -/
theorem extract_known {α : Type} (x d : α) :
    extractWithDefault (IState.Known x) d = x := rfl
