/-
  MetaMillennium.Core.TheoryAndModel

  Copilot: complete a clean abstraction of a first-order style framework.

  - Define `Theory`, `Sentence`, `Model` as abstract structures.
  - Add a `Provable` typeclass: `T ⊢ φ`.
  - Add a `Satisfies` typeclass: `M ⊨[T] φ`.
  - Do NOT implement a full logic engine.
  - Keep everything as lightweight interfaces.
-/

namespace MetaMillennium

/-- A Theory is an abstract structure representing a formal theory.
    The Carrier type represents the underlying domain of discourse. -/
structure Theory where
  /-- The carrier type for the theory's language -/
  Carrier : Type
  deriving Inhabited

/-- A Sentence is a formal statement in the language of a theory.
    For now, this is a placeholder structure. -/
structure Sentence (T : Theory) where
  /-- Placeholder field -/
  dummy : Unit := ()
  deriving Inhabited

/-- A Model is a structure that interprets a theory.
    The Carrier type represents the domain of the model. -/
structure Model (T : Theory) where
  /-- The carrier set of the model -/
  Carrier : Type
  deriving Inhabited

/-- Typeclass for provability in a theory.
    `Provable T φ` means φ is derivable from the axioms of T. -/
class Provable (T : Theory) where
  /-- The provability relation -/
  proves : Sentence T → Prop

/-- Notation for provability: T ⊢ φ -/
notation:45 T " ⊢ " φ => Provable.proves (T := T) φ

/-- Typeclass for satisfaction/truth in a model.
    `Satisfies T M φ` means φ is true in model M. -/
class Satisfies (T : Theory) where
  /-- The satisfaction relation -/
  models : Model T → Sentence T → Prop

/-- Notation for satisfaction: M ⊨[T] φ -/
notation:60 M " ⊨[" T "] " φ => Satisfies.models (T := T) M φ

/-- Negation of a sentence (abstract placeholder) -/
def Sentence.neg {T : Theory} (_ : Sentence T) : Sentence T :=
  { dummy := () }

/-- Notation for sentence negation -/
prefix:70 "∼" => Sentence.neg

end MetaMillennium
