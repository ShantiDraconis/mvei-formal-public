import Riemann.claims.Claim5_MultiStateWeightedModularDecay
import Mathlib.Data.Nat.Log

namespace Riemann.claims

open scoped BigOperators

structure BalancedDyadicBlock where
  d : ℕ
  U : ℕ
  V : ℕ
deriving DecidableEq, Repr

namespace BalancedDyadicBlock

def uScale (u : ℕ) : ℕ := Nat.log 2 (u + 1)
def vScale (v : ℕ) : ℕ := Nat.log 2 (v + 1)

def petals
    (A : MultiStateSNData)
    (N : ℕ)
    (B : BalancedDyadicBlock) : Finset (ℕ × ℕ) :=
  ((Finset.range N).product (Finset.range N)).filter fun uv =>
    A.active N B.d uv.1 uv.2 &&
    decide (uScale uv.1 = B.U) &&
    decide (vScale uv.2 = B.V)

noncomputable def coeffFactor
    (A : MultiStateSNData)
    (N : ℕ)
    (B : BalancedDyadicBlock)
    (uv : ℕ × ℕ) : ℝ :=
  (Real.log N / (B.d + 1 : ℝ)) *
    A.coeff N ((B.d + 1) * (uv.1 + 1)) *
    A.coeff N ((B.d + 1) * (uv.2 + 1))

noncomputable def modularFactor
    (A : MultiStateSNData)
    (uv : ℕ × ℕ) : ℝ :=
  A.kernel (uv.1 + 1) (uv.2 + 1)

noncomputable def contribution
    (A : MultiStateSNData)
    (N : ℕ)
    (B : BalancedDyadicBlock) : ℝ :=
  ∑ uv in B.petals A N,
    B.coeffFactor A N uv * B.modularFactor A uv

noncomputable def E_coeff
    (A : MultiStateSNData)
    (N : ℕ)
    (B : BalancedDyadicBlock) : ℝ :=
  ∑ uv in B.petals A N, (B.coeffFactor A N uv) ^ 2

noncomputable def E_mod
    (A : MultiStateSNData)
    (N : ℕ)
    (B : BalancedDyadicBlock) : ℝ :=
  ∑ uv in B.petals A N, (B.modularFactor A uv) ^ 2

theorem E_coeff_nonneg
    (A : MultiStateSNData) (N : ℕ) (B : BalancedDyadicBlock) :
    0 ≤ B.E_coeff A N := by
  unfold E_coeff
  exact Finset.sum_nonneg (fun _ _ => sq_nonneg _)

theorem E_mod_nonneg
    (A : MultiStateSNData) (N : ℕ) (B : BalancedDyadicBlock) :
    0 ≤ B.E_mod A N := by
  unfold E_mod
  exact Finset.sum_nonneg (fun _ _ => sq_nonneg _)

theorem contribution_sq_le_energy
    (A : MultiStateSNData) (N : ℕ) (B : BalancedDyadicBlock) :
    (B.contribution A N) ^ 2 ≤ B.E_coeff A N * B.E_mod A N := by
  unfold contribution E_coeff E_mod
  exact Finset.sum_mul_sq_le_sq_mul_sq
    (B.petals A N)
    (fun uv => B.coeffFactor A N uv)
    (fun uv => B.modularFactor A uv)

end BalancedDyadicBlock

def balancedDyadicBlocks (N : ℕ) : Finset BalancedDyadicBlock :=
  (Finset.range N).biUnion fun d =>
    (Finset.range (Nat.log 2 N + 1)).biUnion fun U =>
      (Finset.range (Nat.log 2 N + 1)).image fun V =>
        { d := d, U := U, V := V }

noncomputable def balancedBlockEps
    (A : MultiStateSNData) (N : ℕ) : ℝ :=
  ∑ B in balancedDyadicBlocks N,
    Real.sqrt (B.E_coeff A N * B.E_mod A N)


