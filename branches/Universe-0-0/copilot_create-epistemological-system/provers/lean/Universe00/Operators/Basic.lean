/-
  Universe00/Operators/Basic.lean
  
  Basic operators for the Outcome monad: map, bind, and composition.
  These are already defined in Core/Outcome.lean, but this module
  provides additional utilities and derived operators.
  
  Author: Universe-0-0 Project
  Version: 1.0.0
  Date: 2025-12-31
-/

import Universe00.Core.Outcome
import Universe00.Core.Regime

namespace Universe00.Operators

open Universe00.Core

/-! ## Basic Operators

Foundational operators for working with Outcome values.
These build on the monad structure defined in Core/Outcome.
-/

/-- Apply a binary function to two Outcomes -/
def liftA2 {α β γ : Type u} (f : α → β → γ) :
    Outcome α → Outcome β → Outcome γ
  | Outcome.value a, Outcome.value b => Outcome.value (f a b)
  | Outcome.limit r, _ => Outcome.limit r
  | _, Outcome.limit r => Outcome.limit r

/-- Apply a ternary function to three Outcomes -/
def liftA3 {α β γ δ : Type u} (f : α → β → γ → δ) :
    Outcome α → Outcome β → Outcome γ → Outcome δ
  | Outcome.value a, Outcome.value b, Outcome.value c => 
      Outcome.value (f a b c)
  | Outcome.limit r, _, _ => Outcome.limit r
  | _, Outcome.limit r, _ => Outcome.limit r
  | _, _, Outcome.limit r => Outcome.limit r

/-- Conditional outcome: if condition is value true, return first, else second -/
def cond {α : Type u} : Outcome Bool → Outcome α → Outcome α → Outcome α
  | Outcome.value true, onTrue, _ => onTrue
  | Outcome.value false, _, onFalse => onFalse
  | Outcome.limit r, _, _ => Outcome.limit r

/-- Filter: keep value only if predicate holds -/
def filter {α : Type u} (p : α → Bool) (reason : LimitReason) :
    Outcome α → Outcome α
  | Outcome.value a => if p a then Outcome.value a else Outcome.limit reason
  | Outcome.limit r => Outcome.limit r

/-- Optional unwrapping with custom limit reason -/
def fromOptionWith {α : Type u} (reason : LimitReason) :
    Option α → Outcome α :=
  Outcome.fromOption reason

/-- Catch a limit and replace with default -/
def catchLimit {α : Type u} (default : α) : Outcome α → Outcome α
  | Outcome.value a => Outcome.value a
  | Outcome.limit _ => Outcome.value default

/-- Recover from a limit using a function -/
def recover {α : Type u} (f : LimitReason → Outcome α) :
    Outcome α → Outcome α
  | Outcome.value a => Outcome.value a
  | Outcome.limit r => f r

/-! ## Regime-Aware Operators

Operators that are aware of the current regime and adapt accordingly.
-/

structure RegimeAware (α : Type u) where
  classical : Outcome α
  constructive : Outcome α
  meadow : Outcome α
  paraconsistent : Outcome α
  extreme : Outcome α
deriving Inhabited

namespace RegimeAware

/-- Select outcome based on regime -/
def select {α : Type u} (ra : RegimeAware α) (r : Regime) : Outcome α :=
  match r with
  | Regime.Classical => ra.classical
  | Regime.Constructive => ra.constructive
  | Regime.Meadow => ra.meadow
  | Regime.Paraconsistent => ra.paraconsistent
  | Regime.Extreme => ra.extreme
  | Regime.Regularized _ => ra.extreme
  | Regime.Custom _ => ra.classical

/-- Create regime-aware value (same in all regimes) -/
def pure {α : Type u} (a : α) : RegimeAware α :=
  { classical := Outcome.value a
  , constructive := Outcome.value a
  , meadow := Outcome.value a
  , paraconsistent := Outcome.value a
  , extreme := Outcome.value a }

/-- Create regime-aware limit (same in all regimes) -/
def limit {α : Type u} (r : LimitReason) : RegimeAware α :=
  { classical := Outcome.limit r
  , constructive := Outcome.limit r
  , meadow := Outcome.limit r
  , paraconsistent := Outcome.limit r
  , extreme := Outcome.limit r }

end RegimeAware

/-! ## Operator Composition

Utilities for composing regime-aware operations.
-/

/-- Compose two Outcome-producing functions -/
def composeOp {α β γ : Type u} 
    (f : α → Outcome β) (g : β → Outcome γ) :
    α → Outcome γ :=
  fun a => Outcome.bind (f a) g

/-- Chain a list of operations -/
def chain {α : Type u} : List (α → Outcome α) → α → Outcome α
  | [], a => Outcome.value a
  | (f :: fs), a => Outcome.bind (f a) (chain fs)

/-- Repeat an operation n times -/
def repeatOp {α : Type u} (n : Nat) (f : α → Outcome α) : α → Outcome α :=
  chain (List.replicate n f)

/-! ## Error Handling

Utilities for handling and transforming limit states.
-/

/-- Transform a limit reason -/
def mapLimit {α : Type u} (f : LimitReason → LimitReason) :
    Outcome α → Outcome α
  | Outcome.value a => Outcome.value a
  | Outcome.limit r => Outcome.limit (f r)

/-- Add context to a limit -/
def withContext {α : Type u} (context : String) : Outcome α → Outcome α :=
  mapLimit fun r => 
    LimitReason.customReason s!"{context}: {match r with
      | LimitReason.divisionByZero => "division by zero"
      | LimitReason.lossOfUniqueness => "loss of uniqueness"
      | LimitReason.undecidable => "undecidable"
      | LimitReason.inconsistent => "inconsistent"
      | LimitReason.structuralBoundary s => s!"structural boundary ({s})"
      | LimitReason.customReason s => s}"

/-! ## Theorems about Basic Operators

Establish properties of the derived operators.
-/

namespace BasicTheorems

variable {α β γ : Type u}

/-- liftA2 preserves limits -/
theorem liftA2_limit_left (f : α → β → γ) (r : LimitReason) (ob : Outcome β) :
    liftA2 f (Outcome.limit r) ob = Outcome.limit r := by
  cases ob <;> rfl

theorem liftA2_limit_right (f : α → β → γ) (oa : Outcome α) (r : LimitReason) :
    liftA2 f oa (Outcome.limit r) = 
    match oa with
    | Outcome.limit r' => Outcome.limit r'
    | Outcome.value _ => Outcome.limit r := by
  cases oa <;> rfl

/-- filter respects outcomes -/
theorem filter_value (p : α → Bool) (r : LimitReason) (a : α) :
    filter p r (Outcome.value a) = 
    if p a then Outcome.value a else Outcome.limit r := by
  rfl

theorem filter_limit (p : α → Bool) (r r' : LimitReason) :
    filter p r (Outcome.limit r') = Outcome.limit r' := by
  rfl

/-- recover allows transformation -/
theorem recover_value (f : LimitReason → Outcome α) (a : α) :
    recover f (Outcome.value a) = Outcome.value a := by
  rfl

theorem recover_limit (f : LimitReason → Outcome α) (r : LimitReason) :
    recover f (Outcome.limit r) = f r := by
  rfl

/-- compose preserves structure -/
theorem compose_assoc (f : α → Outcome β) (g : β → Outcome γ) (h : γ → Outcome δ) :
    ∀ (a : α), composeOp (composeOp f g) h a = composeOp f (composeOp g h) a := by
  intro a
  simp [composeOp]
  cases hf : f a
  · rfl
  · rfl

end BasicTheorems

end Universe00.Operators
