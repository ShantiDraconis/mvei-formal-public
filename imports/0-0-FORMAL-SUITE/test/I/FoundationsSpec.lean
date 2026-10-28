/-
  test/I/FoundationsSpec.lean

  Test specifications for the IField foundations.
  Verifies core theorems and model instances.

  This file contains no `sorry` statements.
-/

import FormalSuite.I.Foundations

/-!
# IField Foundations Tests

This module provides test cases for the IField foundations,
verifying:
- The fundamental theorem I = 1
- The real number model
- Idempotence properties
-/

namespace FormalSuite.Test.IFoundations

open FormalSuite.IConstant

/-!
## Real Model Tests
-/

/-- Test: In the real model, I equals 1. -/
example : IField.I (α := ℝ) = (1 : ℝ) := by
  exact IField.I_eq_one

/-- Test: Real I is non-zero. -/
example : IField.I (α := ℝ) ≠ 0 := by
  exact IField.I_ne_zero'

/-- Test: Real I is idempotent. -/
example : (IField.I (α := ℝ)) * (IField.I (α := ℝ)) = IField.I (α := ℝ) := by
  exact IField.I_mul_self'

/-!
## Complex Model Tests
-/

/-- Test: In the complex model, I equals 1. -/
example : IField.I (α := ℂ) = (1 : ℂ) := by
  exact IField.I_eq_one

/-- Test: Complex I is non-zero. -/
example : IField.I (α := ℂ) ≠ 0 := by
  exact IField.I_ne_zero'

/-!
## General Property Tests
-/

/-- Test: Any non-zero idempotent equals 1 (in ℝ). -/
example {x : ℝ} (hx : x * x = x) (hx0 : x ≠ 0) : x = 1 := by
  exact eq_one_of_idempotent_of_ne_zero hx hx0

/-- Test: I^2 = I. -/
example : (IField.I (α := ℝ)) ^ 2 = IField.I (α := ℝ) := by
  exact IField.I_pow_two

/-- Test: I^n = I for n ≥ 1. -/
example : (IField.I (α := ℝ)) ^ 3 = IField.I (α := ℝ) := by
  exact IField.I_pow_eq_I (by norm_num : 0 < 3)

/-- Test: I inverse equals I (since I = 1). -/
example : (IField.I (α := ℝ))⁻¹ = IField.I (α := ℝ) := by
  exact IField.I_inv_eq_I

/-!
## Simp Tests
-/

/-- Test: simp can simplify I to 1. -/
example : (IField.I (α := ℝ)) + 1 = 2 := by
  simp [IField.I_eq_one]

/-- Test: simp handles I in expressions. -/
example : (IField.I (α := ℝ)) * (IField.I (α := ℝ)) + 1 = 2 := by
  simp

end FormalSuite.Test.IFoundations
