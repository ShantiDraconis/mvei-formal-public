/-!
# Basics - Fundamental Definitions for P vs NP Formalization

This module provides the core mathematical foundations for the 
Symbolic Separation Program theorem, following classical complexity theory.

## Contents
- Binary alphabet Σ = {0, 1}
- Words (binary strings)
- Languages as predicates over words
- Language operations (complement, union, intersection)
- Numerical constants for complexity bounds

## Axiom Registry Reference
- A14: Definition of Languages

## Mathematical Foundation
All definitions follow Arora-Barak (2009) and standard complexity theory.
-/

namespace PvsNP

/-! ## Section 1: Alphabet and Words -/

/-- The binary alphabet Σ = {0, 1}, represented as Bool -/
abbrev Alphabet := Bool

/-- Symbol zero (0) -/
def zero : Alphabet := false

/-- Symbol one (1) -/
def one : Alphabet := true

/-- A word is a finite sequence of alphabet symbols (binary string) -/
abbrev Word := List Alphabet

/-- The length of a word |w| -/
def wordLength (w : Word) : Nat := w.length

/-- The empty word ε -/
def emptyWord : Word := []

/-- Concatenation of words w₁ · w₂ -/
def wordConcat (w₁ w₂ : Word) : Word := w₁ ++ w₂

infixl:65 " ⬝ " => wordConcat

/-! ## Section 2: Language Definition (Axiom A14) -/

/-- A language L ⊆ Σ* is a predicate over words (characteristic function) -/
def Language := Word → Prop

instance : Membership Word Language where
  mem w L := L w

/-- Language membership notation: w ∈ L -/
def inLanguage (w : Word) (L : Language) : Prop := L w

notation:50 w " ∈ᴸ " L => inLanguage w L

/-! ## Section 3: Special Languages -/

/-- The empty language ∅ (contains no words) -/
def emptyLanguage : Language := fun _ => False

/-- The universal language Σ* (contains all words) -/
def universalLanguage : Language := fun _ => True

/-- The singleton language {ε} containing only the empty word -/
def epsilonLanguage : Language := fun w => w = emptyWord

/-! ## Section 4: Language Operations -/

/-- Language complement: L̄ = {w : w ∉ L} -/
def complement (L : Language) : Language := fun w => ¬ L w

notation:max "∁" L => complement L

/-- Language union: L₁ ∪ L₂ = {w : w ∈ L₁ ∨ w ∈ L₂} -/
def union (L₁ L₂ : Language) : Language := fun w => L₁ w ∨ L₂ w

infixl:65 " ∪ᴸ " => union

/-- Language intersection: L₁ ∩ L₂ = {w : w ∈ L₁ ∧ w ∈ L₂} -/
def intersection (L₁ L₂ : Language) : Language := fun w => L₁ w ∧ L₂ w

infixl:70 " ∩ᴸ " => intersection

/-- Language subset relation: L₁ ⊆ L₂ -/
def languageSubset (L₁ L₂ : Language) : Prop := ∀ w, L₁ w → L₂ w

infixl:50 " ⊆ᴸ " => languageSubset

/-- Language strict subset relation: L₁ ⊂ L₂ -/
def languageStrictSubset (L₁ L₂ : Language) : Prop := 
  (L₁ ⊆ᴸ L₂) ∧ ∃ w, L₂ w ∧ ¬ L₁ w

infixl:50 " ⊂ᴸ " => languageStrictSubset

/-- Language equality via extensionality: L₁ = L₂ ↔ ∀w, w ∈ L₁ ↔ w ∈ L₂ -/
def languageEq (L₁ L₂ : Language) : Prop := ∀ w, L₁ w ↔ L₂ w

notation:50 L₁ " =ᴸ " L₂ => languageEq L₁ L₂

/-! ## Section 5: Fundamental Language Theorems -/

/-- Empty language is subset of any language -/
theorem empty_subset (L : Language) : emptyLanguage ⊆ᴸ L := by
  intro w h
  exact False.elim h

/-- Any language is subset of universal language -/
theorem subset_universal (L : Language) : L ⊆ᴸ universalLanguage := by
  intro w _
  exact True.intro

/-- Language subset is reflexive -/
theorem subset_refl (L : Language) : L ⊆ᴸ L := by
  intro w h
  exact h

/-- Language subset is transitive -/
theorem subset_trans (L₁ L₂ L₃ : Language) : 
    L₁ ⊆ᴸ L₂ → L₂ ⊆ᴸ L₃ → L₁ ⊆ᴸ L₃ := by
  intro h12 h23 w h1
  exact h23 w (h12 w h1)

/-- Language subset is antisymmetric (gives equality) -/
theorem subset_antisymm (L₁ L₂ : Language) : 
    L₁ ⊆ᴸ L₂ → L₂ ⊆ᴸ L₁ → L₁ =ᴸ L₂ := by
  intro h12 h21 w
  exact ⟨h12 w, h21 w⟩

/-- Double complement is identity -/
theorem complement_complement (L : Language) : ∁(∁L) =ᴸ L := by
  intro w
  constructor
  · intro h
    by_contra hNot
    exact h hNot
  · intro h hNot
    exact hNot h

