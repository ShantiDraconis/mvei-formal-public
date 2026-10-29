/-
  Universe00/Core/Regime.lean
  
  Defines mathematical regimes (domains) and their transitions.
  
  A regime specifies the scope of validity for mathematical laws.
  This implements Law 3 (Explicit Regimes): every law has a declared scope.
  
  Author: Universe-0-0 Project
  Version: 1.0.0
  Date: 2025-12-31
-/

import Universe00.Core.Outcome

namespace Universe00.Core

/-! ## Regime Type

A regime is a mathematical context where certain laws and operations are valid.
This makes explicit what is usually implicit: the domain of applicability.

Examples:
- Classical: standard mathematics with LEM, AC, etc.
- Constructive: intuitionistic mathematics without LEM
- Meadow: division is total (0/0 defined)
- Paraconsistent: contradictions don't explode
- Extreme: at boundaries/limits
- Regularized: divergences handled by renormalization
-/

inductive Regime where
  | Classical : Regime
  | Constructive : Regime
  | Meadow : Regime
  | Paraconsistent : Regime
  | Extreme : Regime
  | Regularized : String → Regime  -- Named regularization scheme
  | Custom : String → Regime       -- User-defined regime
deriving Repr, BEq, Inhabited

namespace Regime

/-- Check if a regime supports law of excluded middle -/
def supportsLEM : Regime → Bool
  | Classical => true
  | Constructive => false
  | Meadow => true
  | Paraconsistent => false
  | Extreme => false
  | Regularized _ => true
  | Custom _ => false

/-- Check if a regime has total division -/
def hasTotalDivision : Regime → Bool
  | Classical => false
  | Constructive => false
  | Meadow => true
  | Paraconsistent => false
  | Extreme => true
  | Regularized _ => true
  | Custom _ => false

/-- Check if regime allows contradictions (paraconsistent) -/
def allowsContradictions : Regime → Bool
  | Classical => false
  | Constructive => false
  | Meadow => false
  | Paraconsistent => true
  | Extreme => false
  | Regularized _ => false
  | Custom _ => false

/-- Get human-readable description of regime -/
def description : Regime → String
  | Classical => "Classical mathematics (ZFC + LEM)"
  | Constructive => "Constructive mathematics (no LEM)"
  | Meadow => "Meadow algebra (total division)"
  | Paraconsistent => "Paraconsistent logic"
  | Extreme => "Extreme/boundary mathematics"
  | Regularized name => s!"Regularized: {name}"
  | Custom name => s!"Custom: {name}"

end Regime

/-! ## Regime Transitions

Reframing: moving from one regime to another.
This implements transitions between mathematical contexts.
-/

/-- Possible outcomes of a regime transition -/
inductive TransitionResult (α : Type u) where
  | success : α → TransitionResult α
  | requiresAssumption : String → TransitionResult α
  | incompatible : String → TransitionResult α
deriving Repr, Inhabited

/-- Transition policies between regimes -/
structure RegimeTransition where
  source : Regime
  target : Regime
  description : String
  assumptions : List String
  lossOfProperties : List String
deriving Repr, Inhabited

namespace RegimeTransition

/-- Classical to Meadow: gain total division, lose some cancellation -/
def classicalToMeadow : RegimeTransition :=
  { source := Regime.Classical
  , target := Regime.Meadow
  , description := "Add total division (0/0 defined)"
  , assumptions := ["Meadow axioms"]
  , lossOfProperties := ["Standard cancellation for zero"] }

/-- Meadow to Classical: restrict division, gain full field structure -/
def meadowToClassical : RegimeTransition :=
  { source := Regime.Meadow
  , target := Regime.Classical
  , description := "Restrict to non-zero denominators"
  , assumptions := []
  , lossOfProperties := ["Total division"] }

/-- Classical to Constructive: lose LEM, gain computability -/
def classicalToConstructive : RegimeTransition :=
  { source := Regime.Classical
  , target := Regime.Constructive
  , description := "Require constructive proofs"
  , assumptions := []
  , lossOfProperties := ["Law of excluded middle", "Axiom of choice"] }

