-- AntiRHDefinitions.lean
-- Anti-RH Research OS — Formal definitions under the ¬RH working hypothesis
--
-- Assumes: AntiRH.antiRH (at least one zero off the critical line)
-- and builds the classification of zero sets.

import AntiRH.RHFramework

namespace AntiRH

-- ─────────────────────────────────────────────────────────────────
-- §3  Zero classification
-- ─────────────────────────────────────────────────────────────────

/-- Z_0: the set of zeros on the critical line (Δ = 0). -/
def Z_critical : Set NontrivialZero :=
  { z | onCriticalLine z }

/-- Z_Δ: the set of zeros off the critical line (Δ ≠ 0). -/
def Z_delta : Set NontrivialZero :=
  { z | ¬ onCriticalLine z }

/-- Z_Δ⁺: zeros with Re(ρ) > 1/2. -/
def Z_delta_plus : Set NontrivialZero :=
  { z | horizontalShift z > 0 }

/-- Z_Δ⁻: zeros with Re(ρ) < 1/2. -/
def Z_delta_minus : Set NontrivialZero :=
  { z | horizontalShift z < 0 }

-- Z_Δ is the disjoint union of Z_Δ⁺ and Z_Δ⁻
theorem z_delta_split :
    Z_delta = Z_delta_plus ∪ Z_delta_minus := by
  ext z
  simp only [Z_delta, Z_delta_plus, Z_delta_minus,
             Set.mem_setOf_eq, Set.mem_union, onCriticalLine]
  constructor
  · intro h
    rcases lt_or_gt_of_ne h with h | h
    · right; exact h
    · left; exact h
  · intro h
    rcases h with h | h
    · linarith
    · linarith

-- Z_Δ⁺ and Z_Δ⁻ are disjoint
theorem z_delta_disjoint :
    Disjoint Z_delta_plus Z_delta_minus := by
  rw [Set.disjoint_left]
  intro z h_plus h_minus
  simp only [Z_delta_plus, Set.mem_setOf_eq] at h_plus
  simp only [Z_delta_minus, Set.mem_setOf_eq] at h_minus
  linarith

-- ─────────────────────────────────────────────────────────────────
-- §4  The horizontal shift parameter
-- ─────────────────────────────────────────────────────────────────

/-- antiRH expressed via the horizontal shift. -/
theorem antiRH_iff_shift :
    antiRH ↔ ∃ z : NontrivialZero, horizontalShift z ≠ 0 := by
  simp [antiRH, onCriticalLine]

/-- The shift Δ lies in (−1/2, 1/2). -/
theorem shift_bounds (z : NontrivialZero) :
    -(1/2 : ℝ) < horizontalShift z ∧ horizontalShift z < (1/2 : ℝ) := by
  constructor
  · simp [horizontalShift]; linarith [z.hlb]
  · simp [horizontalShift]; linarith [z.hub]

-- ─────────────────────────────────────────────────────────────────
-- §5  Symmetry quartet (Lemma 3.1 and 3.2)
-- ─────────────────────────────────────────────────────────────────

/-- The symmetry axiom: if ρ is a zero, so is 1 − ρ.
    This follows from the functional equation ξ(s) = ξ(1−s).
    Axiomatised here for the framework. -/
axiom functional_symmetry (z : NontrivialZero) :
    ∃ w : NontrivialZero, w.ρ = 1 - z.ρ

/-- The conjugation axiom: if ρ is a zero, so is ρ̄. -/
axiom conjugation_symmetry (z : NontrivialZero) :
    ∃ w : NontrivialZero, w.ρ = starRingEnd ℂ z.ρ

/-- For an off-line zero, 1 − ρ is also off-line with opposite-sense shift. -/
theorem functional_partner_off_line
    (z : NontrivialZero) (hz : horizontalShift z ≠ 0)
    (w : NontrivialZero) (hw : w.ρ = 1 - z.ρ) :
    horizontalShift w ≠ 0 := by
  simp [horizontalShift, hw]
  linarith [show w.ρ.re = 1 - z.ρ.re by
    rw [hw]; simp [Complex.sub_re]]

-- ─────────────────────────────────────────────────────────────────
-- §6  Supremum of real parts
-- ─────────────────────────────────────────────────────────────────

/-- Under the closure axiom (Axiom 5.1), β_max exists and is < 1. -/
axiom beta_max_exists : ∃ β : ℝ, (1/2 : ℝ) < β ∧ β < 1 ∧
    ∀ z ∈ Z_delta, z.ρ.re ≤ β

end AntiRH
