import Riemann.frozen.vanishing_upper_bound_green_5c66f8dc
import Riemann.refutedRoutes.A14NonImplication

namespace Riemann.claims

/-
Fail-closed registry for the external RH bridge.
No theorem of type DNLimit = 0 -> RiemannHypothesis is asserted here,
and no negation of that implication is fabricated.
-/

def CLAIM_3_ID : String := "FAIL-CLOSED-27ac66f4"
def CLAIM_3_HASH : String := "27ac66f4"
def CLAIM_3_STATE : String := "FAIL_CLOSED"
def CLAIM_3_IMPORTED_INTO_FINAL : Bool := false
def CLAIM_3_RH_CLAIMS : Nat := 0

#check Riemann.refutedRoutes.A14_alone_not_sufficient_for_covering
#check Riemann.refutedRoutes.A14_alone_not_sufficient_for_testDefect
#check Riemann.refutedRoutes.A14_alone_not_sufficient_for_joint_decay

end Riemann.claims
