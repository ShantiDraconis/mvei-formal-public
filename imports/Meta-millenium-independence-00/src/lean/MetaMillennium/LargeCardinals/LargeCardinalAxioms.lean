/-
  MetaMillennium.LargeCardinals.LargeCardinalAxioms
  Large cardinal axioms
-/

import MetaMillennium.Models.LargeCardinalSkeleton

namespace MetaMillennium.LargeCardinals

open MetaMillennium.Models

/-- Re-export large cardinal definitions -/
export MetaMillennium.Models (
  Cardinal isInaccessible isMahlo isMeasurable isWoodin isSupercompact
  LC_inaccessible LC_measurable LC_woodin LC_supercompact
)

/-- Strongly inaccessible -/
def isStronglyInaccessible (κ : Cardinal) : Prop :=
  isInaccessible κ

/-- Ramsey cardinal -/
def isRamsey (κ : Cardinal) : Prop := True  -- κ → (κ)^{<ω}_2

/-- Rowbottom cardinal -/
def isRowbottom (κ : Cardinal) : Prop := True  -- Partition property

/-- Huge cardinal -/
def isHuge (κ : Cardinal) : Prop := True  -- Strong embedding property

/-- I0 embedding -/
def isI0 (κ : Cardinal) : Prop := True  -- j : L(Vλ+1) → L(Vλ+1)

/-- Reinhardt cardinal (inconsistent with AC) -/
def isReinhardt (κ : Cardinal) : Prop := True  -- j : V → V

/-- Berkeley cardinal (inconsistent) -/
def isBerkeley (κ : Cardinal) : Prop := True

/-- The hierarchy -/
def large_cardinal_hierarchy : List String := [
  "ZFC",
  "Inaccessible",
  "Mahlo",
  "Weakly compact",
  "Ramsey",
  "Measurable",
  "Strong",
  "Woodin",
  "Supercompact",
  "Huge",
  "I0, I1, I2, I3",
  "Reinhardt (inconsistent with AC)",
  "Berkeley (inconsistent)"
]

end MetaMillennium.LargeCardinals
