/-
  MetaMillennium/InnerModels/InnerModelBasics.lean

  Basic definitions for inner models in the Meta-Millennium Framework.
-/

import MetaMillennium.Core.TheoryAndModel

namespace MetaMillennium.InnerModels

open MetaMillennium

/-- Abstraction: an inner model of T. -/
structure InnerModel (T : Theory) where
  carrierModel : Model T
  includedInV  : True  -- "M ⊆ V" (schematic)

/-- Marker that a model is "canonical" in the inner-model sense. -/
class CanonicalInnerModel (T : Theory) (M : InnerModel T) : Prop where
  canonical : True

/-- An inner model is a model of its base theory. -/
def innerModelIsModel (T : Theory) (M : InnerModel T) : Model T :=
  M.carrierModel

/-- Transitivity property (abstract). -/
def IsTransitive (_M : InnerModel T) : Prop := True

/-- Well-founded property (abstract). -/
def IsWellFounded (_M : InnerModel T) : Prop := True

end MetaMillennium.InnerModels
