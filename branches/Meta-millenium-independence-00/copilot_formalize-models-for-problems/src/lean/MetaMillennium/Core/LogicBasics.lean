/-
  MetaMillennium.Core.LogicBasics

  Basic logical definitions and helper lemmas.
  This module provides foundational logical concepts.
-/

namespace MetaMillennium

/-- A proposition that is always true -/
def trivialTrue : Prop := True

/-- A proposition that is always false -/
def trivialFalse : Prop := False

/-- Logical implication helper -/
def implies (P Q : Prop) : Prop := P → Q

/-- Logical equivalence helper -/
def iff' (P Q : Prop) : Prop := P ↔ Q

/-- Negation of a proposition -/
def neg (P : Prop) : Prop := ¬P

/-- Conjunction of propositions -/
def conj (P Q : Prop) : Prop := P ∧ Q

/-- Disjunction of propositions -/
def disj (P Q : Prop) : Prop := P ∨ Q

/-- Basic lemma: double negation introduction -/
theorem double_neg_intro (P : Prop) : P → ¬¬P := fun hp hnp => hnp hp

/-- Basic lemma: modus ponens -/
theorem modus_ponens (P Q : Prop) (hpq : P → Q) (hp : P) : Q := hpq hp

/-- Basic lemma: conjunction elimination left -/
theorem conj_elim_left (P Q : Prop) (hpq : P ∧ Q) : P := hpq.left

/-- Basic lemma: conjunction elimination right -/
theorem conj_elim_right (P Q : Prop) (hpq : P ∧ Q) : Q := hpq.right

/-- Basic lemma: conjunction introduction -/
theorem conj_intro (P Q : Prop) (hp : P) (hq : Q) : P ∧ Q := ⟨hp, hq⟩

end MetaMillennium
