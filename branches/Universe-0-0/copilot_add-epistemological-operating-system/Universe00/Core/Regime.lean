/-
Universe00/Core/Regime.lean

Regimes define the scope of validity for mathematical operations.

Law 3 (Explicit Regimes): Every law has a declared scope (regime).
This eliminates implicit "valid everywhere" assumptions that become structural lies.

Status: PROVED (core type definition)
-/

import Universe00.Core.Outcome

namespace Universe00.Core

/-!
## Regime

A Regime defines a mathematical framework with its own rules,
assumptions, and boundaries.

Each operation is indexed by regime, allowing coexistence of:
- Classical mathematics (full power)
- Constructive mathematics (no excluded middle)
- Meadow/Total functions (division always defined)
- Paraconsistent logic (contradiction-tolerant)
- Extreme boundaries (frontier exploration)
- Regularized (explicit conventions)
-/

inductive Regime : Type where
  | Classical : Regime       -- Standard mathematics with excluded middle
  | Constructive : Regime    -- No excluded middle, explicit witnesses
  | Meadow : Regime          -- Total division (0/0 = specific value)
  | Paraconsistent : Regime  -- Tolerates local contradictions
  | Extreme : Regime         -- Boundary/frontier exploration
  | Regularized : Regime     -- Explicit conventions/regularizations
  | Custom : String → Regime -- User-defined regime
  deriving Repr, BEq, Inhabited

namespace Regime

/-!
## Regime Properties
-/

/-- Check if regime allows excluded middle -/
def hasExcludedMiddle : Regime → Bool
  | Classical => true
  | Meadow => true
  | Regularized => true
  | _ => false

/-- Check if regime has total division -/
def hasTotalDivision : Regime → Bool
  | Meadow => true
  | Regularized => true
  | _ => false

/-- Check if regime tolerates contradictions -/
def toleratesContradiction : Regime → Bool
  | Paraconsistent => true
  | _ => false

/-- Check if regime is for boundary exploration -/
def isBoundaryRegime : Regime → Bool
  | Extreme => true
  | _ => false

/-!
## Regime Relationships
-/

/-- Conservative extension: target extends source without contradicting it -/
def conservativeExtension : Regime → Regime → Bool
  | Classical, Classical => true
  | Classical, Extreme => true
  | Classical, Regularized => true
  | Constructive, Classical => true  -- Can embed constructive in classical
  | Constructive, Constructive => true
  | r1, r2 => r1 == r2

/-- Can we safely transition from source to target? -/
def canTransition : Regime → Regime → Bool
  | source, target => conservativeExtension source target

/-!
## Regime Annotations

These type-level annotations allow tracking which regime
a value or operation belongs to.
-/

/-- A value tagged with its regime of origin -/
structure Tagged (α : Type u) where
  regime : Regime
  value : α
  deriving Repr

/-- Extract value, forgetting regime -/
def Tagged.get {α : Type u} (t : Tagged α) : α := t.value

/-- Change regime if transition is valid -/
def Tagged.reframe {α : Type u} (t : Tagged α) (target : Regime) : 
    Outcome (Tagged α) :=
  if canTransition t.regime target then
    Outcome.value ⟨target, t.value⟩
  else
    Outcome.limit <| LimitState.RegimeBoundary 
      s!"Cannot transition from {t.regime} to {target}"

/-!
## Regime Context

The ambient regime for operations.
In practice, this would be tracked via a reader monad or implicit parameter.
-/

structure Context where
  regime : Regime
  assumptions : List String  -- Explicit assumptions in this context
  deriving Repr

def Context.default : Context :=
  ⟨Classical, []⟩

/-!
## Theorems
-/

theorem conservativeExtension_refl (r : Regime) : 
    conservativeExtension r r = true := by
  cases r <;> rfl

theorem conservativeExtension_trans (r1 r2 r3 : Regime) :
    conservativeExtension r1 r2 = true →
    conservativeExtension r2 r3 = true →
    conservativeExtension r1 r3 = true := by
  cases r1 <;> cases r2 <;> cases r3 <;> 
    simp [conservativeExtension] <;> intros <;> trivial

end Regime

end Universe00.Core
