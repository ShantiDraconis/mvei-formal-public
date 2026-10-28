/-!
  # PvsNP.Basics - Basic Definitions for P vs NP Formalization
  
  This module defines the fundamental building blocks for the P vs NP
  theorem program:
  
  - Binary alphabet Σ = {0, 1}
  - Words (binary strings)  
  - Languages as predicates over words
  - Basic operations on languages (complement, union, intersection)
  - Numerical constants for complexity bounds
  
  ## Design Philosophy
  
  We use **predicates** (Word → Prop) for languages rather than sets,
  as this aligns better with the computational interpretation:
  a language is the characteristic function of a decision problem.
  
  ## Axiom Status
  
  This file contains only definitions, no axioms or admitted proofs.
-/

namespace PvsNP

/-! ## Alphabet and Words -/

/-- The binary alphabet Σ = {0, 1}, represented as Bool for simplicity -/
abbrev Alphabet := Bool

/-- A word is a finite sequence of alphabet symbols (binary string) -/
abbrev Word := List Alphabet

/-- A language is a predicate over words (characteristic function) -/
def Language := Word → Prop

/-- The length of a word -/
def wordLength (w : Word) : Nat := w.length

/-- The empty word ε -/
def emptyWord : Word := []

/-- Concatenation of words -/
def wordConcat (w₁ w₂ : Word) : Word := w₁ ++ w₂

/-! ## Language Membership and Operations -/

/-- Language membership: w ∈ L -/
def inLanguage (w : Word) (L : Language) : Prop := L w

notation:50 w " ∈ᴸ " L => inLanguage w L

/-- The empty language ∅ (no words accepted) -/
def emptyLanguage : Language := fun _ => False

/-- The universal language Σ* (all words accepted) -/
def universalLanguage : Language := fun _ => True

/-- Language complement: w ∈ L̄ ↔ w ∉ L -/
def complement (L : Language) : Language := fun w => ¬ L w

notation:max "∁" L => complement L

/-- Language union: w ∈ (L₁ ∪ L₂) ↔ w ∈ L₁ ∨ w ∈ L₂ -/
def union (L₁ L₂ : Language) : Language := fun w => L₁ w ∨ L₂ w

infixl:65 " ∪ᴸ " => union

/-- Language intersection: w ∈ (L₁ ∩ L₂) ↔ w ∈ L₁ ∧ w ∈ L₂ -/
def intersection (L₁ L₂ : Language) : Language := fun w => L₁ w ∧ L₂ w

infixl:70 " ∩ᴸ " => intersection

/-- Language subset relation: L₁ ⊆ L₂ ↔ ∀w, w ∈ L₁ → w ∈ L₂ -/
def languageSubset (L₁ L₂ : Language) : Prop := ∀ w, L₁ w → L₂ w

infixl:50 " ⊆ᴸ " => languageSubset

/-- Language equality: L₁ = L₂ ↔ L₁ ⊆ L₂ ∧ L₂ ⊆ L₁ -/
def languageEq (L₁ L₂ : Language) : Prop := (L₁ ⊆ᴸ L₂) ∧ (L₂ ⊆ᴸ L₁)

/-! ## Basic Language Theorems -/

/-- Empty language is subset of any language -/
theorem empty_subset (L : Language) : emptyLanguage ⊆ᴸ L := by
  intro w h
  exact False.elim h

/-- Any language is subset of universal language -/
theorem subset_universal (L : Language) : L ⊆ᴸ universalLanguage := by
  intro w _
  exact True.intro

/-- Double complement is identity -/
theorem complement_complement (L : Language) : ∁(∁L) = L := by
  funext w
  simp [complement]

/-! ## Numerical Constants -/

/-- Numerical constants used in complexity bounds -/
structure ComplexityConstants where
  /-- Polynomial degree k ≥ 1 -/
  polyDegree : Nat
  polyDegree_pos : polyDegree ≥ 1
  /-- Multiplicative constant c ≥ 1 -/
  multConstant : Nat
  multConstant_pos : multConstant ≥ 1

/-- Default complexity constants (k=1, c=1) -/
def defaultComplexityConstants : ComplexityConstants := {
  polyDegree := 1,
  polyDegree_pos := le_refl 1,
  multConstant := 1,
  multConstant_pos := le_refl 1
}
  
/-- Error probability ε ∈ (0, 1) for average-case complexity -/
structure ErrorProbability where
  value : Rat
  pos : 0 < value
  lt_one : value < 1

/-- Standard error probability 1/3 for BPP -/
def standardError : ErrorProbability := {
  value := 1/3,
  pos := by norm_num,
  lt_one := by norm_num
}

end PvsNP
