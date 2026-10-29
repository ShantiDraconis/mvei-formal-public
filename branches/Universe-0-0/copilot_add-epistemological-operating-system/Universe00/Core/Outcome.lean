/-
Universe00/Core/Outcome.lean

The fundamental Outcome type for the Universe-00 epistemological operating system.

An Outcome represents the result of a computation that may encounter structural
boundaries where classical mathematics cannot continue without arbitrary choices.

Law 1 (Limit Preservation): When an operation would require arbitrary choice,
loss of uniqueness, contradiction, or impossible decision, the system returns
a limit state instead of inventing a value.

Status: PROVED (core type definition)
-/

namespace Universe00.Core

/-!
## LimitState

A limit state represents a structural boundary where the classical framework
cannot continue. It is NOT an error and NOT false - it is informative data
about reaching a regime boundary.
-/

inductive LimitState : Type where
  | ArbitraryChoice : String → LimitState  -- Would require ad hoc choice
  | LostUniqueness : String → LimitState   -- Multiple valid values exist
  | Contradiction : String → LimitState    -- Leads to inconsistency
  | Undecidable : String → LimitState      -- Cannot be decided in this regime
  | RegimeBoundary : String → LimitState   -- Reached boundary of current regime
  deriving Repr, BEq

/-!
## Outcome

The core return type for all regime-sensitive operations.

Returns either:
- `value a`: Normal result in current regime
- `limit ℓ`: Reached a structural boundary (informative, not error)

This is the "boundary semantics" universal to Universe-00.
-/

inductive Outcome (α : Type u) : Type u where
  | value : α → Outcome α
  | limit : LimitState → Outcome α
  deriving Repr

namespace Outcome

/-!
## Basic Operations
-/

/-- Check if outcome is a value -/
def isValue {α : Type u} : Outcome α → Bool
  | value _ => true
  | limit _ => false

/-- Check if outcome is a limit -/
def isLimit {α : Type u} : Outcome α → Bool
  | value _ => false
  | limit _ => true

/-- Extract value with default -/
def getOrElse {α : Type u} (o : Outcome α) (default : α) : α :=
  match o with
  | value a => a
  | limit _ => default

/-- Extract limit state if present -/
def getLimitState {α : Type u} : Outcome α → Option LimitState
  | value _ => none
  | limit ℓ => some ℓ

/-!
## Functor Instance (map)

Law: `map f (limit ℓ) = limit ℓ` (limit preservation)
-/

def map {α β : Type u} (f : α → β) : Outcome α → Outcome β
  | value a => value (f a)
  | limit ℓ => limit ℓ  -- First limit dominates (Law 1)

instance : Functor Outcome where
  map := @map

/-!
## Applicative Operations
-/

def pure {α : Type u} (a : α) : Outcome α :=
  value a

def seq {α β : Type u} : Outcome (α → β) → (Unit → Outcome α) → Outcome β
  | value f, x => map f (x ())
  | limit ℓ, _ => limit ℓ  -- First limit dominates

instance : Applicative Outcome where
  pure := @pure
  seq := @seq

/-!
## Monad Instance (bind)

The bind operation composes outcomes following limit preservation:
- If first outcome is limit, return that limit (first limit dominates)
- Otherwise, apply the function to the value

This is the core of composability without lying about boundaries.
-/

def bind {α β : Type u} : Outcome α → (α → Outcome β) → Outcome β
  | value a, f => f a
  | limit ℓ, _ => limit ℓ  -- First limit dominates (Law 1)

instance : Monad Outcome where
  pure := @pure
  bind := @bind

/-!
## Helper Combinators
-/

/-- Sequence two outcomes, keeping first limit if any -/
def andThen {α β : Type u} (oa : Outcome α) (ob : Outcome β) : Outcome β :=
  oa >>= (fun _ => ob)

/-- Choose first successful value, or combine limits -/
def orElse {α : Type u} : Outcome α → Outcome α → Outcome α
  | value a, _ => value a
  | limit _, value b => value b
  | limit ℓ1, limit ℓ2 => limit ℓ1  -- First limit dominates

/-- Lift a potentially failing operation into Outcome -/
def fromOption {α : Type u} (o : Option α) (ℓ : LimitState) : Outcome α :=
  match o with
  | some a => value a
  | none => limit ℓ

/-- Convert Outcome to Option (losing limit information) -/
def toOption {α : Type u} : Outcome α → Option α
  | value a => some a
  | limit _ => none

/-!
## Theorems

These establish the formal properties of Outcome as a monad
following limit preservation semantics.
-/

-- Monad Laws

theorem left_identity {α β : Type u} (a : α) (f : α → Outcome β) :
    (pure a >>= f) = f a := rfl

theorem right_identity {α : Type u} (oa : Outcome α) :
    (oa >>= pure) = oa := by
  cases oa <;> rfl

theorem associativity {α β γ : Type u}
    (oa : Outcome α) (f : α → Outcome β) (g : β → Outcome γ) :
    ((oa >>= f) >>= g) = (oa >>= fun x => f x >>= g) := by
  cases oa <;> rfl

-- Limit Preservation Laws

theorem limit_preserves_through_map {α β : Type u} (f : α → β) (ℓ : LimitState) :
    map f (limit ℓ : Outcome α) = (limit ℓ : Outcome β) := rfl

theorem limit_preserves_through_bind {α β : Type u}
    (ℓ : LimitState) (f : α → Outcome β) :
    (limit ℓ : Outcome α) >>= f = (limit ℓ : Outcome β) := rfl

theorem first_limit_dominates {α β : Type u}
    (ℓ : LimitState) (a : α) (f : α → Outcome β) :
    (limit ℓ : Outcome α) >>= f = (limit ℓ : Outcome β) := rfl

end Outcome

end Universe00.Core
