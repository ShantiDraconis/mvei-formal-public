/-
  Harappan Universal Testbed - Phonotactics
  =========================================
  
  This file defines phonotactic rules for Harappan sign sequences.
  
  Phonotactics govern which sign sequences are valid/invalid based on:
  - Position constraints
  - Co-occurrence restrictions
  - Sequence patterns
-/

import Harappan.BasicTypes
import Harappan.SignSet

namespace Harappan.Phonotactics

-- A sequence of signs (inscription)
abbrev SignSequence := List SignId

-- Phonotactic constraint types
inductive ConstraintType
  | positionRestriction : Position → ConstraintType  -- Sign must appear in specific position
  | adjacencyProhibited : SignId → SignId → ConstraintType  -- Two signs cannot be adjacent
  | adjacencyRequired : SignId → SignId → ConstraintType  -- Two signs must be adjacent when both present
  | lengthConstraint : Nat → Nat → ConstraintType  -- Min and max sequence length
  deriving Repr

-- A phonotactic rule
structure PhonConstraint where
  name : String
  constraintType : ConstraintType
  active : Bool := true

-- Position of a sign in a sequence
def positionInSequence (seq : SignSequence) (idx : Nat) : Position :=
  if idx == 0 then Position.initial
  else if idx == seq.length - 1 then Position.final
  else Position.medial

-- Check if a sign can appear at a position
def validPosition (sign : Sign) (pos : Position) : Bool :=
  sign.typicalPosition == pos || sign.typicalPosition == Position.any

-- Check position constraint
def checkPositionConstraint (seq : SignSequence) (signSet : SignSet) (sid : SignId) (requiredPos : Position) : Bool :=
  match seq.findIdx? (· == sid) with
  | none => true  -- Sign not present, constraint satisfied
  | some idx =>
    let actualPos := positionInSequence seq idx
    actualPos == requiredPos || requiredPos == Position.any

-- Check adjacency prohibition
def checkAdjacencyProhibited (seq : SignSequence) (s1 s2 : SignId) : Bool :=
  let pairs := seq.zip (seq.drop 1)
  !pairs.any (fun (a, b) => (a == s1 && b == s2) || (a == s2 && b == s1))

-- Check if sequence has required adjacency (when both signs present)
def checkAdjacencyRequired (seq : SignSequence) (s1 s2 : SignId) : Bool :=
  let hasS1 := seq.any (· == s1)
  let hasS2 := seq.any (· == s2)
  if hasS1 && hasS2 then
    let pairs := seq.zip (seq.drop 1)
    pairs.any (fun (a, b) => (a == s1 && b == s2) || (a == s2 && b == s1))
  else true

-- Check length constraint
def checkLengthConstraint (seq : SignSequence) (minLen maxLen : Nat) : Bool :=
  seq.length ≥ minLen && seq.length ≤ maxLen

-- Check a single constraint
def checkConstraint (seq : SignSequence) (signSet : SignSet) (constraint : PhonConstraint) : Bool :=
  if !constraint.active then true
  else match constraint.constraintType with
    | .positionRestriction pos => true  -- Would need sign ID
    | .adjacencyProhibited s1 s2 => checkAdjacencyProhibited seq s1 s2
    | .adjacencyRequired s1 s2 => checkAdjacencyRequired seq s1 s2
    | .lengthConstraint minLen maxLen => checkLengthConstraint seq minLen maxLen

-- A set of phonotactic rules
structure Phonotactics where
  rules : List PhonConstraint

-- Check all constraints
def Phonotactics.validate (pt : Phonotactics) (seq : SignSequence) (signSet : SignSet) : Bool :=
  pt.rules.all (checkConstraint seq signSet)

-- Get violated constraints
def Phonotactics.violations (pt : Phonotactics) (seq : SignSequence) (signSet : SignSet) : List PhonConstraint :=
  pt.rules.filter (fun c => !checkConstraint seq signSet c)

-- Standard Harappan phonotactic rules (hypothetical)
def standardPhonotactics : Phonotactics := {
  rules := [
    -- Length constraint: inscriptions are typically 4-26 signs
    { name := "length_constraint"
      constraintType := .lengthConstraint 1 26 },
    -- Example: certain signs cannot be adjacent
    { name := "no_double_determinatives"
      constraintType := .adjacencyProhibited ⟨"H001"⟩ ⟨"H001"⟩ }
  ]
}

-- A sequence is well-formed if it satisfies all phonotactic rules
def isWellFormed (seq : SignSequence) (signSet : SignSet) (pt : Phonotactics) : Prop :=
  pt.validate seq signSet = true

-- Theorem: Empty sequence violates length constraint
theorem empty_violates_standard :
    standardPhonotactics.validate [] SignSet.empty = true := by
  simp [Phonotactics.validate, standardPhonotactics]
  sorry

-- Theorem: Single sign sequence is well-formed
theorem singleton_wellformed (s : SignId) :
    checkLengthConstraint [s] 1 26 = true := by
  simp [checkLengthConstraint]

-- Count violations for a corpus
def countViolations (seqs : List SignSequence) (signSet : SignSet) (pt : Phonotactics) : Nat :=
  seqs.filter (fun seq => !pt.validate seq signSet) |>.length

-- A corpus is phonotactically valid if all sequences are well-formed
def isValidCorpus (seqs : List SignSequence) (signSet : SignSet) (pt : Phonotactics) : Prop :=
  countViolations seqs signSet pt = 0

-- Phonotactic complexity: number of active rules
def Phonotactics.complexity (pt : Phonotactics) : Nat :=
  pt.rules.filter (·.active) |>.length

-- Generate all valid bigrams
def validBigrams (signSet : SignSet) (pt : Phonotactics) : List (SignId × SignId) :=
  let sids := signSet.signs.map (·.id)
  let allPairs := sids.bind (fun s1 => sids.map (fun s2 => (s1, s2)))
  allPairs.filter (fun (s1, s2) => checkAdjacencyProhibited [s1, s2] s1 s2)

end Harappan.Phonotactics
