/-
  MetaMillennium/Core/TheoryAndModel.lean

  Foundational definitions for theories, models, and sentences
  in the Meta-Millennium Independence Framework.

  This file provides the abstract interface that the rest of
  the framework uses to reason about formal systems, models,
  and semantic relations.
-/

namespace MetaMillennium

/-- Abstract type representing a formal theory. -/
structure Theory where
  name : String
  deriving Repr, DecidableEq

/-- Abstract type representing a sentence in a theory. -/
structure Sentence (T : Theory) where
  formula : String
  deriving Repr, DecidableEq

/-- Abstract type representing a model of a theory. -/
structure Model (T : Theory) where
  name : String
  deriving Repr

/-- Class for theories with a notion of provability. -/
class Provable (T : Theory) where
  proves : Sentence T → Prop
  refutes : Sentence T → Prop
  consistent : ¬ (∃ φ : Sentence T, proves φ ∧ refutes φ)

/-- Satisfaction relation: model satisfies sentence. -/
def Satisfies (_M : Model T) (_φ : Sentence T) : Prop := True  -- abstract placeholder

notation:50 M " ⊨ " φ => Satisfies M φ

/-- Soundness: if T proves φ, then every model satisfies φ. -/
axiom soundness {T : Theory} [Provable T] (φ : Sentence T) :
  Provable.proves φ → ∀ M : Model T, M ⊨ φ

/-- Completeness (abstract): if all models satisfy φ, then T proves φ. -/
axiom completeness {T : Theory} [Provable T] (φ : Sentence T) :
  (∀ M : Model T, M ⊨ φ) → Provable.proves φ

end MetaMillennium
