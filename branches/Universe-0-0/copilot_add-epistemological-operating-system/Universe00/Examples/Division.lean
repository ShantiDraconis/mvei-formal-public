/-
Universe00/Examples/Division.lean

Canonical Example #1: Division

This demonstrates how Universe-00 handles the classic "division by zero"
problem across different regimes.

Status: PROVED (example)
-/

import Universe00.Core.Outcome
import Universe00.Core.Regime
import Universe00.Core.Status
import Universe00.Laws.Conservativity
import Universe00.Laws.Preservation
import Universe00.Operators.SafeDiv

namespace Universe00.Examples

open Universe00.Core
open Universe00.Operators

/-!
## The Division Problem

Classical mathematics: division by zero is "undefined"
Problem: This gives no information and breaks composition

Universe-00 solution: Return informative limit states
-/

/-!
## Scenario 1: Classical Regime

In Classical regime, division by zero is a genuine boundary.
-/

def classicalExample : Outcome Nat :=
  sdivNat Regime.Classical 42 0

theorem classicalIsLimit :
    ∃ ℓ : LimitState, classicalExample = Outcome.limit ℓ := by
  exists LimitState.ArbitraryChoice 
    "Division by zero: uniqueness lost, any value makes 0*x = 0"
  rfl

/-!
## Scenario 2: Meadow Regime

In Meadow regime, division is total: 0/0 = 0 by explicit convention.
-/

def meadowExample : Outcome Nat :=
  sdivNat Regime.Meadow 42 0

theorem meadowIsValue :
    meadowExample = Outcome.value 0 := rfl

/-!
## Scenario 3: Composition Shows Difference

The power of Outcome: limits propagate correctly.
-/

def classicalComposition : Outcome Nat :=
  sdivNat Regime.Classical 100 0 >>= fun x =>
  sdivNat Regime.Classical x 2

theorem classicalCompositionIsLimit :
    ∃ ℓ : LimitState, classicalComposition = Outcome.limit ℓ := by
  exists LimitState.ArbitraryChoice 
    "Division by zero: uniqueness lost, any value makes 0*x = 0"
  rfl

def meadowComposition : Outcome Nat :=
  sdivNat Regime.Meadow 100 0 >>= fun x =>
  sdivNat Regime.Meadow x 2

theorem meadowCompositionIsValue :
    meadowComposition = Outcome.value 0 := rfl

/-!
## Scenario 4: Normal Cases Preserved (Law 0)

When division is well-defined classically, Universe-00 preserves that.
-/

def normalDivision : Outcome Nat :=
  sdivNat Regime.Classical 100 10

theorem normalPreserved :
    normalDivision = Outcome.value 10 := rfl

/-!
## Scenario 5: Informative Boundaries

The limit state carries information about WHY we hit a boundary.
-/

def inspectLimit : String :=
  match classicalExample with
  | Outcome.value _ => "Got value (unexpected)"
  | Outcome.limit ℓ =>
      match ℓ with
      | LimitState.ArbitraryChoice reason => 
          s!"Boundary: {reason}"
      | LimitState.LostUniqueness reason => 
          s!"Uniqueness lost: {reason}"
      | _ => "Other boundary"

#eval inspectLimit  -- "Boundary: Division by zero: ..."

/-!
## Scenario 6: Status Tracking

Track epistemic status of our claims.
-/

def divisionClaim : Claim (sdivNat Regime.Classical 10 2 = Outcome.value 5) :=
  Claim.proved rfl "Universe00/Examples/Division.lean" "divisionClaim"

theorem claimIsVerified :
    divisionClaim.isProved = true := rfl

/-!
## What This Demonstrates

1. **Law 0 (Conservativity)**: Normal division works exactly as before
2. **Law 1 (Preservation)**: Boundaries return limit, not crash
3. **Law 2 (Non-Explosion)**: Limits don't let us prove anything
4. **Law 3 (Explicit Regimes)**: Different behavior in different regimes
5. **Law 4 (Anti-Ad Hoc)**: Meadow convention is explicit
6. **Law 5 (Traceability)**: Claims have clear epistemic status

This is Universe-00's epistemology in action.
-/

/-!
## Comparison with Classical Approach

Classical: "division by zero is undefined"
- No information
- Breaks composition
- Forces exception handling

Universe-00: "division by zero is a limit"
- Informative boundary
- Preserves composition
- Type-safe handling
-/

end Universe00.Examples
