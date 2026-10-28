import Riemann.full.Obligations

namespace Riemann.claims

open MCore.RH.NB

def CLAIM_5_ID : String := "UNCONDITIONAL_VANISHING_PRODUCER"
def CLAIM_5_STATE : String := "OPEN_MATH"

/-- This is the exact producer interface. It is intentionally not inhabited here. -/
def Claim5Requirement := Riemann.full.VanishingProducer

end Riemann.claims
