/-
  Harappan Universal Testbed - Phonology
  
  Formalization of phonological hypotheses and mappings.
-/

import Harappan.BasicTypes

namespace Harappan

/-- Distinctive phonological features -/
inductive Feature where
  | consonantal : Feature
  | sonorant : Feature
  | voiced : Feature
  | nasal : Feature
  | labial : Feature
  | coronal : Feature
  | dorsal : Feature
  | continuant : Feature
  | strident : Feature
  | high : Feature
  | low : Feature
  | back : Feature
  | round : Feature
  deriving Repr, BEq

/-- A phoneme with its features -/
structure PhonemeSpec where
  phoneme : Phoneme
  features : List Feature
  deriving Repr

/-- A phoneme hypothesis for a sign -/
structure PhonemeHypothesis where
  signId : SignId
  phoneme : Phoneme
  confidence : Confidence
  source : String
  deriving Repr

/-- Phoneme distance based on feature overlap -/
def featureDistance (p1 p2 : PhonemeSpec) : Float :=
  let common := p1.features.filter (fun f => p2.features.contains f)
  let total := p1.features.length + p2.features.length
  if total = 0 then 0
  else 1 - (2 * common.length.toFloat / total.toFloat)

/-- A phoneme mapping from Harappan to target language -/
structure PhonemeMapping where
  signId : SignId
  targetPhoneme : Phoneme
  targetLanguage : String
  confidence : Confidence
  deriving Repr

/-- Phoneme inventory for a language -/
structure PhonemeInventory where
  language : String
  consonants : List PhonemeSpec
  vowels : List PhonemeSpec

/-- Check if a phoneme is valid in an inventory -/
def PhonemeInventory.contains (inv : PhonemeInventory) (p : Phoneme) : Bool :=
  inv.consonants.any (fun ps => ps.phoneme == p) ||
  inv.vowels.any (fun ps => ps.phoneme == p)

/-- Phonotactic constraint -/
structure PhonotacticConstraint where
  name : String
  check : List Phoneme → Bool

/-- Syllable structure constraint -/
def syllableStructureConstraint (onset vowel coda : Nat → Bool) : PhonotacticConstraint :=
  { name := "syllable_structure"
  , check := fun phones => 
      -- Simplified check: at least one vowel
      phones.any (fun p => p.isVowel)
  }

end Harappan
