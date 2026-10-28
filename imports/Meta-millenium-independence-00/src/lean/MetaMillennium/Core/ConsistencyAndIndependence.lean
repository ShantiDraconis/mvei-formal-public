/-
  MetaMillennium.Core.ConsistencyAndIndependence
  Consistency and Independence definitions
-/

import MetaMillennium.Core.TheoryAndModel

namespace MetaMillennium.Core

/-- A theory is consistent if it has a model -/
def Theory.Consistent (T : Theory) : Prop :=
  ∃ M : Model, M ⊨ₜ T

/-- Notation for consistency -/
notation "Con(" T ")" => Theory.Consistent T

/-- A sentence is provable from a theory -/
-- Abstract definition; would require proof calculus
structure Provable (T : Theory) (φ : Sentence) : Prop where
  /-- The sentence is provable -/
  proof_exists : True  -- Placeholder

notation:50 T " ⊢ " φ => Provable T φ

/-- A sentence is refutable from a theory -/
def Refutable (T : Theory) (φ : Sentence) : Prop :=
  Provable T φ.neg

notation:50 T " ⊢ ¬" φ => Refutable T φ

/-- A sentence is independent of a theory -/
structure Independent (T : Theory) (φ : Sentence) : Prop where
  /-- Not provable -/
  not_provable : ¬(T ⊢ φ)
  /-- Not refutable -/
  not_refutable : ¬(T ⊢ ¬φ)

/-- Notation for independence -/
notation "Ind(" T ", " φ ")" => Independent T φ

/-- Independence via consistency (semantic characterization) -/
theorem independence_via_consistency (T : Theory) (φ : Sentence) :
    Con(T) → (Ind(T, φ) ↔ (Con(T + φ) ∧ Con(T + φ.neg))) := by
  intro hCon
  constructor
  · intro hInd
    constructor
    · -- Con(T + φ) follows from not refutable
      sorry  -- Would need completeness theorem
    · -- Con(T + ¬φ) follows from not provable
      sorry
  · intro ⟨hPos, hNeg⟩
    constructor
    · -- Not provable from Con(T + ¬φ)
      sorry
    · -- Not refutable from Con(T + φ)
      sorry

/-- Relative consistency -/
def RelativeConsistency (T₁ T₂ : Theory) : Prop :=
  Con(T₁) → Con(T₂)

notation "Con(" T₁ ") → Con(" T₂ ")" => RelativeConsistency T₁ T₂

end MetaMillennium.Core
