import Riemann.claims.Claim5_BalancedMobiusEstermannHabitant
import Riemann.claims.Claim5_ConcreteMobiusVasyuninData

namespace Riemann.claims

noncomputable def correlatedBlockEps
    (A : MultiStateSNData) (N : ℕ) : ℝ :=
  ∑ B in balancedDyadicBlocks N, |B.contribution A N|

theorem correlatedBlockEps_nonneg
    (A : MultiStateSNData) :
    ∀ N, 0 ≤ correlatedBlockEps A N := by
  intro N
  unfold correlatedBlockEps
  exact Finset.sum_nonneg (fun _ _ => abs_nonneg _)

theorem global_abs_le_correlatedBlockEps
    (A : MultiStateSNData) (N : ℕ) :
    |A.global N| ≤ correlatedBlockEps A N := by
  rw [global_eq_sum_block_contributions A N]
  exact Finset.abs_sum_le_sum_abs

structure CorrelatedBalancedHabitant
    (A : MultiStateSNData) : Prop where
  decay :
    Filter.Tendsto (correlatedBlockEps A) Filter.atTop (nhds 0)

namespace CorrelatedBalancedHabitant

def toWeightedDecay
    {A : MultiStateSNData}
    (H : CorrelatedBalancedHabitant A) :
    WeightedModularBilinearDecayCertificate A.global :=
  {
    N0 := 0
    eps := correlatedBlockEps A
    eps_nonneg := correlatedBlockEps_nonneg A
    eps_tendsto_zero := H.decay
    bound := by
      intro N _
      exact global_abs_le_correlatedBlockEps A N
  }

theorem closes_weighted_modular_decay
    {A : MultiStateSNData}
    (H : CorrelatedBalancedHabitant A) :
    WEIGHTED_MODULAR_BILINEAR_DECAY A :=
  ⟨H.toWeightedDecay⟩

end CorrelatedBalancedHabitant

noncomputable def concreteCorrelatedBlockEps
    (delta : ℝ) : ℕ → ℝ :=
  correlatedBlockEps (concreteMobiusVasyuninData delta)

def CONCRETE_CORRELATED_BALANCED_DECAY
    (delta : ℝ) : Prop :=
  Filter.Tendsto (concreteCorrelatedBlockEps delta)
    Filter.atTop (nhds 0)

noncomputable def concreteCorrelatedHabitantOfDecay
    (delta : ℝ)
    (hdecay : CONCRETE_CORRELATED_BALANCED_DECAY delta) :
    CorrelatedBalancedHabitant (concreteMobiusVasyuninData delta) :=
  { decay := hdecay }

theorem concreteCorrelatedDecay_closes_weighted_modular
    (delta : ℝ)
    (hdecay : CONCRETE_CORRELATED_BALANCED_DECAY delta) :
    WEIGHTED_MODULAR_BILINEAR_DECAY (concreteMobiusVasyuninData delta) :=
  (concreteCorrelatedHabitantOfDecay delta hdecay).closes_weighted_modular_decay

def CONCRETE_CORRELATED_BALANCED_STATE : String :=
  "OPEN_MATH_CORE__BLOCKWISE_BILINEAR_DECAY"

#print axioms global_abs_le_correlatedBlockEps
#print axioms concreteCorrelatedDecay_closes_weighted_modular

end Riemann.claims
