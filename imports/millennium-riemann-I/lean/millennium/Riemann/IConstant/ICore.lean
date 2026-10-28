/-
Copyright (c) 2025 ShantiDraconis. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ShantiDraconis

# The I-Constant (Universe-0-0) Core Definitions

The I-constant 𝕀 = 0/0 is the fundamental indeterminate element
that extends complex numbers to CollapseComplex.
-/

import Millennium.Riemann.CollapseComplex

namespace Millennium.Riemann.IConstant

open CollapseComplex

/-- The I-constant: 𝕀 = 0/0 (Universe-0-0) -/
def 𝕀 : CollapseComplex := I

/-- 𝕀 has zero real part -/
theorem I_real_zero : 𝕀.re = 0 := by simp [𝕀, I]

/-- 𝕀 has zero imaginary part -/
theorem I_imag_zero : 𝕀.im = 0 := by simp [𝕀, I]

/-- 𝕀 has unit indeterminate part -/
theorem I_indet_one : 𝕀.indet = 1 := by simp [𝕀, I]

/-- Idempotent property: 𝕀² = 𝕀 -/
theorem I_squared : 𝕀 * 𝕀 = 𝕀 := by
  simp [𝕀, I, mul, Mul.mul]
  constructor
  · ring
  constructor
  · ring
  · ring

/-- 𝕀 · 0 = 0 (absorption with zero) -/
theorem I_times_zero : 𝕀 * zero = zero := by
  simp [𝕀, I, zero, mul, Mul.mul, Zero.zero]

/-- 0 · 𝕀 = 0 -/
theorem zero_times_I : zero * 𝕀 = zero := by
  simp [𝕀, I, zero, mul, Mul.mul, Zero.zero]

/-- 𝕀 · 1 = 𝕀 -/
theorem I_times_one : 𝕀 * one = 𝕀 := by
  simp [𝕀, I, one, mul, Mul.mul, One.one]

/-- 1 · 𝕀 = 𝕀 -/
theorem one_times_I : one * 𝕀 = 𝕀 := by
  simp [𝕀, I, one, mul, Mul.mul, One.one]

/-- 𝕀 ≠ 0 -/
theorem I_ne_zero : 𝕀 ≠ zero := by
  intro h
  have h1 : 𝕀.indet = zero.indet := by rw [h]
  simp [𝕀, I, zero, Zero.zero] at h1

/-- 𝕀 ≠ 1 -/
theorem I_ne_one : 𝕀 ≠ one := by
  intro h
  have h1 : 𝕀.re = one.re := by rw [h]
  simp [𝕀, I, one, One.one] at h1

/-- The I-component extracts the indeterminate part -/
def I_component (z : CollapseComplex) : ℝ := z.indet

/-- Pure I-number: form c·𝕀 -/
def isPureI (z : CollapseComplex) : Prop :=
  z.re = 0 ∧ z.im = 0

/-- 𝕀 is pure I -/
theorem I_is_pure : isPureI 𝕀 := by
  simp [isPureI, 𝕀, I]

/-- Scalar multiplication with 𝕀 -/
def scaleI (r : ℝ) : CollapseComplex :=
  { re := 0, im := 0, indet := r }

/-- scaleI 1 = 𝕀 -/
theorem scaleI_one : scaleI 1 = 𝕀 := by
  simp [scaleI, 𝕀, I]

/-- scaleI 0 = 0 -/
theorem scaleI_zero : scaleI 0 = zero := by
  simp [scaleI, zero, Zero.zero]

end Millennium.Riemann.IConstant
