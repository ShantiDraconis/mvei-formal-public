import Riemann.external.ExternalCertificate

namespace Riemann.external

def CERTIFICATE_TYPE : String := "SCOPED_EXTERNAL_CERTIFICATE"
def FAIL_CLOSED : Bool := true
def RH_CLAIMS : Nat := 0
def RH_STATE : String := "OPEN_MATH"
def PRODUCER_STATE : String :=
  "OPEN_MATH: construct VanishingUpperBound for the concrete generator family"
def BRIDGE_STATE : String :=
  "FAIL_CLOSED: no certified DNLimit=0 -> RiemannHypothesis bridge"

#check FINAL_EXTERNAL_CERTIFICATE
#check EXTERNAL_SCOPED_CLAIM

end Riemann.external
