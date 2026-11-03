import Riemann.claims.Claim5_UnconditionalVUB

namespace Riemann.claims

open MCore.RH.NB
open scoped BigOperators

/-!
# Multi-state S_N formalization

One scalar is represented at three compatible levels:
* petal state  (d,u,v),
* rose state   d = sum over coprime/far petals,
* global state S_N = log N * sum_d (1/d) rose_d.

The dyadic (U,V) coordinates are an indexing/refinement of the same petals;
they do not create a second mathematical gap.

The terminal gap is a single F1 certificate:
  |S_N| <= eps_N,  eps_N -> 0.
-/

structure MultiStateSNData where
  coeff : ℕ → ℕ → ℝ
  kernel : ℕ → ℕ → ℝ
  active : ℕ → ℕ → ℕ → ℕ → Bool

namespace MultiStateSNData

noncomputable def petal
    (A : MultiStateSNData)
    (N d u v : ℕ) : ℝ :=
  if A.active N d u v then
    A.coeff N ((d + 1) * (u + 1)) *
    A.coeff N ((d + 1) * (v + 1)) *
    A.kernel (u + 1) (v + 1)
  else 0

noncomputable def rose
    (A : MultiStateSNData)
    (N d : ℕ) : ℝ :=
  ∑ u in Finset.range N, ∑ v in Finset.range N, A.petal N d u v

noncomputable def block
    (A : MultiStateSNData)
    (uBlock vBlock : ℕ → ℕ)
    (N d U V : ℕ) : ℝ :=
  ∑ u in Finset.range N, ∑ v in Finset.range N,
    if uBlock (u + 1) = U ∧ vBlock (v + 1) = V
    then A.petal N d u v
    else 0

noncomputable def global
    (A : MultiStateSNData)
    (N : ℕ) : ℝ :=
  Real.log N *
    ∑ d in Finset.range N,
      ((1 : ℝ) / (d + 1 : ℝ)) * A.rose N d

theorem global_eq_bouquet
    (A : MultiStateSNData)
    (N : ℕ) :
    A.global N =
      Real.log N *
        ∑ d in Finset.range N,
          ((1 : ℝ) / (d + 1 : ℝ)) *
            (∑ u in Finset.range N,
              ∑ v in Finset.range N, A.petal N d u v) := by
  rfl

end MultiStateSNData

structure WeightedModularBilinearDecayCertificate
    (SN : ℕ → ℝ) where
  N0 : ℕ
  eps : ℕ → ℝ
  eps_nonneg : ∀ N, 0 ≤ eps N
  eps_tendsto_zero :
    Filter.Tendsto eps Filter.atTop (nhds 0)
  bound :
    ∀ N, N0 ≤ N → |SN N| ≤ eps N

namespace WeightedModularBilinearDecayCertificate

theorem tendsto_zero
    {SN : ℕ → ℝ}
    (C : WeightedModularBilinearDecayCertificate SN) :
    Filter.Tendsto SN Filter.atTop (nhds 0) := by
  rw [tendsto_zero_iff_norm_tendsto_zero]
  have hnorm :
      Filter.Tendsto (fun N => |SN N|) Filter.atTop (nhds 0) := by
    apply squeeze_zero'
    · filter_upwards with N
      exact abs_nonneg (SN N)
    · filter_upwards [Filter.eventually_ge_atTop C.N0] with N hN
      exact C.bound N hN
    · exact C.eps_tendsto_zero
  simpa [Real.norm_eq_abs] using hnorm

end WeightedModularBilinearDecayCertificate

structure SNToDNTransport
    (D : NBHilbertData)
    (rho : D.GeneratorFamily)
    (SN : ℕ → ℝ) where
  N0 : ℕ
  regular : ℕ → ℝ
  regular_nonneg : ∀ N, 0 ≤ regular N
  regular_tendsto_zero :
    Filter.Tendsto regular Filter.atTop (nhds 0)
  dn_bound :
    ∀ N, N0 ≤ N →
      D.DN rho N ≤ regular N + |SN N|

noncomputable def weighted_modular_bilinear_decay_closes_DN
    {D : NBHilbertData}
    {rho : D.GeneratorFamily}
    {SN : ℕ → ℝ}
    (T : SNToDNTransport D rho SN)
    (C : WeightedModularBilinearDecayCertificate SN) :
    DNBoundCertificate D rho :=
  {
    N0 := max T.N0 C.N0
    eps := fun N => T.regular N + C.eps N
    eps_nonneg := fun N =>
      add_nonneg (T.regular_nonneg N) (C.eps_nonneg N)
    eps_tendsto_zero := by
      simpa using T.regular_tendsto_zero.add C.eps_tendsto_zero
    dn_bound := by
      intro N hN
      have hT : T.N0 ≤ N := le_trans (Nat.le_max_left _ _) hN
      have hC : C.N0 ≤ N := le_trans (Nat.le_max_right _ _) hN
      exact le_trans (T.dn_bound N hT)
        (add_le_add_left (C.bound N hC) (T.regular N))
  }

