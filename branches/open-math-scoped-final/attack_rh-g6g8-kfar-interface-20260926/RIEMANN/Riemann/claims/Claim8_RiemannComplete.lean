import Riemann.claims.Claim7_EndpointBridge

namespace Riemann.claims

def CLAIM_8_ID : String := "RIEMANN_COMPLETE"
def CLAIM_8_STATE : String := "READY_CONDITIONAL_ON_CLAIM5_CLAIM7"

theorem CLAIM_8_RIEMANN_COMPLETE
    (P : Riemann.full.VanishingProducer)
    (B : Riemann.full.EndpointBridge P) :
    Riemann.full.RiemannHypothesis :=
  B.dn_zero_to_rh (CLAIM_6_DNLIMIT_ZERO P)

#print axioms CLAIM_8_RIEMANN_COMPLETE

end Riemann.claims
