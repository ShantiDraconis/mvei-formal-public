/-
Copyright (c) 2025 ShantiDraconis. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ShantiDraconis

# Usage Examples for Extended Numerical Hierarchy

This file demonstrates how to use the extended numerical hierarchy
with practical examples.
-/

import Millennium.Riemann.NumericalHierarchy
import Millennium.Riemann.ExtendedZeta

namespace Millennium.Riemann.Examples

open CollapseComplex
open HorizonComplex
open RefutationComplex
open UniversalNumber

/-- Example 1: Creating numbers in each class -/
namespace BasicCreation

-- Standard complex number (represented as CollapseComplex with indet=0)
def example1_base : CollapseComplex := 
  { re := 3, im := 4, indet := 0 }

-- CollapseComplex with indeterminate component
def example1_collapse : CollapseComplex :=
  { re := 1, im := 2, indet := 0.5 }

-- HorizonComplex with infinity component
def example1_horizon : HorizonComplex :=
  { re := 1, im := 2, indet := 0.5, horizon := 100 }

-- RefutationComplex with all components
def example1_refutation : RefutationComplex :=
  { re := 1, im := 2, indet := 0.5, horizon := 100, refutation := 1 }

-- Special constants
def example1_I : CollapseComplex := CollapseComplex.I
def example1_infinity : HorizonComplex := HorizonComplex.infinity
def example1_refute : RefutationComplex := RefutationComplex.refute

end BasicCreation

/-- Example 2: Arithmetic operations -/
namespace ArithmeticOps

-- Addition in CollapseComplex
def add_collapse : CollapseComplex :=
  let z₁ : CollapseComplex := { re := 1, im := 2, indet := 0.5 }
  let z₂ : CollapseComplex := { re := 3, im := 4, indet := 1.5 }
  z₁ + z₂
  -- Result: { re := 4, im := 6, indet := 2 }

-- Multiplication in CollapseComplex (I² = I rule applies)
def mul_collapse : CollapseComplex :=
  let z₁ : CollapseComplex := { re := 2, im := 0, indet := 1 }
  let z₂ : CollapseComplex := { re := 0, im := 0, indet := 1 }
  z₁ * z₂
  -- Result has indet component from I² = I

-- Addition in HorizonComplex
def add_horizon : HorizonComplex :=
  let h₁ : HorizonComplex := { re := 1, im := 0, indet := 0, horizon := 10 }
  let h₂ : HorizonComplex := { re := 2, im := 0, indet := 0, horizon := 20 }
  h₁ + h₂
  -- Result: { re := 3, im := 0, indet := 0, horizon := 30 }

-- Multiplication with infinity (∞ · ∞ = ∞)
def mul_infinity : HorizonComplex :=
  let h₁ := HorizonComplex.infinity
  let h₂ := HorizonComplex.infinity
  h₁ * h₂
  -- infinity * infinity = infinity (idempotent)

-- Refutation oscillation (ℜ² = -ℜ)
def mul_refutation : RefutationComplex :=
  let r₁ := RefutationComplex.refute
  let r₂ := RefutationComplex.refute
  r₁ * r₂
  -- refute * refute should give -refute

end ArithmeticOps

/-- Example 3: Embeddings and promotions -/
namespace Embeddings

-- Embed CollapseComplex into HorizonComplex
def embed_to_horizon : HorizonComplex :=
  let z : CollapseComplex := { re := 3, im := 4, indet := 1 }
  HorizonComplex.ofCollapseComplex z

-- Embed HorizonComplex into RefutationComplex
def embed_to_refutation : RefutationComplex :=
  let h : HorizonComplex := { re := 1, im := 2, indet := 0.5, horizon := 100 }
  RefutationComplex.ofHorizonComplex h

-- Direct embed from CollapseComplex to RefutationComplex
def embed_direct : RefutationComplex :=
  let z : CollapseComplex := { re := 2, im := 3, indet := 0.1 }
  RefutationComplex.ofCollapseComplex z

-- Universal number promotions
def promote_example : UniversalNumber :=
  let n := UniversalNumber.collapseNum { re := 1, im := 1, indet := 0 }
  UniversalNumber.promote n  -- Promotes to HorizonNum

end Embeddings

/-- Example 4: Transition conditions -/
namespace Transitions

-- Standard transition condition
def stdCond : TransitionCondition :=
  { collapseThreshold := 0, 
    horizonThreshold := 1e10, 
    refutationThreshold := 1e20 }

-- Check if a number should transition to horizon
def check_horizon_transition : Prop :=
  let z : CollapseComplex := { re := 1e6, im := 1e6, indet := 0 }
  shouldTransitionToHorizon z stdCond

-- Large magnitude number that should transition
def large_number : CollapseComplex :=
  { re := 1e11, im := 0, indet := 0 }  -- Exceeds horizon threshold

-- Check transition for large number
theorem large_transitions : shouldTransitionToHorizon large_number stdCond := by
  unfold large_number stdCond shouldTransitionToHorizon
  left
  norm_num

end Transitions

/-- Example 5: Universal numbers and level detection -/
namespace UniversalExamples

-- Create universal numbers at different levels
def univ1 : UniversalNumber :=
  UniversalNumber.collapseNum { re := 1, im := 0, indet := 0 }

