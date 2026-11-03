/-
  Universe00/Examples/Division.lean
  
  Example 1: Division by Zero
  
  Demonstrates three approaches:
  1. Classical: Undefined (avoided)
  2. Meadow: Regularized (0/0 = 0)
  3. Universe 00: Explicit limit state
  
  This is one of the three canonical examples that
  "make the system exist."
-/

import Universe00.Core.Outcome
import Universe00.Core.Regime
import Universe00.Core.LimitState
import Universe00.Laws.Preservation

namespace Universe00.Examples

open Universe00.Core

/-
  Classical Division (undefined for zero denominator)
  This is modeled as a partial function
-/
def div_classical (a b : ℚ) (h : b ≠ 0) : ℚ := a / b

/-
  Meadow Division (totalized, 0/0 = 0)
  Following Bergstra et al.'s meadow algebra
-/
def div_meadow (a b : ℚ) : ℚ :=
  if b = 0 then 0 else a / b

/-
  Universe 00 Division (explicit limit state)
  This is the Complement Layer approach
-/
def div_complement (a b : ℚ) : Outcome ℚ :=
  if b = 0 then
    Outcome.limit LimitState.divisionByZero
  else
    Outcome.value (a / b)

/-
  Examples of each approach
-/

-- Classical: requires proof that denominator is non-zero
example : div_classical 6 2 (by norm_num) = 3 := by norm_num

-- Meadow: total but returns 0 for undefined
example : div_meadow 6 0 = 0 := by simp [div_meadow]
example : div_meadow 6 2 = 3 := by simp [div_meadow]; norm_num

-- Complement: explicit limit state
example : div_complement 6 2 = Outcome.value 3 := by 
  simp [div_complement]
  norm_num

example : div_complement 6 0 = Outcome.limit LimitState.divisionByZero := by
  simp [div_complement]

/-
  Key properties of Universe 00 division
-/

-- Division preserves classical behavior when denominator is non-zero
theorem div_complement_classical (a b : ℚ) (h : b ≠ 0) :
  div_complement a b = Outcome.value (a / b) := by
  simp [div_complement]
  split
  case inl hz => contradiction
  case inr _ => rfl

-- Division returns limit for zero denominator
theorem div_complement_limit (a : ℚ) :
  div_complement a 0 = Outcome.limit LimitState.divisionByZero := by
  simp [div_complement]

-- Complement division is composable
def safe_division_chain (a b c : ℚ) : Outcome ℚ := do
  let x ← div_complement a b
  let y ← div_complement x c
  return y

-- Example: chain halts at first limit
example : safe_division_chain 12 0 3 = Outcome.limit LimitState.divisionByZero := by
  simp [safe_division_chain, div_complement]

/-
  Comparison of approaches
-/

structure DivisionComparison where
  classical_result : Option ℚ           -- None if undefined
  meadow_result : ℚ                     -- Always defined
  complement_result : Outcome ℚ         -- Explicit about limits

def compare_divisions (a b : ℚ) : DivisionComparison :=
  { classical_result := if b = 0 then none else some (a / b)
  , meadow_result := div_meadow a b
  , complement_result := div_complement a b }

-- Example comparisons
example : 
  let comp := compare_divisions 6 2
  comp.classical_result = some 3 ∧ 
  comp.meadow_result = 3 ∧ 
  comp.complement_result = Outcome.value 3 := by
  simp [compare_divisions, div_meadow, div_complement]
  norm_num

example : 
  let comp := compare_divisions 6 0
  comp.classical_result = none ∧ 
  comp.meadow_result = 0 ∧ 
  comp.complement_result = Outcome.limit LimitState.divisionByZero := by
  simp [compare_divisions, div_meadow, div_complement]

/-
  Philosophical remarks
-/

/-
  Classical mathematics: 0/0 is undefined (hand-wave)
  
  Problem: No formal object for the undefined state.
  Must use exceptions, partial functions, or proof obligations.
-/

/-
  Meadow algebra: 0/0 = 0 (regularize)
  
  Advantage: Total function.
  Problem: Forces specific value, loses information.
-/

/-
  Complement Layer: 0/0 = limit("div", "0/0 boundary")
  
  Advantages:
  - Explicit formal object for the boundary
  - Composable (monadic operations)
  - Preserves information about WHY limit occurred
  - No forced regularization
  
  Trade-off: Must work with Outcome type.
-/

end Universe00.Examples
