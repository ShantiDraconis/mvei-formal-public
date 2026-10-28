/-
# Measured Parameter

In this system, error does not measure failure.
It is the coordinate of proof itself.

Every parameter in this framework is inseparable from its error.
The error is part of the parameter.

A parameter without an explicit error cannot exist in this system.
-/

/-- A measured parameter combines a value with its error bound.
    The error must be in [0,1] and represents how far the parameter
    is from its "proven" state (error = 0). -/
structure MeasuredParameter (α : Type) where
  /-- The actual value of the parameter -/
  value : α
  /-- The error associated with this parameter, measuring distance from proof -/
  error : ℝ
  /-- Validity constraint: error must be in [0,1] -/
  valid : 0 ≤ error ∧ error ≤ 1

namespace MeasuredParameter

/-- A parameter is proven if its error is exactly zero -/
def isProven {α : Type} (p : MeasuredParameter α) : Prop :=
  p.error = 0

/-- A parameter is refuted if its error is irreducibly 1 -/
def isRefuted {α : Type} (p : MeasuredParameter α) : Prop :=
  p.error = 1

/-- A parameter is open if its error is strictly between 0 and 1 -/
def isOpen {α : Type} (p : MeasuredParameter α) : Prop :=
  0 < p.error ∧ p.error < 1

/-- Create a proven parameter (error = 0) -/
def proven {α : Type} (val : α) : MeasuredParameter α :=
  { value := val
  , error := 0
  , valid := by constructor <;> norm_num }

/-- Create a maximally uncertain parameter (error = 1) -/
def maximallyUncertain {α : Type} (val : α) : MeasuredParameter α :=
  { value := val
  , error := 1
  , valid := by constructor <;> norm_num }

/-- Create a parameter with specified error in [0,1] -/
def withError {α : Type} (val : α) (err : ℝ) (h : 0 ≤ err ∧ err ≤ 1) : MeasuredParameter α :=
  { value := val
  , error := err
  , valid := h }

end MeasuredParameter
