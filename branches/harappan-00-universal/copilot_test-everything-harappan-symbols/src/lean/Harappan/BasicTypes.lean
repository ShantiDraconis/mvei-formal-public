/-
  Harappan Universal Testbed - Basic Types
  
  Core type definitions for the Harappan formalization.
-/

namespace Harappan

/-- A sign identifier -/
structure SignId where
  id : String
  deriving Repr, BEq, Hashable

/-- Position in an inscription -/
inductive Position where
  | initial : Position
  | medial : Position
  | final : Position
  deriving Repr, BEq

/-- A glyph variant identifier -/
structure GlyphVariant where
  base : SignId
  variant : Char
  deriving Repr, BEq

/-- Confidence level for hypotheses -/
structure Confidence where
  value : Float
  h_bounds : 0 ≤ value ∧ value ≤ 1
  deriving Repr

/-- Create a confidence value with automatic bounds check -/
def mkConfidence (v : Float) : Option Confidence :=
  if h : 0 ≤ v ∧ v ≤ 1 then
    some ⟨v, h⟩
  else
    none

/-- A phoneme representation (IPA) -/
structure Phoneme where
  ipa : String
  isVowel : Bool
  deriving Repr, BEq

/-- Semantic category -/
inductive SemanticCategory where
  | artifact : SemanticCategory
  | animal : SemanticCategory
  | human : SemanticCategory
  | element : SemanticCategory
  | action : SemanticCategory
  | abstract : SemanticCategory
  deriving Repr, BEq

/-- Archetypal concept -/
inductive Archetype where
  | water : Archetype
  | fire : Archetype
  | earth : Archetype
  | air : Archetype
  | ether : Archetype
  | time : Archetype
  | space : Archetype
  | life : Archetype
  | death : Archetype
  deriving Repr, BEq

end Harappan
