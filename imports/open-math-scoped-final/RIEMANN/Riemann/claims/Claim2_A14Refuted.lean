import Riemann.refutedRoutes.A14NonImplication

namespace Riemann.claims

open Riemann.refutedRoutes

def CLAIM_2_ID : String := "A14_REFUTED"
def CLAIM_2_STATE : String := "CLOSED_BY_COUNTERMODEL"

theorem CLAIM_2_COVERING :
    ¬ (∀ obs : NBObservation,
        CompatibleObservation witnessSystem obs → obs.coveringDecay) :=
  A14_alone_not_sufficient_for_covering

theorem CLAIM_2_TESTDEFECT :
    ¬ (∀ obs : NBObservation,
        CompatibleObservation witnessSystem obs → obs.testDefectDecay) :=
  A14_alone_not_sufficient_for_testDefect

theorem CLAIM_2_JOINT :
    ¬ (∀ obs : NBObservation,
        CompatibleObservation witnessSystem obs →
          obs.coveringDecay ∧ obs.testDefectDecay) :=
  A14_alone_not_sufficient_for_joint_decay

#print axioms CLAIM_2_COVERING
#print axioms CLAIM_2_TESTDEFECT
#print axioms CLAIM_2_JOINT

end Riemann.claims