def balancedBlockKey (d u v : ℕ) : BalancedDyadicBlock :=
  { d := d
    U := BalancedDyadicBlock.uScale u
    V := BalancedDyadicBlock.vScale v }

def balancedTriples (N : ℕ) : Finset (ℕ × (ℕ × ℕ)) :=
  (Finset.range N).product ((Finset.range N).product (Finset.range N))

noncomputable def balancedTripleTerm
    (A : MultiStateSNData)
    (N : ℕ)
    (x : ℕ × (ℕ × ℕ)) : ℝ :=
  let d := x.1
  let u := x.2.1
  let v := x.2.2
  if A.active N d u v then
    (balancedBlockKey d u v).coeffFactor A N (u,v) *
      (balancedBlockKey d u v).modularFactor A (u,v)
  else 0

theorem balancedBlockKey_mem
    (N d u v : ℕ)
    (hd : d < N) (hu : u < N) (hv : v < N) :
    balancedBlockKey d u v ∈ balancedDyadicBlocks N := by
  simp only [balancedDyadicBlocks, Finset.mem_biUnion, Finset.mem_range,
    Finset.mem_image]
  refine ⟨d, hd, ?_⟩
  refine ⟨BalancedDyadicBlock.uScale u, ?_, ?_⟩
  · exact Nat.lt_succ_of_le
      (Nat.log_mono_right (Nat.succ_le_iff.mpr hu))
  · refine ⟨BalancedDyadicBlock.vScale v, ?_, ?_⟩
    · exact Nat.lt_succ_of_le
        (Nat.log_mono_right (Nat.succ_le_iff.mpr hv))
    · exact ⟨rfl, rfl⟩

theorem balancedTriples_mapsTo_blocks
    (N : ℕ) :
    ∀ x ∈ balancedTriples N,
      balancedBlockKey x.1 x.2.1 x.2.2 ∈ balancedDyadicBlocks N := by
  intro x hx
  rcases x with ⟨d, uv⟩
  rcases uv with ⟨u,v⟩
  simp only [balancedTriples, Finset.mem_product, Finset.mem_range] at hx
  exact balancedBlockKey_mem N d u v hx.1 hx.2.1 hx.2.2

theorem block_contribution_eq_fiber
    (A : MultiStateSNData)
    (N : ℕ)
    (B : BalancedDyadicBlock) :
    B.contribution A N =
      ∑ x ∈ balancedTriples N with
        balancedBlockKey x.1 x.2.1 x.2.2 = B,
        balancedTripleTerm A N x := by
  classical
  unfold BalancedDyadicBlock.contribution BalancedDyadicBlock.petals
    balancedTriples balancedTripleTerm balancedBlockKey
    BalancedDyadicBlock.coeffFactor BalancedDyadicBlock.modularFactor
    BalancedDyadicBlock.uScale BalancedDyadicBlock.vScale
  simp only [Finset.sum_filter, Finset.mem_product, Finset.mem_range,
    Bool.and_eq_true, decide_eq_true_eq]
  apply Finset.sum_congr rfl
  intro u hu
  apply Finset.sum_congr rfl
  intro v hv
  by_cases hact : A.active N B.d u v = true
  · simp [hact]
  · simp [hact]

theorem global_eq_sum_block_contributions
    (A : MultiStateSNData)
    (N : ℕ) :
    A.global N =
      ∑ B in balancedDyadicBlocks N, B.contribution A N := by
  classical
  rw [show
      (∑ B in balancedDyadicBlocks N, B.contribution A N) =
        ∑ B in balancedDyadicBlocks N,
          ∑ x ∈ balancedTriples N with
            balancedBlockKey x.1 x.2.1 x.2.2 = B,
            balancedTripleTerm A N x by
      apply Finset.sum_congr rfl
      intro B hB
      exact block_contribution_eq_fiber A N B]
  rw [Finset.sum_fiberwise_of_maps_to (balancedTriples_mapsTo_blocks N)
    (balancedTripleTerm A N)]
  unfold MultiStateSNData.global MultiStateSNData.rose MultiStateSNData.petal
    balancedTriples balancedTripleTerm balancedBlockKey
    BalancedDyadicBlock.coeffFactor BalancedDyadicBlock.modularFactor
  simp only [Finset.sum_product, Bool.if_true_left]
  apply Finset.sum_congr rfl
  intro d hd
  rw [Finset.mul_sum]
  apply Finset.sum_congr rfl
  intro u hu
  rw [Finset.mul_sum]
  apply Finset.sum_congr rfl
  intro v hv
  by_cases hact : A.active N d u v = true
  · simp [hact]
    ring
  · simp [hact]

