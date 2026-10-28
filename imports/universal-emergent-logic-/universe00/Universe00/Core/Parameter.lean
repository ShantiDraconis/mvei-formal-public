/-
  Parameter.lean
  
  Fundamental definition: MeasuredParameter
  
  Core Principle:
  In this system, the error does not measure the failure of the proof.
  It is the proof's own coordinate.
  
  Every parameter in a mathematical problem is represented as a pair (value, error).
  The error is not uncertainty—it is an explicit, normalized component.
  
  NO undefined terms. NO 0/0. NO relaxed equality.
  Everything is classical, measurable, and verifiable.
-/

-- MeasuredParameter: A value with explicit, bounded error
structure MeasuredParameter (α : Type) where
  value : α
  error : ℝ  -- Normalized error in [0,1]
  Universe00.Core.Parameter
  
  Central definition: MeasuredParameter
  
  In this system, error does not measure failure.
  It is the coordinate of proof itself.
  
  Core Principle:
  Each parameter is inseparable from its error.
  A parameter is a pair (value, error) where:
    - value is the mathematical object being measured
    - error ∈ [0,1] quantifies incompleteness
    - error = 0 means the parameter is fully proven/determined
    - error = 1 means maximum uncertainty
-/

import Mathlib.Data.Real.Basic

namespace Universe00.Core

/-- 
  A MeasuredParameter represents a mathematical quantity along with its epistemic error.
  
  The error is not an approximation error, but rather a measure of how much work
  remains to fully establish the parameter's value.
  
  Invariant: 0 ≤ error ≤ 1
-/
structure MeasuredParameter (α : Type) where
  /-- The value of the parameter -/
  value : α
  /-- The epistemic error associated with this parameter -/
  error : ℝ
  /-- Proof that error is in valid range [0,1] -/
  valid : 0 ≤ error ∧ error ≤ 1

namespace MeasuredParameter

-- Constructor with explicit error bounds validation
def mk' (α : Type) (v : α) (e : ℝ) (h₁ : 0 ≤ e) (h₂ : e ≤ 1) : MeasuredParameter α :=
  ⟨v, e, ⟨h₁, h₂⟩⟩

-- Perfect parameter: error = 0 means the parameter is exactly known
def perfect (α : Type) (v : α) : MeasuredParameter α :=
  ⟨v, 0, ⟨by norm_num, by norm_num⟩⟩

-- Maximum uncertainty: error = 1 means the parameter is completely unknown
def unknown (α : Type) (v : α) : MeasuredParameter α :=
  ⟨v, 1, ⟨by norm_num, by norm_num⟩⟩

-- The error is always in valid range
theorem error_nonneg (p : MeasuredParameter α) : 0 ≤ p.error :=
  p.valid.1

theorem error_le_one (p : MeasuredParameter α) : p.error ≤ 1 :=
  p.valid.2

theorem error_bounded (p : MeasuredParameter α) : p.error ∈ Set.Icc (0 : ℝ) 1 :=
  ⟨error_nonneg p, error_le_one p⟩

-- Error refinement: a parameter can only improve (monotonicity)
def refines (p₁ p₂ : MeasuredParameter α) : Prop :=
  p₁.error ≤ p₂.error

-- Reflexivity of refinement
theorem refines_refl (p : MeasuredParameter α) : refines p p :=
  le_refl p.error

-- Transitivity of refinement
theorem refines_trans {p₁ p₂ p₃ : MeasuredParameter α}
    (h₁ : refines p₁ p₂) (h₂ : refines p₂ p₃) : refines p₁ p₃ :=
  le_trans h₁ h₂

-- Perfect parameter has zero error
theorem perfect_error_zero (v : α) : (perfect α v).error = 0 :=
  rfl

-- Unknown parameter has maximum error
theorem unknown_error_one (v : α) : (unknown α v).error = 1 :=
  rfl

-- A parameter is proven when its error is exactly zero
def is_proven (p : MeasuredParameter α) : Prop :=
  p.error = 0

-- A parameter cannot be refined beyond zero error
theorem zero_error_minimal (p : MeasuredParameter α) (h : p.error = 0) :
    ∀ p' : MeasuredParameter α, refines p' p → p'.error = 0 := by
  intros p' href
  unfold refines at href
  rw [h] at href
  linarith [error_nonneg p']

end MeasuredParameter

-- Key insight: The error is not a defect of our knowledge.
-- It is a coordinate in the space of proofs.
-- Proof = navigation to error zero.
/-- A parameter with zero error is fully proven -/
def isProven {α : Type} (p : MeasuredParameter α) : Prop :=
  p.error = 0

/-- A parameter with positive error is not yet fully established -/
def isOpen {α : Type} (p : MeasuredParameter α) : Prop :=
  p.error > 0

/-- Create a proven parameter (error = 0) -/
def proven {α : Type} (value : α) : MeasuredParameter α where
  value := value
  error := 0
  valid := by norm_num

/-- Create a maximally uncertain parameter (error = 1) -/
def maximally_uncertain {α : Type} (value : α) : MeasuredParameter α where
  value := value
  error := 1
  valid := by norm_num

/-- Create a parameter with specified error, requires proof that error ∈ [0,1] -/
def mk {α : Type} (value : α) (error : ℝ) (h : 0 ≤ error ∧ error ≤ 1) : MeasuredParameter α where
  value := value
  error := error
  valid := h

theorem error_nonneg {α : Type} (p : MeasuredParameter α) : 0 ≤ p.error :=
  p.valid.1

theorem error_le_one {α : Type} (p : MeasuredParameter α) : p.error ≤ 1 :=
  p.valid.2

theorem proven_iff_zero_error {α : Type} (p : MeasuredParameter α) :
  isProven p ↔ p.error = 0 :=
  Iff.rfl

end MeasuredParameter

end Universe00.Core
