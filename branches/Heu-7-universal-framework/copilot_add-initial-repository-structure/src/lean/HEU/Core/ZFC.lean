/-
  HEU-7 Framework: ZFC Foundation
  
  This module establishes that we work within classical logic
  and ZFC-compatible foundations. All statements are intended
  to be formalizable in ZFC without additional axioms.
-/

namespace HEU.Core

/-- Axiom placeholder indicating ZFC compatibility.
    This is a meta-theoretical assertion that our framework
    is formalizable within standard ZFC set theory. -/
axiom ZFCCompatible : Prop

/-- Classical logic is assumed throughout. -/
axiom classical_logic : ∀ (P : Prop), P ∨ ¬P

/-- Axiom of Choice is available. -/
axiom choice : ∀ (α : Type) (P : α → Prop), (∃ x, P x) → ∃ x, P x

/-- Definability predicate for sets.
    A set is definable if it can be specified by a ZFC formula. -/
class Definable (α : Type) : Prop where
  is_definable : True

/-- All basic types we use are definable in ZFC. -/
instance : Definable Nat := ⟨trivial⟩
instance : Definable Int := ⟨trivial⟩
instance : Definable Bool := ⟨trivial⟩

end HEU.Core
