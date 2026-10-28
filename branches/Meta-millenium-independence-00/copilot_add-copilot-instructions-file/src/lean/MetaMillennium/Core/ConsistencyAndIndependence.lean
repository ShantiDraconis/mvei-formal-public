/-
  MetaMillennium.Core.ConsistencyAndIndependence

  Copilot: define consistency and independence in terms of the Provable relation.

  - `Consistent T` should mean: no sentence φ is both provable and refutable.
  - `Independent T φ` should mean: not provable and not refutable.
  - Keep the definitions abstract, we only care about the interface.
-/

import MetaMillennium.Core.TheoryAndModel

namespace MetaMillennium

open MetaMillennium

/-- A theory T is consistent if there is no sentence φ such that
    both φ and ¬φ are provable from T.
    
    Note: We use ∼φ as the abstract negation of φ. -/
def Consistent (T : Theory) [Provable T] : Prop :=
  ¬ ∃ (φ : Sentence T), (T ⊢ φ) ∧ (T ⊢ ∼φ)

/-- A sentence φ is independent of theory T if neither φ nor ¬φ
    is provable from T. -/
def Independent (T : Theory) [Provable T] (φ : Sentence T) : Prop :=
  ¬ (T ⊢ φ) ∧ ¬ (T ⊢ ∼φ)

/-- Alternative formulation: φ is undecidable in T -/
def Undecidable (T : Theory) [Provable T] (φ : Sentence T) : Prop :=
  Independent T φ

/-- A theory T is complete if every sentence is decidable
    (either provable or refutable) -/
def Complete (T : Theory) [Provable T] : Prop :=
  ∀ (φ : Sentence T), (T ⊢ φ) ∨ (T ⊢ ∼φ)

/-- An incomplete theory has at least one independent sentence -/
def Incomplete (T : Theory) [Provable T] : Prop :=
  ∃ (φ : Sentence T), Independent T φ

/-- Theorem: Independence implies the theory is not complete for that sentence -/
theorem independent_implies_not_decidable 
    {T : Theory} [Provable T] {φ : Sentence T}
    (h : Independent T φ) : ¬((T ⊢ φ) ∨ (T ⊢ ∼φ)) := by
  intro hdec
  cases hdec with
  | inl hphi => exact h.left hphi
  | inr hneg => exact h.right hneg

/-- Relative consistency: if T is consistent, then T + φ is consistent -/
def RelativelyConsistent (T : Theory) [Provable T] (_ : Sentence T) : Prop :=
  Consistent T → Consistent T  -- Placeholder: proper extension needed

end MetaMillennium
