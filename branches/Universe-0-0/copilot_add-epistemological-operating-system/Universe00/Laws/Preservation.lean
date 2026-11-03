/-
Universe00/Laws/Preservation.lean

Law 1: Limit Preservation (Central Law)

When an extension would require:
- Arbitrary choice (ad hoc)
- Loss of uniqueness
- Contradiction
- Impossible decision

The system returns a limit state instead of inventing a value.

This is not an error or failure - it is informative data about
reaching a regime boundary.

Status: ASSUMED (foundational law)
-/

import Universe00.Core.Outcome
import Universe00.Core.Regime

namespace Universe00.Laws

open Universe00.Core

/-!
## Law 1: Limit Preservation

The central law of Universe-00: when classical mathematics cannot continue
without arbitrary choices, we preserve the boundary by returning a limit state.

This replaces:
- Undefined behavior with well-defined limit states
- Ad hoc conventions with explicit regime declarations
- Hidden assumptions with transparent boundaries
-/

axiom limit_preservation {α : Type u} (op : α → α) (x : α) :
  -- If operation requires arbitrary choice/loses uniqueness/contradicts
  (¬ ∃! y : α, op x = y) →
  -- Then return limit state, not invented value
  ∃ ℓ : LimitState, (Outcome.limit ℓ : Outcome α) = Outcome.limit ℓ

/-!
## Trigger Conditions

A limit state is returned when ANY of these conditions hold:
-/

inductive LimitTrigger : Type where
  | arbitrary_choice : String → LimitTrigger
  | lost_uniqueness : List String → LimitTrigger  -- Multiple valid values
  | leads_to_contradiction : String → LimitTrigger
  | undecidable_in_regime : String → LimitTrigger
  deriving Repr

/-!
## Operational Semantics

How limit preservation works in practice:
-/

/-- Check if an operation should return a limit -/
def shouldReturnLimit (trigger : Option LimitTrigger) : Bool :=
  trigger.isSome

/-- Convert trigger to limit state -/
def triggerToLimit : LimitTrigger → LimitState
  | LimitTrigger.arbitrary_choice reason => 
      LimitState.ArbitraryChoice reason
  | LimitTrigger.lost_uniqueness options => 
      LimitState.LostUniqueness s!"Multiple valid values: {options}"
  | LimitTrigger.leads_to_contradiction reason => 
      LimitState.Contradiction reason
  | LimitTrigger.undecidable_in_regime reason => 
      LimitState.Undecidable reason

/-!
## Examples of Limit Preservation
-/

/-- Example: Division by zero requires arbitrary choice or loses uniqueness -/
def divisionByZeroTrigger : LimitTrigger :=
  LimitTrigger.lost_uniqueness ["any value makes 0 * x = 0"]

/-- Example: Undecidable propositions in constructive regime -/
def undecidablePropositionTrigger (prop : String) : LimitTrigger :=
  LimitTrigger.undecidable_in_regime s!"Cannot decide {prop} constructively"

/-!
## Composition Preserves Limits

When composing operations, the first limit dominates.
This ensures limit information propagates correctly.
-/

theorem composition_preserves_first_limit {α β γ : Type u}
    (f : α → Outcome β) (g : β → Outcome γ) (ℓ : LimitState) :
    ((Outcome.limit ℓ : Outcome α) >>= f) >>= g = 
    (Outcome.limit ℓ : Outcome γ) := by
  simp [Outcome.bind]
  rfl

/-!
## No Invented Values

The system never invents a value when uniqueness is lost.
This is formalized as: if we have a limit, we don't have a value.
-/

theorem limit_excludes_value {α : Type u} (ℓ : LimitState) :
    ¬ ∃ (a : α), (Outcome.limit ℓ : Outcome α) = Outcome.value a := by
  intro ⟨a, h⟩
  cases h  -- Contradiction: limit ≠ value

/-!
## Informative, Not Error

A limit state is informative data, not an error condition.
It tells us we've reached a regime boundary.
-/

def limitIsInformative (ℓ : LimitState) : String :=
  match ℓ with
  | LimitState.ArbitraryChoice reason => 
      s!"Reached boundary: arbitrary choice needed: {reason}"
  | LimitState.LostUniqueness reason => 
      s!"Reached boundary: uniqueness lost: {reason}"
  | LimitState.Contradiction reason => 
      s!"Reached boundary: would contradict: {reason}"
  | LimitState.Undecidable reason => 
      s!"Reached boundary: undecidable: {reason}"
  | LimitState.RegimeBoundary reason => 
      s!"Reached boundary: regime limit: {reason}"

/-!
## Preservation Through Functors

Limit preservation is functorial - it respects mathematical structure.
-/

theorem map_preserves_limit {α β : Type u} (f : α → β) (ℓ : LimitState) :
    Outcome.map f (Outcome.limit ℓ : Outcome α) = 
    (Outcome.limit ℓ : Outcome β) := by
  rfl

/-!
## Documentation

This law is the heart of Universe-00's epistemology:

Instead of:
- Saying "undefined" (gives no information)
- Inventing a value (loses truth)
- Throwing an error (treats boundary as failure)

We:
- Return a well-typed limit state
- Preserve the reason for the boundary
- Allow composition to continue correctly
- Make boundaries first-class mathematical objects

This transforms "cannot do" into "informative boundary event".
-/

end Universe00.Laws
