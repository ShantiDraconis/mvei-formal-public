/-
  Harappan Phonotactics
  
  Formal rules for valid phoneme sequences in Harappan.
  Defines constraints on what sequences are phonologically valid.
-/

import Harappan.BasicTypes
import Harappan.Phonology

namespace Harappan.Phonotactics

open Harappan
open Harappan.Phonology

/-- Syllable structure -/
inductive SyllableStructure
  | V      -- Vowel only
  | CV     -- Consonant-Vowel
  | CVC    -- Consonant-Vowel-Consonant
  | VC     -- Vowel-Consonant
  | CCV    -- Two consonants + vowel
  deriving DecidableEq, Repr

/-- Check if a phoneme is a vowel -/
def is_vowel (f : PhonemeFeatures) : Bool :=
  f.phoneme_type = PhonemeType.vowel

/-- Check if a phoneme is a consonant -/
def is_consonant (f : PhonemeFeatures) : Bool :=
  f.phoneme_type = PhonemeType.consonant

/-- Sonority scale value for a phoneme -/
def sonority (f : PhonemeFeatures) : Nat :=
  match f.phoneme_type with
  | .vowel => 
    match f.height with
    | some .low => 10
    | some .mid => 9
    | some .high => 8
    | none => 8
  | .consonant =>
    match f.manner with
    | some .approximant => 7
    | some .lateral => 6
    | some .trill => 5
    | some .nasal => 4
    | some .fricative => 3
    | some .affricate => 2
    | some .stop => 1
    | none => 1

/-- Check if sonority rises in an onset cluster -/
def valid_onset_sonority (phonemes : List PhonemeFeatures) : Bool :=
  match phonemes with
  | [] => true
  | [_] => true
  | p1 :: p2 :: rest => 
    if sonority p1 < sonority p2 then
      valid_onset_sonority (p2 :: rest)
    else
      false

/-- Check if sonority falls in a coda cluster -/
def valid_coda_sonority (phonemes : List PhonemeFeatures) : Bool :=
  match phonemes with
  | [] => true
  | [_] => true
  | p1 :: p2 :: rest =>
    if sonority p1 > sonority p2 then
      valid_coda_sonority (p2 :: rest)
    else
      false

/-- Maximum consonant cluster size allowed -/
def max_cluster_size : Nat := 3

/-- Check if a consonant cluster is valid -/
def valid_cluster (phonemes : List PhonemeFeatures) : Bool :=
  phonemes.length ≤ max_cluster_size ∧ 
  phonemes.all is_consonant

/-- Phonotactic rule result -/
inductive RuleResult
  | valid
  | invalid (reason : String)
  deriving Repr

/-- Check vowel hiatus constraint -/
def check_hiatus (p1 p2 : PhonemeFeatures) : RuleResult :=
  if is_vowel p1 && is_vowel p2 then
    .invalid "Vowel hiatus detected"
  else
    .valid

/-- Check consonant cluster constraint -/
def check_cluster_size (phonemes : List PhonemeFeatures) : RuleResult :=
  let consonants := phonemes.filter is_consonant
  if consonants.length > max_cluster_size then
    .invalid s!"Consonant cluster too large: {consonants.length}"
  else
    .valid

/-- Main phonotactic validation -/
def validate_sequence (phonemes : List PhonemeFeatures) : RuleResult :=
  match phonemes with
  | [] => .valid
  | [_] => .valid
  | p1 :: p2 :: rest =>
    match check_hiatus p1 p2 with
    | .invalid reason => .invalid reason
    | .valid => validate_sequence (p2 :: rest)

/-- A valid phonotactic sequence -/
structure ValidSequence where
  phonemes : List PhonemeFeatures
  h_valid : validate_sequence phonemes = .valid

/-- Theorem: Empty sequence is always valid -/
theorem empty_valid : validate_sequence [] = .valid := rfl

/-- Theorem: Single phoneme is always valid -/
theorem single_valid (p : PhonemeFeatures) : validate_sequence [p] = .valid := rfl

/-- Theorem: CV sequence is valid (assuming no hiatus check triggers) -/
theorem cv_valid (c v : PhonemeFeatures) 
  (hc : is_consonant c = true) 
  (hv : is_vowel v = true) : 
  validate_sequence [c, v] = .valid := by
  simp [validate_sequence, check_hiatus, is_vowel, is_consonant] at *
  split
  · simp [hc] at *
  · rfl

end Harappan.Phonotactics
