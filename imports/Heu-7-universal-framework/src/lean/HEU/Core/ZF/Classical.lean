/-
  HEU-7 Universal Framework
  Classical Logic Module

  This module establishes classical logical principles used
  throughout the HEU-7 framework, including excluded middle,
  double negation elimination, and classical choice principles.

  Designed for automatic expansion by AI assistants.
-/

import HEU.Core.ZF.Axioms

namespace HEU.Core.ZF

/-- Law of Excluded Middle -/
axiom em : ∀ (P : Prop), P ∨ ¬P

/-- Double Negation Elimination -/
theorem dne : ∀ (P : Prop), ¬¬P → P := by
  intro P hnn
  cases em P with
  | inl hp => exact hp
  | inr hn => exact absurd hn hnn

/-- Proof by contradiction -/
theorem byContradiction {P : Prop} (h : ¬P → False) : P := by
  cases em P with
  | inl hp => exact hp
  | inr hn => exact absurd hn h

/-- De Morgan's laws (classical versions) -/
theorem deMorgan1 {P Q : Prop} : ¬(P ∧ Q) ↔ ¬P ∨ ¬Q := by
  constructor
  · intro h
    cases em P with
    | inl hp =>
      cases em Q with
      | inl hq => exact absurd ⟨hp, hq⟩ h
      | inr hnq => exact Or.inr hnq
    | inr hnp => exact Or.inl hnp
  · intro h hpq
    cases h with
    | inl hnp => exact hnp hpq.1
    | inr hnq => exact hnq hpq.2

theorem deMorgan2 {P Q : Prop} : ¬(P ∨ Q) ↔ ¬P ∧ ¬Q := by
  constructor
  · intro h
    constructor
    · intro hp; exact h (Or.inl hp)
    · intro hq; exact h (Or.inr hq)
  · intro ⟨hnp, hnq⟩ hpq
    cases hpq with
    | inl hp => exact hnp hp
    | inr hq => exact hnq hq

/-- Classical implication equivalence -/
theorem classicalImpl {P Q : Prop} : (P → Q) ↔ (¬P ∨ Q) := by
  constructor
  · intro h
    cases em P with
    | inl hp => exact Or.inr (h hp)
    | inr hnp => exact Or.inl hnp
  · intro h hp
    cases h with
    | inl hnp => exact absurd hp hnp
    | inr hq => exact hq

/-- Peirce's law -/
theorem peirce {P Q : Prop} : ((P → Q) → P) → P := by
  intro h
  cases em P with
  | inl hp => exact hp
  | inr hnp => exact h (fun hp => absurd hp hnp)

/-- Decidable equality for Prop (classical) -/
noncomputable instance : DecidableEq Prop := fun P Q =>
  if h : P ↔ Q then isTrue (propext h) else isFalse (fun heq => h (heq ▸ Iff.rfl))

end HEU.Core.ZF
