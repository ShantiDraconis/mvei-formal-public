import Riemann.claims.Claim8_RiemannComplete

namespace Riemann.full

/-- Final theorem constructor. It becomes an unconditional proof only after
    concrete inhabitants for VanishingProducer and EndpointBridge are supplied. -/
theorem FINAL_PROOF
    (P : VanishingProducer)
    (B : EndpointBridge P) :
    RiemannHypothesis :=
  Riemann.claims.CLAIM_8_RIEMANN_COMPLETE P B

#print axioms FINAL_PROOF

end Riemann.full
