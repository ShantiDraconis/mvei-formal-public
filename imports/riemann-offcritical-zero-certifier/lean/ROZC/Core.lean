namespace ROZC

universe u

/-- Abstract carrier for candidate nontrivial zeta zeros.  The analytic adapter
    is responsible for connecting this carrier to the actual Riemann zeta function. -/
structure ZetaModel where
  Point : Type u
  isZero : Point → Prop
  nontrivial : Point → Prop
  onCriticalLine : Point → Prop

/-- A certified witness to a nontrivial zeta zero off the critical line,
    relative to a concrete analytic model. -/
structure OffCriticalZeroWitness (M : ZetaModel) where
  rho : M.Point
  zero : M.isZero rho
  nontrivial_zero : M.nontrivial rho
  off_line : ¬ M.onCriticalLine rho

/-- RH relative to a concrete zeta model: every nontrivial zero lies on the critical line. -/
def RH (M : ZetaModel) : Prop :=
  ∀ z : M.Point, M.isZero z → M.nontrivial z → M.onCriticalLine z

/-- An off-critical nontrivial zero contradicts RH in the same model. -/
theorem offCriticalZero_not_RH
    {M : ZetaModel}
    (h : OffCriticalZeroWitness M) :
    ¬ RH M := by
  intro hrh
  exact h.off_line (hrh h.rho h.zero h.nontrivial_zero)

#print axioms offCriticalZero_not_RH

end ROZC
