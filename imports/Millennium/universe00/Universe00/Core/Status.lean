/-
# Problem Status

The status of a mathematical problem based on its error vector.

A problem can be:
- Proved: all errors are zero
- Refuted: errors cannot be reduced further (structural lower bound)
- Open: errors are non-zero but potentially reducible
-/

import Universe00.Core.Error

/-- The status of a mathematical problem -/
inductive ProblemStatus
  | proved    -- All errors are zero
  | refuted   -- Problem has irreducible positive error (structural refutation)
  | open      -- Errors are non-zero but status undetermined

namespace ProblemStatus

/-- Compute status from an error vector -/
def fromErrorVector (ev : ErrorVector) : ProblemStatus :=
  if h : ∀ e ∈ ev.components, e = 0 then
    ProblemStatus.proved
  else
    ProblemStatus.open

/-- Check if status is proved -/
def isProved : ProblemStatus → Bool
  | proved => true
  | _ => false

/-- Check if status is refuted -/
def isRefuted : ProblemStatus → Bool
  | refuted => true
  | _ => false

/-- Check if status is open -/
def isOpen : ProblemStatus → Bool
  | open => true
  | _ => false

/-- String representation -/
def toString : ProblemStatus → String
  | proved => "Proved"
  | refuted => "Refuted"
  | open => "Open"

instance : ToString ProblemStatus := ⟨toString⟩

/-- Theorem: zero vector has proved status -/
theorem zero_is_proved (n : ℕ) :
    fromErrorVector (ErrorVector.zero n) = proved := by
  unfold fromErrorVector
  simp [ErrorVector.zero_is_zero]

/-- Theorem: if status is proved, then error vector is zero -/
theorem proved_means_zero (ev : ErrorVector) :
    fromErrorVector ev = proved → ErrorVector.isZero ev := by
  intro h
  unfold fromErrorVector at h
  split at h
  · exact ‹∀ e ∈ ev.components, e = 0›
  · contradiction

end ProblemStatus

/-
NOTE ON REFUTATION:

In this system, refutation is not handled via contradiction.
Instead, refutation occurs when there is a proven positive lower bound
on the error that cannot be removed.

For example:
- A parameter might have error ≥ 0.5 due to structural constraints
- This means the problem cannot be fully solved in the current framework
- But it's not a logical contradiction - it's a measured limitation

Refutation is rare and requires explicit proof of an irreducible error bound.
Most problems will remain "open" unless proved or structurally refuted.
-/
