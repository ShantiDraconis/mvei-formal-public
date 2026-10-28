/-
  FormalSuite/Core/Prelude.lean

  Common definitions, notations, and helper lemmas used throughout
  the FormalSuite project. This module re-exports standard Mathlib
  modules and provides unified notation conventions.

  This file contains no `sorry` statements.
-/

import Mathlib.Data.Real.Basic
import Mathlib.Data.Complex.Basic
import Mathlib.Algebra.Field.Basic
import Mathlib.Algebra.Order.Field.Basic
import Mathlib.Analysis.SpecialFunctions.Pow.Real
import Mathlib.Analysis.Normed.Field.Basic
import Mathlib.Tactic

/-!
# FormalSuite Prelude

This module provides common definitions and re-exports used throughout
the FormalSuite formalization project.

## Main Definitions

- `FormalSuite.Universe`: Type universe conventions
- `FormalSuite.Notation`: Custom notation for the project
- `FormalSuite.Helpers`: Small utility lemmas

## Notation Conventions

- `𝓘` : The symbolic constant I (defined in IField)
- `‖·‖` : Norms (from Mathlib)
- `⟨·, ·⟩` : Inner products

-/

namespace FormalSuite

/-!
## Universe Conventions

We use universe polymorphism where possible to maximize generality.
-/

universe u v w

/-!
## Type Aliases

These provide semantic clarity for different mathematical contexts.
-/

/-- Real numbers (from Mathlib). -/
abbrev ℝ' := ℝ

/-- Complex numbers (from Mathlib). -/
abbrev ℂ' := ℂ

/-!
## Utility Functions
-/

/-- Square of a value in a monoid. -/
def square {α : Type*} [Monoid α] (x : α) : α := x * x

@[simp]
lemma square_def {α : Type*} [Monoid α] (x : α) : square x = x * x := rfl

/-- Cube of a value in a monoid. -/
def cube {α : Type*} [Monoid α] (x : α) : α := x * x * x

@[simp]
lemma cube_def {α : Type*} [Monoid α] (x : α) : cube x = x * x * x := rfl

/-!
## Field Lemmas

Utility lemmas for field operations that complement Mathlib.
-/

section FieldLemmas

variable {F : Type*} [Field F]

/--
In a field, if `a * b = a` and `a ≠ 0`, then `b = 1`.

This is a simple cancellation law.
-/
lemma eq_one_of_mul_eq_self {a b : F} (ha : a ≠ 0) (h : a * b = a) : b = 1 := by
  have : a * b = a * 1 := by simp [h]
  exact mul_left_cancel₀ ha this

/--
In a field, if `a * a = a` and `a ≠ 0`, then `a = 1`.

This is the core idempotence result.
-/
lemma eq_one_of_sq_eq_self {a : F} (ha : a ≠ 0) (h : a * a = a) : a = 1 := by
  exact eq_one_of_mul_eq_self ha h

end FieldLemmas

/-!
## Real Number Lemmas
-/

section RealLemmas

/-- Positive reals are non-zero. -/
lemma pos_ne_zero {x : ℝ} (hx : 0 < x) : x ≠ 0 := ne_of_gt hx

/-- The square of a non-zero real is positive. -/
lemma sq_pos_of_ne_zero {x : ℝ} (hx : x ≠ 0) : 0 < x * x := by
  have : 0 < x^2 := sq_pos_iff.mpr hx
  simpa [sq] using this

end RealLemmas

/-!
## Complex Number Lemmas
-/

section ComplexLemmas

/-- Re(1) = 1. -/
@[simp]
lemma Complex.re_one' : Complex.re 1 = 1 := Complex.one_re

/-- Im(1) = 0. -/
@[simp]
lemma Complex.im_one' : Complex.im 1 = 0 := Complex.one_im

/-- The critical line s = 1/2 + it for real t. -/
noncomputable def criticalLine (t : ℝ) : ℂ := ⟨1/2, t⟩

@[simp]
lemma criticalLine_re (t : ℝ) : (criticalLine t).re = 1/2 := rfl

@[simp]
lemma criticalLine_im (t : ℝ) : (criticalLine t).im = t := rfl

end ComplexLemmas

/-!
## Positivity and Bounds
-/

section Bounds

variable {α : Type*} [LinearOrderedField α]

/-- Helper for positive lower bounds. -/
def BoundedBelow (f : α → α) (c : α) : Prop :=
  ∀ x, c ≤ f x

/-- Helper for bounded functions. -/
def Bounded (f : α → α) (c : α) : Prop :=
  ∀ x, |f x| ≤ c

end Bounds

end FormalSuite
