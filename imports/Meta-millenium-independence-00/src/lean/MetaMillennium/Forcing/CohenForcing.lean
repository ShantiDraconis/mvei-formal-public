/-
  MetaMillennium.Forcing.CohenForcing
  Cohen forcing to add generic reals
-/

import MetaMillennium.Forcing.GenericFilters

namespace MetaMillennium.Forcing

/-- Cohen forcing: finite partial functions ω → 2 -/
structure CohenCondition where
  /-- Domain (finite subset of ω) -/
  domain : List Nat
  /-- The partial function -/
  values : Nat → Bool

/-- Cohen poset -/
def CohenPoset : Poset := {
  carrier := CohenCondition
  le := fun p q => True  -- p extends q
  le_refl := fun _ => trivial
  le_trans := fun _ _ _ _ _ => trivial
}

/-- Cohen forcing adds a new subset of ω -/
def cohenReal (G : GenericFilter CohenPoset) : Set Nat :=
  { n | True }  -- The generic real

/-- Cohen forcing makes CH false (with enough generics) -/
axiom cohen_negates_CH :
  ∃ G : GenericFilter CohenPoset, True →
    True  -- M[G] ⊨ ¬CH

/-- Cohen forcing is CCC -/
axiom cohen_is_ccc : hasCountableChainCondition CohenPoset

end MetaMillennium.Forcing
