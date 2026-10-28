/-
  MetaMillennium.Core.LogicBasics
  Basic logical definitions and structures
-/

namespace MetaMillennium.Core

/-- A formula in first-order logic (abstract representation) -/
structure Formula where
  /-- Unique identifier for the formula -/
  id : Nat
  /-- String representation of the formula -/
  repr : String
  deriving Repr, BEq

/-- Negation of a formula -/
def Formula.neg (φ : Formula) : Formula :=
  { id := φ.id + 1000000, repr := s!"¬({φ.repr})" }

/-- Conjunction of formulas -/
def Formula.and (φ ψ : Formula) : Formula :=
  { id := φ.id * 1000 + ψ.id, repr := s!"({φ.repr}) ∧ ({ψ.repr})" }

/-- Disjunction of formulas -/
def Formula.or (φ ψ : Formula) : Formula :=
  { id := φ.id * 1000 + ψ.id + 1, repr := s!"({φ.repr}) ∨ ({ψ.repr})" }

/-- Implication of formulas -/
def Formula.implies (φ ψ : Formula) : Formula :=
  { id := φ.id * 1000 + ψ.id + 2, repr := s!"({φ.repr}) → ({ψ.repr})" }

/-- A sentence is a closed formula (no free variables) -/
abbrev Sentence := Formula

/-- Logical equivalence (defined as biconditional) -/
def Formula.iff (φ ψ : Formula) : Formula :=
  (φ.implies ψ).and (ψ.implies φ)

end MetaMillennium.Core
