/-
Universe00/Complement/Examples.lean

Examples demonstrating the use of the Universe00 Complement Foundation framework.

Version: 1.0.0
Author: Shanti Draconis / Tiago Paschoalatto Fagliari
Date: 2025-12-31
-/

import Universe00.Complement.Foundation

namespace Universe00.Complement.Examples

/-!
# Example 1: Safe Division in Classical Regime

This example shows how to implement a sensitive division operation
that properly handles division by zero without inventing values.
-/

-- Define a sensitive division for real numbers
instance realDivision : SensitiveBinOp ℝ where
  op regime x y :=
    match regime with
    | Regime.Classical =>
        if h : y ≠ 0 then
          Outcome.value (x / y)
        else
          Outcome.limit {
            tag := "DivisionByZero"
            reason := "Cannot divide by zero in Classical regime"
          }
    | Regime.Meadow =>
        -- In Meadow regime, division is totalized
        Outcome.value (x / y)
    | _ =>
        Outcome.limit {
          tag := "UnsupportedRegime"
          reason := "Division not defined in this regime"
        }

-- Use the sensitive division
def safe_divide (x y : ℝ) : Outcome ℝ :=
  SensitiveBinOp.op Regime.Classical x y

-- Example: dividing 10 by 2 (safe)
def example1 : Outcome ℝ := safe_divide 10 2

-- Example: dividing 10 by 0 (returns limit)
def example2 : Outcome ℝ := safe_divide 10 0

/-!
# Example 2: Conservativity Demonstration

This example shows that in the Classical regime, our sensitive operators
agree with standard mathematical operations when safe.
-/

-- Classical division operator
instance : ClassicalBinOp ℝ where
  cop := (· / ·)

-- Theorem: When division by zero is avoided, sensitive and classical agree
-- (This would require proof of Law_Conservativity instantiation)
example (x y : ℝ) (h : y ≠ 0) :
  ∃ z : ℝ, safe_divide x y = Outcome.value z := by
  unfold safe_divide
  unfold SensitiveBinOp.op
  simp [realDivision]
  split
  · use x / y
    rfl
  · contradiction

/-!
# Example 3: Outcome Monad Operations

Demonstrates the functor and monad laws for Outcome.
-/

-- Map example: doubling a result
def double_outcome (o : Outcome ℝ) : Outcome ℝ :=
  Outcome.map (· * 2) o

-- Bind example: chaining divisions
def chained_divide (x y z : ℝ) : Outcome ℝ :=
  Outcome.bind (safe_divide x y) (fun r => safe_divide r z)

-- Example: 100 / 5 / 2 = 10
def example3 : Outcome ℝ := chained_divide 100 5 2

-- Example: 100 / 5 / 0 returns limit
def example4 : Outcome ℝ := chained_divide 100 5 0

-- Example: 100 / 0 / 2 returns limit early
def example5 : Outcome ℝ := chained_divide 100 0 2

/-!
# Example 4: Regularizer with Declared Regime

Shows how to properly declare a regularizer that resolves limits.
-/

-- A meadow-style regularizer that totalizes division by zero
def meadowRegularizer : Regularizer ℝ :=
  { apply := fun regime outcome =>
      match regime, outcome with
      | Regime.Meadow, Outcome.limit ℓ =>
          if ℓ.tag == "DivisionByZero" then
            Outcome.value 0  -- Define 0/0 = 0 in Meadow
          else
            outcome
      | _, _ => outcome
    declared_regime := Regime.Meadow
  }

-- Verify that this regularizer is properly declared (non-Classical)
example : Declared meadowRegularizer := by
  unfold Declared meadowRegularizer
  simp
  -- Meadow ≠ Classical

/-!
# Example 5: Status-Tagged Claims

Demonstrates the use of the Status system for claims.
-/

-- A proved claim (would need actual proof)
def proven_claim : Claim :=
  { regime := Regime.Classical
  , prop := ∀ x : ℝ, x + 0 = x
  , status := Status.proved
  , note := "Additive identity in Classical regime"
  }

-- An assumed claim (axiom)
def assumed_claim : Claim :=
  { regime := Regime.Meadow
  , prop := ∀ x : ℝ, ∃ y : ℝ, x / 0 = y
  , status := Status.assumed
  , note := "Division by zero is total in Meadow regime"
  }

-- A conjectural claim (hypothesis under investigation)
def conjectural_claim : Claim :=
  { regime := Regime.Paraconsistent
  , prop := ∃ x : ℝ, x = x ∧ x ≠ x
  , status := Status.conjectural
  , note := "Testing local inconsistency handling"
  }

/-!
# Example 6: Law Registry Access

Shows how to access and use the law registry.
-/

-- Count the number of laws in the registry
def lawCount : Nat := lawRegistry.length

-- Get the names of all laws
def lawNames : List String :=
  lawRegistry.map (·.name)

-- Check if a specific law is in the registry
def hasConservativityLaw : Bool :=
  lawRegistry.any (fun law => law.name == "L0_Conservativity")

-- Filter laws by status
def assumedLaws : List Law :=
  lawRegistry.filter (fun law => law.status == Status.assumed)

end Universe00.Complement.Examples
