import ROZC.Core

namespace ROZC

/-- Exact semantic proposition represented by decay of the certified DN sequence. -/
abbrev DNDecay := Prop

/-- Exact semantic proposition represented by the weighted modular/Vasyunin terminal decay. -/
abbrev WeightedBilinearDecay := Prop

/-- Audited analytic criterion: RH is equivalent to DN decay. -/
structure RHiffDN (M : ZetaModel) (dnDecay : DNDecay) : Prop where
  iff_statement : RH M ↔ dnDecay

/-- Audited reduction from weighted modular bilinear decay to DN decay. -/
structure BilinearToDN (bilinearDecay : WeightedBilinearDecay) (dnDecay : DNDecay) : Prop where
  forward : bilinearDecay → dnDecay

/-- Full reusable analytic bridge package. -/
structure AnalyticClosure (M : ZetaModel)
    (dnDecay : DNDecay) (bilinearDecay : WeightedBilinearDecay) : Prop where
  rh_iff_dn : RHiffDN M dnDecay
  bilinear_to_dn : BilinearToDN bilinearDecay dnDecay

theorem offCritical_obstructs_dn
    {M : ZetaModel}
    {dnDecay : DNDecay}
    (hzero : OffCriticalZeroWitness M)
    (hchar : RHiffDN M dnDecay) :
    ¬ dnDecay := by
  intro hdn
  have hrh : RH M := hchar.iff_statement.mpr hdn
  exact (offCriticalZero_not_RH hzero) hrh

theorem offCritical_obstructs_weightedBilinear
    {M : ZetaModel}
    {dnDecay : DNDecay}
    {bilinearDecay : WeightedBilinearDecay}
    (hzero : OffCriticalZeroWitness M)
    (hclosure : AnalyticClosure M dnDecay bilinearDecay) :
    ¬ bilinearDecay := by
  intro hb
  have hdn : dnDecay := hclosure.bilinear_to_dn.forward hb
  exact (offCritical_obstructs_dn hzero hclosure.rh_iff_dn) hdn

/-- The entire conditional obstruction chain in one kernel-checked theorem. -/
theorem full_conditional_chain
    {M : ZetaModel}
    {dnDecay : DNDecay}
    {bilinearDecay : WeightedBilinearDecay}
    (hzero : OffCriticalZeroWitness M)
    (hclosure : AnalyticClosure M dnDecay bilinearDecay) :
    (¬ RH M) ∧ (¬ dnDecay) ∧ (¬ bilinearDecay) := by
  constructor
  · exact offCriticalZero_not_RH hzero
  constructor
  · exact offCritical_obstructs_dn hzero hclosure.rh_iff_dn
  · exact offCritical_obstructs_weightedBilinear hzero hclosure

#print axioms offCritical_obstructs_dn
#print axioms offCritical_obstructs_weightedBilinear
#print axioms full_conditional_chain

end ROZC
