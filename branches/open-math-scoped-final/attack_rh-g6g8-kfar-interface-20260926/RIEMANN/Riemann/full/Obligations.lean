import Riemann.full.Endpoint
import MCore.RH.NB.QuantitativeUpperBound

namespace Riemann.full

open MCore.RH.NB

/-- The one genuinely open mathematical producer:
    construct a vanishing upper bound for the concrete Nyman-Beurling data. -/
structure VanishingProducer where
  D : NBHilbertData
  rho : D.GeneratorFamily
  vanishing : D.VanishingUpperBound rho

/-- Direct constructor from the exact remaining quantitative payload.
    This adds no assumption: callers must supply an unconditional majorant
    for the certified defect sequence. -/
def VanishingProducer.ofBound
    (D : NBHilbertData)
    (rho : D.GeneratorFamily)
    (eps : ℕ → ℝ)
    (eps_nonneg : ∀ N, 0 ≤ eps N)
    (dn_le : ∀ N, D.DN rho N ≤ eps N)
    (eps_tendsto_zero : Filter.Tendsto eps Filter.atTop (nhds 0)) :
    VanishingProducer :=
  {
    D := D
    rho := rho
    vanishing := {
      eps := eps
      eps_nonneg := eps_nonneg
      dn_le := dn_le
      eps_tendsto_zero := eps_tendsto_zero
    }
  }

def LOGICAL_OPEN_MATH_GAPS : Nat := 0
def MATERIAL_OPEN_MATH_GAPS : Nat := 1
def OPEN_FORMALIZATION_GAPS : Nat := 1

/-- Formal endpoint bridge interface. The underlying Báez-Duarte criterion is
    externally proved; emitting this bridge for the concrete normalized data
    remains a formalization task, not a second new mathematical conjecture. -/
structure EndpointBridge (P : VanishingProducer) where
  dn_zero_to_rh : P.D.DNLimit P.rho = 0 → RiemannHypothesis

def GAP_1_STATE : String :=
  "CLOSED_CONDITIONAL__MATERIAL_PRODUCER_INHABITANT_OPEN_MATH_CORE"
def GAP_2_STATE : String := "EXTERNAL_PROVED__OPEN_FORMALIZATION"

end Riemann.full
