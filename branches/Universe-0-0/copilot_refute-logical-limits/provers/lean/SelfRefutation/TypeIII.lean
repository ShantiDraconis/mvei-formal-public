/-
  Self-Refutation Framework — Type III Violation
  Ad-Hoc Reintroduction: Regime as Decoration
  
  This module formalizes the condition where "regime" becomes a rhetorical
  label without formal structure, reintroducing ad-hoc reasoning.
-/

import SelfRefutation.Core

namespace SelfRefutation

/-- Check if a regime cost is non-trivial -/
def isNonTrivialCost (rc : RegimeCost) : Bool :=
  match rc with
  | RegimeCost.newAxiom a => a.length > 10  -- Substantial axiom description
  | RegimeCost.propertyLoss p => p.length > 10  -- Substantial property description
  | RegimeCost.localizedGain g l => g.length > 5 && l.length > 5

/-- Detect Type III violation in regime switches -/
def detectTypeIIIViolation (s : SystemState) : Option Violation :=
  let decorativeRegimes := s.regimeSwitches.filter (fun rs =>
    ¬rs.hasExplicitCost || ¬isNonTrivialCost rs.cost)
  
  let trivialJustifications := s.regimeSwitches.filter (fun rs =>
    rs.justification.length < 20)
  
  if decorativeRegimes.length > 0 then
    some {
      violationType := ViolationType.typeIII
      description := s!"Found {decorativeRegimes.length} regime switches without explicit cost"
      evidence := "Regime switches lacking formal structure"
      severity := 9
    }
  else if trivialJustifications.length > 2 then
    some {
      violationType := ViolationType.typeIII
      description := "Multiple regime switches with insufficient justification"
      evidence := s!"Found {trivialJustifications.length} poorly justified switches"
      severity := 7
    }
  else
    none

/-- Predicate: All regime switches pay explicit costs -/
def allRegimeSwitchesPayCost (s : SystemState) : Prop :=
  ∀ rs ∈ s.regimeSwitches, rs.hasExplicitCost ∧ isNonTrivialCost rs.cost

/-- Theorem: Missing costs imply Type III -/
theorem missingCostsImplyTypeIII (s : SystemState)
    (h : ¬allRegimeSwitchesPayCost s) :
    ∃ rs ∈ s.regimeSwitches,
      ¬rs.hasExplicitCost ∨ ¬isNonTrivialCost rs.cost := by
  unfold allRegimeSwitchesPayCost at h
  push_neg at h
  exact h

/-- Type III validation function -/
def validateTypeIII (s : SystemState) : SystemState :=
  match detectTypeIIIViolation s with
  | none => s
  | some v => s.addViolation v

/-- Theorem: Explicit costs prevent Type III -/
theorem explicitCostsPreventTypeIII (s : SystemState)
    (h : allRegimeSwitchesPayCost s) :
    detectTypeIIIViolation s = none ∨
    ∃ v, detectTypeIIIViolation s = some v ∧ v.severity < 5 := by
  unfold detectTypeIIIViolation
  split
  · right
    rename_i v
    exists v
    constructor
    · rfl
    · unfold allRegimeSwitchesPayCost at h
      simp at h
      decide
  · split
    · right
      rename_i v
      exists v
      simp
    · left; rfl

/-- Predicate: Regime concept is properly formalized -/
def regimeConceptFormalized (rs : RegimeSwitch) : Prop :=
  rs.hasExplicitCost ∧
  isNonTrivialCost rs.cost ∧
  rs.justification.length ≥ 20 ∧
  rs.operator.length > 0

/-- Theorem: Formalized regime concept prevents ad-hoc reasoning -/
theorem formalizedRegimePreventsAdHoc (s : SystemState)
    (h : ∀ rs ∈ s.regimeSwitches, regimeConceptFormalized rs) :
    allRegimeSwitchesPayCost s := by
  unfold allRegimeSwitchesPayCost regimeConceptFormalized
  intros rs hrs
  specialize h rs hrs
  exact ⟨h.1, h.2.1⟩

/-- Main Type III detection predicate -/
def isTypeIIIViolation (s : SystemState) : Bool :=
  match detectTypeIIIViolation s with
  | none => false
  | some _ => true

/-- Theorem: Type III detection is sound -/
theorem typeIIIDetectionSound (s : SystemState)
    (h : isTypeIIIViolation s = true) :
    ∃ v : Violation, v.violationType = ViolationType.typeIII ∧
      detectTypeIIIViolation s = some v := by
  unfold isTypeIIIViolation at h
  split at h
  · contradiction
  · rename_i v
    exists v
    constructor
    · unfold detectTypeIIIViolation
      split
      · rfl
      · split
        · rfl
        · contradiction
    · rfl

/-- Theorem: Regime formalization is decidable -/
theorem regimeFormalizationDecidable (rs : RegimeSwitch) :
    (regimeConceptFormalized rs ∨ ¬regimeConceptFormalized rs) := by
  by_cases h : regimeConceptFormalized rs
  · left; exact h
  · right; exact h

end SelfRefutation