theorem block_contribution_abs_le_energy
    (A : MultiStateSNData) (N : ℕ) (B : BalancedDyadicBlock) :
    |B.contribution A N| ≤
      Real.sqrt (B.E_coeff A N * B.E_mod A N) := by
  have hprod :
      0 ≤ B.E_coeff A N * B.E_mod A N :=
    mul_nonneg (B.E_coeff_nonneg A N) (B.E_mod_nonneg A N)
  have hs :=
    B.contribution_sq_le_energy A N
  have hsqrt :
      (Real.sqrt (B.E_coeff A N * B.E_mod A N)) ^ 2 =
        B.E_coeff A N * B.E_mod A N := by
    exact Real.sq_sqrt hprod
  nlinarith [abs_nonneg (B.contribution A N), Real.sqrt_nonneg
    (B.E_coeff A N * B.E_mod A N),
    sq_abs (B.contribution A N)]

theorem global_abs_le_balancedBlockEps
    (A : MultiStateSNData) (N : ℕ) :
    |A.global N| ≤ balancedBlockEps A N := by
  rw [global_eq_sum_block_contributions A N]
  calc
    |∑ B in balancedDyadicBlocks N, B.contribution A N|
        ≤ ∑ B in balancedDyadicBlocks N, |B.contribution A N| := by
          exact Finset.abs_sum_le_sum_abs
    _ ≤ ∑ B in balancedDyadicBlocks N,
          Real.sqrt (B.E_coeff A N * B.E_mod A N) := by
          apply Finset.sum_le_sum
          intro B hB
          exact block_contribution_abs_le_energy A N B
    _ = balancedBlockEps A N := rfl

structure BalancedMobiusEstermannHabitant
    (A : MultiStateSNData) : Prop where
  decay :
    Filter.Tendsto (balancedBlockEps A) Filter.atTop (nhds 0)

namespace BalancedMobiusEstermannHabitant

theorem eps_nonneg
    {A : MultiStateSNData}
    (H : BalancedMobiusEstermannHabitant A) :
    ∀ N, 0 ≤ balancedBlockEps A N := by
  intro N
  unfold balancedBlockEps
  exact Finset.sum_nonneg (fun _ _ => Real.sqrt_nonneg _)

def toWeightedDecay
    {A : MultiStateSNData}
    (H : BalancedMobiusEstermannHabitant A) :
    WeightedModularBilinearDecayCertificate A.global :=
  {
    N0 := 0
    eps := balancedBlockEps A
    eps_nonneg := H.eps_nonneg
    eps_tendsto_zero := H.decay
    bound := by
      intro N _
      exact global_abs_le_balancedBlockEps A N
  }

theorem closes_weighted_modular_decay
    {A : MultiStateSNData}
    (H : BalancedMobiusEstermannHabitant A) :
    WEIGHTED_MODULAR_BILINEAR_DECAY A :=
  ⟨H.toWeightedDecay⟩

end BalancedMobiusEstermannHabitant

def BALANCED_MOBIUS_ESTERMANN_HABITANT_STATE : String :=
  "OPEN_MATH_CORE__DECAY_FIELD_UNINHABITED"

#print axioms BalancedDyadicBlock.contribution_sq_le_energy
#print axioms BalancedMobiusEstermannHabitant.closes_weighted_modular_decay

end Riemann.claims
