/-
  Harappan Basic Types
  
  Fundamental type definitions for the Harappan Universal Testbed.
  This module defines the core data structures used throughout
  the formal verification system.
-/

namespace Harappan

/-- A unique identifier for a Harappan sign -/
structure SignId where
  value : String
  deriving DecidableEq, Repr

/-- A phoneme represented in IPA notation -/
structure Phoneme where
  ipa : String
  deriving DecidableEq, Repr

/-- An archetype representing a fundamental concept -/
inductive Archetype
  | water      -- SH: Flow, life, feminine
  | fire       -- TA: Transformation, energy
  | earth      -- PA: Material, grounding
  | air        -- MA: Spirit, ethereal
  | person     -- NU: Self, boundary, consciousness
  | boundary   -- KA: Container, limit
  | zero_zero  -- 0/0: Primordial undifferentiated
  deriving DecidableEq, Repr

/-- Confidence level for hypotheses (0.0 to 1.0) -/
structure Confidence where
  value : Float
  h_nonneg : value ≥ 0
  h_bounded : value ≤ 1
  deriving Repr

/-- A hypothesis about a sign's interpretation -/
structure Hypothesis where
  sign_id : SignId
  phoneme : Option Phoneme
  meaning : Option String
  archetype : Option Archetype
  confidence : Confidence
  deriving Repr

/-- Position of a sign within an inscription -/
inductive Position
  | initial
  | medial
  | final
  deriving DecidableEq, Repr

/-- A Harappan sign with all associated data -/
structure Sign where
  id : SignId
  glyph_code : String
  frequency : Float
  typical_position : Position
  hypotheses : List Hypothesis
  deriving Repr

/-- An inscription consisting of a sequence of signs -/
structure Inscription where
  id : String
  site : String
  signs : List SignId
  object_type : String
  deriving Repr

/-- A mapping from Harappan to another language -/
structure Mapping where
  sign_id : SignId
  target_language : String
  target_word : String
  target_meaning : String
  confidence : Confidence
  deriving Repr

/-- Collapse state in the symbolic framework -/
inductive CollapseState
  | dispersed   -- Superposition of meanings
  | collapsed   -- Definite meaning
  | entangled   -- Correlated with other signs
  | zero_zero   -- Primordial state
  deriving DecidableEq, Repr

/-- Symbolic state of a sign -/
structure SymbolicState where
  sign_id : SignId
  state : CollapseState
  potential_meanings : List String
  collapsed_meaning : Option String
  energy : Float
  entanglement_partners : List SignId
  deriving Repr

end Harappan
