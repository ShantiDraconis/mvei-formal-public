import MillenniumRiemann.CollapseComplex

/-!
# Examples of CollapseComplex Number System

This file demonstrates basic usage of the CollapseComplex number system.
-/

namespace Collapse.Examples

open CollapseComplex

-- Example 1: Creating CollapseComplex numbers
def ex1_zero : CollapseComplex := 0
def ex1_one : CollapseComplex := 1
def ex1_real : CollapseComplex := ofReal 3.14
def ex1_complex : CollapseComplex := ofComplex ⟨2, 3⟩  -- 2 + 3i
def ex1_full : CollapseComplex := { re := 1, im := 2, indet := 0.5 }  -- 1 + 2i + 0.5I
def ex1_symbolic : CollapseComplex := Icc  -- The symbolic constant I = 0/0

-- Example 2: Basic arithmetic
def ex2_add : CollapseComplex :=
  { re := 1, im := 2, indet := 3 } + { re := 4, im := 5, indet := 6 }
  -- Result: 5 + 7i + 9I

def ex2_mul : CollapseComplex :=
  { re := 2, im := 0, indet := 3 } * { re := 0, im := 1, indet := 2 }
  -- Complex part: 2 * i = 2i
  -- Indet part: 3 * 2 = 6
  -- Result: 0 + 2i + 6I

def ex2_neg : CollapseComplex :=
  -{ re := 1, im := -2, indet := 3 }
  -- Result: -1 + 2i + (-3)I

-- Example 3: Projections
def ex3_number : CollapseComplex := { re := 3, im := 4, indet := 5 }

def ex3_complex_part : ℂ := toComplex ex3_number
  -- Result: 3 + 4i (in ℂ)

def ex3_indet_part : ℝ := toIndet ex3_number
  -- Result: 5 (in ℝ)

-- Example 4: Conjugation
def ex4_z : CollapseComplex := { re := 1, im := 2, indet := 3 }
def ex4_conj_z : CollapseComplex := conj ex4_z
  -- Result: 1 - 2i + 3I (note: indet component unchanged)

-- Verify conjugation is involutive
example : conj (conj ex4_z) = ex4_z := by
  rfl

-- Example 5: Collapse operator Δ_I
def ex5_z : CollapseComplex := { re := 7, im := 8, indet := 9 }
def ex5_collapsed : CollapseComplex := deltaI ex5_z
  -- Result: 0 + 0i + 9I (extracts only indeterminate part)

-- Verify idempotence
example : deltaI (deltaI ex5_z) = deltaI ex5_z := by
  rfl

-- Example 6: Norm
def ex6_z : CollapseComplex := { re := 3, im := 4, indet := 5 }
def ex6_norm : ℝ := normI ex6_z
  -- Result: √(3² + 4²) + |5| = √25 + 5 = 5 + 5 = 10

-- Verify norm properties
example : 0 ≤ normI ex6_z := by
  exact normI_nonneg ex6_z

example : normI 0 = 0 := by
  exact (normI_eq_zero 0).mpr rfl

-- Example 7: Ring properties in action
def ex7_a : CollapseComplex := { re := 1, im := 0, indet := 2 }
def ex7_b : CollapseComplex := { re := 3, im := 0, indet := 4 }
def ex7_c : CollapseComplex := { re := 5, im := 0, indet := 6 }

-- Distributivity: a * (b + c) = a * b + a * c
example : ex7_a * (ex7_b + ex7_c) = ex7_a * ex7_b + ex7_a * ex7_c := by
  exact left_distrib ex7_a ex7_b ex7_c

-- Commutativity: a * b = b * a
example : ex7_a * ex7_b = ex7_b * ex7_a := by
  exact mul_comm ex7_a ex7_b

-- Example 8: Working with pure complex and pure indeterminate elements
def ex8_pure_complex : CollapseComplex := ofComplex ⟨1, 1⟩  -- 1 + i + 0I
def ex8_pure_indet : CollapseComplex := { re := 0, im := 0, indet := 1 }  -- 0 + 0i + 1I

-- Pure complex elements are in the kernel of Δ_I
example : deltaI ex8_pure_complex = 0 := by
  rfl

-- Pure indeterminate elements are fixed by Δ_I
example : deltaI ex8_pure_indet = ex8_pure_indet := by
  rfl

-- Example 9: Projection homomorphism
def ex9_z1 : CollapseComplex := { re := 1, im := 2, indet := 3 }
def ex9_z2 : CollapseComplex := { re := 4, im := 5, indet := 6 }

-- π_C preserves addition
example : toComplex (ex9_z1 + ex9_z2) = toComplex ex9_z1 + toComplex ex9_z2 := by
  exact toComplex_add ex9_z1 ex9_z2

-- π_C preserves multiplication
example : toComplex (ex9_z1 * ex9_z2) = toComplex ex9_z1 * toComplex ex9_z2 := by
  exact toComplex_mul ex9_z1 ex9_z2

-- Example 10: Complex arithmetic embedded in ℂ_I
def ex10_z : CollapseComplex := ofComplex ⟨3, 4⟩  -- 3 + 4i
def ex10_w : CollapseComplex := ofComplex ⟨1, 2⟩  -- 1 + 2i

-- Multiplying complex numbers in ℂ_I gives the same result
-- (3 + 4i)(1 + 2i) = 3 + 6i + 4i + 8i² = 3 + 10i - 8 = -5 + 10i
def ex10_product : CollapseComplex := ex10_z * ex10_w

example : ex10_product.re = -5 ∧ ex10_product.im = 10 ∧ ex10_product.indet = 0 := by
  simp [ex10_product, ex10_z, ex10_w, HMul.hMul, instHMul, mul, ofComplex]
  norm_num

-- Example 11: Identity elements
example : ex1_one * ex10_z = ex10_z := by
  exact one_mul ex10_z

example : ex10_z * ex1_one = ex10_z := by
  exact mul_one ex10_z

example : ex1_zero + ex10_z = ex10_z := by
  exact zero_add ex10_z

-- Example 12: Additive inverse
def ex12_z : CollapseComplex := { re := 1, im := 2, indet := 3 }

example : ex12_z + (-ex12_z) = 0 := by
  exact add_right_neg ex12_z

example : (-ex12_z) + ex12_z = 0 := by
  exact add_left_neg ex12_z

end Collapse.Examples
