/-
  MetaMillennium/Forcing/ForcingBasics.lean

  Bridge 1: Abstract structure of forcing.

  Objective:
  - Define a type `ForcingPoset` with ordering.
  - Define abstract concepts of filter and genericity (still schematic).
  - NOT implementing the full forcing theory (that would be enormous),
    but preparing the interface to connect with DualState.
-/

import MetaMillennium.Core.TheoryAndModel
import MetaMillennium.Core.ConsistencyAndIndependence

namespace MetaMillennium.Forcing

open MetaMillennium

/-- Abstract structure of a forcing poset. -/
structure ForcingPoset where
  Carrier : Type
  le      : Carrier → Carrier → Prop
  top     : Carrier
  le_refl : ∀ p, le p p
  le_trans : ∀ {p q r}, le p q → le q r → le p r
  le_top  : ∀ p, le p top

/-- Abstract filter in a forcing poset. -/
structure Filter (P : ForcingPoset) where
  carrier : Set P.Carrier
  nonempty : ∃ p, p ∈ carrier
  downward_closed :
    ∀ {p q}, q ∈ carrier → P.le p q → p ∈ carrier
  directed :
    ∀ {p q}, p ∈ carrier → q ∈ carrier →
      ∃ r, r ∈ carrier ∧ P.le r p ∧ P.le r q

/-- Abstract density: a subset is dense if there's always an extension in it. -/
def Dense (P : ForcingPoset) (D : Set P.Carrier) : Prop :=
  ∀ p, ∃ q, D q ∧ P.le q p

/-- Schematic structure for "M is a model of T" and "G is M-generic". -/
structure ForcingScenario (T : Theory) where
  baseModel     : Model T
  poset         : ForcingPoset
  genericFilter : Filter poset
  -- In the future: densities in baseModel, real genericity etc.

/-- Placeholder for the forcing extension M[G]. -/
structure ForcingExtension (T : Theory) where
  base     : ForcingScenario T
  extModel : Model T

end MetaMillennium.Forcing
