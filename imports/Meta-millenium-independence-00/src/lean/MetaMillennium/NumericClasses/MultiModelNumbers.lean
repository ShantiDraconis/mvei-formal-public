/-
  MetaMillennium.NumericClasses.MultiModelNumbers
  Numbers with different values in different models
-/

import MetaMillennium.NumericClasses.AxiomaticNumbers

namespace MetaMillennium.NumericClasses

open MetaMillennium.Core

/-- Multi-Model Numbers: numbers whose value varies between models -/
structure MultiModelNumber where
  /-- Description -/
  description : String
  /-- Value in model M₁ -/
  value_in_M1 : Float  -- Placeholder
  /-- Value in model M₂ -/
  value_in_M2 : Float  -- Placeholder
  /-- The models give different values -/
  values_differ : value_in_M1 ≠ value_in_M2

/-- The class of multi-model numbers -/
def M_multi : Type := MultiModelNumber

notation "𝕄" => M_multi

/-- Example: cardinality of the continuum -/
-- In L: 2^ℵ₀ = ℵ₁
-- In some V: 2^ℵ₀ = ℵ₂ or larger

def continuum_cardinality : MultiModelNumber := {
  description := "2^ℵ₀"
  value_in_M1 := 1.0  -- Represents ℵ₁
  value_in_M2 := 2.0  -- Represents ℵ₂
  values_differ := by norm_num
}

end MetaMillennium.NumericClasses
