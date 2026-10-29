/-
  Universe00/Core/Outcome.lean
  
  The fundamental type for representing computations that may reach
  a boundary (limit state) rather than producing a standard value.
  
  This is the core semantic primitive of Universe 00: every sensitive
  operation returns either a value or a limit state, never an arbitrary
  choice or explosion.
  
  Author: Universe-0-0 Project
  Version: 1.0.0
  Date: 2025-12-31
-/

namespace Universe00.Core

/-! ## Outcome Type

The `Outcome` type represents the result of any computation that may
encounter a boundary condition. It is the foundation of the "boundary
semantics" that prevents ad-hoc choices and explosions.

### Design Principles
1. **Explicit boundaries**: No hidden failures or implicit conventions
2. **No explosion**: Limits are data, not errors
3. **Composability**: Clean monadic structure for chaining operations
4. **Traceability**: Each limit carries information about why it occurred
-/

/-- Type representing the reason for reaching a limit state -/
inductive LimitReason where
  | divisionByZero : LimitReason
  | lossOfUniqueness : LimitReason
  | undecidable : LimitReason
  | inconsistent : LimitReason
  | structuralBoundary : String → LimitReason
  | customReason : String → LimitReason
deriving Repr, BEq, Inhabited

/-- The fundamental Outcome type: either a value or a limit state -/
inductive Outcome (α : Type u) where
  | value : α → Outcome α
  | limit : LimitReason → Outcome α
deriving Repr, Inhabited

namespace Outcome

/-- Check if an outcome is a value -/
def isValue {α : Type u} : Outcome α → Bool
  | value _ => true
  | limit _ => false

/-- Check if an outcome is a limit -/
def isLimit {α : Type u} : Outcome α → Bool
  | value _ => false
  | limit _ => true

/-- Get the value, or a default if limit -/
def getOrElse {α : Type u} (default : α) : Outcome α → α
  | value a => a
  | limit _ => default

/-- Get the limit reason if it's a limit -/
def getLimitReason {α : Type u} : Outcome α → Option LimitReason
  | value _ => none
  | limit r => some r

/-! ## Functor Instance

Map a function over the value, preserving limits.
This is Law 1 (Preservation): limits propagate through transformations.
-/

def map {α β : Type u} (f : α → β) : Outcome α → Outcome β
  | value a => value (f a)
  | limit r => limit r

instance : Functor Outcome where
  map := map

/-! ## Monad Instance

Bind operation: chain computations where the first limit dominates.
This enforces the "first boundary wins" principle.
-/

def bind {α β : Type u} : Outcome α → (α → Outcome β) → Outcome β
  | value a, f => f a
  | limit r, _ => limit r

def pure {α : Type u} (a : α) : Outcome α := value a

instance : Monad Outcome where
  pure := pure
  bind := bind

/-! ## Applicative Instance -/

def seq {α β : Type u} : Outcome (α → β) → (Unit → Outcome α) → Outcome β
  | value f, x => map f (x ())
  | limit r, _ => limit r

instance : Applicative Outcome where
  pure := pure
  seq := seq

/-! ## Helper Functions -/

/-- Lift a partial function to Outcome, returning limit on none -/
def fromOption {α : Type u} (reason : LimitReason) : Option α → Outcome α
  | some a => value a
  | none => limit reason

/-- Convert to Option (losing limit reason information) -/
def toOption {α : Type u} : Outcome α → Option α
  | value a => some a
  | limit _ => none

/-- Combine two outcomes, taking the first limit if any -/
def combine {α β γ : Type u} (f : α → β → γ) : 
    Outcome α → Outcome β → Outcome γ
  | value a, value b => value (f a b)
  | limit r, _ => limit r
  | _, limit r => limit r

/-- Sequence a list of outcomes, failing fast on first limit -/
def sequence {α : Type u} : List (Outcome α) → Outcome (List α)
  | [] => value []
  | (value a :: rest) => 
      match sequence rest with
      | value as => value (a :: as)
      | limit r => limit r
  | (limit r :: _) => limit r

/-- Map a function that returns Outcome over a list -/
def traverse {α β : Type u} (f : α → Outcome β) : 
    List α → Outcome (List β)
  | [] => value []
  | (a :: rest) =>
      match f a with
      | value b =>
          match traverse f rest with
          | value bs => value (b :: bs)
          | limit r => limit r
      | limit r => limit r

end Outcome

/-! ## Theorems about Outcome

These establish that Outcome satisfies the monad laws and preserves
the non-explosion property (Law 2).
-/

namespace OutcomeTheorems

variable {α β γ : Type u}

/-- Left identity: pure a >>= f = f a -/
theorem bind_pure_left (a : α) (f : α → Outcome β) :
    Outcome.bind (Outcome.pure a) f = f a := rfl

/-- Right identity: m >>= pure = m -/
theorem bind_pure_right : ∀ (m : Outcome α),
    Outcome.bind m Outcome.pure = m
  | Outcome.value _ => rfl
  | Outcome.limit _ => rfl

/-- Associativity: (m >>= f) >>= g = m >>= (λ x => f x >>= g) -/
theorem bind_assoc (m : Outcome α) (f : α → Outcome β) (g : β → Outcome γ) :
    Outcome.bind (Outcome.bind m f) g = 
    Outcome.bind m (fun x => Outcome.bind (f x) g) := by
  cases m <;> rfl

/-- Map preserves values -/
theorem map_value (f : α → β) (a : α) :
    Outcome.map f (Outcome.value a) = Outcome.value (f a) := rfl

/-- Map preserves limits (Law 1: Preservation) -/
theorem map_limit (f : α → β) (r : LimitReason) :
    Outcome.map f (Outcome.limit r) = Outcome.limit r := rfl

/-- Bind with pure is map (functor-monad law) -/
theorem bind_pure_is_map (f : α → β) (m : Outcome α) :
    Outcome.bind m (fun a => Outcome.pure (f a)) = Outcome.map f m := by
  cases m <;> rfl

/-- First limit dominates in bind -/
theorem bind_limit_dominates (r : LimitReason) (f : α → Outcome β) :
    Outcome.bind (Outcome.limit r) f = Outcome.limit r := rfl

/-- Non-explosion: from limit, we cannot derive arbitrary value -/
theorem no_explosion_from_limit (r : LimitReason) (a : α) :
    Outcome.limit r ≠ Outcome.value a := by
  intro h
  cases h

end OutcomeTheorems

end Universe00.Core
