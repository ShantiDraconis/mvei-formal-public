import ROZC.AssumedFamilyCertificate
import ROZC.ConcreteBridgeLedger

namespace ROZC

/-- Abstract proposition for the unconditional BCF/zero-residue control
    identified by m-core-riemann as the terminal positive-lane producer. -/
abbrev BCFZeroResidueControl := Prop

/-- Abstract proposition for the certified vanishing-upper-bound frontier. -/
abbrev VanishingUpperBound := Prop

/-- Reduction contract: BCF/zero-residue control is strong enough to produce
    the vanishing upper bound.  This contract is not manufactured here. -/
structure BCFToVanishingUpperBound
    (bcf : BCFZeroResidueControl)
    (vub : VanishingUpperBound) : Prop where
  forward : bcf → vub

/-- Reused reduction contract: vanishing upper bound yields DN decay.
    The concrete m-core-riemann provenance is tracked separately. -/
structure VanishingUpperBoundToDN
    (vub : VanishingUpperBound)
    (dnDecay : DNDecay) : Prop where
  forward : vub → dnDecay

/-- Composition of the two positive-lane reductions. -/
theorem bcf_to_dn
    {bcf : BCFZeroResidueControl}
    {vub : VanishingUpperBound}
    {dnDecay : DNDecay}
    (h₁ : BCFToVanishingUpperBound bcf vub)
    (h₂ : VanishingUpperBoundToDN vub dnDecay) :
    bcf → dnDecay := by
  intro hbcf
  exact h₂.forward (h₁.forward hbcf)

/-- On the assumed off-critical-family lane, any BCF producer that would force
    DN decay is obstructed. -/
theorem assumed_family_obstructs_bcf
    {M : ZetaModel}
    {dnDecay : DNDecay}
    {bilinearDecay : WeightedBilinearDecay}
    {bcf : BCFZeroResidueControl}
    {vub : VanishingUpperBound}
    (T : AssumedOffCriticalFamilyTheory M)
    (j : T.family.Index)
    (A : AnalyticClosure M dnDecay bilinearDecay)
    (h₁ : BCFToVanishingUpperBound bcf vub)
    (h₂ : VanishingUpperBoundToDN vub dnDecay) :
    ¬ bcf := by
  intro hbcf
  have hdn : dnDecay := bcf_to_dn h₁ h₂ hbcf
  exact (family_member_full_obstruction T.family j A).2.1 hdn

/-- The same assumed-family lane obstructs the vanishing upper bound itself
    whenever that upper bound implies DN decay. -/
theorem assumed_family_obstructs_vanishing_upper_bound
    {M : ZetaModel}
    {dnDecay : DNDecay}
    {bilinearDecay : WeightedBilinearDecay}
    {vub : VanishingUpperBound}
    (T : AssumedOffCriticalFamilyTheory M)
    (j : T.family.Index)
    (A : AnalyticClosure M dnDecay bilinearDecay)
    (h₂ : VanishingUpperBoundToDN vub dnDecay) :
    ¬ vub := by
  intro hvub
  have hdn : dnDecay := h₂.forward hvub
  exact (family_member_full_obstruction T.family j A).2.1 hdn

#print axioms bcf_to_dn
#print axioms assumed_family_obstructs_bcf
#print axioms assumed_family_obstructs_vanishing_upper_bound

end ROZC
