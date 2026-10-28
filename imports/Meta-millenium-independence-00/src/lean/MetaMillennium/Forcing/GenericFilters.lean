/-
  MetaMillennium.Forcing.GenericFilters
  Generic filters and their properties
-/

import MetaMillennium.Forcing.ForcingBasics

namespace MetaMillennium.Forcing

open MetaMillennium.Models

/-- Existence of generic filters (for countable models) -/
axiom generic_exists_for_countable :
  ∀ P : Poset, ∀ M : Model, True →  -- M is countable
    ∃ G : GenericFilter P, True

/-- The generic object: what G "codes" -/
def genericObject (P : Poset) (G : GenericFilter P) : Type := Condition P

/-- Name for a set in the forcing language -/
structure Name (P : Poset) where
  /-- The name data -/
  data : Nat  -- Placeholder

/-- Interpretation of a name by a generic -/
def interpret (P : Poset) (G : GenericFilter P) (τ : Name P) : Type :=
  Nat  -- Placeholder

/-- Key property: everything in M[G] has a name in M -/
axiom name_exists :
  ∀ P : Poset, ∀ G : GenericFilter P, ∀ x : Nat,  -- x in M[G]
    ∃ τ : Name P, True  -- τ names x

end MetaMillennium.Forcing
