import ROZC.Bridges

namespace ROZC

/-- A conditional certificate proves every downstream consequence from an
    explicitly supplied off-critical witness and analytic bridge package. -/
structure ConditionalExternalCertificate
    (M : ZetaModel) (dnDecay : DNDecay) (bilinearDecay : WeightedBilinearDecay) where
  witness : OffCriticalZeroWitness M
  analytic_closure : AnalyticClosure M dnDecay bilinearDecay
  not_rh : ¬ RH M
  not_dn_decay : ¬ dnDecay
  not_bilinear_decay : ¬ bilinearDecay

def mkConditionalExternalCertificate
    {M : ZetaModel}
    {dnDecay : DNDecay}
    {bilinearDecay : WeightedBilinearDecay}
    (hzero : OffCriticalZeroWitness M)
    (hclosure : AnalyticClosure M dnDecay bilinearDecay) :
    ConditionalExternalCertificate M dnDecay bilinearDecay := by
  have h := full_conditional_chain hzero hclosure
  exact {
    witness := hzero
    analytic_closure := hclosure
    not_rh := h.1
    not_dn_decay := h.2.1
    not_bilinear_decay := h.2.2
  }

/-- Verification evidence is deliberately abstract at the logical kernel layer.
    The external verifier must provide a proof object for its exact verification predicate. -/
structure VerifiedOffCriticalZero (M : ZetaModel) where
  witness : OffCriticalZeroWitness M
  verificationPredicate : Prop
  verificationProof : verificationPredicate

/-- Unconditional external certificate type.  It cannot be inhabited without a
    VerifiedOffCriticalZero proof object. -/
structure ExternalCertificate
    (M : ZetaModel) (dnDecay : DNDecay) (bilinearDecay : WeightedBilinearDecay) where
  verified_zero : VerifiedOffCriticalZero M
  analytic_closure : AnalyticClosure M dnDecay bilinearDecay
  not_rh : ¬ RH M
  not_dn_decay : ¬ dnDecay
  not_bilinear_decay : ¬ bilinearDecay

def externalCertificateOfVerified
    {M : ZetaModel}
    {dnDecay : DNDecay}
    {bilinearDecay : WeightedBilinearDecay}
    (hz : VerifiedOffCriticalZero M)
    (hc : AnalyticClosure M dnDecay bilinearDecay) :
    ExternalCertificate M dnDecay bilinearDecay := by
  have h := full_conditional_chain hz.witness hc
  exact {
    verified_zero := hz
    analytic_closure := hc
    not_rh := h.1
    not_dn_decay := h.2.1
    not_bilinear_decay := h.2.2
  }

#print axioms mkConditionalExternalCertificate
#print axioms externalCertificateOfVerified

end ROZC
