import Riemann.claims.Claim4_EndpointTyped
import Riemann.claims.Claim5_UnconditionalVUB
import Riemann.claims.Claim6_DNLimitZero
import Riemann.claims.Claim7_EndpointBridge
import Riemann.claims.Claim8_RiemannComplete

namespace Riemann.claims

def FULL_CLAIMS_TOTAL : Nat := 5
def CLOSED_NOW : Nat := 2
def OPEN_MATH_NOW : Nat := 1
def OPEN_FORMALIZATION_NOW : Nat := 1
def READY_CONDITIONAL : Nat := 1
def FULL_RH_CLAIMS : Nat := 0
def FULL_STATUS : String :=
  "STRUCTURE_COMPLETE__ONE_OPEN_MATH_GAP__ONE_EXTERNAL_BRIDGE_FORMALIZATION"

end Riemann.claims
