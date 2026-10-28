import ROZC.Family
import ROZC.Bridges

namespace ROZC

/-- A family member plus the analytic closure package obstructs all positive-lane decays. -/
theorem family_member_full_obstruction
    {M : ZetaModel}
    {dnDecay : DNDecay}
    {bilinearDecay : WeightedBilinearDecay}
    (F : OffCriticalZeroFamily M)
    (j : F.Index)
    (A : AnalyticClosure M dnDecay bilinearDecay) :
    (¬ RH M) ∧ (¬ dnDecay) ∧ (¬ bilinearDecay) :=
  full_conditional_chain (F.witness j) A

/-- Uniform family form: every indexed off-critical state yields the same obstruction chain. -/
theorem family_full_obstruction
    {M : ZetaModel}
    {dnDecay : DNDecay}
    {bilinearDecay : WeightedBilinearDecay}
    (F : OffCriticalZeroFamily M)
    (A : AnalyticClosure M dnDecay bilinearDecay) :
    ∀ j : F.Index, (¬ RH M) ∧ (¬ dnDecay) ∧ (¬ bilinearDecay) := by
  intro j
  exact family_member_full_obstruction F j A

#print axioms family_member_full_obstruction
#print axioms family_full_obstruction

end ROZC
