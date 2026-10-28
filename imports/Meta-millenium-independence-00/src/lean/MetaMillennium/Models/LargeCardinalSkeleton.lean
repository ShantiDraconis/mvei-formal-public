/-
  MetaMillennium.Models.LargeCardinalSkeleton
  Abstract skeleton of large cardinal axioms
-/

import MetaMillennium.Core.TheoryAndModel

namespace MetaMillennium.Models

open MetaMillennium.Core

/-- Cardinal (abstract representation) -/
structure Cardinal where
  /-- Ordinal index -/
  index : Nat
  deriving Repr, BEq

/-- Ordering on cardinals -/
def Cardinal.le (κ μ : Cardinal) : Prop := κ.index ≤ μ.index
def Cardinal.lt (κ μ : Cardinal) : Prop := κ.index < μ.index

instance : LE Cardinal := ⟨Cardinal.le⟩
instance : LT Cardinal := ⟨Cardinal.lt⟩

/-- Regularity: cf(κ) = κ -/
def isRegular (κ : Cardinal) : Prop := True  -- Placeholder

/-- Strong limit: ∀λ < κ, 2^λ < κ -/
def isStrongLimit (κ : Cardinal) : Prop := True  -- Placeholder

/-- Inaccessible cardinal -/
def isInaccessible (κ : Cardinal) : Prop :=
  κ.index > 0 ∧ isRegular κ ∧ isStrongLimit κ

/-- Mahlo cardinal -/
def isMahlo (κ : Cardinal) : Prop :=
  isInaccessible κ ∧ True  -- Set of inaccessibles below is stationary

/-- Measurable cardinal -/
def isMeasurable (κ : Cardinal) : Prop :=
  True  -- Has κ-complete non-principal ultrafilter

/-- Woodin cardinal -/
def isWoodin (κ : Cardinal) : Prop :=
  True  -- For all f: κ → κ, exists appropriate extender

/-- Supercompact cardinal -/
def isSupercompact (κ : Cardinal) : Prop :=
  True  -- For all λ ≥ κ, exists appropriate embedding

/-- Large cardinal axiom: there exists an inaccessible -/
def LC_inaccessible : Sentence :=
  { id := 301, repr := "∃κ(κ is inaccessible)" }

/-- Large cardinal axiom: there exists a measurable -/
def LC_measurable : Sentence :=
  { id := 302, repr := "∃κ(κ is measurable)" }

/-- Large cardinal axiom: there exists a Woodin -/
def LC_woodin : Sentence :=
  { id := 303, repr := "∃κ(κ is Woodin)" }

/-- Large cardinal axiom: there exists a supercompact -/
def LC_supercompact : Sentence :=
  { id := 304, repr := "∃κ(κ is supercompact)" }

/-- Hierarchy: higher LCs imply lower ones -/
axiom measurable_implies_inaccessible :
  ∀ κ : Cardinal, isMeasurable κ → isInaccessible κ

axiom supercompact_implies_measurable :
  ∀ κ : Cardinal, isSupercompact κ → isMeasurable κ

end MetaMillennium.Models
