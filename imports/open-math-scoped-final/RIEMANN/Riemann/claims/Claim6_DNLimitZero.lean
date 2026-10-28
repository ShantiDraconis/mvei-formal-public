import Riemann.claims.Claim5_UnconditionalVUB
import Riemann.frozen.vanishing_upper_bound_green_5c66f8dc

namespace Riemann.claims

def CLAIM_6_ID : String := "DNLIMIT_ZERO_FROM_PRODUCER"
def CLAIM_6_STATE : String := "CLOSED_CONDITIONAL_ON_CLAIM5"

theorem CLAIM_6_DNLIMIT_ZERO
    (P : Riemann.full.VanishingProducer) :
    P.D.DNLimit P.rho = 0 :=
  Riemann.frozen.vanishing_upper_bound_thm P.D P.rho P.vanishing

#print axioms CLAIM_6_DNLIMIT_ZERO

end Riemann.claims
