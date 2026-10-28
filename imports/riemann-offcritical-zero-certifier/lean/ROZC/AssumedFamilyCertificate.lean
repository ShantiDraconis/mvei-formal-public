import ROZC.FamilyBridges
import ROZC.Provenance

namespace ROZC

/-- Explicitly assumption-scoped theory: the family is accepted as model input,
    not claimed as externally verified. -/
structure AssumedOffCriticalFamilyTheory (M : ZetaModel) where
  family : OffCriticalZeroFamily M

/-- Family-scoped certificate.  It certifies only consequences of the supplied
    assumed family and analytic closure package. -/
structure AssumptionFamilyCertificate
    (M : ZetaModel)
    (dnDecay : DNDecay)
    (bilinearDecay : WeightedBilinearDecay) where
  theory : AssumedOffCriticalFamilyTheory M
  analyticClosure : AnalyticClosure M dnDecay bilinearDecay
  familyObstruction :
    ∀ j : theory.family.Index,
      (¬ RH M) ∧ (¬ dnDecay) ∧ (¬ bilinearDecay)

/-- Constructor for the assumption-scoped family certificate. -/
def mkAssumptionFamilyCertificate
    {M : ZetaModel}
    {dnDecay : DNDecay}
    {bilinearDecay : WeightedBilinearDecay}
    (T : AssumedOffCriticalFamilyTheory M)
    (A : AnalyticClosure M dnDecay bilinearDecay) :
    AssumptionFamilyCertificate M dnDecay bilinearDecay := by
  exact {
    theory := T
    analyticClosure := A
    familyObstruction := family_full_obstruction T.family A
  }

/-- An inhabited assumed family theory immediately yields RH negation. -/
theorem assumed_family_not_RH
    {M : ZetaModel}
    (T : AssumedOffCriticalFamilyTheory M)
    (j : T.family.Index) :
    ¬ RH M :=
  family_not_RH T.family j

#print axioms mkAssumptionFamilyCertificate
#print axioms assumed_family_not_RH

end ROZC
