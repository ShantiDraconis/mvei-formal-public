-- MetaMillennium/DualState/BiModel.lean
-- Bi-Model structure carrying two models of the same theory T,
-- representing the "true branch" and the "false branch" for a given sentence φ.

namespace MetaMillennium

/-- Theory: a placeholder for a formal theory (e.g., ZFC). -/
structure Theory where
  name : String

/-- Model: a placeholder for a model of a theory. -/
structure Model (T : Theory) where
  name : String

/-- Sentence: a placeholder for a formal sentence in a theory. -/
structure Sentence (T : Theory) where
  content : String

/-- Satisfaction relation: M ⊨[T] φ means model M satisfies sentence φ in theory T. -/
class Satisfies (T : Theory) where
  sat : Model T → Sentence T → Prop

notation:50 M " ⊨[" T "] " φ => Satisfies.sat M φ

/-- 
  BiModel: a single structure carrying two models of the same theory T,
  intended to represent the "true branch" and the "false branch" for a
  given sentence φ.
-/
structure BiModel (T : Theory) where
  Mpos  : Model T    -- M⁺ (true-branch)
  Mneg  : Model T    -- M⁻ (false-branch)
/- Later you can enrich with maps ι⁺, ι⁻, relations, etc. -/

/-- For now, we abstract a satisfaction relation on each side. -/
variable {T : Theory} [Satisfies T]

/-- Type alias for the collection of all BiModels of a theory T.
    Intended for future use when defining functions over collections of bi-models. -/
def BiModels (T : Theory) := BiModel T

/-- Dual-state valuation of a sentence on a BiModel:
    returns the truth-value in M⁺ and in M⁻ as a pair. -/
def biVal (B : BiModel T) (φ : Sentence T) : Prop × Prop :=
  (B.Mpos ⊨[T] φ, B.Mneg ⊨[T] φ)

/-- A (T, φ)-BiModel is meant to satisfy φ on M⁺ and ¬φ on M⁻.
    Here we just encode it as a predicate for now. -/
def isDualFor (B : BiModel T) (φ : Sentence T) : Prop :=
  (B.Mpos ⊨[T] φ) ∧ ¬ (B.Mneg ⊨[T] φ)

/-- A bi-consistent BiModel: both components are models of T and no
    cross-constraints force a collapse of φ and ¬φ.
    TODO: In a real development, formalize the absence of cross-axioms
    with proper consistency checks.
-/
def BiConsistent (B : BiModel T) : Prop := True

end MetaMillennium