def univ2 : UniversalNumber :=
  UniversalNumber.horizonNum { re := 0, im := 0, indet := 0, horizon := 1 }

def univ3 : UniversalNumber :=
  UniversalNumber.refutationNum { re := 0, im := 0, indet := 0, horizon := 0, refutation := 1 }

-- Get levels
def level1 := UniversalNumber.level univ1  -- Returns NumericalLevel.collapse
def level2 := UniversalNumber.level univ2  -- Returns NumericalLevel.horizon
def level3 := UniversalNumber.level univ3  -- Returns NumericalLevel.refutation

-- Promote through levels
def promoted_once := UniversalNumber.promote univ1    -- collapse → horizon
def promoted_twice := UniversalNumber.promote promoted_once  -- horizon → refutation

end UniversalExamples

/-- Example 6: Working with operators -/
namespace OperatorExamples

-- Get operators for each level
def base_ops := SymbolicOperator.operatorsAtLevel NumericalLevel.base
def collapse_ops := SymbolicOperator.operatorsAtLevel NumericalLevel.collapse
def horizon_ops := SymbolicOperator.operatorsAtLevel NumericalLevel.horizon
def refutation_ops := SymbolicOperator.operatorsAtLevel NumericalLevel.refutation

-- Verify operator counts increase with level
theorem operators_increase :
  base_ops.length < collapse_ops.length := by
  unfold base_ops collapse_ops
  unfold SymbolicOperator.operatorsAtLevel
  unfold SymbolicOperator.complexOps SymbolicOperator.collapseOps
  simp

end OperatorExamples

/-- Example 7: Extended zeta function usage -/
namespace ZetaExamples

-- Evaluate zeta on CollapseComplex (using symbolic axiom)
def zeta_at_2 : CollapseComplex :=
  zetaSymbolic (CollapseComplex.ofReal 2)
  -- Should equal π²/6 by axiom

-- Universal zeta on different levels
def zeta_univ_collapse : UniversalNumber :=
  let n := UniversalNumber.collapseNum { re := 2, im := 0, indet := 0 }
  zetaUniversal n

def zeta_univ_horizon : UniversalNumber :=
  let n := UniversalNumber.horizonNum { re := 0.5, im := 14.134, indet := 0, horizon := 0 }
  zetaUniversal n  -- First Riemann zero location (approximately)

-- Critical line points
def critical_point_collapse : CollapseComplex :=
  { re := 0.5, im := 14.134725, indet := 0 }  -- First zero (approx)

def critical_point_horizon : HorizonComplex :=
  { re := 0.5, im := 14.134725, indet := 0, horizon := 0 }

def is_on_critical_line : Prop :=
  criticalLine critical_point_collapse

theorem critical_point_is_critical : is_on_critical_line := by
  unfold is_on_critical_line critical_point_collapse criticalLine
  norm_num

end ZetaExamples

/-- Example 8: Proof refutation dynamics -/
namespace RefutationDynamics

-- A statement that's true in collapse domain
def statement_in_collapse (s : CollapseComplex) : Prop :=
  s.re ≥ 0 ∨ s.re < 0  -- Tautology in standard logic

-- At refutation boundary, examine behavior
def at_boundary : RefutationComplex :=
  let s : CollapseComplex := { re := 1e25, im := 0, indet := 0 }
  RefutationComplex.ofCollapseComplex s

-- The refutation component captures boundary behavior
def refutation_active : RefutationComplex :=
  RefutationComplex.refute + at_boundary

end RefutationDynamics

/-- Example 9: Complex calculations -/
namespace ComplexCalculations

-- Compute (1 + I) * (1 + I) where I is indeterminate
def square_one_plus_I : CollapseComplex :=
  let z := CollapseComplex.one + CollapseComplex.I
  z * z
  -- Using I² = I: (1 + I)² = 1 + 2I + I² = 1 + 2I + I = 1 + 3I

-- Compute (1 + ∞) * 2 where ∞ is infinity
def two_times_one_plus_infinity : HorizonComplex :=
  let h := HorizonComplex.one + HorizonComplex.infinity
  h * (HorizonComplex.one + HorizonComplex.one)
  -- ∞ dominates: result should have large horizon component

-- Compute ℜ + (-ℜ) where ℜ is refutation
def refutation_cancellation : RefutationComplex :=
  RefutationComplex.refute + RefutationComplex.neg RefutationComplex.refute
  -- Should be zero (self-canceling)

end ComplexCalculations

/-- Example 10: Practical scenarios -/
namespace PracticalScenarios

-- Scenario: Evaluating a divergent series
-- As the series diverges, transition to horizon complex
def divergent_series_limit : HorizonComplex :=
  -- Symbolically represents lim_{n→∞} sum of 1/k
  HorizonComplex.infinity

-- Scenario: Handling 0/0 indeterminate form
def handle_indeterminate : CollapseComplex :=
  CollapseComplex.I  -- The 0/0 constant

-- Scenario: Detecting proof failure at boundary
def proof_at_boundary (condition : ℝ) : UniversalNumber :=
  if condition > 1e20 then
    UniversalNumber.refutationNum RefutationComplex.refute
  else
    UniversalNumber.collapseNum CollapseComplex.zero

end PracticalScenarios

end Millennium.Riemann.Examples
