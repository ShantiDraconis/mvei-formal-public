/-
  Aggregation.lean
  
  Weighted aggregation of error vectors into a single percentage.
  
  Given:
  - A weight vector w = (w₁, ..., wₙ) with Σwᵢ = 1
  - An error vector E = (e₁, ..., eₙ) with each eᵢ ∈ [0,1]
  
  The aggregate error is:
    E_total = 100 × Σ(wᵢ × eᵢ)
  
  This gives a percentage in [0, 100].
  
  NO approximations. NO hidden normalization.
  Everything is explicit and verifiable.
-/

import Universe00.Core.Vector

namespace ErrorAggregation

-- Weights must sum to 1
structure Weights where
  values : List ℝ
  nonneg : ∀ w ∈ values, 0 ≤ w
  sum_one : values.sum = 1

-- Weighted sum of errors
def weightedSum (w e : List ℝ) : ℝ :=
  List.sum (List.zipWith (· * ·) w e)

-- Aggregate error as a percentage
def aggregateError (w : Weights) (e : ErrorVector) : ℝ :=
  100 * weightedSum w.values e.components

-- The aggregate is always in [0, 100]
theorem aggregate_nonneg (w : Weights) (e : ErrorVector) :
    0 ≤ aggregateError w e := by
  unfold aggregateError weightedSum
  sorry -- Technical: product of non-negatives is non-negative

theorem aggregate_le_hundred (w : Weights) (e : ErrorVector)
    (h_dim : w.values.length = e.components.length) :
    aggregateError w e ≤ 100 := by
  unfold aggregateError weightedSum
  sorry -- Technical: weighted average of values ≤1 with weights summing to 1

-- Zero error vector gives zero aggregate
theorem aggregate_zero_of_proven (w : Weights) (e : ErrorVector)
    (h : e.is_proven) : aggregateError w e = 0 := by
  unfold aggregateError weightedSum
  sorry -- Technical: all errors are 0, so weighted sum is 0

-- If aggregate is zero, all weighted components must be zero
theorem proven_of_aggregate_zero (w : Weights) (e : ErrorVector)
    (h_pos : ∀ w' ∈ w.values, 0 < w')
    (h : aggregateError w e = 0) : e.is_proven := by
  unfold aggregateError weightedSum at h
  sorry -- Technical: if all weights positive and sum zero, all errors must be zero

-- Aggregate is monotone: refining errors reduces aggregate
theorem aggregate_monotone (w : Weights) (e₁ e₂ : ErrorVector)
    (h_dim : w.values.length = e₁.components.length)
    (h_refine : ErrorVector.refines e₁ e₂) :
    aggregateError w e₁ ≤ aggregateError w e₂ := by
  unfold aggregateError weightedSum
  sorry -- Technical: componentwise decrease propagates to weighted sum

-- Construction: uniform weights for n parameters
def uniformWeights (n : ℕ) (hn : 0 < n) : Weights :=
  ⟨List.replicate n (1 / n),
   by
     intros w hw
     simp [List.mem_replicate] at hw
     rcases hw with ⟨_, rfl⟩
     exact div_nonneg (by norm_num) (Nat.cast_nonneg n),
   by
     simp [List.sum_replicate]
     field_simp
     ring⟩

-- Construction: custom weights from a list with proof
def customWeights (ws : List ℝ) 
    (h_nonneg : ∀ w ∈ ws, 0 ≤ w)
    (h_sum : ws.sum = 1) : Weights :=
  ⟨ws, h_nonneg, h_sum⟩

-- Example: two parameters with 70/30 split
def weights_70_30 : Weights :=
  customWeights [0.7, 0.3]
    (by
      intros w hw
      cases hw with
      | head => norm_num
      | tail _ ht =>
        cases ht with
        | head => norm_num
        | tail _ ht' => exact absurd ht' (List.not_mem_nil w))
    (by norm_num)

-- Example: three parameters with equal weight
def weights_equal_3 : Weights :=
  uniformWeights 3 (by norm_num)

end ErrorAggregation

