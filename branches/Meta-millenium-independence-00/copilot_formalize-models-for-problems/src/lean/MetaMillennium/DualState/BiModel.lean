/-
  MetaMillennium.DualState.BiModel

  Copilot: define a BiModel with two models of T, representing M⁺ and M⁻,
  and a dual-state valuation `biVal`.

  - Do NOT try to express ¬φ explicitly yet.
  - Just return the pair of truth values (Mpos ⊨ φ, Mneg ⊨ φ).
-/

import MetaMillennium.Core.TheoryAndModel

namespace MetaMillennium

open MetaMillennium

/-- A BiModel consists of two models of the same theory.
    These represent the "positive" and "negative" models
    that witness dual-state behavior. -/
structure BiModel (T : Theory) where
  /-- The positive model where φ holds -/
  Mpos : Model T
  /-- The negative model where ¬φ holds -/
  Mneg : Model T

variable {T : Theory}

/-- Bi-valuation: given a bi-model and a sentence,
    return the pair of truth values in each model.
    
    biVal B φ = (Mpos ⊨ φ, Mneg ⊨ φ) -/
def biVal [Satisfies T] (B : BiModel T) (φ : Sentence T) : Prop × Prop :=
  (B.Mpos ⊨[T] φ, B.Mneg ⊨[T] φ)

/-- A bi-model is a dual witness for φ if:
    - Mpos satisfies φ
    - Mneg does not satisfy φ (i.e., satisfies ¬φ) -/
def isDualFor [Satisfies T] (B : BiModel T) (φ : Sentence T) : Prop :=
  (B.Mpos ⊨[T] φ) ∧ ¬(B.Mneg ⊨[T] φ)

/-- A bi-model is a strict dual witness if it separates φ completely:
    φ is true in exactly one of the models -/
def isStrictDualFor [Satisfies T] (B : BiModel T) (φ : Sentence T) : Prop :=
  ((B.Mpos ⊨[T] φ) ∧ ¬(B.Mneg ⊨[T] φ)) ∨ 
  (¬(B.Mpos ⊨[T] φ) ∧ (B.Mneg ⊨[T] φ))

/-- Swap the models in a bi-model -/
def BiModel.swap (B : BiModel T) : BiModel T :=
  { Mpos := B.Mneg, Mneg := B.Mpos }

/-- Swapping preserves the bi-model structure -/
theorem swap_swap (B : BiModel T) : B.swap.swap = B := rfl

/-- If B is a dual witness for φ, then B.swap is a dual witness for ¬φ -/
theorem swap_dual [Satisfies T] (B : BiModel T) (φ : Sentence T)
    (h : isDualFor B φ) : isDualFor B.swap (∼φ) := by
  -- This requires relating satisfaction of φ and ¬φ
  sorry

end MetaMillennium
