import Mathlib.Data.Nat.Basic
import Mathlib.Tactic

namespace FiniteEvidence

/-- A toy sequence that agrees with zero up to a finite cutoff and differs after it.
It formalizes the elementary logical reason a finite prefix cannot determine an
arbitrary infinite sequence.  It is not a statement about zeta zeros. -/
def delayedWitness (cutoff n : ℕ) : ℕ := if n ≤ cutoff then 0 else 1

theorem delayedWitness_prefix_zero (cutoff n : ℕ) (h : n ≤ cutoff) :
    delayedWitness cutoff n = 0 := by
  simp [delayedWitness, h]

theorem delayedWitness_after_one (cutoff : ℕ) :
    delayedWitness cutoff (cutoff + 1) = 1 := by
  simp [delayedWitness]

end FiniteEvidence
