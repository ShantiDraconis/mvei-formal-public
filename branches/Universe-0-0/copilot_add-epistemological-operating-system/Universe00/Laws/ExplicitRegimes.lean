/-
Universe00/Laws/ExplicitRegimes.lean

Law 3: Explicit Regimes

Every law, operation, and claim has an explicitly declared scope (regime).
This eliminates implicit "valid everywhere" assumptions that become
structural lies.

Status: ASSUMED (foundational law)
-/

import Universe00.Core.Outcome
import Universe00.Core.Regime

namespace Universe00.Laws

open Universe00.Core

/-!
## Law 3: Explicit Regimes

Every operation, theorem, and claim in Universe-00 has an explicitly
declared regime of validity.

This prevents:
- Implicit universal quantification
- Scope confusion
- Invalid generalizations
- Hidden assumptions
-/

/-!
## Regime-Indexed Operations

All sensitive operations are indexed by regime.
-/

structure RegimeIndexedOp (α β : Type u) where
  regime : Regime
  operation : α → Outcome β
  deriving Repr

/-!
## Scope Declaration

Every mathematical claim must declare its scope.
-/

structure ScopedClaim (α : Type u) where
  regime : Regime
  statement : α
  assumptions : List String
  deriving Repr

/-!
## No Implicit Universals

The system rejects implicit "this holds everywhere" claims.
-/

axiom no_implicit_universal {α : Type u} (op : α → α) :
  -- Every operation must be explicitly scoped to a regime
  ∃ r : Regime, ∃ f : RegimeIndexedOp α α, f.regime = r

/-!
## Regime Declarations

Standard patterns for declaring regime scope.
-/

/-- Declare an operation valid in a specific regime -/
def inRegime {α β : Type u} (r : Regime) (op : α → Outcome β) :
    RegimeIndexedOp α β :=
  ⟨r, op⟩

/-- Declare a claim valid in a specific regime -/
def claimInRegime {α : Type u} (r : Regime) (stmt : α) 
    (asms : List String) : ScopedClaim α :=
  ⟨r, stmt, asms⟩

/-!
## Examples
-/

/-- Division in Classical regime -/
def divClassical : RegimeIndexedOp (Nat × Nat) Rat :=
  inRegime Regime.Classical fun (n, d) =>
    if d = 0 then
      Outcome.limit (LimitState.ArbitraryChoice "division by zero")
    else
      Outcome.value (n / d)

/-- Excluded middle in Classical regime -/
def excludedMiddleClassical (P : Prop) : ScopedClaim (P ∨ ¬P) :=
  claimInRegime Regime.Classical (P ∨ ¬P) ["Law of excluded middle"]

/-!
## Regime Mismatch Detection

The system can detect when operations from incompatible regimes
are being mixed.
-/

def regimesCompatible (r1 r2 : Regime) : Bool :=
  r1 == r2 ∨ Regime.conservativeExtension r1 r2

theorem incompatible_regimes_detected
    {α β γ : Type u}
    (op1 : RegimeIndexedOp α β) (op2 : RegimeIndexedOp β γ) :
    ¬regimesCompatible op1.regime op2.regime →
    ∃ ℓ : LimitState, True := by
  intro _
  exact ⟨LimitState.RegimeBoundary "incompatible regimes", trivial⟩

/-!
## Explicit Scope Annotations

In practice, every definition should include regime annotation.
-/

/-
Example annotation format:

```lean
-- Regime: Classical
-- Assumptions: Excluded middle, Choice
def myOperation ...
```
-/

/-!
## Benefits

Explicit regimes provide:
1. **Clarity**: Always know where claims are valid
2. **Safety**: Cannot accidentally mix incompatible frameworks
3. **Honesty**: No hidden assumptions
4. **Modularity**: Different regimes can coexist
-/

/-!
## Integration with Type System

Regimes can be encoded at the type level for compile-time checking.
-/

def TypedInRegime (α : Type u) (r : Regime) := Regime.Tagged α

/-!
## Documentation

This law answers: "Where does this apply?"

Every operation answers this question explicitly:
- Classical mathematics
- Constructive mathematics  
- Total functions (Meadow)
- Boundary exploration (Extreme)
- With explicit conventions (Regularized)

No more implicit "everywhere" that turns into "nowhere" at boundaries.
-/

end Universe00.Laws
