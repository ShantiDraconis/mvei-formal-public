/-
# Problem Ledger

The central object tracking a mathematical problem's state.

A ledger contains:
- Named parameters with their values and errors
- Weights for aggregating errors
- The error vector
- Total aggregated error percentage
- Current status

All components must be consistent.
-/

import Universe00.Core.Parameter
import Universe00.Core.Error
import Universe00.Core.Aggregation
import Universe00.Core.Status

/-- A complete ledger for a mathematical problem -/
structure ProblemLedger where
  /-- Name of the problem -/
  name : String
  /-- List of measured parameters -/
  parameters : List (MeasuredParameter ℝ)
  /-- Weights for aggregating parameter errors (must sum to 1) -/
  weights : List ℝ
  /-- The error vector extracted from parameters -/
  errorVector : ErrorVector
  /-- Total aggregated error as percentage in [0,100] -/
  totalError : ℝ
  /-- Current status of the problem -/
  status : ProblemStatus
  /-- Consistency: number of parameters = number of weights -/
  param_weight_consistent : parameters.length = weights.length
  /-- Consistency: weights are valid (non-negative, sum to 1) -/
  weights_valid : ErrorAggregation.validWeights weights
  /-- Consistency: error vector length = parameter count -/
  error_vector_consistent : errorVector.length = parameters.length
  /-- Consistency: error vector components match parameter errors -/
  error_components_match : errorVector.components = parameters.map (·.error)
  /-- Consistency: total error = aggregated error -/
  total_error_is_aggregate : totalError = aggregateError weights errorVector.components
  /-- Consistency: status matches error vector -/
  status_consistent : status = ProblemStatus.fromErrorVector errorVector

namespace ProblemLedger

/-- Create a simple ledger with equal weights -/
def withEqualWeights (name : String) (params : List (MeasuredParameter ℝ))
    (hn : params.length > 0) : ProblemLedger :=
  let weights := ErrorAggregation.equalWeights params.length hn
  let errors := params.map (·.error)
  let ev : ErrorVector := {
    components := errors,
    valid := by
      intro e he
      simp [errors] at he
      sorry -- Requires proof that parameter errors satisfy bounds
  }
  let total := aggregateError weights errors
  let status := ProblemStatus.fromErrorVector ev
  { name := name
  , parameters := params
  , weights := weights
  , errorVector := ev
  , totalError := total
  , status := status
  , param_weight_consistent := by simp [weights, ErrorAggregation.equalWeights]
  , weights_valid := ErrorAggregation.equalWeights_valid params.length hn
  , error_vector_consistent := by simp [ev, errors]
  , error_components_match := by rfl
  , total_error_is_aggregate := by rfl
  , status_consistent := by rfl }

/-- Get the number of parameters in the ledger -/
def parameterCount (ledger : ProblemLedger) : ℕ :=
  ledger.parameters.length

/-- Check if the problem is solved (status = proved) -/
def isSolved (ledger : ProblemLedger) : Bool :=
  ledger.status.isProved

/-- Check if the problem is refuted -/
def isRefuted (ledger : ProblemLedger) : Bool :=
  ledger.status.isRefuted

/-- Check if the problem is open -/
def isOpen (ledger : ProblemLedger) : Bool :=
  ledger.status.isOpen

/-- Get summary statistics -/
def summary (ledger : ProblemLedger) : String :=
  s!"Problem: {ledger.name}\n" ++
  s!"Parameters: {ledger.parameterCount}\n" ++
  s!"Total Error: {ledger.totalError}%\n" ++
  s!"Status: {ledger.status}\n" ++
  s!"Max Error: {ledger.errorVector.max}\n" ++
  s!"Min Error: {ledger.errorVector.min}"

/-- Update a single parameter's error (maintaining consistency) -/
def updateParameterError (ledger : ProblemLedger) (idx : ℕ)
    (newError : ℝ) (hbounds : 0 ≤ newError ∧ newError ≤ 1)
    (hidx : idx < ledger.parameterCount) : ProblemLedger :=
  sorry -- Requires rebuilding all consistency proofs

/-- Theorem: a solved ledger has zero total error -/
theorem solved_means_zero_error (ledger : ProblemLedger) :
    ledger.isSolved → ledger.totalError = 0 := by
  sorry

/-- Theorem: zero total error means solved -/
theorem zero_error_means_solved (ledger : ProblemLedger) :
    ledger.totalError = 0 → ledger.isSolved := by
  sorry

end ProblemLedger
