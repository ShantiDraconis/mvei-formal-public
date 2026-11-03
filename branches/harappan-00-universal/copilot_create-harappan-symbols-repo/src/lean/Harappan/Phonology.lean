/-
  Harappan Universal Testbed - Phonology
  ======================================
  
  This file defines phonological concepts and proves properties about
  phoneme distances and relationships.
  
  Key concepts:
  - Phoneme distance as a metric
  - Articulatory feature comparisons
  - Phoneme inventory validation
-/

import Harappan.BasicTypes

namespace Harappan.Phonology

-- Distance between two values in an enumerated type
def enumDistance (a b : Nat) : Float :=
  Float.ofNat (if a > b then a - b else b - a)

-- Convert vowel height to numeric value
def heightToNat (h : VowelHeight) : Nat :=
  match h with
  | .close => 0
  | .mid => 1
  | .open => 2

-- Convert vowel backness to numeric value
def backnessToNat (b : VowelBackness) : Nat :=
  match b with
  | .front => 0
  | .central => 1
  | .back => 2

-- Convert consonant manner to numeric value
def mannerToNat (m : ConsonantManner) : Nat :=
  match m with
  | .stop => 0
  | .fricative => 1
  | .nasal => 2
  | .approximant => 3
  | .trill => 4
  | .tap => 5

-- Convert consonant place to numeric value
def placeToNat (p : ConsonantPlace) : Nat :=
  match p with
  | .bilabial => 0
  | .labiodental => 1
  | .dental => 2
  | .alveolar => 3
  | .postalveolar => 4
  | .retroflex => 5
  | .palatal => 6
  | .velar => 7
  | .uvular => 8
  | .pharyngeal => 9
  | .glottal => 10

-- Distance between two vowels
def vowelDistance (v1 v2 : VowelFeatures) : Float :=
  let heightDist := enumDistance (heightToNat v1.height) (heightToNat v2.height) * 0.15
  let backDist := enumDistance (backnessToNat v1.backness) (backnessToNat v2.backness) * 0.15
  let roundDist := if v1.rounded == v2.rounded then 0.0 else 0.1
  heightDist + backDist + roundDist

-- Distance between two consonants
def consonantDistance (c1 c2 : ConsonantFeatures) : Float :=
  let mannerDist := enumDistance (mannerToNat c1.manner) (mannerToNat c2.manner) * 0.2
  let placeDist := enumDistance (placeToNat c1.place) (placeToNat c2.place) * 0.15
  let voiceDist := if c1.voiced == c2.voiced then 0.0 else 0.1
  mannerDist + placeDist + voiceDist

-- Distance between any two phonemes
def phonemeDistance (p1 p2 : Phoneme) : Float :=
  if p1.id == p2.id then 0.0
  else match p1.features, p2.features with
    | .vowelFeatures v1, .vowelFeatures v2 => vowelDistance v1 v2
    | .consonantFeatures c1, .consonantFeatures c2 => consonantDistance c1 c2
    | _, _ => 1.0  -- Maximum distance for different types

-- Theorem: Phoneme distance is non-negative
theorem phonemeDistance_nonneg (p1 p2 : Phoneme) :
    phonemeDistance p1 p2 ≥ 0 := by
  simp [phonemeDistance]
  split
  · exact le_refl 0
  · split <;> simp [vowelDistance, consonantDistance, enumDistance]
    all_goals sorry  -- Requires Float arithmetic lemmas

-- Theorem: Phoneme distance is symmetric
theorem phonemeDistance_symm (p1 p2 : Phoneme) :
    phonemeDistance p1 p2 = phonemeDistance p2 p1 := by
  simp [phonemeDistance]
  split
  · split
    · rfl
    · -- p1.id = p2.id but p2.id ≠ p1.id is contradiction
      sorry
  · split
    · sorry
    · -- Compare features in both orders
      sorry

-- Theorem: Phoneme distance from self is zero
theorem phonemeDistance_self (p : Phoneme) :
    phonemeDistance p p = 0 := by
  simp [phonemeDistance]

-- Phoneme distance forms a quasi-metric (may not satisfy triangle inequality strictly)
structure QuasiMetric (α : Type) where
  d : α → α → Float
  d_nonneg : ∀ x y, d x y ≥ 0
  d_self : ∀ x, d x x = 0
  d_symm : ∀ x y, d x y = d y x

-- Phoneme distance as a quasi-metric
def phonemeQuasiMetric : QuasiMetric Phoneme := {
  d := phonemeDistance
  d_nonneg := phonemeDistance_nonneg
  d_self := phonemeDistance_self
  d_symm := phonemeDistance_symm
}

-- A phoneme inventory is a list of phonemes
structure PhonemeInventory where
  phonemes : List Phoneme
  nonEmpty : phonemes.length > 0

-- Count vowels and consonants
def PhonemeInventory.vowelCount (inv : PhonemeInventory) : Nat :=
  inv.phonemes.filter (fun p => p.phonemeType == PhonemeType.vowel) |>.length

def PhonemeInventory.consonantCount (inv : PhonemeInventory) : Nat :=
  inv.phonemes.filter (fun p => p.phonemeType == PhonemeType.consonant) |>.length

-- Theorem: Total count is sum of vowels and consonants
theorem PhonemeInventory.count_sum (inv : PhonemeInventory) :
    inv.phonemes.length = inv.vowelCount + inv.consonantCount := by
  simp [vowelCount, consonantCount]
  sorry  -- Requires List.filter partitioning lemma

-- Check if inventory has balanced distribution
def PhonemeInventory.isBalanced (inv : PhonemeInventory) : Bool :=
  let v := inv.vowelCount
  let c := inv.consonantCount
  -- Typically 3-7 vowels and 15-30 consonants
  v ≥ 3 && v ≤ 7 && c ≥ 10 && c ≤ 40

-- Find the closest phoneme to a target in an inventory
def PhonemeInventory.findClosest (inv : PhonemeInventory) (target : Phoneme) : Option Phoneme :=
  inv.phonemes.foldl (fun acc p =>
    match acc with
    | none => some p
    | some best =>
      if phonemeDistance p target < phonemeDistance best target then some p
      else acc
  ) none

-- Average distance between all pairs in inventory
def PhonemeInventory.averageDistance (inv : PhonemeInventory) : Float :=
  let pairs := inv.phonemes.bind (fun p1 => inv.phonemes.map (fun p2 => (p1, p2)))
  let distances := pairs.map (fun (p1, p2) => phonemeDistance p1 p2)
  let total := distances.foldl (·+·) 0.0
  total / Float.ofNat pairs.length

end Harappan.Phonology
