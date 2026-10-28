/-
INumber: Extended numeric class with collapse state.

This module defines an extended number system for handling
anomalous zeros as singularities.
-/

namespace Riemann.INumber

open Complex

/-- Extended number class with regular and collapse states -/
inductive INumber
  | regular (z : ℂ) : INumber
  | collapse : INumber
  deriving DecidableEq, Repr

open INumber

/-- Convert a complex number to INumber -/
def ofComplex (z : ℂ) : INumber := regular z

/-- Placeholder for the I constant -/
def I_num : INumber := ofComplex (0 : ℂ)

/-- The one element -/
def one_num : INumber := ofComplex (1 : ℂ)

/-- The zero element -/
def zero_num : INumber := ofComplex (0 : ℂ)

/-- The imaginary unit -/
def i_num : INumber := ofComplex (Complex.I)

/-- Check if an INumber is in collapse state -/
def isCollapsed : INumber → Prop
  | regular _ => False
  | collapse   => True

/-- Addition on INumber -/
def add : INumber → INumber → INumber
  | regular z₁, regular z₂ => regular (z₁ + z₂)
  | collapse, _ => collapse
  | _, collapse => collapse

/-- Multiplication on INumber -/
def mul : INumber → INumber → INumber
  | regular z₁, regular z₂ => regular (z₁ * z₂)
  | collapse, _ => collapse
  | _, collapse => collapse

/-- Negation on INumber -/
def neg : INumber → INumber
  | regular z => regular (-z)
  | collapse => collapse

/-- Subtraction on INumber -/
def sub (x y : INumber) : INumber := add x (neg y)

/-- Division on INumber (collapses on division by zero) -/
def div : INumber → INumber → INumber
  | regular z₁, regular z₂ => if z₂ = 0 then collapse else regular (z₁ / z₂)
  | collapse, _ => collapse
  | _, collapse => collapse

/-- Complex conjugate -/
def conj : INumber → INumber
  | regular z => regular (Complex.conj z)
  | collapse => collapse

/-- Real part (returns option) -/
def realPart : INumber → Option ℝ
  | regular z => some z.re
  | collapse => none

/-- Imaginary part (returns option) -/
def imagPart : INumber → Option ℝ
  | regular z => some z.im
  | collapse => none

/-- Collapse propagates through addition -/
theorem collapse_add_left (x : INumber) : add collapse x = collapse := by
  cases x <;> rfl

theorem collapse_add_right (x : INumber) : add x collapse = collapse := by
  cases x <;> rfl

/-- Collapse propagates through multiplication -/
theorem collapse_mul_left (x : INumber) : mul collapse x = collapse := by
  cases x <;> rfl

theorem collapse_mul_right (x : INumber) : mul x collapse = collapse := by
  cases x <;> rfl

/-- Addition is commutative for regular numbers -/
theorem add_comm (z₁ z₂ : ℂ) : 
  add (regular z₁) (regular z₂) = add (regular z₂) (regular z₁) := by
  simp [add, Complex.add_comm]

/-- Multiplication is commutative for regular numbers -/
theorem mul_comm (z₁ z₂ : ℂ) : 
  mul (regular z₁) (regular z₂) = mul (regular z₂) (regular z₁) := by
  simp [mul, Complex.mul_comm]

/-- Zero is additive identity for regular numbers -/
theorem add_zero (z : ℂ) : add (regular z) zero_num = regular z := by
  simp [add, zero_num, ofComplex]
  ring

/-- One is multiplicative identity for regular numbers -/
theorem mul_one (z : ℂ) : mul (regular z) one_num = regular z := by
  simp [mul, one_num, ofComplex]
  ring

end Riemann.INumber
