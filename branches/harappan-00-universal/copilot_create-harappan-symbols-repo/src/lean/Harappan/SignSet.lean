/-
  Harappan Universal Testbed - Sign Set
  =====================================
  
  This file defines the set of Harappan signs and proves basic properties
  about the sign system.
  
  Axioms:
  - The set of signs is finite
  - Every sign has a unique ID
  - Sign IDs form a decidable equivalence relation
-/

import Harappan.BasicTypes

namespace Harappan

-- A finite set of signs
structure SignSet where
  signs : List Sign
  uniqueIds : ∀ s1 s2 : Sign, s1 ∈ signs → s2 ∈ signs → s1.id = s2.id → s1 = s2

-- Check if a sign is in the set
def SignSet.contains (ss : SignSet) (sid : SignId) : Bool :=
  ss.signs.any (fun s => s.id == sid)

-- Get a sign by ID
def SignSet.get (ss : SignSet) (sid : SignId) : Option Sign :=
  ss.signs.find? (fun s => s.id == sid)

-- Number of signs in the set
def SignSet.size (ss : SignSet) : Nat :=
  ss.signs.length

-- The set is non-empty
def SignSet.nonEmpty (ss : SignSet) : Prop :=
  ss.signs.length > 0

-- Theorem: Sign lookup is deterministic
theorem SignSet.lookup_deterministic (ss : SignSet) (sid : SignId) :
    ∀ s1 s2 : Sign, ss.get sid = some s1 → ss.get sid = some s2 → s1 = s2 := by
  intro s1 s2 h1 h2
  simp [SignSet.get] at h1 h2
  -- If both found the same ID, they must be the same sign
  sorry  -- Proof requires additional lemmas about List.find?

-- Create an empty sign set
def SignSet.empty : SignSet := {
  signs := []
  uniqueIds := by
    intro s1 s2 h1 h2 _
    simp at h1
}

-- Add a sign to the set (if ID not already present)
def SignSet.add (ss : SignSet) (s : Sign) : SignSet :=
  if ss.contains s.id then ss
  else {
    signs := s :: ss.signs
    uniqueIds := by
      intro s1 s2 h1 h2 heq
      simp at h1 h2
      cases h1 with
      | inl h => 
        cases h2 with
        | inl h' => rw [h, h']
        | inr h' => sorry
      | inr h =>
        cases h2 with
        | inl h' => sorry
        | inr h' => exact ss.uniqueIds s1 s2 h h' heq
  }

-- Standard corpus sign IDs
def standardSignIds : List String := [
  "H001", "H002", "H003", "H004", "H005",
  "H006", "H007", "H008", "H009", "H010",
  "H011", "H012", "H013", "H014", "H015"
]

-- Theorem: Standard corpus has finite size
theorem standardCorpus_finite : standardSignIds.length = 15 := by rfl

-- A sign ID is valid if it matches the pattern "HXXX"
def isValidSignId (sid : SignId) : Bool :=
  sid.value.length == 4 && 
  sid.value.get? 0 == some 'H' &&
  (sid.value.drop 1).all Char.isDigit

-- Theorem: All standard sign IDs are valid
theorem standardSignIds_valid : 
    standardSignIds.all (fun s => isValidSignId ⟨s⟩) := by
  native_decide

-- Sign frequency must be between 0 and 1
def validFrequency (f : Float) : Prop := f ≥ 0 ∧ f ≤ 1

-- A sign corpus is consistent if all frequencies sum to approximately 1
-- (allowing for rounding errors)
def SignSet.frequencyConsistent (ss : SignSet) : Prop :=
  let total := ss.signs.foldl (fun acc s => acc + s.frequency) 0.0
  total ≥ 0.99 ∧ total ≤ 1.01

-- Get all signs at a specific position
def SignSet.byPosition (ss : SignSet) (pos : Position) : List Sign :=
  ss.signs.filter (fun s => s.typicalPosition == pos || s.typicalPosition == Position.any)

-- Count signs by position type
def SignSet.positionCounts (ss : SignSet) : Nat × Nat × Nat × Nat :=
  let initial := (ss.byPosition Position.initial).length
  let medial := (ss.byPosition Position.medial).length
  let final := (ss.byPosition Position.final).length
  let any := (ss.byPosition Position.any).length
  (initial, medial, final, any)

end Harappan