noncomputable def weighted_modular_bilinear_decay_to_openMathProducer
    {D : NBHilbertData}
    {rho : D.GeneratorFamily}
    {SN : ℕ → ℝ}
    (T : SNToDNTransport D rho SN)
    (C : WeightedModularBilinearDecayCertificate SN) :
    OpenMathProducer D rho :=
  .arithmeticTransform
    { certificate := weighted_modular_bilinear_decay_closes_DN T C }

def WEIGHTED_MODULAR_BILINEAR_DECAY
    (A : MultiStateSNData) : Prop :=
  Nonempty (WeightedModularBilinearDecayCertificate A.global)

def MULTISTATE_SN_GAP_COUNT : Nat := 1
def MULTISTATE_SN_STATE : String := "OPEN_MATH_CORE__F1_VANISHING"

#print axioms MultiStateSNData.global_eq_bouquet
#print axioms WeightedModularBilinearDecayCertificate.tendsto_zero
#print axioms weighted_modular_bilinear_decay_closes_DN


/-! ## Dyadic/block energy inhabitant

This is the explicit sufficient object suggested by the modular FAR audit.
Cancellation is preserved inside each block.  Absolute values are taken only
after the block sum has been formed.
-/

structure ModularBlockEnergyData
    (SN : ℕ → ℝ) where
  blockCount : ℕ → ℕ
  blockContribution : ℕ → ℕ → ℝ
  coeffEnergy : ℕ → ℕ → ℝ
  modularEnergy : ℕ → ℕ → ℝ
  coeffEnergy_nonneg : ∀ N b, 0 ≤ coeffEnergy N b
  modularEnergy_nonneg : ∀ N b, 0 ≤ modularEnergy N b
  decomp :
    ∀ N, SN N =
      ∑ b in Finset.range (blockCount N), blockContribution N b
  block_bound :
    ∀ N b, b < blockCount N →
      |blockContribution N b| ≤
        Real.sqrt (coeffEnergy N b * modularEnergy N b)

namespace ModularBlockEnergyData

noncomputable def eps
    {SN : ℕ → ℝ}
    (B : ModularBlockEnergyData SN) : ℕ → ℝ :=
  fun N =>
    ∑ b in Finset.range (B.blockCount N),
      Real.sqrt (B.coeffEnergy N b * B.modularEnergy N b)

theorem eps_nonneg
    {SN : ℕ → ℝ}
    (B : ModularBlockEnergyData SN) :
    ∀ N, 0 ≤ B.eps N := by
  intro N
  exact Finset.sum_nonneg (fun b hb => Real.sqrt_nonneg _)

theorem global_abs_le_eps
    {SN : ℕ → ℝ}
    (B : ModularBlockEnergyData SN) :
    ∀ N, |SN N| ≤ B.eps N := by
  intro N
  rw [B.decomp N]
  calc
    |∑ b in Finset.range (B.blockCount N), B.blockContribution N b|
        ≤ ∑ b in Finset.range (B.blockCount N),
            |B.blockContribution N b| := by
              exact Finset.abs_sum_le_sum_abs
    _ ≤ ∑ b in Finset.range (B.blockCount N),
          Real.sqrt (B.coeffEnergy N b * B.modularEnergy N b) := by
            apply Finset.sum_le_sum
            intro b hb
            exact B.block_bound N b (Finset.mem_range.mp hb)
    _ = B.eps N := rfl

end ModularBlockEnergyData

/-- The exact remaining analytic inhabitant in block-energy form. -/
structure ModularBlockEnergyDecayCertificate
    (SN : ℕ → ℝ) extends ModularBlockEnergyData SN where
  eps_tendsto_zero :
    Filter.Tendsto toModularBlockEnergyData.eps Filter.atTop (nhds 0)

namespace ModularBlockEnergyDecayCertificate

noncomputable def toWeightedDecay
    {SN : ℕ → ℝ}
    (B : ModularBlockEnergyDecayCertificate SN) :
    WeightedModularBilinearDecayCertificate SN :=
  {
    N0 := 0
    eps := B.toModularBlockEnergyData.eps
    eps_nonneg := B.toModularBlockEnergyData.eps_nonneg
    eps_tendsto_zero := B.eps_tendsto_zero
    bound := by
      intro N hN
      exact B.toModularBlockEnergyData.global_abs_le_eps N
  }

end ModularBlockEnergyDecayCertificate

def MODULAR_BLOCK_ENERGY_VANISHING
    (A : MultiStateSNData) : Prop :=
  Nonempty (ModularBlockEnergyDecayCertificate A.global)

theorem modular_block_energy_vanishing_implies_weighted_decay
    (A : MultiStateSNData)
    (h : MODULAR_BLOCK_ENERGY_VANISHING A) :
    WEIGHTED_MODULAR_BILINEAR_DECAY A := by
  rcases h with ⟨B⟩
  exact ⟨B.toWeightedDecay⟩

#print axioms ModularBlockEnergyData.global_abs_le_eps
#print axioms modular_block_energy_vanishing_implies_weighted_decay

end Riemann.claims
