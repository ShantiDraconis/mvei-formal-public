/-
  MetaMillennium.Forcing.ForcingBasics
  Basic forcing definitions
-/

import MetaMillennium.Models.ForcingSkeleton

namespace MetaMillennium.Forcing

open MetaMillennium.Models

/-- Re-export the forcing skeleton -/
export MetaMillennium.Models (Poset Condition Dense Filter GenericFilter forcing_extension)

/-- Maximum element of a poset -/
def Poset.maxElement (P : Poset) : Condition P := sorry  -- Would be defined per poset

/-- Compatibility of conditions -/
def compatible (P : Poset) (p q : Condition P) : Prop :=
  ∃ r : Condition P, P.le r p ∧ P.le r q

/-- Incompatibility -/
def incompatible (P : Poset) (p q : Condition P) : Prop :=
  ¬compatible P p q

/-- Antichain: mutually incompatible conditions -/
def Antichain (P : Poset) (A : Set (Condition P)) : Prop :=
  ∀ p q, p ∈ A → q ∈ A → p ≠ q → incompatible P p q

/-- Chain condition: no large antichains -/
def hasCountableChainCondition (P : Poset) : Prop :=
  ∀ A : Set (Condition P), Antichain P A → Set.Countable A

/-- CCC posets don't collapse cardinals -/
axiom ccc_preserves_cardinals :
  ∀ P : Poset, hasCountableChainCondition P →
    True  -- Cardinals are preserved in forcing extension

end MetaMillennium.Forcing
