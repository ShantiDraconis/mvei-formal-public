/-
  Examples and Tests for Distinction Axioms
  
  Demonstrates the use of distinction axioms in practice.
  
  Version: 1.0.0
  Author: Shanti Draconis / Tiago Paschoalatto Fagliari
  Date: 2025-12-09
-/

import Universe00.Foundations.DistinctionAxioms

namespace Universe00.Foundations.Distinction.Examples

/-!
# Examples of Distinction Axioms in Use

This file provides concrete examples demonstrating the distinction axioms.
-/

/-! ## Example 1: Verifying the Fundamental Axiom -/

example (i : IConst) : DeltaSpace.ofI i ≠ DeltaSpace.ofComplex 1 :=
  i_ne_one i

/-! ## Example 2: Reflexivity Holds -/

example : DeltaSpace.ofComplex (1 : ℂ) = DeltaSpace.ofComplex 1 :=
  one_equals_one

example (i : IConst) : DeltaSpace.ofI i = DeltaSpace.ofI i :=
  i_equals_i i

/-! ## Example 3: Approximation at Different Scales -/

-- At ε = 0.01
example : complexApproximation.approx_eq 0.01 1 1 := by
  exact one_approx_one_at_all_scales 0.01 (by norm_num)

-- At ε = 0.000001
example : complexApproximation.approx_eq 0.000001 1 1 := by
  exact one_approx_one_at_all_scales 0.000001 (by norm_num)

/-! ## Example 4: Paradoxical Statements are False -/

example (i : IConst) : ¬(DeltaSpace.ofI i ≠ DeltaSpace.ofI i) :=
  i_not_ne_itself i

example : ¬(DeltaSpace.ofComplex (1 : ℂ) ≠ DeltaSpace.ofComplex 1) :=
  fun h => h rfl

/-! ## Example 5: Framework Consistency -/

-- The framework is consistent across all levels
example (i : IConst) : 
  (DeltaSpace.ofI i ≠ DeltaSpace.ofComplex 1) ∧
  (DeltaSpace.ofI i = DeltaSpace.ofI i) :=
  ⟨i_ne_one i, rfl⟩

/-! ## Example 6: Interpreting Complex Statements -/

-- The statement "(I ≠ I ∧ 1 ≠ 1) ∨ (1 ≈ 1)" evaluates to true
-- because the approximation clause is always true
example (i : IConst) (ε : ℝ) (hε : ε > 0) :
  (DeltaSpace.ofI i ≠ DeltaSpace.ofI i ∧ 
   DeltaSpace.ofComplex (1 : ℂ) ≠ DeltaSpace.ofComplex 1) ∨
  complexApproximation.approx_eq ε 1 1 :=
  statement_interpretation i ε hε

/-! ## Example 7: Using Different Truth Values -/

-- Demonstrate the four truth values
def example_absolute_true : TruthValue := TruthValue.absolute_true
def example_approximate : TruthValue := TruthValue.approximate
def example_distinct : TruthValue := TruthValue.distinct
def example_paradoxical : TruthValue := TruthValue.paradoxical

-- Evaluate them
example (i : IConst) : evaluateDistinction i example_absolute_true = true := rfl
example (i : IConst) : evaluateDistinction i example_approximate = true := rfl
example (i : IConst) : evaluateDistinction i example_distinct = true := rfl
example (i : IConst) : evaluateDistinction i example_paradoxical = false := rfl

/-! ## Example 8: Master Reconciliation in Practice -/

-- Show that all four aspects coexist harmoniously
example (i : IConst) :
  (DeltaSpace.ofI i ≠ DeltaSpace.ofComplex 1) ∧
  (DeltaSpace.ofComplex (1 : ℂ) = DeltaSpace.ofComplex 1) ∧
  (∀ ε > 0, complexApproximation.approx_eq ε 1 1) ∧
  ¬(DeltaSpace.ofI i ≠ DeltaSpace.ofI i) :=
  master_reconciliation i

/-! ## Example 9: Practical Application to I ≠ 0 -/

-- I is also distinct from 0 (by the general axiom)
example (i : IConst) : DeltaSpace.ofI i ≠ DeltaSpace.ofComplex 0 :=
  i_ne_complex i 0

/-! ## Example 10: Consistency Check -/

-- The framework remains consistent
example (i : IConst) :
  (DeltaSpace.ofI i ≠ DeltaSpace.ofComplex 1) ∧
  (DeltaSpace.ofI i = DeltaSpace.ofI i) ∧
  ¬(DeltaSpace.ofI i ≠ DeltaSpace.ofI i) := by
  constructor
  · exact i_ne_one i
  constructor
  · rfl
  · exact i_not_ne_itself i

end Universe00.Foundations.Distinction.Examples
