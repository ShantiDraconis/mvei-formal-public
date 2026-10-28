import MCore.Real.SevenRealProducer

namespace MCore.Real.SevenCertificateBridge

/-- The external chain is type-identical to a genuine producer.
    These aliases do not manufacture an inhabitant. -/
abbrev EXTERNAL_GAP : Type :=
  RealProducer

abbrev EXTERNAL_CERTIFICATE : Type :=
  EXTERNAL_GAP

abbrev FINAL_ROOT : Type :=
  EXTERNAL_CERTIFICATE

abbrev FINAL_PROOF : Type :=
  FINAL_ROOT

def issueExternalCertificate
    (p : RealProducer) :
    EXTERNAL_CERTIFICATE :=
  p

def toFinalRoot
    (c : EXTERNAL_CERTIFICATE) :
    FINAL_ROOT :=
  c

def toFinalProof
    (r : FINAL_ROOT) :
    FINAL_PROOF :=
  r

end MCore.Real.SevenCertificateBridge