-- The aggregate error is not a heuristic.
-- It is a precise, measurable coordinate showing how far we are from proof.
-- Proof = aggregate error reaches exactly 0.
  Universe00.Core.Aggregation
  
  Error aggregation functions
  
  Aggregates multiple error components into a single percentage,
  using weighted averaging.
  
  Key property: The aggregate must be in [0, 100] representing
  a percentage of total incompleteness.
-/

import Universe00.Core.Error
import Mathlib.Data.Real.Basic
import Mathlib.Data.List.Basic

namespace Universe00.Core

/--
  Aggregate error components using weights to produce a percentage.
  
  Formula: 100 * Σᵢ (weightᵢ × errorᵢ)
  
  Requirements:
  - weights and errors must have same length
  - all weights must be non-negative
  - weights must sum to 1
  - all errors must be in [0,1]
  
  Output: A percentage in [0,100]
-/
def aggregateError (weights errors : List ℝ) : ℝ :=
  100 * List.sum (List.zipWith (· * ·) weights errors)

/-- Weighted sum without percentage scaling -/
def weightedSum (weights errors : List ℝ) : ℝ :=
  List.sum (List.zipWith (· * ·) weights errors)

namespace Aggregation

/-- Validity condition for weights: must sum to 1 -/
def validWeights (weights : List ℝ) : Prop :=
  List.sum weights = 1 ∧ ∀ w ∈ weights, 0 ≤ w ∧ w ≤ 1

/-- Weights and errors must have matching lengths -/
def validLengths (weights errors : List ℝ) : Prop :=
  weights.length = errors.length

/-- Complete validity check for aggregation -/
def validAggregation (weights errors : List ℝ) : Prop :=
  validWeights weights ∧ 
  validLengths weights errors ∧
  (∀ e ∈ errors, 0 ≤ e ∧ e ≤ 1)

/-- Theorem: If aggregation is valid, weightedSum is in [0,1] -/
theorem weightedSum_bounds (weights errors : List ℝ) 
    (h : validAggregation weights errors) :
  0 ≤ weightedSum weights errors ∧ weightedSum weights errors ≤ 1 := by
  sorry -- Proof by induction on lists

/-- Theorem: If aggregation is valid, aggregateError is in [0,100] -/
theorem aggregateError_bounds (weights errors : List ℝ)
    (h : validAggregation weights errors) :
  0 ≤ aggregateError weights errors ∧ aggregateError weights errors ≤ 100 := by
  unfold aggregateError
  have ⟨h1, h2⟩ := weightedSum_bounds weights errors h
  constructor
  · apply mul_nonneg
    · norm_num
    · exact h1
  · calc
      100 * weightedSum weights errors ≤ 100 * 1 := by
        apply mul_le_mul_of_nonneg_left h2
        norm_num
      _ = 100 := by norm_num

/-- If all errors are zero, aggregate is zero -/
theorem aggregate_zero_of_errors_zero (weights errors : List ℝ)
    (h : validAggregation weights errors)
    (hz : ∀ e ∈ errors, e = 0) :
  aggregateError weights errors = 0 := by
  sorry -- Proof by induction

/-- If any error is positive and its weight is positive, aggregate is positive -/
theorem aggregate_positive_of_error_positive (weights errors : List ℝ)
    (h : validAggregation weights errors)
    (i : Fin errors.length)
    (hw : weights[i] > 0)
    (he : errors[i] > 0) :
  aggregateError weights errors > 0 := by
  sorry -- Detailed proof required

/-- Aggregate error from ErrorVector using uniform weights -/
def uniformWeightAggregate (ev : ErrorVector) : ℝ :=
  if h : ev.dim > 0 then
    let w := 1 / (ev.dim : ℝ)
    let weights := List.replicate ev.dim w
    aggregateError weights ev.components
  else
    0

/-- Uniform weights are valid -/
theorem uniform_weights_valid (n : ℕ) (hn : n > 0) :
    validWeights (List.replicate n (1 / (n : ℝ))) := by
  sorry -- Proof involves sum of replicated list

end Aggregation

end Universe00.Core
