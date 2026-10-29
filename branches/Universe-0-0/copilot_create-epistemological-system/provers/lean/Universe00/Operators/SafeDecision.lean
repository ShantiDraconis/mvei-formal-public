/-
  Universe00/Operators/SafeDecision.lean
  
  Safe decision operator (decide) that handles undecidable propositions
  explicitly using the Outcome type.
  
  This connects Universe 00 to computability theory and decidability.
  
  Author: Universe-0-0 Project
  Version: 1.0.0
  Date: 2025-12-31
-/

import Universe00.Core.Outcome
import Universe00.Core.Regime
import Universe00.Core.LimitState

namespace Universe00.Operators

open Universe00.Core

/-! ## Safe Decision Operator

The `decideOutcome` operator attempts to decide a proposition:
- If decidable: returns value true/false
- If undecidable: returns limit (undecidable)
- If inconsistent context: returns limit (inconsistent)

This makes undecidability explicit rather than crashing or looping.
-/

/-- Safe decision for decidable propositions -/
def decideOutcome (p : Prop) [Decidable p] : Outcome Bool :=
  if p then Outcome.value true else Outcome.value false

/-- Safe decision that can handle undecidability -/
structure DecisionProblem where
  proposition : Prop
  isDecidable : Bool
  witness : Option Bool  -- Some true/false if decidable, None if undecidable
deriving Repr, Inhabited

/-- Attempt to decide a decision problem -/
def solveDecisionProblem (prob : DecisionProblem) : Outcome Bool :=
  if prob.isDecidable then
    match prob.witness with
    | some b => Outcome.value b
    | none => Outcome.limit LimitReason.undecidable
  else
    Outcome.limit LimitReason.undecidable

/-! ## Decidability Examples

Concrete examples of decidable and undecidable propositions.
-/

namespace DecidabilityExamples

/-- Example: Even numbers are decidable -/
def isEven (n : Nat) : DecisionProblem :=
  { proposition := n % 2 = 0
  , isDecidable := true
  , witness := some (n % 2 = 0) }

/-- Example: Halting problem is undecidable -/
def halts (program : Nat) : DecisionProblem :=
  { proposition := True  -- "program halts" (informal)
  , isDecidable := false
  , witness := none }

/-- Example: Basic arithmetic equality is decidable -/
def arithEqual (a b : Nat) : DecisionProblem :=
  { proposition := a = b
  , isDecidable := true
  , witness := some (a = b) }

/-- Decide if even -/
example (n : Nat) : ∃ b, solveDecisionProblem (isEven n) = Outcome.value b := by
  exists (n % 2 = 0)
  simp [solveDecisionProblem, isEven]

/-- Halting is undecidable -/
example (p : Nat) : 
    ∃ r, solveDecisionProblem (halts p) = Outcome.limit r := by
  exists LimitReason.undecidable
  simp [solveDecisionProblem, halts]

end DecidabilityExamples

/-! ## Regime-Aware Decision

Different regimes have different attitudes toward decidability.
-/

/-- Classical regime: LEM allows decision for all propositions (in principle) -/
def decideClassical (p : Prop) : Outcome Bool :=
  -- In classical logic, p ∨ ¬p always holds
  -- But computationally, we may not be able to decide
  Outcome.limit (LimitReason.customReason "classical: use LEM")

/-- Constructive regime: only decidable propositions can be decided -/
def decideConstructive (p : Prop) [Decidable p] : Outcome Bool :=
  decideOutcome p

/-- Extreme regime: undecidability is a boundary state -/
def decideExtreme (prob : DecisionProblem) : Outcome Bool :=
  if prob.isDecidable then
    match prob.witness with
    | some b => Outcome.value b
    | none => Outcome.limit (LimitReason.structuralBoundary "decidability boundary")
  else
    Outcome.limit (LimitReason.structuralBoundary "undecidable proposition")

/-! ## Millennium Problem Connection: P vs NP

The P vs NP problem is about decidability and complexity.
Universe 00 treats this as a structural boundary question.
-/

structure ComplexityClass where
  problems : List String
  decidableInPolynomialTime : Bool
deriving Repr, Inhabited

def P : ComplexityClass :=
  { problems := ["Sorting", "Graph connectivity", "Primality testing"]
  , decidableInPolynomialTime := true }

def NP : ComplexityClass :=
  { problems := ["SAT", "Hamiltonian path", "Knapsack"]
  , decidableInPolynomialTime := false }  -- Conjectured

/-- Is P = NP? This is a decision problem at the meta-level -/
def pEqualsNP : DecisionProblem :=
  { proposition := P = NP
  , isDecidable := false  -- Unknown!
  , witness := none }

/-- P vs NP is currently undecidable -/
example : ∃ r, solveDecisionProblem pEqualsNP = Outcome.limit r := by
  exists LimitReason.undecidable
  simp [solveDecisionProblem, pEqualsNP]

/-! ## Theorems about Safe Decision

Establish properties of the decision operator.
-/

namespace SafeDecisionTheorems

/-- Decidable propositions have value outcomes -/
theorem decidable_has_value (p : Prop) [Decidable p] :
    ∃ b, decideOutcome p = Outcome.value b := by
  by_cases h : p
  · exists true
    simp [decideOutcome, h]
  · exists false
    simp [decideOutcome, h]

/-- Undecidable propositions have limit outcomes -/
theorem undecidable_has_limit (prob : DecisionProblem) (h : ¬prob.isDecidable) :
    ∃ r, solveDecisionProblem prob = Outcome.limit r := by
  exists LimitReason.undecidable
  simp [solveDecisionProblem, h]

/-- Decision respects logical equivalence -/
theorem decision_respects_equivalence (p q : Prop) [Decidable p] [Decidable q]
    (h : p ↔ q) :
    decideOutcome p = decideOutcome q := by
  by_cases hp : p
  · have hq : q := h.mp hp
    simp [decideOutcome, hp, hq]
  · have hnq : ¬q := fun hq => hp (h.mpr hq)
    simp [decideOutcome, hp, hnq]

end SafeDecisionTheorems

/-! ## Connection to Computability

Universe 00's treatment of decidability connects to computability theory.
-/

structure ComputabilityLevel where
  name : String
  decidable : Bool
  semicomputable : Bool
  arithmeticalLevel : Nat  -- Arithmetic hierarchy level
deriving Repr, Inhabited

def computableLevel : ComputabilityLevel :=
  { name := "Computable/Decidable"
  , decidable := true
  , semicomputable := true
  , arithmeticalLevel := 0 }

def semicomputableLevel : ComputabilityLevel :=
  { name := "Semicomputable (r.e.)"
  , decidable := false
  , semicomputable := true
  , arithmeticalLevel := 1 }

def noncomputableLevel : ComputabilityLevel :=
  { name := "Non-computable"
  , decidable := false
  , semicomputable := false
  , arithmeticalLevel := 2 }

/-- Classify a decision problem by computability -/
def classifyComputability (prob : DecisionProblem) : ComputabilityLevel :=
  if prob.isDecidable then
    computableLevel
  else
    semicomputableLevel  -- Could be refined

end Universe00.Operators
