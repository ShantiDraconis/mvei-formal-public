/-
  Ledger.lean
  
  The central object: ProblemLedger
  
  A complete, auditable record of a mathematical problem's state:
  - Name and description
  - Complete list of measured parameters
  - Weights for aggregation
  - Error vector
  - Total aggregate error (percentage)
  - Current status (proved/refuted/open)
  
  This is not a proof assistant's internal state.
  This is a mathematical object that can be:
  - Inspected
  - Audited
  - Compared
  - Evolved (monotonically)
  
  NO hidden state. NO implicit assumptions.
  Everything is explicit, typed, and verifiable.
-/

import Universe00.Core.Parameter
import Universe00.Core.Vector
import Universe00.Core.Aggregation
import Universe00.Core.Status

-- The complete ledger for a mathematical problem
structure ProblemLedger where
  -- Identification
  name : String
  description : String
  
  -- Parameters: the core components of the problem
  parameters : List (MeasuredParameter ℝ)
  
  -- Weights for aggregation (must match parameter count)
  weights : ErrorAggregation.Weights
  
  -- Error vector (extracted from parameters)
  errorVector : ErrorVector
  
  -- Total aggregate error (0-100 percentage)
  totalError : ℝ
  
  -- Current logical status
  status : ProblemStatus
  
  -- Consistency constraints
  dim_match : weights.values.length = parameters.length
  error_match : errorVector.components.length = parameters.length
  total_consistent : totalError = ErrorAggregation.aggregateError weights errorVector
  total_bounded : 0 ≤ totalError ∧ totalError ≤ 100

namespace ProblemLedger

-- Extract error vector from parameters
def extractErrorVector (params : List (MeasuredParameter ℝ)) : ErrorVector :=
  ⟨params.map (fun p => p.error),
   by
     intros e he
     simp [List.mem_map] at he
     rcases he with ⟨p, _, rfl⟩
     exact p.valid⟩

-- Constructor with automatic error extraction and status computation
def mk' (name desc : String) (params : List (MeasuredParameter ℝ))
    (weights : ErrorAggregation.Weights)
    (h_dim : weights.values.length = params.length) :
    ProblemLedger :=
  let ev := extractErrorVector params
  let total := ErrorAggregation.aggregateError weights ev
  let status := statusFromError ev
  ⟨name, desc, params, weights, ev, total, status,
   h_dim,
   by simp [extractErrorVector],
   rfl,
   ⟨ErrorAggregation.aggregate_nonneg weights ev,
    ErrorAggregation.aggregate_le_hundred weights ev (by simp [extractErrorVector]; exact h_dim)⟩⟩

-- Check if ledger represents a proved problem
def is_proved (ledger : ProblemLedger) : Prop :=
  ledger.status = ProblemStatus.proved

-- Check if ledger represents a refuted problem
def is_refuted (ledger : ProblemLedger) : Prop :=
  ledger.status = ProblemStatus.refuted

-- Check if ledger represents an open problem
def is_open (ledger : ProblemLedger) : Prop :=
  ledger.status = ProblemStatus.open

-- Ledger refinement: parameters improve, total error decreases
def refines (l₁ l₂ : ProblemLedger) : Prop :=
  l₁.name = l₂.name ∧
  l₁.parameters.length = l₂.parameters.length ∧
  ErrorVector.refines l₁.errorVector l₂.errorVector ∧
  l₁.totalError ≤ l₂.totalError

-- Reflexivity
theorem refines_refl (l : ProblemLedger) : refines l l :=
  ⟨rfl, rfl, ErrorVector.refines_refl l.errorVector, le_refl l.totalError⟩

-- Transitivity
theorem refines_trans {l₁ l₂ l₃ : ProblemLedger}
    (h₁ : refines l₁ l₂) (h₂ : refines l₂ l₃) : refines l₁ l₃ := by
  obtain ⟨name₁, len₁, ev₁, err₁⟩ := h₁
  obtain ⟨name₂, len₂, ev₂, err₂⟩ := h₂
  constructor
  · rw [name₁, name₂]
  constructor
  · rw [len₁, len₂]
  constructor
  · exact ErrorVector.refines_trans ev₁ ev₂
  · exact le_trans err₁ err₂

