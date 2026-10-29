/-
  Self-Refutation Framework — Core Definitions
  Version: 1.0.0
  Date: 2025-12-31
  
  This module defines the core types and structures for the self-refutation
  framework of Universe-0-0.
-/

namespace SelfRefutation

/-- A problem in the mathematical or computational sense -/
structure Problem where
  name : String
  domain : String
  difficulty : ℕ
  deriving Repr

/-- Classification of problems by difficulty -/
inductive ProblemClass where
  | trivial : ProblemClass
  | routine : ProblemClass
  | difficult : ProblemClass
  | deep : ProblemClass
  | millennium : ProblemClass
  deriving Repr, DecidableEq

/-- Types of limits that can be invoked -/
inductive LimitType where
  | turingUndecidable : LimitType
  | analyticDivergence : LimitType
  | physicalSingularity : LimitType
  | ontologicalIndetermination : LimitType
  | computationalComplexity : LimitType
  deriving Repr, DecidableEq

/-- Formal criterion for a limit invocation -/
structure LimitCriterion where
  description : String
  formalDefinition : String
  reproducible : Bool
  hasCanonicalExample : Bool
  deriving Repr

/-- A response to a problem -/
inductive Response where
  | classicalSolution (proof : String) : Response
  | limitInvocation (limitType : LimitType) (criterion : LimitCriterion) : Response
  | partialProgress (details : String) : Response
  deriving Repr

/-- Regime in the mathematical sense (domain of operation) -/
structure Regime where
  name : String
  axioms : List String
  operations : List String
  deriving Repr

/-- Cost of switching regimes -/
inductive RegimeCost where
  | newAxiom (axiom : String) : RegimeCost
  | propertyLoss (property : String) : RegimeCost
  | localizedGain (gain : String) (loss : String) : RegimeCost
  deriving Repr

/-- A regime switch with its documentation -/
structure RegimeSwitch where
  source : Regime
  target : Regime
  operator : String
  cost : RegimeCost
  justification : String
  deriving Repr

/-- System claims about Universe-0-0 itself -/
inductive SystemClaim where
  | optional (description : String) : SystemClaim
  | mandatory (description : String) : SystemClaim
  | universal (description : String) : SystemClaim
  deriving Repr

/-- History of system responses -/
structure ResponseHistory where
  responses : List (Problem × Response)
  totalProblems : ℕ
  limitInvocations : ℕ
  deriving Repr

/-- Classification system for limits -/
structure LimitClassification where
  types : List LimitType
  criteriaMap : List (LimitType × LimitCriterion)
  deriving Repr

/-- Check if a problem is classified as difficult -/
def Problem.isDifficult (p : Problem) : Bool :=
  p.difficulty ≥ 7

/-- Check if a response is a limit invocation -/
def Response.isLimit (r : Response) : Bool :=
  match r with
  | Response.limitInvocation _ _ => true
  | _ => false

/-- Check if a response attempted classical methods first -/
def Response.attemptedClassical (r : Response) : Bool :=
  match r with
  | Response.classicalSolution _ => true
  | Response.partialProgress _ => true
  | Response.limitInvocation _ _ => false

/-- Extract limit type from response if it's a limit -/
def Response.getLimitType? (r : Response) : Option LimitType :=
  match r with
  | Response.limitInvocation lt _ => some lt
  | _ => none

/-- Check if limit criterion is complete -/
def LimitCriterion.isComplete (c : LimitCriterion) : Bool :=
  c.reproducible && c.hasCanonicalExample && c.description.length > 0

/-- Check if regime switch has explicit cost -/
def RegimeSwitch.hasExplicitCost (rs : RegimeSwitch) : Bool :=
  match rs.cost with
  | RegimeCost.newAxiom a => a.length > 0
  | RegimeCost.propertyLoss p => p.length > 0
  | RegimeCost.localizedGain g l => g.length > 0 && l.length > 0

/-- Check if system claim is universalizing -/
def SystemClaim.isUniversalizing (sc : SystemClaim) : Bool :=
  match sc with
  | SystemClaim.mandatory _ => true
  | SystemClaim.universal _ => true
  | SystemClaim.optional _ => false

/-- Calculate ratio of limit responses to total responses -/
def ResponseHistory.limitRatio (rh : ResponseHistory) : ℚ :=
  if rh.totalProblems = 0 then 0
  else (rh.limitInvocations : ℚ) / (rh.totalProblems : ℚ)

/-- Check if two limit types are structurally distinct -/
def LimitType.structurallyDistinct (lt1 lt2 : LimitType) : Bool :=
  lt1 ≠ lt2

/-- The five types of self-refutation violations -/
inductive ViolationType where
  | typeI    -- Triviality: Limit as final answer
  | typeII   -- Granularity: Limit without differentiation
  | typeIII  -- Ad-hoc: Regime as decoration
  | typeIV   -- Meta-totality: System becomes totalizing
  | typeV    -- Untestable: Limits without criteria
  deriving Repr, DecidableEq

/-- A self-refutation violation -/
structure Violation where
  violationType : ViolationType
  description : String
  evidence : String
  severity : ℕ
  deriving Repr

/-- System state for validation -/
structure SystemState where
  responseHistory : ResponseHistory
  limitClassification : LimitClassification
  regimeSwitches : List RegimeSwitch
  systemClaims : List SystemClaim
  violations : List Violation
  deriving Repr

/-- Check if system is in consistent state (no violations) -/
def SystemState.isConsistent (s : SystemState) : Bool :=
  s.violations.isEmpty

/-- Add a violation to system state -/
def SystemState.addViolation (s : SystemState) (v : Violation) : SystemState :=
  { s with violations := v :: s.violations }

/-- Core theorem: System consistency equivalence -/
theorem systemConsistentIffNoViolations (s : SystemState) :
    s.isConsistent ↔ s.violations.isEmpty := by
  unfold SystemState.isConsistent
  rfl

/-- Utility: Check if a criterion is verifiable -/
def isVerifiable (c : LimitCriterion) : Bool :=
  c.reproducible && c.formalDefinition.length > 0

/-- Utility: Count violations by type -/
def SystemState.countViolationType (s : SystemState) (vt : ViolationType) : ℕ :=
  s.violations.filter (fun v => v.violationType = vt) |>.length

/-- Utility: Get most severe violation -/
def SystemState.maxSeverity (s : SystemState) : ℕ :=
  s.violations.foldl (fun acc v => max acc v.severity) 0

/-- Empty system state for initialization -/
def SystemState.empty : SystemState :=
  { responseHistory := ⟨[], 0, 0⟩
  , limitClassification := ⟨[], []⟩
  , regimeSwitches := []
  , systemClaims := []
  , violations := []
  }

end SelfRefutation