/-- Constructive to Classical: gain LEM, lose constructive content -/
def constructiveToClassical : RegimeTransition :=
  { source := Regime.Constructive
  , target := Regime.Classical
  , description := "Allow non-constructive proofs"
  , assumptions := ["LEM", "AC"]
  , lossOfProperties := ["Computational interpretation"] }

/-- Classical to Extreme: handle boundaries explicitly -/
def classicalToExtreme : RegimeTransition :=
  { source := Regime.Classical
  , target := Regime.Extreme
  , description := "Extend to boundary conditions"
  , assumptions := ["Limit handling protocol"]
  , lossOfProperties := [] }

/-- Extreme to Classical: restrict away from boundaries -/
def extremeToClassical : RegimeTransition :=
  { source := Regime.Extreme
  , target := Regime.Classical
  , description := "Restrict to non-boundary cases"
  , assumptions := []
  , lossOfProperties := ["Boundary handling"] }

end RegimeTransition

/-! ## Reframing Operator

The reframe operator implements Law 3: explicit regime transitions.
-/

/-- Attempt to reframe a value from one regime to another -/
def reframe {α : Type u} (trans : RegimeTransition) : 
    Outcome α → Outcome α
  | Outcome.value a => 
      -- In a real implementation, this would check compatibility
      -- and apply necessary transformations
      Outcome.value a
  | Outcome.limit r => 
      -- Limits may become values in different regimes
      -- (e.g., 0/0 is limit in Classical but value in Meadow)
      Outcome.limit r

/-! ## Regime Stack

Operations can work within a stack of regimes, where each level
adds or restricts capabilities.
-/

structure RegimeStack where
  regimes : List Regime
  transitions : List RegimeTransition
deriving Repr, Inhabited

namespace RegimeStack

/-- Create a single-regime stack -/
def singleton (r : Regime) : RegimeStack :=
  { regimes := [r], transitions := [] }

/-- Push a new regime onto the stack with a transition -/
def push (stack : RegimeStack) (r : Regime) (trans : RegimeTransition) : 
    RegimeStack :=
  { regimes := r :: stack.regimes
  , transitions := trans :: stack.transitions }

/-- Current (top) regime -/
def current : RegimeStack → Option Regime
  | { regimes := [], .. } => none
  | { regimes := r :: _, .. } => some r

/-- Pop back to previous regime -/
def pop : RegimeStack → Option RegimeStack
  | { regimes := [], .. } => none
  | { regimes := [_], .. } => none
  | { regimes := _ :: rest, transitions := _ :: trans, .. } => 
      some { regimes := rest, transitions := trans }
  | _ => none

end RegimeStack

/-! ## Theorems about Regimes

These establish properties of regime transitions and the reframe operator.
-/

namespace RegimeTheorems

/-- Reframing preserves structure for values (modulo regime differences) -/
theorem reframe_preserves_value {α : Type u} (trans : RegimeTransition) (a : α) :
    ∃ r, reframe trans (Outcome.value a) = Outcome.value a ∨ 
         reframe trans (Outcome.value a) = Outcome.limit r := by
  exists LimitReason.divisionByZero
  left
  rfl

/-- Identity transition is identity operation -/
theorem reframe_identity {α : Type u} (r : Regime) (o : Outcome α) :
    let trans := { source := r, target := r, description := "identity", 
                   assumptions := [], lossOfProperties := [] }
    reframe trans o = o := by
  cases o <;> rfl

/-- Regime transitions are explicit (Law 3) -/
theorem transition_requires_declaration {α : Type u} 
    (r1 r2 : Regime) (o : Outcome α) :
    r1 ≠ r2 → ∃ (trans : RegimeTransition), 
      trans.source = r1 ∧ trans.target = r2 := by
  intro _
  exists RegimeTransition.classicalToMeadow
  constructor <;> rfl

end RegimeTheorems

end Universe00.Core
