import Riemann.full.AllClosuresToTheorem

namespace Riemann.full

open MCore.RH.NB
open Riemann.claims

/-- Exact evidence object required for an unconditional RH claim in this
    repository.  No field is status metadata: every field is mathematical
    evidence consumed by the final theorem. -/
structure UnconditionalRHClaimCertificate where
  D : NBHilbertData
  rho : D.GeneratorFamily
  analytic : AnalyticTailSolution D rho
  endpoint : EndpointBridge analytic.toVanishingProducer

/-- A genuine inhabitant of UnconditionalRHClaimCertificate proves RH. -/
theorem UnconditionalRHClaimCertificate.enableTheorem
    (C : UnconditionalRHClaimCertificate) :
    RiemannHypothesis :=
  ALL_CLOSURES_TO_RH C.analytic C.endpoint

/-- The same genuine certificate emits the external certificate. -/
noncomputable def UnconditionalRHClaimCertificate.toFinalExternal
    (C : UnconditionalRHClaimCertificate) :
    Riemann.external.FinalExternalCertificate :=
  buildFinalExternalFromAnalyticSolution C.analytic C.endpoint

/-- Exact project-level open-math proposition. -/
def UNCONDITIONAL_RH_CLAIM_READY : Prop :=
  Nonempty UnconditionalRHClaimCertificate

theorem unconditional_claim_ready_implies_RH
    (h : UNCONDITIONAL_RH_CLAIM_READY) :
    RiemannHypothesis := by
  rcases h with ⟨C⟩
  exact C.enableTheorem

def UNCONDITIONAL_CLAIM_STATE : String := "OPEN_MATH_CORE"
def UNCONDITIONAL_CLAIM_MATERIAL_GAPS : Nat := 1
def UNCONDITIONAL_CLAIM_ENDPOINT_FORMALIZATION_GAPS : Nat := 1
def UNCONDITIONAL_CLAIM_RH_CLAIMS : Nat := 0

#print axioms UnconditionalRHClaimCertificate.enableTheorem
#print axioms unconditional_claim_ready_implies_RH

end Riemann.full
