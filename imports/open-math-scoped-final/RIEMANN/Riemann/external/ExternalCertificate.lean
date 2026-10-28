import Riemann.scoped.FinalProof
import Riemann.claims.ClaimsRegistry
import Riemann.refutedRoutes.A14NonImplication

namespace Riemann.external

open MCore.RH.NB

structure ExternalCertificate where
  scopedClaim :
    ∀ (D : NBHilbertData) (rho : D.GeneratorFamily),
      D.VanishingUpperBound rho → D.DNLimit rho = 0
  a14CoveringRefuted :
    ¬ (∀ obs : Riemann.refutedRoutes.NBObservation,
        Riemann.refutedRoutes.CompatibleObservation
          Riemann.refutedRoutes.witnessSystem obs →
        obs.coveringDecay)
  a14TestDefectRefuted :
    ¬ (∀ obs : Riemann.refutedRoutes.NBObservation,
        Riemann.refutedRoutes.CompatibleObservation
          Riemann.refutedRoutes.witnessSystem obs →
        obs.testDefectDecay)
  a14JointRefuted :
    ¬ (∀ obs : Riemann.refutedRoutes.NBObservation,
        Riemann.refutedRoutes.CompatibleObservation
          Riemann.refutedRoutes.witnessSystem obs →
        obs.coveringDecay ∧ obs.testDefectDecay)
  rhClaims : Nat
  rhClaims_zero : rhClaims = 0
  externalState : String

def FINAL_EXTERNAL_CERTIFICATE : ExternalCertificate where
  scopedClaim := by
    intro D rho h
    exact Riemann.scoped.FINAL_PROOF D rho h
  a14CoveringRefuted :=
    Riemann.refutedRoutes.A14_alone_not_sufficient_for_covering
  a14TestDefectRefuted :=
    Riemann.refutedRoutes.A14_alone_not_sufficient_for_testDefect
  a14JointRefuted :=
    Riemann.refutedRoutes.A14_alone_not_sufficient_for_joint_decay
  rhClaims := 0
  rhClaims_zero := rfl
  externalState := "SCOPED_GREEN_FAIL_CLOSED_RH_OPEN"

theorem EXTERNAL_SCOPED_CLAIM
    (D : NBHilbertData)
    (rho : D.GeneratorFamily)
    (h : D.VanishingUpperBound rho) :
    D.DNLimit rho = 0 :=
  FINAL_EXTERNAL_CERTIFICATE.scopedClaim D rho h

#print axioms EXTERNAL_SCOPED_CLAIM

end Riemann.external
