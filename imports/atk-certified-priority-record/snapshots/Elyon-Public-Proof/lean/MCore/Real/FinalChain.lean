import MCore.Real.SevenExternalCertificate

namespace MCore.Real.SevenCertificateBridge

/-- The single concrete resolution step induced by the kernel-checked seven-way evidence. -/
def canonicalResolutionStep :
    ResolutionStep
      .indeterminate
      (.resolved canonicalSevenEndpoint) :=
  ResolutionStep.resolve canonicalSevenGreenEvidence

/-- The concrete path from indeterminate state to the certified endpoint. -/
def canonicalResolutionPath :
    ResolutionPath
      .indeterminate
      (.resolved canonicalSevenEndpoint) :=
  Relation.ReflTransGen.single canonicalResolutionStep

/-- Concrete producer inhabited only by the certified seven-way endpoint evidence. -/
def canonicalRealProducer : RealProducer :=
  buildRealProducer
    canonicalSevenGreenEvidence
    canonicalResolutionPath

/-- Concrete external certificate emitted from the real producer. -/
def canonicalExternalCertificate : EXTERNAL_CERTIFICATE :=
  issueExternalCertificate canonicalRealProducer

/-- Concrete final root. -/
def canonicalFinalRoot : FINAL_ROOT :=
  toFinalRoot canonicalExternalCertificate

/-- Concrete final proof endpoint. -/
def canonicalFinalProof : FINAL_PROOF :=
  toFinalProof canonicalFinalRoot

#print axioms MCore.Real.SevenCertificateBridge.canonicalResolutionStep
#print axioms MCore.Real.SevenCertificateBridge.canonicalResolutionPath
#print axioms MCore.Real.SevenCertificateBridge.canonicalRealProducer
#print axioms MCore.Real.SevenCertificateBridge.canonicalExternalCertificate
#print axioms MCore.Real.SevenCertificateBridge.canonicalFinalRoot
#print axioms MCore.Real.SevenCertificateBridge.canonicalFinalProof

end MCore.Real.SevenCertificateBridge
