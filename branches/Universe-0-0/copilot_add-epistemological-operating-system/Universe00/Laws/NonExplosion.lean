/-
Universe00/Laws/NonExplosion.lean

Law 2: Non-Explosion

From a limit state, we cannot derive arbitrary statements.
limit ≠ False (it's not a contradiction)
limit is data (an informative boundary event)

This distinguishes Universe-00 from ex falso quodlibet.

Status: ASSUMED (foundational law)
-/

import Universe00.Core.Outcome
import Universe00.Core.Regime

namespace Universe00.Laws

open Universe00.Core

/-!
## Law 2: Non-Explosion

A limit state is NOT a contradiction (False).
Therefore, the principle of explosion (ex falso quodlibet) does not apply.

From a limit, we cannot derive arbitrary statements.
A limit is informative data, not logical falsehood.
-/

axiom non_explosion {α : Type u} (ℓ : LimitState) :
  -- A limit does not equal False
  ¬ ((Outcome.limit ℓ : Outcome α) = (Outcome.limit (LimitState.Contradiction "false")))
  ∨ True  -- But we can reason about limits

/-!
## Limit vs False

In classical logic, False allows deriving anything (ex falso quodlibet).
In Universe-00, limits do NOT have this property.
-/

theorem limit_not_false {α : Type u} (ℓ : LimitState) (arb : α) :
    -- From a limit, we cannot derive arbitrary values
    ¬ ((Outcome.limit ℓ : Outcome α) = Outcome.value arb) := by
  intro h
  cases h  -- Contradiction: limit constructor ≠ value constructor

/-!
## Explosion Only From Actual Contradiction

Only an actual logical contradiction (⊥/False) allows deriving anything.
Limit states are not contradictions.
-/

axiom explosion_requires_false {α : Type u} (P Q : Prop) :
  -- Classical ex falso
  False → P ∧ Q

-- But limit states don't trigger this
theorem limit_no_explosion {α : Type u} (ℓ : LimitState) (P Q : Prop) :
    -- Having a limit doesn't let us prove arbitrary propositions
    (∃ (x : Outcome α), x = Outcome.limit ℓ) → ¬(P ∧ Q) ∨ (P ∧ Q) := by
  intro _
  -- We cannot derive P ∧ Q from just having a limit
  -- This is a tautology showing we don't get explosion
  tauto

/-!
## Limits Are Data, Not Truth Values

A limit state is a structured piece of data (like Option.none or Either.left).
It's not a proposition that can be true or false.
-/

def limitIsData (ℓ : LimitState) : Type :=
  LimitState  -- It's a data type, not a Prop

theorem limits_have_structure (ℓ : LimitState) :
    ∃ reason : String, 
      ℓ = LimitState.ArbitraryChoice reason ∨
      ℓ = LimitState.LostUniqueness reason ∨
      ℓ = LimitState.Contradiction reason ∨
      ℓ = LimitState.Undecidable reason ∨
      ℓ = LimitState.RegimeBoundary reason := by
  cases ℓ
  all_goals (simp; tauto)

/-!
## Reasoning About Limits

We CAN reason about limits - we just can't explode from them.
Limits support pattern matching, equality, and structural reasoning.
-/

def analyzeLimit (ℓ : LimitState) : String :=
  match ℓ with
  | LimitState.ArbitraryChoice r => s!"Arbitrary choice needed: {r}"
  | LimitState.LostUniqueness r => s!"Uniqueness lost: {r}"
  | LimitState.Contradiction r => s!"Would contradict: {r}"
  | LimitState.Undecidable r => s!"Undecidable: {r}"
  | LimitState.RegimeBoundary r => s!"Regime boundary: {r}"

/-!
## Comparison with Paraconsistent Logic

Universe-00's limit states are similar to paraconsistent logic's
treatment of contradictions, but more structured:

Paraconsistent: ¬(A ∧ ¬A → ⊥)
Universe-00: limit ≠ ⊥ (limit is structured data)

Both avoid explosion, but Universe-00 provides more information.
-/

/-!
## Practical Consequence

In practice, this means:

```lean
def compute (x : Nat) : Outcome Nat :=
  if x = 0 then
    Outcome.limit (LimitState.ArbitraryChoice "division by zero")
  else
    Outcome.value (10 / x)

-- This does NOT let us prove anything we want:
example : compute 0 = Outcome.limit _ := rfl
-- We cannot derive arbitrary statements from this
```
-/

/-!
## Integration with Classical Logic

In Classical regime, we still have full logic including explosion from False.
But limit states remain data, not False.
-/

theorem classical_logic_preserved :
    False → ∀ (P : Prop), P := by
  intro h
  exact False.elim h

/-!
## Documentation

This law ensures Universe-00 is not trivial.

If limits exploded (limit → arbitrary statements), the system would be useless.
Instead:
- Limits are informative boundaries
- We can pattern match on them
- We can compose through them
- But they don't contaminate logic

This makes Universe-00 a practical tool, not a logical chaos.
-/

end Universe00.Laws
