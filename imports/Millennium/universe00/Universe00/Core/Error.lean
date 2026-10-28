/-
# Error Vector

The error vector is the fundamental object that describes
the state of a mathematical problem.

Each component represents the error of one parameter.
All components must be in [0,1].
-/

/-- An error vector contains the errors of all parameters
    in a problem. Each error must be in [0,1]. -/
structure ErrorVector where
  /-- List of error values, one per parameter -/
  components : List ℝ
  /-- Validity: all errors must be in [0,1] -/
  valid : ∀ e ∈ components, 0 ≤ e ∧ e ≤ 1

namespace ErrorVector

/-- The zero error vector represents a completely proven state -/
def zero (n : ℕ) : ErrorVector :=
  { components := List.replicate n 0
  , valid := by
      intro e he
      simp [List.replicate] at he
      cases he
      · rw [‹e = 0›]; constructor <;> norm_num
      · contradiction }

/-- Check if all components of the error vector are zero -/
def isZero (ev : ErrorVector) : Prop :=
  ∀ e ∈ ev.components, e = 0

/-- The maximum error in the vector -/
def max (ev : ErrorVector) : ℝ :=
  ev.components.foldr (fun e acc => max e acc) 0

/-- The minimum error in the vector -/
def min (ev : ErrorVector) : ℝ :=
  match ev.components with
  | [] => 0
  | h :: t => t.foldr (fun e acc => min e acc) h

/-- The number of components in the error vector -/
def length (ev : ErrorVector) : ℕ :=
  ev.components.length

/-- Get the i-th component of the error vector (0-indexed) -/
def get (ev : ErrorVector) (i : ℕ) (h : i < ev.length) : ℝ :=
  ev.components.get ⟨i, h⟩

/-- Count how many errors are exactly zero -/
def countZeros (ev : ErrorVector) : ℕ :=
  ev.components.filter (· = 0) |>.length

/-- Count how many errors are less than or equal to epsilon -/
def countBelowThreshold (ev : ErrorVector) (ε : ℝ) : ℕ :=
  ev.components.filter (· ≤ ε) |>.length

/-- Theorem: Maximum error is in [0,1] -/
theorem max_valid (ev : ErrorVector) : 0 ≤ ev.max ∧ ev.max ≤ 1 := by
  sorry -- Requires inductive proof over list structure

/-- Theorem: Minimum error is in [0,1] -/
theorem min_valid (ev : ErrorVector) : 0 ≤ ev.min ∧ ev.min ≤ 1 := by
  sorry -- Requires case analysis and induction

/-- Theorem: Zero vector has all components zero -/
theorem zero_is_zero (n : ℕ) : isZero (zero n) := by
  intro e he
  simp [zero, List.replicate] at he
  cases he
  · exact ‹e = 0›
  · contradiction

end ErrorVector
