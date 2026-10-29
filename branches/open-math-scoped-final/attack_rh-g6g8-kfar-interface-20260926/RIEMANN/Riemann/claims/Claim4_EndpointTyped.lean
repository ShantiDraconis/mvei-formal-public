import Riemann.full.Endpoint

namespace Riemann.claims

def CLAIM_4_ID : String := "RH_ENDPOINT_TYPED"
def CLAIM_4_STATE : String := "CLOSED_DEFINITIONAL"

theorem CLAIM_4_ENDPOINT_TYPED :
    Riemann.full.ENDPOINT_TYPED = true :=
  Riemann.full.endpoint_typed

#print axioms CLAIM_4_ENDPOINT_TYPED

end Riemann.claims
