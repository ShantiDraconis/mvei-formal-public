import Riemann.claims.Claim5_MultiStateWeightedModularDecay
import Riemann.full.MinimalUnconditionalRHCertificate

namespace Riemann.claims

open MCore.RH.NB

structure RiemannHabitant (SN : ℕ → ℝ) where
  eps : ℕ → ℝ
  eps_nonneg : ∀ N, 0 ≤ eps N
  eps_vanishes : Filter.Tendsto eps Filter.atTop (nhds 0)
  bound : ∀ N, |SN N| ≤ eps N

namespace RiemannHabitant

def toWeightedModularBilinearDecayCertificate
    {SN : ℕ → ℝ}
    (H : RiemannHabitant SN) :
    WeightedModularBilinearDecayCertificate SN :=
  {
    N0 := 0
    eps := H.eps
    eps_nonneg := H.eps_nonneg
    eps_tendsto_zero := H.eps_vanishes
    bound := by
      intro N _
      exact H.bound N
  }

theorem kfar_vanishes
    {SN : ℕ → ℝ}
    (H : RiemannHabitant SN) :
    Filter.Tendsto SN Filter.atTop (nhds 0) :=
  H.toWeightedModularBilinearDecayCertificate.tendsto_zero

noncomputable def toDNBoundCertificate
    {D : NBHilbertData}
    {rho : D.GeneratorFamily}
    {SN : ℕ → ℝ}
    (T : SNToDNTransport D rho SN)
    (H : RiemannHabitant SN) :
    DNBoundCertificate D rho :=
  weighted_modular_bilinear_decay_closes_DN
    T H.toWeightedModularBilinearDecayCertificate

noncomputable def toOpenMathProducer
    {D : NBHilbertData}
    {rho : D.GeneratorFamily}
    {SN : ℕ → ℝ}
    (T : SNToDNTransport D rho SN)
    (H : RiemannHabitant SN) :
    OpenMathProducer D rho :=
  .arithmeticTransform
    { certificate := H.toDNBoundCertificate T }

end RiemannHabitant

structure RiemannUnconditionalClosureCertificate where
  D : NBHilbertData
  rho : D.GeneratorFamily
  SN : ℕ → ℝ
  transport : SNToDNTransport D rho SN
  habitant : RiemannHabitant SN
  endpoint :
    Riemann.full.EndpointBridge
      (habitant.toDNBoundCertificate transport).toVanishingProducer

namespace RiemannUnconditionalClosureCertificate

theorem enableTheorem
    (C : RiemannUnconditionalClosureCertificate) :
    Riemann.full.RiemannHypothesis :=
  Riemann.full.FINAL_PROOF
    (C.habitant.toDNBoundCertificate C.transport).toVanishingProducer
    C.endpoint

noncomputable def toFinalExternal
    (C : RiemannUnconditionalClosureCertificate) :
    Riemann.external.FinalExternalCertificate :=
  Riemann.external.buildFinalExternalCertificate
    (C.habitant.toDNBoundCertificate C.transport).toVanishingProducer
    C.endpoint

end RiemannUnconditionalClosureCertificate

def RIEMANN_UNCONDITIONAL_CLAIM_READY : Prop :=
  Nonempty RiemannUnconditionalClosureCertificate

theorem riemann_unconditional_claim_ready_implies_RH
    (h : RIEMANN_UNCONDITIONAL_CLAIM_READY) :
    Riemann.full.RiemannHypothesis := by
  rcases h with ⟨C⟩
  exact C.enableTheorem

def RIEMANN_HABITANT_STATE : String := "OPEN_MATH_CORE"
def RIEMANN_MATERIAL_PRODUCER_GAPS : Nat := 1
def RIEMANN_RH_CLAIMS : Nat := 0

#print axioms RiemannHabitant.kfar_vanishes
#print axioms RiemannUnconditionalClosureCertificate.enableTheorem
#print axioms riemann_unconditional_claim_ready_implies_RH

end Riemann.claims
