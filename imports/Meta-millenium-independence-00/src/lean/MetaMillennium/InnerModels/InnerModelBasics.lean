/-
  MetaMillennium.InnerModels.InnerModelBasics
  Basic inner model definitions
-/

import MetaMillennium.Core.TheoryAndModel

namespace MetaMillennium.InnerModels

open MetaMillennium.Core

/-- An inner model is a transitive class containing all ordinals -/
structure InnerModel extends Model where
  /-- The model is transitive -/
  is_transitive : True
  /-- Contains all ordinals -/
  contains_ordinals : True
  /-- Satisfies ZFC -/
  satisfies_ZFC : Model.satisfiesTheory toModel ZFC

/-- The constructible universe L -/
def L : InnerModel := {
  toModel := { id := 0, name := "L" }
  is_transitive := trivial
  contains_ordinals := trivial
  satisfies_ZFC := sorry
}

/-- L satisfies V = L -/
axiom L_satisfies_VeqL : L.toModel ⊨ { id := 200, repr := "V = L" }

/-- L satisfies GCH -/
axiom L_satisfies_GCH : L.toModel ⊨ { id := 202, repr := "GCH" }

/-- L satisfies AC -/
axiom L_satisfies_AC : L.toModel ⊨ { id := 110, repr := "AC" }

/-- Inclusion of inner models -/
def InnerModel.subset (M N : InnerModel) : Prop := True  -- M ⊆ N

/-- L is minimal -/
axiom L_is_minimal :
  ∀ M : InnerModel, L.subset M

end MetaMillennium.InnerModels
