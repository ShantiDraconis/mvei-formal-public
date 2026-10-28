/-
  FormalSuite/I/Foundations.lean

  Formal foundations for the symbolic constant I
  (conceptually interpreted as "0/0", but treated here
  as an abstract element in a field with well-defined axioms).

  This file contains no `sorry` statements.

  ## Main Results

  1. `IField` typeclass defining fields with a distinguished element I
  2. Theorem: I = 1 in any IField (forced by idempotence + non-zero)
  3. Concrete model: ℝ with I = 1
  4. Uniqueness: any idempotent non-zero element equals I

  ## References

  See docs/i-foundations.md for detailed mathematical exposition.
-/

import FormalSuite.Core.Prelude

/-!
# IField Foundations

This module establishes the axiomatic foundation for the symbolic
constant `I`, which we treat as an abstract element satisfying
specific algebraic properties.

## Philosophy

While `I` is conceptually motivated by "0/0", we do not attempt to
literally define division by zero. Instead, we axiomatize the key
property: `I` is a non-zero idempotent in a field.

The remarkable consequence is that these axioms uniquely determine
`I = 1`, demonstrating the mathematical inevitability of this result.

## Main Definitions

- `IField α` : A field with distinguished element I satisfying I² = I and I ≠ 0
- `IField.I` : The distinguished element
- `IField.I_mul_self` : Axiom that I * I = I
- `IField.I_ne_zero` : Axiom that I ≠ 0

## Main Theorems

- `IField.I_eq_one` : In any IField, I = 1
- `eq_one_of_idempotent_of_ne_zero` : Any non-zero idempotent equals 1
- `eq_I_of_idempotent_of_ne_zero` : Any non-zero idempotent equals I

-/

namespace FormalSuite.IConstant

universe u

/-!
## IField Typeclass

The core definition axiomatizing the symbolic constant I.
-/

/--
`IField α` is a *field* (in the usual mathematical sense)
equipped with a distinguished element `I : α` satisfying:

* `I * I = I`  (multiplicative idempotence)
* `I ≠ 0`     (non-zero constraint)

We interpret this `I` as the formal version of the universal constant,
without imposing the literal operation `0 / 0` at the Lean level.
-/
class IField (α : Type u) extends Field α where
  /-- The distinguished symbolic constant. -/
  I : α
  /-- Idempotence: I * I = I. -/
  I_mul_self : I * I = I
  /-- Non-zero: I ≠ 0. -/
  I_ne_zero : I ≠ 0

namespace IField

variable {α : Type u} [IField α]

/-- Local notation for the universal constant `I`. -/
local notation "𝓘" => IField.I (α := α)

/-!
## Basic Properties
-/

/-- Direct lemma from the axiom: `𝓘 * 𝓘 = 𝓘`. -/
@[simp]
lemma I_mul_self' : 𝓘 * 𝓘 = (𝓘 : α) :=
  IField.I_mul_self (α := α)

/-- `𝓘 ≠ 0`. -/
lemma I_ne_zero' : (𝓘 : α) ≠ 0 :=
  IField.I_ne_zero (α := α)

/--
An element `x : α` is multiplicatively idempotent
if it satisfies `x * x = x`.
-/
def isIdempotent (x : α) : Prop :=
  x * x = x

/-- The constant `𝓘` is idempotent by definition. -/
lemma I_isIdempotent : isIdempotent (𝓘 : α) := by
  unfold isIdempotent
  exact I_mul_self'

/-!
## The Fundamental Theorem: I = 1
-/

/--
**Fundamental Theorem**: In any `IField α`, the distinguished element `𝓘`
equals `1`. That is, the combination "field + idempotence + non-zero"
forces `𝓘 = 1`.

### Proof Strategy

1. From `𝓘 * 𝓘 = 𝓘`, we derive `𝓘 * (𝓘 - 1) = 0`
2. In a field, `a * b = 0` implies `a = 0` or `b = 0`
3. Since `𝓘 ≠ 0`, we must have `𝓘 - 1 = 0`
4. Therefore `𝓘 = 1`

### Mathematical Significance

