/-
  Sanity Tests for PvsNP Formalization
  
  These tests verify that basic definitions work correctly.
-/

import PvsNP.Basics
import PvsNP.SAT_NPCompleteness

namespace PvsNP.Tests

-- Test: Empty word has length 0
example : Word.empty.length = 0 := rfl

-- Test: A simple SAT formula
def testFormula : CNFFormula :=
  [[Literal.pos 0, Literal.neg 1],  -- (x₀ ∨ ¬x₁)
   [Literal.neg 0, Literal.pos 1]]  -- (¬x₀ ∨ x₁)

-- Test: An assignment that satisfies the formula
def testAssignment : Assignment := fun i =>
  match i with
  | 0 => true
  | 1 => true
  | _ => false

-- The formula should be satisfied by this assignment
example : testFormula.satisfied testAssignment = true := by
  native_decide

end PvsNP.Tests
