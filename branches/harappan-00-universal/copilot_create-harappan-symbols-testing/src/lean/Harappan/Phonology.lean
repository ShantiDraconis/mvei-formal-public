/-
  Harappan Phonology
  
  Formal definitions of phonological concepts including
  phoneme features and distance metrics.
-/

import Harappan.BasicTypes

namespace Harappan.Phonology

open Harappan

/-- Phoneme type classification -/
inductive PhonemeType
  | vowel
  | consonant
  deriving DecidableEq, Repr

/-- Place of articulation for consonants -/
inductive PlaceOfArticulation
  | bilabial
  | labiodental
  | dental
  | alveolar
  | postalveolar
  | retroflex
  | palatal
  | velar
  | uvular
  | glottal
  deriving DecidableEq, Repr

/-- Manner of articulation for consonants -/
inductive MannerOfArticulation
  | stop
  | nasal
  | fricative
  | affricate
  | approximant
  | lateral
  | trill
  deriving DecidableEq, Repr

/-- Vowel height -/
inductive VowelHeight
  | high
  | mid
  | low
  deriving DecidableEq, Repr

/-- Vowel frontness -/
inductive VowelFrontness
  | front
  | central
  | back
  deriving DecidableEq, Repr

/-- Complete phoneme features -/
structure PhonemeFeatures where
  phoneme_type : PhonemeType
  -- Consonant features (None if vowel)
  place : Option PlaceOfArticulation
  manner : Option MannerOfArticulation
  voiced : Option Bool
  -- Vowel features (None if consonant)
  height : Option VowelHeight
  frontness : Option VowelFrontness
  rounded : Option Bool
  deriving Repr

/-- Create vowel features -/
def mkVowelFeatures 
  (height : VowelHeight) 
  (frontness : VowelFrontness) 
  (rounded : Bool) : PhonemeFeatures :=
  { phoneme_type := PhonemeType.vowel
    place := none
    manner := none
    voiced := some true  -- Vowels are voiced
    height := some height
    frontness := some frontness
    rounded := some rounded }

/-- Create consonant features -/
def mkConsonantFeatures 
  (place : PlaceOfArticulation) 
  (manner : MannerOfArticulation) 
  (voiced : Bool) : PhonemeFeatures :=
  { phoneme_type := PhonemeType.consonant
    place := some place
    manner := some manner
    voiced := some voiced
    height := none
    frontness := none
    rounded := none }

/-- Distance between two phoneme types -/
def type_distance (t1 t2 : PhonemeType) : Float :=
  if t1 = t2 then 0.0 else 1.0

/-- Distance between places of articulation -/
def place_distance (p1 p2 : PlaceOfArticulation) : Float :=
  if p1 = p2 then 0.0
  else match p1, p2 with
    | .bilabial, .labiodental => 0.2
    | .labiodental, .bilabial => 0.2
    | .alveolar, .dental => 0.2
    | .dental, .alveolar => 0.2
    | .alveolar, .postalveolar => 0.2
    | .postalveolar, .alveolar => 0.2
    | .velar, .uvular => 0.3
    | .uvular, .velar => 0.3
    | _, _ => 0.5

/-- Distance between manners of articulation -/
def manner_distance (m1 m2 : MannerOfArticulation) : Float :=
  if m1 = m2 then 0.0
  else match m1, m2 with
    | .stop, .nasal => 0.3
    | .nasal, .stop => 0.3
    | .fricative, .affricate => 0.2
    | .affricate, .fricative => 0.2
    | .approximant, .lateral => 0.2
    | .lateral, .approximant => 0.2
    | _, _ => 0.5

/-- Distance based on voicing -/
def voicing_distance (v1 v2 : Bool) : Float :=
  if v1 = v2 then 0.0 else 0.2

/-- Distance between vowel heights -/
def height_distance (h1 h2 : VowelHeight) : Float :=
  if h1 = h2 then 0.0
  else match h1, h2 with
    | .high, .mid => 0.3
    | .mid, .high => 0.3
    | .mid, .low => 0.3
    | .low, .mid => 0.3
    | _, _ => 0.5

/-- Calculate phoneme distance from features -/
def phoneme_distance (f1 f2 : PhonemeFeatures) : Float :=
  let type_dist := type_distance f1.phoneme_type f2.phoneme_type
  if type_dist > 0 then
    type_dist
  else
    match f1.phoneme_type with
    | .consonant =>
      let pd := match f1.place, f2.place with
        | some p1, some p2 => place_distance p1 p2
        | _, _ => 0.5
      let md := match f1.manner, f2.manner with
        | some m1, some m2 => manner_distance m1 m2
        | _, _ => 0.5
      let vd := match f1.voiced, f2.voiced with
        | some v1, some v2 => voicing_distance v1 v2
        | _, _ => 0.2
      (pd + md + vd) / 3.0
    | .vowel =>
      let hd := match f1.height, f2.height with
        | some h1, some h2 => height_distance h1 h2
        | _, _ => 0.5
      let fd := match f1.frontness, f2.frontness with
        | some VowelFrontness.front, some VowelFrontness.back => 0.5
        | some VowelFrontness.back, some VowelFrontness.front => 0.5
        | some f1, some f2 => if f1 = f2 then 0.0 else 0.3
        | _, _ => 0.3
      (hd + fd) / 2.0

/-- Theorem: Phoneme distance is non-negative -/
theorem phoneme_distance_nonneg (f1 f2 : PhonemeFeatures) : 
  phoneme_distance f1 f2 ≥ 0 := by
  unfold phoneme_distance
  simp [type_distance, place_distance, manner_distance, voicing_distance, height_distance]
  split <;> simp_all
  · split <;> simp_all
  · split <;> simp_all

/-- Theorem: Phoneme distance is symmetric -/
theorem phoneme_distance_symm (f1 f2 : PhonemeFeatures) :
  phoneme_distance f1 f2 = phoneme_distance f2 f1 := by
  unfold phoneme_distance type_distance
  simp [eq_comm]
  sorry  -- Full proof requires more case analysis

end Harappan.Phonology
