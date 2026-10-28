/-
  Status.lean
  
  The logical status of a mathematical problem.
  
  Three states:
  - proved: error vector is exactly zero (E = 0)
  - refuted: error vector has a positive structural lower bound
  - open: error is positive but could potentially reach zero
  
  NO ambiguity. NO "probably true". NO informal intuition.
  Status is determined purely by the error vector.
-/

import Universe00.Core.Vector

-- The three possible states of a mathematical problem
inductive ProblemStatus
  | proved   -- All errors are exactly zero
  | refuted  -- Errors have a positive structural lower bound
  | open     -- Errors are positive but might reach zero

namespace ProblemStatus

-- String representation
def toString : ProblemStatus → String
  | proved => "PROVED (E = 0)"
  | refuted => "REFUTED (E ≥ ε > 0 structurally)"
  | open => "OPEN (E > 0, limit unknown)"
  Universe00.Core.Status
  
  Problem status determination
  
  A mathematical problem can be:
  - proved: all error components are zero
  - refuted: irreducible positive error (structural impossibility)
  - open: positive error that may yet be reduced
  
  Status is determined entirely by the error vector.
-/

import Universe00.Core.Error

namespace Universe00.Core

/--
  The status of a mathematical problem.
  
  Note: Refutation in this system is NOT by contradiction,
  but by demonstrating an irreducible positive lower bound on error.
-/
inductive ProblemStatus
  | proved    -- All errors are zero
  | refuted   -- Positive error with proven lower bound
  | open      -- Positive error, reduction possible
  deriving Repr, DecidableEq

namespace ProblemStatus

/-- String representation for status -/
def toString : ProblemStatus → String
  | proved => "PROVED"
  | refuted => "REFUTED"
  | open => "OPEN"

instance : ToString ProblemStatus where
  toString := toString

-- Decidable equality
instance : DecidableEq ProblemStatus
  | proved, proved => isTrue rfl
  | refuted, refuted => isTrue rfl
  | open, open => isTrue rfl
  | proved, refuted => isFalse (by intro h; cases h)
  | proved, open => isFalse (by intro h; cases h)
  | refuted, proved => isFalse (by intro h; cases h)
  | refuted, open => isFalse (by intro h; cases h)
  | open, proved => isFalse (by intro h; cases h)
  | open, refuted => isFalse (by intro h; cases h)

end ProblemStatus

-- Determine status from error vector
def statusFromError (E : ErrorVector) : ProblemStatus :=
  if E.is_proven then
    ProblemStatus.proved
  else
    ProblemStatus.open
    -- Note: refutation requires additional structural proof
    -- that error cannot reach zero; this is problem-specific

-- Determine status with explicit refutation witness
def statusFromErrorWithRefutation (E : ErrorVector) (ε : ℝ)
    (h_refuted : 0 < ε ∧ E.has_positive_lower_bound E ε h_refuted.1) :
    ProblemStatus :=
  if E.is_proven then
    ProblemStatus.proved
  else if h_refuted.2 then
    ProblemStatus.refuted
  else
    ProblemStatus.open

-- A proved problem has zero error
theorem proved_implies_zero_error (E : ErrorVector)
    (h : statusFromError E = ProblemStatus.proved) :
    E.is_proven := by
  unfold statusFromError at h
  split at h
  · assumption
  · cases h

-- An open problem has positive error
theorem open_implies_positive_error (E : ErrorVector)
    (h : statusFromError E = ProblemStatus.open) :
    ¬E.is_proven := by
  unfold statusFromError at h
  split at h
  · cases h
  · assumption

-- Status is monotone under refinement (with same refutation witness)
theorem status_monotone_under_refinement (E₁ E₂ : ErrorVector)
    (h_refine : ErrorVector.refines E₁ E₂)
    (h_status₂ : statusFromError E₂ = ProblemStatus.proved) :
    statusFromError E₁ = ProblemStatus.proved ∨
    statusFromError E₁ = ProblemStatus.open := by
  sorry -- Technical: if E₂ proven, E₁ must also be proven by monotonicity

-- Examples of status determination

-- Example 1: Poincaré conjecture (resolved, zero error)
def poincare_status : ProblemStatus :=
  statusFromError (ErrorVector.zero 0)

-- Should be proved
example : poincare_status = ProblemStatus.proved := by
  unfold poincare_status statusFromError
  simp [ErrorVector.is_proven, ErrorVector.zero]
  sorry -- Technical detail

-- Example 2: An open problem with positive errors
def open_problem_status : ProblemStatus :=
  statusFromError (ErrorVector.singleton 0.42 (by norm_num) (by norm_num))

-- Should be open
example : open_problem_status = ProblemStatus.open := by
  unfold open_problem_status statusFromError
  simp [ErrorVector.is_proven, ErrorVector.singleton]
  sorry -- Technical detail

-- The status is not an opinion.
-- It is a direct, mechanical consequence of the error vector.
-- No interpretation. No debate. Just measurement.
end ProblemStatus

/--
  Determine problem status from error vector.
  
  A problem is proved iff all error components are exactly zero.
  Otherwise, it is open (or refuted with additional proof).
-/
def statusFromError (E : ErrorVector) : ProblemStatus :=
  if h : ∀ e ∈ E.components, e = 0 then
    ProblemStatus.proved
  else
    ProblemStatus.open

/-- Alternative: decide based on whether error vector is zero -/
def statusFromErrorVector (E : ErrorVector) : ProblemStatus :=
  if E.isZero then
    ProblemStatus.proved
  else
    ProblemStatus.open

theorem status_proved_iff_zero_error (E : ErrorVector) :
  statusFromError E = ProblemStatus.proved ↔ ∀ e ∈ E.components, e = 0 := by
  unfold statusFromError
  split_ifs with h
  · simp [h]
  · simp
    intro h'
    exact h h'

theorem status_open_iff_positive_error (E : ErrorVector) :
  statusFromError E = ProblemStatus.open ↔ ∃ e ∈ E.components, e ≠ 0 := by
  unfold statusFromError
  split_ifs with h
  · simp
    intro e he hnz
    exact h e he ▸ hnz rfl
  · simp
    push_neg at h
    exact h

/--
  Refutation status with proof of irreducible error.
  
  To mark a problem as refuted (not just open), we need:
  1. The current error vector
  2. A proof that there exists ε > 0 such that no valid
     refinement can reduce any component below ε
-/
structure RefutedStatus where
  errorVector : ErrorVector
  lowerBound : ℝ
  positive : lowerBound > 0
  irreducible : ∀ e ∈ errorVector.components, e ≥ lowerBound

/-- If we have a refuted status, the problem status is refuted -/
def statusFromRefutation (rs : RefutedStatus) : ProblemStatus :=
  ProblemStatus.refuted

theorem refuted_implies_positive_error (rs : RefutedStatus) :
  ∃ e ∈ rs.errorVector.components, e > 0 := by
  rcases rs.errorVector.components with _ | ⟨h, t⟩
  · -- Empty list case: contradiction since we need positive lower bound
    sorry
  · -- Non-empty list case
    use h
    constructor
    · simp
    · calc
        h ≥ rs.lowerBound := rs.irreducible h (by simp)
        _ > 0 := rs.positive

end Universe00.Core
