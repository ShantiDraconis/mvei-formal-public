import Riemann.full.UnconditionalClaimCertificate
import Riemann.claims.Claim5_UnconditionalVUB

namespace Riemann.full

open MCore.RH.NB
open Riemann.claims

/-- Minimal unconditional RH certificate for the current repository architecture.
    The analytic side is reduced to the exact direct DN vanishing certificate;
    no coefficient representation is required. -/
structure MinimalUnconditionalRHCertificate where
  D : NBHilbertData
  rho : D.GeneratorFamily
  dn : DNBoundCertificate D rho
  endpoint : EndpointBridge dn.toVanishingProducer

theorem MinimalUnconditionalRHCertificate.enableTheorem
    (C : MinimalUnconditionalRHCertificate) :
    RiemannHypothesis :=
  FINAL_PROOF C.dn.toVanishingProducer C.endpoint

noncomputable def MinimalUnconditionalRHCertificate.toFinalExternal
    (C : MinimalUnconditionalRHCertificate) :
    Riemann.external.FinalExternalCertificate :=
  Riemann.external.buildFinalExternalCertificate
    C.dn.toVanishingProducer
    C.endpoint

/-- Any AnalyticTailSolution still embeds into the minimal certificate. -/
noncomputable def MinimalUnconditionalRHCertificate.ofAnalyticTail
    {D : NBHilbertData}
    {rho : D.GeneratorFamily}
    (S : AnalyticTailSolution D rho)
    (B : EndpointBridge S.toVanishingProducer) :
    MinimalUnconditionalRHCertificate := by
  let C := S.toDNBoundCertificate
  refine {
    D := D
    rho := rho
    dn := C
    endpoint := ?_
  }
  simpa [C, AnalyticTailSolution.toDNBoundCertificate,
    DNBoundCertificate.toVanishingProducer,
    AnalyticTailSolution.toVanishingProducer] using B

def MINIMAL_UNCONDITIONAL_RH_READY : Prop :=
  Nonempty MinimalUnconditionalRHCertificate

theorem minimal_unconditional_rh_ready_implies_RH
    (h : MINIMAL_UNCONDITIONAL_RH_READY) :
    RiemannHypothesis := by
  rcases h with ⟨C⟩
  exact C.enableTheorem

def MINIMAL_UNCONDITIONAL_MATERIAL_TARGET : String :=
  "DNBoundCertificate"
def MINIMAL_UNCONDITIONAL_ENDPOINT_TARGET : String :=
  "EndpointBridge"
def MINIMAL_UNCONDITIONAL_RH_CLAIMS : Nat := 0

#print axioms MinimalUnconditionalRHCertificate.enableTheorem
#print axioms minimal_unconditional_rh_ready_implies_RH

end Riemann.full
