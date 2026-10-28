import MillenniumRiemann

/-!
# Verification Tests for CollapseComplex

This file contains comprehensive tests verifying that the CollapseComplex
implementation satisfies all the required mathematical properties.
-/

namespace Collapse.Tests

open CollapseComplex

/-! ### Test 1: Basic Structure -/

-- Test: Equality works correctly
example : ({ re := 1, im := 2, indet := 3 } : CollapseComplex) = 
          { re := 1, im := 2, indet := 3 } := rfl

example : ({ re := 1, im := 2, indet := 3 } : CollapseComplex) ≠ 
          { re := 1, im := 2, indet := 4 } := by
  intro h
  cases h
  
/-! ### Test 2: Additive Group Axioms -/

section AdditiveGroup

variable (a b c : CollapseComplex)

-- Closure
example : ∃ d, a + b = d := ⟨a + b, rfl⟩

-- Associativity  
example : (a + b) + c = a + (b + c) := add_assoc a b c

-- Identity
example : 0 + a = a := zero_add a
example : a + 0 = a := add_zero a

-- Inverse
example : a + (-a) = 0 := add_right_neg a
example : (-a) + a = 0 := add_left_neg a

-- Commutativity
example : a + b = b + a := add_comm a b

end AdditiveGroup

/-! ### Test 3: Multiplicative Properties -/

section Multiplication

variable (a b c : CollapseComplex)

-- Closure
example : ∃ d, a * b = d := ⟨a * b, rfl⟩

-- Associativity
example : (a * b) * c = a * (b * c) := mul_assoc a b c

-- Identity
example : 1 * a = a := one_mul a
example : a * 1 = a := mul_one a

-- Commutativity
example : a * b = b * a := mul_comm a b

-- Distributivity
example : a * (b + c) = a * b + a * c := left_distrib a b c
example : (a + b) * c = a * c + b * c := right_distrib a b c

end Multiplication

/-! ### Test 4: Ring Axioms -/

section RingAxioms

variable (a b c : CollapseComplex)

-- Zero is absorbing
example : 0 * a = 0 := zero_mul a
example : a * 0 = 0 := mul_zero a

-- Negation distributes over multiplication
example : (-a) * b = -(a * b) := by
  rw [← neg_mul]

example : a * (-b) = -(a * b) := by
  rw [← mul_neg]

-- Subtraction definition
example : a - b = a + (-b) := by
  rfl

end RingAxioms

/-! ### Test 5: Conjugation Properties -/

section Conjugation

variable (z w : CollapseComplex)

-- Conjugation is additive
example : conj (z + w) = conj z + conj w := conj_add z w

-- Conjugation is multiplicative
example : conj (z * w) = conj z * conj w := conj_mul z w

-- Conjugation is involutive
example : conj (conj z) = z := conj_conj z

-- Conjugation of zero
example : conj 0 = 0 := by
  simp [conj, Zero.zero, instZero]

-- Conjugation of one
example : conj 1 = 1 := by
  simp [conj, One.one, instOne]

end Conjugation

/-! ### Test 6: Projection Properties -/

section Projections

variable (z w : CollapseComplex)

-- π_C is a ring homomorphism
example : toComplex (z + w) = toComplex z + toComplex w := 
  toComplex_add z w

example : toComplex (z * w) = toComplex z * toComplex w := 
  toComplex_mul z w

example : toComplex 0 = 0 := by
  simp [toComplex, Zero.zero, instZero]

-- π_I is additive
example : toIndet (z + w) = toIndet z + toIndet w := by
  simp [toIndet, HAdd.hAdd, instHAdd, add]

end Projections

/-! ### Test 7: Collapse Operator Δ_I -/

section CollapseOperator

variable (z w : CollapseComplex)

-- Linearity
example : deltaI (z + w) = deltaI z + deltaI w := deltaI_add z w

-- Idempotence
example : deltaI (deltaI z) = deltaI z := deltaI_idem z

-- Kernel property
example : deltaI { re := 1, im := 2, indet := 0 } = 0 := by
  simp [deltaI, Zero.zero, instZero]

-- Image property
example : deltaI { re := 1, im := 2, indet := 3 } = { re := 0, im := 0, indet := 3 } := by
  simp [deltaI]