/-- De Morgan's law for union -/
theorem demorgan_union (L₁ L₂ : Language) : 
    ∁(L₁ ∪ᴸ L₂) =ᴸ (∁L₁) ∩ᴸ (∁L₂) := by
  intro w
  constructor
  · intro h
    constructor
    · intro h1; exact h (Or.inl h1)
    · intro h2; exact h (Or.inr h2)
  · intro ⟨hn1, hn2⟩ hOr
    cases hOr with
    | inl h1 => exact hn1 h1
    | inr h2 => exact hn2 h2

/-- De Morgan's law for intersection -/
theorem demorgan_inter (L₁ L₂ : Language) : 
    ∁(L₁ ∩ᴸ L₂) =ᴸ (∁L₁) ∪ᴸ (∁L₂) := by
  intro w
  constructor
  · intro h
    by_cases h1 : L₁ w
    · by_cases h2 : L₂ w
      · exact False.elim (h ⟨h1, h2⟩)
      · exact Or.inr h2
    · exact Or.inl h1
  · intro hOr ⟨h1, h2⟩
    cases hOr with
    | inl hn1 => exact hn1 h1
    | inr hn2 => exact hn2 h2

/-- Union is commutative -/
theorem union_comm (L₁ L₂ : Language) : (L₁ ∪ᴸ L₂) =ᴸ (L₂ ∪ᴸ L₁) := by
  intro w
  constructor
  · intro h; cases h with
    | inl h1 => exact Or.inr h1
    | inr h2 => exact Or.inl h2
  · intro h; cases h with
    | inl h2 => exact Or.inr h2
    | inr h1 => exact Or.inl h1

/-- Intersection is commutative -/
theorem inter_comm (L₁ L₂ : Language) : (L₁ ∩ᴸ L₂) =ᴸ (L₂ ∩ᴸ L₁) := by
  intro w
  constructor
  · intro ⟨h1, h2⟩; exact ⟨h2, h1⟩
  · intro ⟨h2, h1⟩; exact ⟨h1, h2⟩

/-- Union is associative -/
theorem union_assoc (L₁ L₂ L₃ : Language) : 
    ((L₁ ∪ᴸ L₂) ∪ᴸ L₃) =ᴸ (L₁ ∪ᴸ (L₂ ∪ᴸ L₃)) := by
  intro w
  constructor
  · intro h
    cases h with
    | inl h12 => 
      cases h12 with
      | inl h1 => exact Or.inl h1
      | inr h2 => exact Or.inr (Or.inl h2)
    | inr h3 => exact Or.inr (Or.inr h3)
  · intro h
    cases h with
    | inl h1 => exact Or.inl (Or.inl h1)
    | inr h23 =>
      cases h23 with
      | inl h2 => exact Or.inl (Or.inr h2)
      | inr h3 => exact Or.inr h3

/-- Intersection distributes over union -/
theorem inter_union_distrib (L₁ L₂ L₃ : Language) : 
    (L₁ ∩ᴸ (L₂ ∪ᴸ L₃)) =ᴸ ((L₁ ∩ᴸ L₂) ∪ᴸ (L₁ ∩ᴸ L₃)) := by
  intro w
  constructor
  · intro ⟨h1, h23⟩
    cases h23 with
    | inl h2 => exact Or.inl ⟨h1, h2⟩
    | inr h3 => exact Or.inr ⟨h1, h3⟩
  · intro h
    cases h with
    | inl ⟨h1, h2⟩ => exact ⟨h1, Or.inl h2⟩
    | inr ⟨h1, h3⟩ => exact ⟨h1, Or.inr h3⟩

/-! ## Section 6: Numerical Constants -/

/-- Complexity constants record -/
structure ComplexityConstants where
  /-- Polynomial degree k ≥ 1 -/
  polyDegree : Nat
  polyDegree_pos : polyDegree ≥ 1
  /-- Multiplicative constant c ≥ 1 -/
  multConstant : Nat
  multConstant_pos : multConstant ≥ 1

/-- Default complexity constants (k=1, c=1) -/
def defaultConstants : ComplexityConstants := {
  polyDegree := 1,
  polyDegree_pos := Nat.le_refl 1,
  multConstant := 1,
  multConstant_pos := Nat.le_refl 1
}

/-- Polynomial function n^k -/
def poly (k : Nat) (n : Nat) : Nat := n ^ k

/-- Linear function n -/
def linear (n : Nat) : Nat := n

/-- Quadratic function n² -/
def quadratic (n : Nat) : Nat := n ^ 2

/-- Exponential function 2^n -/
def exp2 (n : Nat) : Nat := 2 ^ n

/-- Double exponential 2^(2^n) -/
def exp2_2 (n : Nat) : Nat := 2 ^ (2 ^ n)

/-! ## Section 7: Error Probability for Randomized Complexity -/

/-- Error probability ε ∈ (0, 1) represented as rational -/
structure ErrorProbability where
  numerator : Nat
  denominator : Nat
  denom_pos : denominator > 0
  lt_one : numerator < denominator

/-- Standard BPP error probability 1/3 -/
def standardError : ErrorProbability := {
  numerator := 1,
  denominator := 3,
  denom_pos := by decide,
  lt_one := by decide
}

/-- Inverse polynomial error 1/n -/
def inversePolyError (n : Nat) (hn : n > 0) : ErrorProbability := {
  numerator := 1,
  denominator := n,
  denom_pos := hn,
  lt_one := Nat.one_lt_iff_ne_one.mpr (fun h => by omega)
}

end PvsNP
