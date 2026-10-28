import AxiomaticMillenium.BoundedMinimality
import AxiomaticMillenium.FinalEGC

namespace AxiomaticMillenium

/-- Kernel-level certificate for the current P-vs-NP reduction state.

This is intentionally not a proof of P != NP.  It certifies:
1. the canonical reduced frontier used by the RootContract;
2. the real conditional EGC term;
3. the root is not frozen yet;
4. therefore a final EGC cannot currently exist.
-/
structure PvsNPReductionCertificate
    (M : PvsNPOfficialModel)
    (I : PvsNPFrontierInputs)
    (W : PvsNPClosureWitness M I) where
  reducedFrontier : ReducedFrontier
  reducedIsCandidate :
    reducedFrontier.frontier.atoms = pvsnpCandidateFrontier.atoms
  conditional :
    ConditionalExternalGlobalCertificate (pvsnpRootContract M I W)
  rootUnfrozen :
    (pvsnpFrozenRoot M).hashStatus ≠ RootHashStatus.frozen
  finalBlocked :
    ¬ Nonempty (FinalExternalGlobalCertificate (pvsnpRootContract M I W))

/-- Canonical inhabitant of the current reduction certificate, built entirely
from already-checked components. -/
def pvsnpReductionCertificate
    (M : PvsNPOfficialModel)
    (I : PvsNPFrontierInputs)
    (W : PvsNPClosureWitness M I) :
    PvsNPReductionCertificate M I W :=
  { reducedFrontier := pvsnpReducedFrontier
    reducedIsCandidate := rfl
    conditional := pvsnpConditionalEGC M I W
    rootUnfrozen := pvsnp_abstract_root_not_frozen M
    finalBlocked := pvsnp_no_final_egc_while_root_unfrozen M I W }

/- The real conditional closure term is carried by `conditional`.
It is intentionally reused rather than wrapped in a second theorem:
`ConditionalExternalGlobalCertificate.termIfFrontier` is already kernel-checked
and audited by the EGC axiom-base gate. -/

end AxiomaticMillenium