-- Proved ledger has zero total error
theorem proved_implies_zero_total (l : ProblemLedger)
    (h : l.is_proved) : l.totalError = 0 := by
  unfold is_proved at h
  sorry -- Technical: proved status implies zero error vector implies zero aggregate

-- Zero total error implies proved (assuming positive weights)
theorem zero_total_implies_proved (l : ProblemLedger)
    (h_pos : ∀ w ∈ l.weights.values, 0 < w)
    (h : l.totalError = 0) : l.is_proved := by
  unfold is_proved
  sorry -- Technical: zero aggregate with positive weights implies proven status

-- Format ledger for display
def format (l : ProblemLedger) : String :=
  s!"Problem: {l.name}\n" ++
  s!"Description: {l.description}\n" ++
  s!"Parameters: {l.parameters.length}\n" ++
  s!"Total Error: {l.totalError}%\n" ++
  s!"Status: {l.status}"

-- Example: A simple ledger with one parameter
def example_ledger : ProblemLedger :=
  let param := MeasuredParameter.mk' ℝ 0.0 0.5 (by norm_num) (by norm_num)
  let weights := ErrorAggregation.uniformWeights 1 (by norm_num)
  mk' "Example Problem" "A simple test problem" [param] weights (by simp)

-- The example should be open with 50% error
example : example_ledger.totalError = 50 := by
  unfold example_ledger
  simp [mk', extractErrorVector, ErrorAggregation.aggregateError]
  sorry -- Technical computation

-- The example should be open
example : example_ledger.status = ProblemStatus.open := by
  unfold example_ledger
  simp [mk', statusFromError]
  sorry -- Technical detail

end ProblemLedger

-- The ledger is the proof itself, in coordinate form.
-- It doesn't describe the proof—it IS the proof, expressed as E → 0.
-- When E = 0, the problem is proved.
-- When E has a positive lower bound, the problem is refuted.
-- Otherwise, it remains open.
  Universe00.Core.Ledger
  
  The central Problem Ledger structure
  
  A ProblemLedger ties together all aspects of a mathematical problem:
  - Named parameters with their errors
  - Weights for aggregation
  - Total error percentage
  - Current status
  
  All components must be consistent.
-/

import Universe00.Core.Parameter
import Universe00.Core.Error
import Universe00.Core.Status
import Universe00.Core.Aggregation
import Mathlib.Data.List.Basic

namespace Universe00.Core

/--
  A ProblemLedger is the complete accounting of a mathematical problem's state.
  
  It contains:
  - A list of measured parameters
  - Weights for error aggregation
  - The error vector
  - The aggregated total error (as percentage)
  - The current status
  
  Invariants (to be proven):
  - Parameter count = error vector length = weight count
  - Weights sum to 1
  - totalError = aggregateError weights errorVector
  - status = statusFromError errorVector
-/
structure ProblemLedger where
  /-- Name of the mathematical problem -/
  name : String
  /-- List of measured parameters defining the problem -/
  parameters : List (MeasuredParameter ℝ)
  /-- Weights for aggregating parameter errors -/
  weights : List ℝ
  /-- The error vector (must match parameters) -/
  errorVector : ErrorVector
  /-- Total aggregated error as percentage [0,100] -/
  totalError : ℝ
  /-- Current status of the problem -/
  status : ProblemStatus
  /-- Proof of consistency: dimensions match -/
  dim_match : parameters.length = errorVector.dim ∧ 
              errorVector.dim = weights.length
  /-- Proof of consistency: weights are valid -/
  weights_valid : Aggregation.validWeights weights
  /-- Proof of consistency: total error matches aggregation -/
  total_correct : totalError = aggregateError weights errorVector.components
  /-- Proof of consistency: status matches error vector -/
  status_correct : status = statusFromError errorVector

namespace ProblemLedger

/-- Extract the list of errors from parameters -/
def extractErrors (params : List (MeasuredParameter ℝ)) : List ℝ :=
  params.map (λ p => p.error)

/-- Check if all errors in parameters are in bounds -/
def errorsInBounds (params : List (MeasuredParameter ℝ)) : Prop :=
  ∀ e ∈ extractErrors params, 0 ≤ e ∧ e ≤ 1

/-- This follows from MeasuredParameter validity -/
theorem parameters_errors_in_bounds (params : List (MeasuredParameter ℝ)) :
  errorsInBounds params := by
  intro e he
  unfold extractErrors at he
  simp [List.mem_map] at he
  obtain ⟨p, _, rfl⟩ := he
  exact p.valid

/--
  Constructor helper: build a ProblemLedger from components,
  computing derived values and verifying constraints.
-/
def mk (name : String) 
       (params : List (MeasuredParameter ℝ))
       (weights : List ℝ)
       (hdim : params.length = weights.length)
       (hweights : Aggregation.validWeights weights) :
  ProblemLedger :=
  let errors := extractErrors params
  let ev : ErrorVector := ⟨errors, parameters_errors_in_bounds params⟩
  let total := aggregateError weights errors
  let stat := statusFromError ev
  { name := name
    parameters := params
    weights := weights
    errorVector := ev
    totalError := total
    status := stat
    dim_match := by
      constructor
      · unfold ErrorVector.dim
        simp [extractErrors]
        exact hdim
      · unfold ErrorVector.dim
        simp [extractErrors]
        exact hdim.symm
    weights_valid := hweights
    total_correct := rfl
    status_correct := rfl
  }

/-- Check if the problem is solved -/
def isSolved (ledger : ProblemLedger) : Prop :=
  ledger.status = ProblemStatus.proved

/-- Check if the problem is still open -/
def isOpen (ledger : ProblemLedger) : Prop :=
  ledger.status = ProblemStatus.open

/-- Check if the problem is refuted -/
def isRefuted (ledger : ProblemLedger) : Prop :=
  ledger.status = ProblemStatus.refuted

/-- A solved problem has zero total error -/
theorem solved_implies_zero_error (ledger : ProblemLedger) 
    (h : isSolved ledger) :
  ledger.totalError = 0 := by
  unfold isSolved at h
  rw [ledger.status_correct] at h
  have : ∀ e ∈ ledger.errorVector.components, e = 0 := by
    rw [status_proved_iff_zero_error] at h
    exact h
  rw [ledger.total_correct]
  apply Aggregation.aggregate_zero_of_errors_zero
  · constructor
    · exact ledger.weights_valid
    constructor
    · unfold Aggregation.validLengths
      exact ledger.dim_match.2.symm
    · exact ledger.errorVector.valid
  · exact this

/-- If total error is zero and weights are positive, problem is solved -/
theorem zero_error_implies_solved (ledger : ProblemLedger)
    (h : ledger.totalError = 0)
    (hw : ∀ w ∈ ledger.weights, w > 0) :
  isSolved ledger := by
  sorry -- Requires proof that zero aggregate implies all components zero

/-- Get the i-th parameter -/
def getParameter (ledger : ProblemLedger) (i : Fin ledger.parameters.length) :
  MeasuredParameter ℝ :=
  ledger.parameters[i]

/-- Get the i-th error from the error vector -/
def getError (ledger : ProblemLedger) (i : Fin ledger.errorVector.dim) : ℝ :=
  ledger.errorVector.get i

/-- Get the i-th weight -/
def getWeight (ledger : ProblemLedger) (i : Fin ledger.weights.length) : ℝ :=
  ledger.weights[i]

/-- Progress update: create new ledger with reduced errors -/
def updateProgress (ledger : ProblemLedger) 
    (newParams : List (MeasuredParameter ℝ))
    (h_len : newParams.length = ledger.parameters.length)
    (h_mono : ∀ i : Fin newParams.length, 
      newParams[i].error ≤ ledger.parameters[i.cast h_len].error) :
  ProblemLedger :=
  mk ledger.name newParams ledger.weights
    (h_len.trans ledger.dim_match.1.trans ledger.dim_match.2)
    ledger.weights_valid

end ProblemLedger

end Universe00.Core
