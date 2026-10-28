import ROZC.Core

namespace ROZC

universe u

/-- A family of nontrivial off-critical zeros in one zeta model. -/
structure OffCriticalZeroFamily (M : ZetaModel) where
  Index : Type u
  state : Index → M.Point
  zero : ∀ j, M.isZero (state j)
  nontrivial : ∀ j, M.nontrivial (state j)
  off_line : ∀ j, ¬ M.onCriticalLine (state j)

/-- Every member of an off-critical family is an individual witness. -/
def OffCriticalZeroFamily.witness
    {M : ZetaModel} (F : OffCriticalZeroFamily M) (j : F.Index) :
    OffCriticalZeroWitness M :=
  { rho := F.state j
    zero := F.zero j
    nontrivial_zero := F.nontrivial j
    off_line := F.off_line j }

/-- A nonempty off-critical family contradicts RH. -/
theorem family_not_RH
    {M : ZetaModel}
    (F : OffCriticalZeroFamily M)
    (j : F.Index) :
    ¬ RH M :=
  offCriticalZero_not_RH (F.witness j)

/-- The family-level statement is uniform: every index generates the same RH obstruction. -/
theorem every_family_member_not_RH
    {M : ZetaModel}
    (F : OffCriticalZeroFamily M) :
    ∀ j : F.Index, ¬ RH M := by
  intro j
  exact family_not_RH F j

#print axioms family_not_RH
#print axioms every_family_member_not_RH

end ROZC
