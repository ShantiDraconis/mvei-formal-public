/-
  MetaMillennium/LargeCardinals/LargeCardinalAxioms.lean

  Abstract axioms for large cardinals in the Meta-Millennium Framework.
-/

import MetaMillennium.Core.TheoryAndModel

namespace MetaMillennium.LargeCardinals

open MetaMillennium

/-- Abstract type for cardinals. -/
structure Cardinal where
  name : String
  deriving Repr, DecidableEq

/-- Predicates for "being a large cardinal" (abstract). -/
def IsMeasurable (κ : Cardinal) : Prop := κ.name.containsSubstr "measurable"
def IsSupercompact (κ : Cardinal) : Prop := κ.name.containsSubstr "supercompact"
def IsWoodin (κ : Cardinal) : Prop := κ.name.containsSubstr "Woodin"
def IsInaccessible (κ : Cardinal) : Prop := κ.name.containsSubstr "inaccessible"
def IsMahlo (κ : Cardinal) : Prop := κ.name.containsSubstr "Mahlo"

/-- Axiom schemes: large cardinals exist. -/
axiom exists_measurable : ∃ κ : Cardinal, IsMeasurable κ
axiom exists_supercompact : ∃ κ : Cardinal, IsSupercompact κ
axiom exists_Woodin : ∃ κ : Cardinal, IsWoodin κ
axiom exists_inaccessible : ∃ κ : Cardinal, IsInaccessible κ

/-- Large cardinal hierarchy (abstract ordering). -/
def LargeCardinalStrength : Cardinal → ℕ
  | ⟨s⟩ => if s.containsSubstr "supercompact" then 100
           else if s.containsSubstr "Woodin" then 80
           else if s.containsSubstr "measurable" then 50
           else if s.containsSubstr "Mahlo" then 30
           else if s.containsSubstr "inaccessible" then 20
           else 0

end MetaMillennium.LargeCardinals
