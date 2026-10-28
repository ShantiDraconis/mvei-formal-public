import ROZC.Family
import ROZC.Orbit

namespace ROZC

universe u

/-- A coordinate layer centered on the critical line.
    This is model geometry, not a theorem about the concrete Riemann zeta function. -/
structure CriticalCoordinateModel (M : ZetaModel) where
  Coord : Type u
  zero : Coord
  displacement : M.Point → Coord
  onLine_iff_zero : ∀ z, M.onCriticalLine z ↔ displacement z = zero

/-- "Free off-critical placement" means no extra positional law is imposed:
    membership in the family only requires being a nontrivial zero and being off-line.
    The family itself supplies the chosen states. -/
structure FreeOffCriticalTheory (M : ZetaModel) where
  family : OffCriticalZeroFamily M

/-- Every state selected by a free off-critical theory is excluded from the critical line. -/
theorem free_state_off_line
    {M : ZetaModel}
    (T : FreeOffCriticalTheory M)
    (j : T.family.Index) :
    ¬ M.onCriticalLine (T.family.state j) :=
  T.family.off_line j

/-- Therefore every selected state has nonzero critical displacement. -/
theorem free_state_nonzero_displacement
    {M : ZetaModel}
    (C : CriticalCoordinateModel M)
    (T : FreeOffCriticalTheory M)
    (j : T.family.Index) :
    C.displacement (T.family.state j) ≠ C.zero := by
  intro hzero
  have hon : M.onCriticalLine (T.family.state j) :=
    (C.onLine_iff_zero (T.family.state j)).2 hzero
  exact T.family.off_line j hon

/-- Any inhabited free off-critical theory contradicts RH. -/
theorem free_theory_not_RH
    {M : ZetaModel}
    (T : FreeOffCriticalTheory M)
    (j : T.family.Index) :
    ¬ RH M :=
  family_not_RH T.family j

#print axioms free_state_off_line
#print axioms free_state_nonzero_displacement
#print axioms free_theory_not_RH

end ROZC
