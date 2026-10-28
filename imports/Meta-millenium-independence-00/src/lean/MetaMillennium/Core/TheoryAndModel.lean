/-
  MetaMillennium.Core.TheoryAndModel
  Definitions of Theory and Model
-/

import MetaMillennium.Core.LogicBasics

namespace MetaMillennium.Core

/-- A theory is a collection of sentences (axioms) -/
structure Theory where
  /-- Name of the theory -/
  name : String
  /-- Axioms of the theory -/
  axioms : List Sentence
  deriving Repr

/-- A model is an abstract structure that can satisfy sentences -/
structure Model where
  /-- Identifier for the model -/
  id : Nat
  /-- Name of the model -/
  name : String
  deriving Repr, BEq

/-- The satisfaction relation: M ⊨ φ -/
-- This is abstract; in a real implementation, we would define semantics
structure Satisfies (M : Model) (φ : Sentence) : Prop where
  /-- The model satisfies the sentence -/
  holds : True  -- Placeholder for actual semantics

notation:50 M " ⊨ " φ => Satisfies M φ

/-- A model satisfies a theory if it satisfies all axioms -/
def Model.satisfiesTheory (M : Model) (T : Theory) : Prop :=
  ∀ φ ∈ T.axioms, Satisfies M φ

notation:50 M " ⊨ₜ " T => Model.satisfiesTheory M T

/-- ZFC as a theory (abstract) -/
def ZFC : Theory := {
  name := "ZFC"
  axioms := []  -- Axioms would be listed here in a full formalization
}

/-- PA (Peano Arithmetic) as a theory -/
def PA : Theory := {
  name := "PA"
  axioms := []
}

/-- Extension of a theory with additional axioms -/
def Theory.extend (T : Theory) (φ : Sentence) : Theory := {
  name := s!"{T.name} + {φ.repr}"
  axioms := T.axioms ++ [φ]
}

notation:60 T " + " φ => Theory.extend T φ

end MetaMillennium.Core
