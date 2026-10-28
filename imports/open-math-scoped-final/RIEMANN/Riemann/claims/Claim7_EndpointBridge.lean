import Riemann.claims.Claim6_DNLimitZero

namespace Riemann.claims

def CLAIM_7_ID : String := "DNLIMIT_ZERO_TO_RH_BRIDGE"
def CLAIM_7_MATH_STATE : String := "PROVED_EXTERNAL_BAEZ_DUARTE"
def CLAIM_7_FORMAL_STATE : String := "OPEN_FORMALIZATION"

def Claim7Requirement (P : Riemann.full.VanishingProducer) :=
  Riemann.full.EndpointBridge P

end Riemann.claims
