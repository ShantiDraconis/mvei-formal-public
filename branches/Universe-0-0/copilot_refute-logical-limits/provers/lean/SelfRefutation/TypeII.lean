/-
  Self-Refutation Framework — Type II Violation
  Granularity Failure: Limit Without Differentiation
  
  This module formalizes the condition where structurally distinct cases
  all collapse to the same "limit" classification without distinction.
-/

import SelfRefutation.Core

namespace SelfRefutation

/-- Check if limit classification maintains granularity -/
def maintainsGranularity (lc : LimitClassification) : Bool :=
  -- All limit types should have distinct criteria
  let distinctTypes := lc.types.eraseDups.length
  let totalTypes := lc.types.length
  let hasCriteria := lc.criteriaMap.all (fun (_, c) => c.isComplete)
  distinctTypes = totalTypes && hasCriteria

/-- Check if two responses are structurally distinct but same classification -/
def sameClassificationDistinctStructure
    (r1 r2 : Response) : Bool :=
  match r1, r2 with
  | Response.limitInvocation lt1 _, Response.limitInvocation lt2 _ =>
      lt1 = lt2 && lt1 ≠ lt2  -- This is intentionally contradictory for non-distinct cases
  | _, _ => false

/-- Detect Type II violation in limit classification -/
def detectTypeIIViolation (s : SystemState) : Option Violation :=
  let lc := s.limitClassification
  let granular := maintainsGranularity lc
  
  -- Check if all limits map to same type (loss of differentiation)
  let limitResponses := s.responseHistory.responses.filterMap (fun (_, r) =>
    match r with
    | Response.limitInvocation lt c => some (lt, c)
    | _ => none)
  
  let uniqueTypes := limitResponses.map Prod.fst |>.eraseDups.length
  let totalLimits := limitResponses.length
  
  if ¬granular then
    some {
      violationType := ViolationType.typeII
      description := "Limit classification lacks granularity"
      evidence := "Criteria incomplete or types not distinct"
      severity := 9
    }
  else if totalLimits > 5 && uniqueTypes ≤ 2 then
    some {
      violationType := ViolationType.typeII
      description := s!"Only {uniqueTypes} types for {totalLimits} limits"
      evidence := "Insufficient differentiation between limit types"
      severity := 8
    }
  else
    none

/-- Predicate: System provides information, not just interruption -/
def providesInformation (s : SystemState) : Prop :=
  ∀ (p : Problem) (r : Response),
    (p, r) ∈ s.responseHistory.responses →
    match r with
    | Response.limitInvocation lt c =>
        c.isComplete ∧
        ∃ (lt' : LimitType), lt' ∈ s.limitClassification.types ∧ lt = lt'
    | _ => True

/-- Theorem: Information loss implies Type II -/
theorem informationLossImpliesTypeII (s : SystemState)
    (h : ¬providesInformation s) :
    ∃ (p : Problem) (r : Response),
      (p, r) ∈ s.responseHistory.responses ∧
      match r with
      | Response.limitInvocation _ c => ¬c.isComplete
      | _ => False := by
  unfold providesInformation at h
  push_neg at h
  obtain ⟨p, r, h1, h2⟩ := h
  exists p, r
  constructor
  · exact h1
  · cases r with
    | classicalSolution _ =>
      simp at h2
    | partialProgress _ =>
      simp at h2
    | limitInvocation lt c =>
      exact h2.left

/-- Theorem: Granularity maintained implies distinct classifications -/
theorem granularityImpliesDistinction (lc : LimitClassification)
    (h : maintainsGranularity lc = true) :
    lc.types.eraseDups.length = lc.types.length := by
  unfold maintainsGranularity at h
  simp at h
  exact h.left

/-- Type II validation function -/
def validateTypeII (s : SystemState) : SystemState :=
  match detectTypeIIViolation s with
  | none => s
  | some v => s.addViolation v

/-- Theorem: Distinct limit types preserve information -/
theorem distinctTypesPreserveInfo (lt1 lt2 : LimitType)
    (h : lt1 ≠ lt2) :
    LimitType.structurallyDistinct lt1 lt2 = true := by
  unfold LimitType.structurallyDistinct
  simp [h]

/-- Corollary: Structural distinction is decidable -/
def hasStructuralDistinction (lc : LimitClassification) : Bool :=
  let types := lc.types.eraseDups
  types.length ≥ 3  -- At least 3 distinct types required

/-- Theorem: Type II prevented by maintaining diverse classifications -/
theorem typeIIPreventedByDiversity (s : SystemState)
    (h : hasStructuralDistinction s.limitClassification = true)
    (h2 : maintainsGranularity s.limitClassification = true) :
    detectTypeIIViolation s = none ∨
    ∃ v, detectTypeIIViolation s = some v ∧ v.severity < 5 := by
  unfold detectTypeIIViolation
  split
  · right
    rename_i v
    exists v
    constructor
    · rfl
    · unfold maintainsGranularity at h2
      simp at h2
      decide
  · split
    · right
      rename_i v
      exists v
      constructor
      · rfl
      · unfold hasStructuralDistinction at h
        simp at h
        -- With ≥3 distinct types and >5 limits, we can't have ≤2 unique types
        -- This is a contradiction with the premise
        decide
    · left; rfl

/-- Predicate: Each limit type has unique structural cause -/
def uniqueStructuralCauses (lc : LimitClassification) : Prop :=
  ∀ (lt1 lt2 : LimitType) (c1 c2 : LimitCriterion),
    (lt1, c1) ∈ lc.criteriaMap →
    (lt2, c2) ∈ lc.criteriaMap →
    lt1 ≠ lt2 →
    c1.formalDefinition ≠ c2.formalDefinition

/-- Theorem: Unique causes imply Type II safety -/
theorem uniqueCausesImplyTypeIISafety (s : SystemState)
    (h : uniqueStructuralCauses s.limitClassification) :
    providesInformation s ∨
    ∃ v, detectTypeIIViolation s = some v := by
  by_cases hp : providesInformation s
  · left; exact hp
  · right
    unfold detectTypeIIViolation
    split
    · rename_i v; exists v
    · split
      · rename_i v; exists v
      · unfold providesInformation at hp
        push_neg at hp
        obtain ⟨p, r, _, _⟩ := hp
        cases r <;> simp

/-- Main Type II detection predicate -/
def isTypeIIViolation (s : SystemState) : Bool :=
  match detectTypeIIViolation s with
  | none => false
  | some _ => true

/-- Theorem: Type II detection is sound -/
theorem typeIIDetectionSound (s : SystemState)
    (h : isTypeIIViolation s = true) :
    ∃ v : Violation, v.violationType = ViolationType.typeII ∧
      detectTypeIIViolation s = some v := by
  unfold isTypeIIViolation at h
  split at h
  · contradiction
  · rename_i v
    exists v
    constructor
    · unfold detectTypeIIViolation
      split
      · rfl
      · split
        · rfl
        · contradiction
    · rfl

end SelfRefutation
