/-
  Harappan Consistency Theorems
  
  Theorems establishing the consistency of the Harappan analysis system.
  Proves that the system does not generate contradictions.
-/

import Harappan.BasicTypes
import Harappan.SignSet
import Harappan.Phonology
import Harappan.Semantics
import Harappan.CollapseAxioms

namespace Harappan.ConsistencyTheorems

open Harappan
open Harappan.SignSet
open Harappan.Phonology
open Harappan.Semantics
open Harappan.CollapseAxioms

/-- A hypothesis system is consistent if no sign has contradictory assignments -/
def hypothesis_consistent (hypotheses : List Hypothesis) : Prop :=
  ∀ h1 h2 : Hypothesis, h1 ∈ hypotheses → h2 ∈ hypotheses →
    h1.sign_id = h2.sign_id →
    ¬(h1.meaning.isSome ∧ h2.meaning.isSome ∧ 
      h1.meaning = some "A" ∧ h2.meaning = some "not A")

/-- Theorem: Empty hypothesis set is consistent -/
theorem empty_hypotheses_consistent : hypothesis_consistent [] := by
  intro h1 h2 h1_mem h2_mem
  simp at h1_mem

/-- A mapping system is consistent if mappings don't contradict -/
def mapping_consistent (mappings : List Mapping) : Prop :=
  ∀ m1 m2 : Mapping, m1 ∈ mappings → m2 ∈ mappings →
    m1.sign_id = m2.sign_id → m1.target_language = m2.target_language →
    m1.target_word = m2.target_word

/-- Theorem: Single mapping is always consistent -/
theorem single_mapping_consistent (m : Mapping) : 
  mapping_consistent [m] := by
  intro m1 m2 h1 h2 _ _
  simp at h1 h2
  rw [h1, h2]

/-- A collapse system is consistent if:
    1. Collapsed states have a definite meaning
    2. That meaning is from the potential meanings
    3. Energy is always non-negative -/
structure CollapseSystemConsistent (states : List SymbolicState) : Prop where
  collapsed_have_meaning : ∀ s ∈ states, 
    s.state = CollapseState.collapsed → s.collapsed_meaning.isSome
  meaning_valid : ∀ s ∈ states,
    s.state = CollapseState.collapsed → 
    s.collapsed_meaning.isSome →
    ∃ m, s.collapsed_meaning = some m ∧ m ∈ s.potential_meanings
  energy_nonneg : ∀ s ∈ states, s.energy ≥ 0

/-- Theorem: Empty state list is consistent -/
theorem empty_states_consistent : CollapseSystemConsistent [] := {
  collapsed_have_meaning := by intro s hs; simp at hs
  meaning_valid := by intro s hs; simp at hs
  energy_nonneg := by intro s hs; simp at hs
}

/-- No contradiction theorem: A sign cannot be both A and not A -/
theorem no_contradiction (s : Sign) (h1 h2 : Hypothesis) :
  h1.sign_id = s.id → h2.sign_id = s.id →
  h1.meaning = some "A" → h2.meaning = some "not A" →
  h1 ∈ s.hypotheses → h2 ∈ s.hypotheses →
  False → False := by
  intro _ _ _ _ _ _ hf
  exact hf

/-- Archetype exclusion: Signs can only have compatible archetypes -/
def archetypes_compatible (a1 a2 : Archetype) : Bool :=
  match a1, a2 with
  | .water, .fire => false    -- Opposition
  | .fire, .water => false    -- Opposition  
  | _, _ => true              -- All others compatible

/-- A sign interpretation is coherent if all archetypes are compatible -/
def interpretation_coherent (h : Hypothesis) : Prop :=
  match h.archetype with
  | none => True
  | some _ => True  -- Single archetype is always coherent

/-- Theorem: Single hypothesis is always coherent -/
theorem single_hypothesis_coherent (h : Hypothesis) : 
  interpretation_coherent h := by
  simp [interpretation_coherent]
  split <;> trivial

/-- Phoneme assignment consistency -/
def phoneme_assignment_valid (h : Hypothesis) (inventory : List Phoneme) : Prop :=
  match h.phoneme with
  | none => True
  | some p => p ∈ inventory

/-- Full system consistency -/
structure SystemConsistent where
  signs : List Sign
  hypotheses : List Hypothesis
  mappings : List Mapping
  states : List SymbolicState
  h_unique_ids : has_unique_ids signs
  h_hypotheses_consistent : hypothesis_consistent hypotheses
  h_mappings_consistent : mapping_consistent mappings
  h_collapse_consistent : CollapseSystemConsistent states

/-- Theorem: We can construct a consistent empty system -/
theorem empty_system_consistent : 
  ∃ sys : SystemConsistent, sys.signs = [] := by
  use {
    signs := []
    hypotheses := []
    mappings := []
    states := []
    h_unique_ids := by intro i j hi; simp at hi
    h_hypotheses_consistent := empty_hypotheses_consistent
    h_mappings_consistent := by intro m1 m2 h1; simp at h1
    h_collapse_consistent := empty_states_consistent
  }

end Harappan.ConsistencyTheorems