end CollapseOperator

/-! ### Test 8: Norm Properties -/

section NormProperties

variable (z w : CollapseComplex)

-- Non-negativity
example : 0 ≤ normI z := normI_nonneg z

-- Definiteness
example : normI 0 = 0 := (normI_eq_zero 0).mpr rfl

-- Triangle inequality
example : normI (z + w) ≤ normI z + normI w := normI_add_le z w

-- Specific norm calculations
example : normI { re := 3, im := 4, indet := 0 } = 5 := by
  simp [normI]
  norm_num

example : normI { re := 0, im := 0, indet := 5 } = 5 := by
  simp [normI]
  norm_num

end NormProperties

/-! ### Test 9: Embedding Properties -/

section Embeddings

-- Real embedding preserves operations
example (r s : ℝ) : ofReal (r + s) = ofReal r + ofReal s := by
  simp [ofReal, HAdd.hAdd, instHAdd, add]

example (r s : ℝ) : ofReal (r * s) = ofReal r * ofReal s := by
  simp [ofReal, HMul.hMul, instHMul, mul]

-- Complex embedding preserves operations
example (c d : ℂ) : ofComplex (c + d) = ofComplex c + ofComplex d := by
  simp [ofComplex, HAdd.hAdd, instHAdd, add, Complex.add_re, Complex.add_im]

example (c d : ℂ) : ofComplex (c * d) = ofComplex c * ofComplex d := by
  simp [ofComplex, HMul.hMul, instHMul, mul, Complex.mul_re, Complex.mul_im]

end Embeddings

/-! ### Test 10: Special Element Properties -/

section SpecialElements

-- Symbolic I
example : Icc = { re := 0, im := 0, indet := 1 } := rfl

-- Icc in kernel of toComplex
example : toComplex Icc = 0 := by
  simp [Icc, toComplex]

-- Adding I
example : { re := 1, im := 2, indet := 0 } + Icc = { re := 1, im := 2, indet := 1 } := by
  simp [Icc, HAdd.hAdd, instHAdd, add]

end SpecialElements

/-! ### Test 11: Complex Arithmetic Compatibility -/

section ComplexCompatibility

-- Standard complex multiplication should work when embedded
def z1 : CollapseComplex := ofComplex ⟨3, 4⟩
def z2 : CollapseComplex := ofComplex ⟨1, 2⟩

-- (3 + 4i)(1 + 2i) = 3 + 6i + 4i + 8i² = 3 + 10i - 8 = -5 + 10i
example : z1 * z2 = { re := -5, im := 10, indet := 0 } := by
  simp [z1, z2, ofComplex, HMul.hMul, instHMul, mul]
  norm_num

end ComplexCompatibility

/-! ### Test 12: Decomposition -/

section Decomposition

-- Any CollapseComplex can be decomposed
example (z : CollapseComplex) : 
    z = ofComplex (toComplex z) + deltaI z := by
  ext <;> simp [ofComplex, toComplex, deltaI, HAdd.hAdd, instHAdd, add]

-- Pure complex + pure indeterminate
example : { re := 1, im := 2, indet := 3 } = 
          ofComplex ⟨1, 2⟩ + { re := 0, im := 0, indet := 3 } := by
  simp [ofComplex, HAdd.hAdd, instHAdd, add]

end Decomposition

/-! ### Test 13: Practical Calculations -/

section Calculations

-- Test a practical computation
def compute1 : CollapseComplex :=
  ({ re := 1, im := 1, indet := 2 } + { re := 2, im := 3, indet := 4 }) * 
  { re := 1, im := 0, indet := 1 }

example : compute1 = { re := 3, im := 4, indet := 6 } := by
  simp [compute1, HAdd.hAdd, instHAdd, add, HMul.hMul, instHMul, mul]

-- Test conjugation in computation
def compute2 : CollapseComplex :=
  conj ({ re := 1, im := 2, indet := 3 } + { re := 4, im := 5, indet := 6 })

example : compute2 = { re := 5, im := -7, indet := 9 } := by
  simp [compute2, conj, HAdd.hAdd, instHAdd, add]

end Calculations

end Collapse.Tests
