import Riemann.full.FinalProof
import Riemann.claims.FullClaimsRegistry

namespace Riemann.external

structure FinalExternalCertificate where
  producer : Riemann.full.VanishingProducer
  bridge : Riemann.full.EndpointBridge producer
  rhProof : Riemann.full.RiemannHypothesis
  rhProof_eq_final :
    rhProof = Riemann.full.FINAL_PROOF producer bridge

/-- Constructor for the final certificate. No certificate value is fabricated. -/
def buildFinalExternalCertificate
    (P : Riemann.full.VanishingProducer)
    (B : Riemann.full.EndpointBridge P) :
    FinalExternalCertificate :=
  {
    producer := P
    bridge := B
    rhProof := Riemann.full.FINAL_PROOF P B
    rhProof_eq_final := rfl
  }

def FINAL_EXTERNAL_STATE : String := "READY_CONDITIONAL_ON_TWO_OPEN_MATH_GAPS"
def FINAL_RH_CLAIMS : Nat := 0

end Riemann.external
