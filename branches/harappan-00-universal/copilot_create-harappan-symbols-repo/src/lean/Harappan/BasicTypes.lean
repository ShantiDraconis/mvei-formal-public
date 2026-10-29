/-
  Harappan Universal Testbed - Basic Types
  ========================================
  
  This file defines the fundamental types for modeling Harappan script elements.
  
  Types defined:
  - Sign: A Harappan symbol with its properties
  - Phoneme: A phonetic unit with articulatory features
  - Mapping: A correspondence between signs and phonemes
  - Archetype: A semantic/symbolic category
-/

-- Basic identifier types
structure SignId where
  value : String
  deriving Repr, DecidableEq, Hashable

structure PhonemeId where
  value : String
  deriving Repr, DecidableEq, Hashable

-- Position in inscription
inductive Position
  | initial : Position
  | medial : Position
  | final : Position
  | any : Position
  deriving Repr, DecidableEq

-- Phoneme type
inductive PhonemeType
  | vowel : PhonemeType
  | consonant : PhonemeType
  deriving Repr, DecidableEq

-- Vowel features
inductive VowelHeight
  | close : VowelHeight
  | mid : VowelHeight
  | open : VowelHeight
  deriving Repr, DecidableEq

inductive VowelBackness
  | front : VowelBackness
  | central : VowelBackness
  | back : VowelBackness
  deriving Repr, DecidableEq

-- Consonant features
inductive ConsonantManner
  | stop : ConsonantManner
  | fricative : ConsonantManner
  | nasal : ConsonantManner
  | approximant : ConsonantManner
  | trill : ConsonantManner
  | tap : ConsonantManner
  deriving Repr, DecidableEq

inductive ConsonantPlace
  | bilabial : ConsonantPlace
  | labiodental : ConsonantPlace
  | dental : ConsonantPlace
  | alveolar : ConsonantPlace
  | postalveolar : ConsonantPlace
  | retroflex : ConsonantPlace
  | palatal : ConsonantPlace
  | velar : ConsonantPlace
  | uvular : ConsonantPlace
  | pharyngeal : ConsonantPlace
  | glottal : ConsonantPlace
  deriving Repr, DecidableEq

-- Phonetic features
structure VowelFeatures where
  height : VowelHeight
  backness : VowelBackness
  rounded : Bool
  deriving Repr, DecidableEq

structure ConsonantFeatures where
  manner : ConsonantManner
  place : ConsonantPlace
  voiced : Bool
  deriving Repr, DecidableEq

-- Phoneme definition
inductive PhonemeFeatures
  | vowelFeatures : VowelFeatures → PhonemeFeatures
  | consonantFeatures : ConsonantFeatures → PhonemeFeatures
  deriving Repr, DecidableEq

structure Phoneme where
  id : PhonemeId
  ipa : String
  phonemeType : PhonemeType
  features : PhonemeFeatures
  deriving Repr, DecidableEq

-- Harappan Sign
structure Sign where
  id : SignId
  code : String      -- Unicode representation
  variant : String   -- Variant designation (A, B, C)
  name : String
  frequency : Float
  typicalPosition : Position
  deriving Repr

-- Confidence value (0.0 to 1.0)
structure Confidence where
  value : Float
  h_nonneg : value ≥ 0
  h_le_one : value ≤ 1

-- Mapping between Sign and Phoneme
structure Mapping where
  sign : SignId
  phoneme : PhonemeId
  confidence : Float
  source : String
  deriving Repr

-- Archetypal categories
inductive Archetype
  | water : Archetype
  | fire : Archetype
  | earth : Archetype
  | air : Archetype
  | ether : Archetype
  | divine : Archetype
  | human : Archetype
  | animal : Archetype
  | plant : Archetype
  | container : Archetype
  | direction : Archetype
  | fertility : Archetype
  | death : Archetype
  | rebirth : Archetype
  | transit : Archetype
  | boundary : Archetype
  deriving Repr, DecidableEq

-- Symbolic archetype mapping
structure ArchetypeMapping where
  sign : SignId
  archetype : Archetype
  confidence : Float
  deriving Repr

-- Collapse state for 0/0 theory
inductive CollapseState
  | collapsed : CollapseState
  | superposed : CollapseState
  | dispersed : CollapseState
  | void : CollapseState
  deriving Repr, DecidableEq

-- Symbolic energy
structure SymbolicEnergy where
  value : Float
  h_nonneg : value ≥ 0 := by decide

-- Complete sign with all attributes
structure HarappanSymbol where
  sign : Sign
  phonemeHypotheses : List Mapping
  archetypes : List ArchetypeMapping
  collapseState : CollapseState
  energy : Float
  deriving Repr
