/-
Universe00/Operators/SafeDiv.lean

Safe division operator that returns Outcome.

Instead of:
- undefined behavior
- exception throwing
- arbitrary values (like 0/0 = 0)

We return limit states that preserve the reason for boundary.

Status: PROVED (implementation)
-/

import Universe00.Core.Outcome
import Universe00.Core.Regime
import Universe00.Laws.Preservation

namespace Universe00.Operators

open Universe00.Core

/-!
## Safe Division (sdiv)

Division that never lies, never crashes, never invents values.
-/

/-- Safe division in a regime -/
def sdiv (R : Regime) (α : Type u) [Div α] [BEq α] [OfNat α 0] :
    α → α → Outcome α :=
  fun numerator denominator =>
    if denominator == 0 then
      match R with
      | Regime.Meadow => 
          -- In Meadow regime, 0/0 = 0 by convention
          Outcome.value 0
      | Regime.Regularized =>
          -- In Regularized regime, might have specific convention
          Outcome.value 0  -- Example: could be configured
      | _ =>
          -- In most regimes, division by zero is a boundary
          Outcome.limit (LimitState.ArbitraryChoice 
            "Division by zero: uniqueness lost, any value makes 0*x = 0")
    else
      Outcome.value (numerator / denominator)

/-!
## Safe Integer Division
-/

def sdivNat (R : Regime) : Nat → Nat → Outcome Nat :=
  sdiv R Nat

def sdivInt (R : Regime) : Int → Int → Outcome Int :=
  sdiv R Int

/-!
## Safe Rational Division
-/

def sdivRat (R : Regime) : Rat → Rat → Outcome Rat :=
  sdiv R Rat

/-!
## Examples
-/

/-- Normal division succeeds -/
example : sdivNat Regime.Classical 10 2 = Outcome.value 5 := rfl

/-- Division by zero returns limit in Classical regime -/
example : ∃ ℓ : LimitState, 
    sdivNat Regime.Classical 10 0 = Outcome.limit ℓ := by
  exists LimitState.ArbitraryChoice 
    "Division by zero: uniqueness lost, any value makes 0*x = 0"
  rfl

/-- Division by zero returns value in Meadow regime -/
example : sdivNat Regime.Meadow 10 0 = Outcome.value 0 := rfl

/-!
## Properties
-/

theorem sdiv_preserves_classical {α : Type u} [Div α] [BEq α] [OfNat α 0]
    (n d : α) (h : d ≠ 0) :
    -- When denominator is non-zero, sdiv behaves classically
    ∃ v : α, sdiv Regime.Classical α n d = Outcome.value v := by
  exists n / d
  simp [sdiv]
  split
  · contradiction  -- h says d ≠ 0, split says d == 0
  · rfl

theorem sdiv_boundary_at_zero {α : Type u} [Div α] [BEq α] [OfNat α 0]
    (n : α) :
    -- Division by zero produces limit in Classical regime
    ∃ ℓ : LimitState, 
      sdiv Regime.Classical α n 0 = Outcome.limit ℓ := by
  exists LimitState.ArbitraryChoice 
    "Division by zero: uniqueness lost, any value makes 0*x = 0"
  simp [sdiv]
  rfl

/-!
## Composability

Safe division composes correctly using Outcome monad.
-/

def chain_divisions (R : Regime) (a b c : Nat) : Outcome Nat :=
  sdivNat R a b >>= fun x =>
  sdivNat R x c

example : chain_divisions Regime.Classical 100 10 2 = Outcome.value 5 := rfl

example : ∃ ℓ : LimitState,
    chain_divisions Regime.Classical 100 0 2 = Outcome.limit ℓ := by
  exists LimitState.ArbitraryChoice 
    "Division by zero: uniqueness lost, any value makes 0*x = 0"
  rfl  -- First division hits limit, which propagates

/-!
## Documentation

This operator demonstrates Law 1 (Limit Preservation) in action:

Instead of:
- Crashing with exception
- Returning undefined
- Inventing value (0/0 = 0 without declaration)

We:
- Return informative limit state
- Preserve composability
- Make regime explicit
- Allow different conventions in different regimes

This is honesty in computation.
-/

end Universe00.Operators
