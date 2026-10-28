/-
  MetaMillennium.Models.ForcingSkeleton
  Abstract skeleton of forcing
-/

import MetaMillennium.Core.TheoryAndModel

namespace MetaMillennium.Models

open MetaMillennium.Core

/-- A partial order (poset) for forcing -/
structure Poset where
  /-- The carrier type -/
  carrier : Type
  /-- The ordering relation -/
  le : carrier → carrier → Prop
  /-- Reflexivity -/
  le_refl : ∀ p, le p p
  /-- Transitivity -/
  le_trans : ∀ p q r, le p q → le q r → le p r

/-- A condition in the poset -/
abbrev Condition (P : Poset) := P.carrier

/-- Extension relation: p extends q means p ≤ q (more specific) -/
def extends_ (P : Poset) (p q : Condition P) : Prop := P.le p q

/-- A dense set in a poset -/
def Dense (P : Poset) (D : Set (Condition P)) : Prop :=
  ∀ p : Condition P, ∃ q ∈ D, P.le q p

/-- A filter in a poset -/
structure Filter (P : Poset) where
  /-- The filter elements -/
  elements : Set (Condition P)
  /-- Non-empty -/
  nonempty : elements.Nonempty
  /-- Upward closed -/
  upward : ∀ p q, p ∈ elements → P.le p q → q ∈ elements
  /-- Directed -/
  directed : ∀ p q, p ∈ elements → q ∈ elements →
    ∃ r ∈ elements, P.le r p ∧ P.le r q

/-- Generic filter: meets all dense sets -/
structure GenericFilter (P : Poset) extends Filter P where
  /-- Meets all dense sets -/
  meets_dense : ∀ D : Set (Condition P), Dense P D → (elements ∩ D).Nonempty

/-- Abstract forcing extension: M[G] -/
-- Given a model M and a generic G, produce M[G]
def forcing_extension (M : Model) (P : Poset) (G : GenericFilter P) : Model :=
  { id := M.id + 1000, name := s!"{M.name}[G]" }

/-- Key property: M[G] is a model of ZFC if M is -/
-- This is the fundamental theorem of forcing (stated abstractly)
axiom forcing_preserves_ZFC :
  ∀ (M : Model) (P : Poset) (G : GenericFilter P),
    M ⊨ₜ ZFC → (forcing_extension M P G) ⊨ₜ ZFC

end MetaMillennium.Models