This theorem shows that the only non-zero idempotent in a field is
the multiplicative identity. This is a fundamental algebraic fact
that constrains the possible values of our symbolic constant.
-/
theorem I_eq_one : (𝓘 : α) = (1 : α) := by
  -- From I * I = I, consider I * I - I
  -- By I_mul_self, this equals I - I = 0
  have h1 : 𝓘 * 𝓘 - 𝓘 = (0 : α) := by
    simpa [I_mul_self'] using sub_self (𝓘 : α)

  -- Rewrite I * I - I as I * (I - 1) using distributivity:
  -- a*b - a = a*b - a*1 = a*(b - 1)
  have h2 : 𝓘 * (𝓘 - 1) = (0 : α) := by
    have : 𝓘 * (𝓘 - 1) = 𝓘 * 𝓘 - 𝓘 := by
      simpa [mul_sub, one_mul]
    exact this ▸ h1

  -- In a field, a * b = 0 implies a = 0 ∨ b = 0
  have h3 : 𝓘 = 0 ∨ 𝓘 - 1 = 0 := mul_eq_zero.mp h2

  -- Eliminate the case I = 0 using the axiom I_ne_zero
  cases h3 with
  | inl hI =>
      -- This branch is impossible since it contradicts I_ne_zero
      exact False.elim (I_ne_zero' hI)
  | inr hIm1 =>
      -- If I - 1 = 0, then I = 1
      exact sub_eq_zero.mp hIm1

/-- Simp-enabled version of `I_eq_one`. -/
@[simp]
lemma I_eq_one_simp : (𝓘 : α) = (1 : α) := I_eq_one

/- The reverse direction is also useful for simp. -/
/-- Reverse orientation of `I_eq_one`. Intentionally not tagged `[simp]`
to avoid a rewrite loop with `I_eq_one_simp`. -/
lemma one_eq_I_simp : (1 : α) = (𝓘 : α) := I_eq_one.symm

/-!
## General Idempotence Results

These results don't require the IField structure; they hold in any field.
-/

/--
**General Idempotence Theorem**: Any multiplicatively idempotent,
non-zero element in a field must equal `1`.

This result is independent of the IField structure and holds in
any field whatsoever.
-/
theorem eq_one_of_idempotent_of_ne_zero
    {α : Type u} [Field α] {x : α}
    (hx : x * x = x) (hx0 : x ≠ 0) :
    x = (1 : α) := by
  -- Construct a local IField instance where I = x
  classical
  let inst : IField α :=
    { toField    := ‹Field α›
      I          := x
      I_mul_self := hx
      I_ne_zero  := hx0 }

  -- Apply I_eq_one in this context
  have : x = (1 : α) := by
    let _ : IField α := inst
    simpa [IField.I, inst] using I_eq_one (α := α)

  exact this

/--
**Uniqueness of I**: If `y` is idempotent and non-zero in an IField,
then `y = 𝓘`.

The proof is immediate: both equal `1`.
-/
theorem eq_I_of_idempotent_of_ne_zero
    {y : α} (hy : y * y = y) (hy0 : y ≠ 0) :
    y = (𝓘 : α) := by
  have hy1 : y = (1 : α) := eq_one_of_idempotent_of_ne_zero (α := α) hy hy0
  calc
    y = (1 : α) := hy1
    _ = (𝓘 : α) := I_eq_one.symm

/-!
## Power Properties
-/

/-- `𝓘²= 𝓘` as a power. -/
@[simp]
lemma I_pow_two : (𝓘 : α) ^ 2 = (𝓘 : α) := by
  simpa [pow_two, I_mul_self']

/--
For any `n ≥ 1`, `𝓘ⁿ = 𝓘`.

Since `𝓘 = 1` and `1ⁿ = 1` in any field.
-/
theorem I_pow_eq_I {n : Nat} (hn : 0 < n) :
    (𝓘 : α) ^ n = (𝓘 : α) := by
  have hI1 : (𝓘 : α) = (1 : α) := I_eq_one
  calc
    (𝓘 : α) ^ n = (1 : α) ^ n := by simpa [hI1]
    _            = (1 : α)     := by simpa using (one_pow n : (1 : α) ^ n = (1 : α))
    _            = (𝓘 : α)     := by simpa [hI1]

/-- `𝓘⁰ = 1` (standard convention). -/
@[simp]
lemma I_pow_zero : (𝓘 : α) ^ 0 = (1 : α) := by
  simp [pow_zero]

/-!
## Derived Algebraic Properties
-/

/-- `𝓘 * 1 = 𝓘`. -/
@[simp]
lemma I_mul_one : 𝓘 * (1 : α) = (𝓘 : α) := by simp

/-- `1 * 𝓘 = 𝓘`. -/
@[simp]
lemma one_mul_I : (1 : α) * 𝓘 = (𝓘 : α) := by simp

/-- `𝓘 + 0 = 𝓘`. -/
@[simp]
lemma I_add_zero : 𝓘 + (0 : α) = (𝓘 : α) := by simp

/-- `𝓘 is invertible (since 𝓘 = 1). -/
lemma I_inv : (𝓘 : α)⁻¹ = (1 : α) := by
  simp [I_eq_one]

/-- `𝓘⁻¹ = 𝓘`. -/
@[simp]
lemma I_inv_eq_I : (𝓘 : α)⁻¹ = (𝓘 : α) := by
  simp [I_eq_one, I_inv]

end IField

/-!
## Concrete Model: Real Numbers

We provide a concrete instance of IField on ℝ with I = 1.
This demonstrates that the axioms are consistent (they have a model).
-/

/--
Instance of `IField ℝ`.

This guarantees that the axioms are not contradictory:
at least one explicit model exists (the real numbers with I = 1).
-/
noncomputable instance realIField : IField ℝ where
  toField := inferInstance
  I := (1 : ℝ)
  I_mul_self := by simp
  I_ne_zero := by simpa using (one_ne_zero : (1 : ℝ) ≠ 0)

/--
Verification lemma: in the real model, `I` is literally `1`.
-/
@[simp]
theorem real_I_eq_one : (IField.I (α := ℝ)) = (1 : ℝ) := by
  have : IField.I (α := ℝ) = (1 : ℝ) := IField.I_eq_one (α := ℝ)
  simpa using this

/-!
## Complex Model

Similarly, we can define IField on ℂ.
-/

/--
Instance of `IField ℂ` with I = 1.
-/
noncomputable instance complexIField : IField ℂ where
  toField := inferInstance
  I := (1 : ℂ)
  I_mul_self := by simp
  I_ne_zero := by simpa using (one_ne_zero : (1 : ℂ) ≠ 0)

/--
In the complex model, `I` equals `1` (not to be confused with `i = √(-1)`).
-/
@[simp]
theorem complex_I_eq_one : (IField.I (α := ℂ)) = (1 : ℂ) := by
  exact IField.I_eq_one (α := ℂ)

end FormalSuite.IConstant
