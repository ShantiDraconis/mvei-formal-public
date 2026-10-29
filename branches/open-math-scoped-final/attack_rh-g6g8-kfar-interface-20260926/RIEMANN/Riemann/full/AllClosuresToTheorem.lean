import Riemann.claims.Claim5_UnconditionalVUB
import Riemann.external.FinalExternalCertificate

namespace Riemann.full

open MCore.RH.NB
open Riemann.claims

/-- All certified closure machinery assembled into one theorem constructor.
    The only non-constructed inputs are the analytic tail solution and the
    endpoint bridge for the resulting producer. -/
theorem ALL_CLOSURES_TO_RH
    {D : NBHilbertData}
    {rho : D.GeneratorFamily}
    (S : AnalyticTailSolution D rho)
    (B : EndpointBridge S.toVanishingProducer) :
    RiemannHypothesis :=
  FINAL_PROOF S.toVanishingProducer B

/-- The same assembly at external-certificate level. -/
noncomputable def buildFinalExternalFromAnalyticSolution
    {D : NBHilbertData}
    {rho : D.GeneratorFamily}
    (S : AnalyticTailSolution D rho)
    (B : EndpointBridge S.toVanishingProducer) :
    Riemann.external.FinalExternalCertificate :=
  Riemann.external.buildFinalExternalCertificate
    S.toVanishingProducer
    B

/-- Exact closure condition for the current project architecture. -/
def FinalOpenMathClosureRequirement : Prop :=
  ∃ (D : NBHilbertData) (rho : D.GeneratorFamily)
    (S : AnalyticTailSolution D rho),
    EndpointBridge S.toVanishingProducer

theorem finalOpenMathClosureRequirement_to_RH
    (h : FinalOpenMathClosureRequirement) :
    RiemannHypothesis := by
  rcases h with ⟨D, rho, S, B⟩
  exact ALL_CLOSURES_TO_RH S B

def ALL_CLOSURES_STATE : String := "READY_CONDITIONAL"
def ALL_CLOSURES_LOGICAL_GAPS : Nat := 0
def ALL_CLOSURES_MATERIAL_GAPS : Nat := 1
def ALL_CLOSURES_ENDPOINT_FORMALIZATION_GAPS : Nat := 1
def ALL_CLOSURES_RH_CLAIMS : Nat := 0

#print axioms ALL_CLOSURES_TO_RH
#print axioms finalOpenMathClosureRequirement_to_RH

end Riemann.full
