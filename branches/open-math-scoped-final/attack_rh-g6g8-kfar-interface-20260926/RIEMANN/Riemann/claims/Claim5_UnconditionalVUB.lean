import Riemann.full.Obligations

namespace Riemann.claims

open MCore.RH.NB

def CLAIM_5_ID : String := "UNCONDITIONAL_VANISHING_PRODUCER"
def CLAIM_5_STATE : String := "OPEN_MATH"
def CLAIM_5_OWNERSHIP : String := "PROJECT_CLAIM"
def CLAIM_5_EXTERNAL_SOURCE_POLICY : String :=
  "CITED_SUPPORT_ONLY_NO_AUTOMATIC_PROOF_CREDIT"
def CLAIM_5_CLOSURE_POLICY : String :=
  "closure theorem, adapters, normalization, and certificate are project-local"

/-!
ATK compression of the only material Riemann gate.

Already reusable and not to be reproved:
* Nyman--Beurling/Baez--Duarte endpoint criterion: external proved interface.
* Existing frozen downstream theorem:
  VanishingUpperBound -> DNToZero -> DNLimit = 0.
* Bettin--Conrey--Farmer unconditional decomposition: external identity only.
* Finite Gram/Vasyunin infrastructure and certified finite-N computations.

Supporting public results such as quantitative Mobius/cotangent estimates and
smoothed Gram decay may be imported as lemmas after normalization checks, but
they do not by themselves inhabit this producer.

The exact new mathematical object still required is one unconditional
VanishingUpperBound for the certified concrete generator family:
  eps : Nat -> Real
  0 <= eps N
  DN N <= eps N
  eps N -> 0.
No RH-equivalent hypothesis may be used to construct eps.
-/

def CLAIM_5_PUBLIC_REUSE_BAEZ_DUARTE : String := "GREEN_EXTERNAL_CITED"
def CLAIM_5_PUBLIC_REUSE_BCF_IDENTITY : String := "GREEN_EXTERNAL_CITED"
def CLAIM_5_PUBLIC_REUSE_GRAM_VASYUNIN : String := "GREEN_EXTERNAL_CITED"
def CLAIM_5_PUBLIC_SUPPORT_BETTIN_CONREY : String :=
  "SOURCE_REFERENCE_ONLY"
def CLAIM_5_PUBLIC_SUPPORT_MAIER_RASSIAS : String :=
  "SOURCE_REFERENCE_ONLY"
def CLAIM_5_PUBLIC_SUPPORT_MOBIUS_COTANGENT : String := "SUPPORTING_ONLY"
def CLAIM_5_PUBLIC_SUPPORT_SMOOTHED_GRAM_DECAY : String := "SUPPORTING_ONLY"

def CLAIM_5_MATERIAL_SUBGATES : Nat := 1
def CLAIM_5_G8_CANONICAL_BLOCKER : String :=
  "ZERO_RESIDUE_SUM_UNCONDITIONAL_CONTROL"
def CLAIM_5_G8_EXTERNAL_STATUS : String :=
  "UNCONDITIONAL_IDENTITY_AVAILABLE__UNIFORM_TAIL_BOUND_NOT_AVAILABLE"
def CLAIM_5_REQUIRED_OBJECT : String :=
  "unconditional concrete VanishingUpperBound"

/-- This is the exact producer interface. It is intentionally not inhabited here. -/
def Claim5Requirement := Riemann.full.VanishingProducer


/--
Finite-span reduction of the remaining quantitative frontier.

Because `DN = dN^2`, the admissible candidate must bound the *squared*
residual norm.  This theorem proves the geometric/projection part once and for
all; the only mathematical input left to construct is `hanalytic`.
-/
theorem DN_le_eps_frontier
    (D : NBHilbertData)
    (rho : D.GeneratorFamily)
    (eps : ℕ → ℝ)
    (hanalytic :
      ∀ N : ℕ, ∃ v : D.H,
        v ∈ D.V rho N ∧
        ‖D.chi - v‖ ^ 2 ≤ eps N) :
    ∀ N : ℕ, D.DN rho N ≤ eps N := by
  intro N
  rcases hanalytic N with ⟨v, hv, hv_bound⟩
  have hd : D.dN rho N ≤ ‖D.chi - v‖ := by
    rw [NBHilbertData.dN, D.P_minimal rho N D.chi]
    have hInf :
        (⨅ w : D.V rho N, ‖D.chi - (w : D.H)‖) ≤
          ‖D.chi - ((⟨v, hv⟩ : D.V rho N) : D.H)‖ := by
      apply ciInf_le
      refine ⟨0, ?_⟩
      intro x hx
      rcases hx with ⟨w, rfl⟩
      exact norm_nonneg _
    simpa using hInf
  have hsquare : (D.dN rho N) ^ 2 ≤ ‖D.chi - v‖ ^ 2 := by
    nlinarith [D.dN_nonneg rho N, norm_nonneg (D.chi - v)]
  exact le_trans hsquare hv_bound

/--
This is now the sole analytic payload required by Claim5:
construct an explicit finite-span approximant at every N whose squared
L2 residual is bounded by a vanishing majorant.
-/
def Claim5AnalyticFrontier
    (D : NBHilbertData)
    (rho : D.GeneratorFamily)
    (eps : ℕ → ℝ) : Prop :=
  ∀ N : ℕ, ∃ v : D.H,
    v ∈ D.V rho N ∧
    ‖D.chi - v‖ ^ 2 ≤ eps N


/-! ## Kernel-checkable analytic solution scaffold

The remaining problem is represented as an explicit tail-energy estimate.
No axiom and no hidden theorem is introduced here.
-/

noncomputable def explicitApprox
    (D : NBHilbertData)
    (rho : D.GeneratorFamily)
    (N : ℕ)
    (a : Fin N → ℝ) : D.H :=
  ∑ n : Fin N, a n • rho n

theorem explicitApprox_mem
    (D : NBHilbertData)
    (rho : D.GeneratorFamily)
    (N : ℕ)
    (a : Fin N → ℝ) :
    explicitApprox D rho N a ∈ D.V rho N := by
  unfold explicitApprox
  exact Submodule.sum_mem _ (fun n _ =>
    Submodule.smul_mem _ _ (D.generator_mem_V rho N n))

noncomputable def residualEnergy
    (D : NBHilbertData)
    (rho : D.GeneratorFamily)
    (N : ℕ)
    (a : Fin N → ℝ) : ℝ :=
  ‖D.chi - explicitApprox D rho N a‖ ^ 2

theorem DN_le_residualEnergy
    (D : NBHilbertData)
    (rho : D.GeneratorFamily)
    (N : ℕ)
    (a : Fin N → ℝ) :
    D.DN rho N ≤ residualEnergy D rho N a := by
  have h := DN_le_eps_frontier D rho
    (fun M =>
      if hMN : M = N then residualEnergy D rho N a else D.DN rho M)
    (fun M => by
      by_cases hMN : M = N
      · subst M
        refine ⟨explicitApprox D rho N a, explicitApprox_mem D rho N a, ?_⟩
        simp [residualEnergy]
      · refine ⟨(D.P rho M D.chi : D.H), D.P_mem rho M D.chi, ?_⟩
        simp [hMN, NBHilbertData.dN, NBHilbertData.DN])
  simpa using h N

/-- A fully explicit research target: coefficients plus a vanishing tail majorant. -/
structure AnalyticTailSolution
    (D : NBHilbertData)
    (rho : D.GeneratorFamily) where
  N0 : ℕ
  coeff : ∀ N, Fin N → ℝ
  epsTail : ℕ → ℝ
  epsTail_nonneg : ∀ N, 0 ≤ epsTail N
  epsTail_tendsto_zero :
    Filter.Tendsto epsTail Filter.atTop (nhds 0)
  energy_le :
    ∀ N, N0 ≤ N →
      residualEnergy D rho N (coeff N) ≤ epsTail N

namespace AnalyticTailSolution

variable
    {D : NBHilbertData}
    {rho : D.GeneratorFamily}

theorem DN_tail_le
    (S : AnalyticTailSolution D rho)
    (N : ℕ)
    (hN : S.N0 ≤ N) :
    D.DN rho N ≤ S.epsTail N := by
  exact le_trans
    (DN_le_residualEnergy D rho N (S.coeff N))
    (S.energy_le N hN)

noncomputable def patchedEps
    (S : AnalyticTailSolution D rho) : ℕ → ℝ :=
  fun N => if N < S.N0 then D.DN rho N else S.epsTail N

theorem patchedEps_nonneg
    (S : AnalyticTailSolution D rho) :
    ∀ N, 0 ≤ S.patchedEps N := by
  intro N
  by_cases hN : N < S.N0
  · simp [patchedEps, hN, D.DN_nonneg rho N]
  · simp [patchedEps, hN, S.epsTail_nonneg N]

theorem DN_le_patchedEps
    (S : AnalyticTailSolution D rho) :
    ∀ N, D.DN rho N ≤ S.patchedEps N := by
  intro N
  by_cases hN : N < S.N0
  · simp [patchedEps, hN]
  · have hN0 : S.N0 ≤ N := Nat.le_of_not_gt hN
    simpa [patchedEps, hN] using S.DN_tail_le N hN0

theorem patchedEps_tendsto_zero
    (S : AnalyticTailSolution D rho) :
    Filter.Tendsto S.patchedEps Filter.atTop (nhds 0) := by
  apply S.epsTail_tendsto_zero.congr'
  filter_upwards [Filter.eventually_ge_atTop S.N0] with N hN
  simp [patchedEps, Nat.not_lt.mpr hN]

noncomputable def toVanishingUpperBound
    (S : AnalyticTailSolution D rho) :
    D.VanishingUpperBound rho :=
  {
    eps := S.patchedEps
    eps_nonneg := S.patchedEps_nonneg
    dn_le := S.DN_le_patchedEps
    eps_tendsto_zero := S.patchedEps_tendsto_zero
  }

noncomputable def toVanishingProducer
    (S : AnalyticTailSolution D rho) :
    Riemann.full.VanishingProducer :=
  {
    D := D
    rho := rho
    vanishing := S.toVanishingUpperBound
  }

theorem newApproximant_closes_material_open_math
    (S : AnalyticTailSolution D rho) :
    ∃ P : Riemann.full.VanishingProducer,
      P.D = D := by
  exact ⟨S.toVanishingProducer, rfl⟩

end AnalyticTailSolution

/-- The research frontier after all geometric and finite-prefix reductions. -/
def EnergyTailFrontier
    (D : NBHilbertData)
    (rho : D.GeneratorFamily) : Prop :=
  Nonempty (AnalyticTailSolution D rho)


/-! ### G6-G8 — fail-closed K_far certificate interface

This interface does not assume or assert the far-tail estimate.  It proves that an
explicit decomposition and two analytic bounds are sufficient to close the far tail.
-/

structure KFarCertificate
    (Kfar : ℕ → ℝ) where
  N0 : ℕ
  C1 : ℝ
  C2 : ℝ
  smooth : ℕ → ℝ
  arith : ℕ → ℝ
  C1_nonneg : 0 ≤ C1
  C2_nonneg : 0 ≤ C2
  log_pos : ∀ N, N0 ≤ N → 0 < Real.log N
  decomp : ∀ N, N0 ≤ N → Kfar N = smooth N + arith N
  smooth_bound : ∀ N, N0 ≤ N → |smooth N| ≤ C1 / Real.log N
  arith_bound : ∀ N, N0 ≤ N → |arith N| ≤ C2 / Real.log N

namespace KFarCertificate

theorem abs_bound
    {Kfar : ℕ → ℝ}
    (S : KFarCertificate Kfar)
    (N : ℕ)
    (hN : S.N0 ≤ N) :
    |Kfar N| ≤ (S.C1 + S.C2) / Real.log N := by
  rw [S.decomp N hN]
  calc
    |S.smooth N + S.arith N|
        ≤ |S.smooth N| + |S.arith N| := abs_add _ _
    _ ≤ S.C1 / Real.log N + S.C2 / Real.log N :=
      add_le_add (S.smooth_bound N hN) (S.arith_bound N hN)
    _ = (S.C1 + S.C2) / Real.log N := by ring

theorem upper_bound
    {Kfar : ℕ → ℝ}
    (S : KFarCertificate Kfar)
    (N : ℕ)
    (hN : S.N0 ≤ N) :
    Kfar N ≤ (S.C1 + S.C2) / Real.log N := by
  exact le_trans (le_abs_self (Kfar N)) (S.abs_bound N hN)

end KFarCertificate

def KFarOpenFrontier (Kfar : ℕ → ℝ) : Prop :=
  Nonempty (KFarCertificate Kfar)


/-! ### G8 producer subinterfaces

These structures expose the two genuine analytic producers separately.
They carry no theorem credit until inhabited.
-/

structure SmoothTailCertificate
    (smooth : ℕ → ℝ) where
  N0 : ℕ
  C1 : ℝ
  C1_nonneg : 0 ≤ C1
  log_pos : ∀ N, N0 ≤ N → 0 < Real.log N
  bound : ∀ N, N0 ≤ N → |smooth N| ≤ C1 / Real.log N

structure ArithmeticTailCertificate
    (arith : ℕ → ℝ) where
  N0 : ℕ
  C2 : ℝ
  C2_nonneg : 0 ≤ C2
  log_pos : ∀ N, N0 ≤ N → 0 < Real.log N
  bound : ∀ N, N0 ≤ N → |arith N| ≤ C2 / Real.log N

def SmoothTailOpenFrontier (smooth : ℕ → ℝ) : Prop :=
  Nonempty (SmoothTailCertificate smooth)

def ArithmeticTailOpenFrontier (arith : ℕ → ℝ) : Prop :=
  Nonempty (ArithmeticTailCertificate arith)

/-- Glue theorem: once the decomposition and the two producer certificates exist,
the full K_far certificate is kernel-checkable. -/
def KFarCertificate.ofParts
    (Kfar smooth arith : ℕ → ℝ)
    (N0 : ℕ)
    (hdecomp : ∀ N, N0 ≤ N → Kfar N = smooth N + arith N)
    (hs : SmoothTailCertificate smooth)
    (ha : ArithmeticTailCertificate arith)
    (hsN0 : hs.N0 ≤ N0)
    (haN0 : ha.N0 ≤ N0) :
    KFarCertificate Kfar :=
  {
    N0 := N0
    C1 := hs.C1
    C2 := ha.C2
    smooth := smooth
    arith := arith
    C1_nonneg := hs.C1_nonneg
    C2_nonneg := ha.C2_nonneg
    log_pos := fun N hN => hs.log_pos N (le_trans hsN0 hN)
    decomp := hdecomp
    smooth_bound := fun N hN => hs.bound N (le_trans hsN0 hN)
    arith_bound := fun N hN => ha.bound N (le_trans haN0 hN)
  }

/-! ### G4 — exact Hilbert energy expansion -/

noncomputable def targetInner
    (D : NBHilbertData)
    (rho : D.GeneratorFamily)
    (N : ℕ)
    (a : Fin N → ℝ) : ℝ :=
  @inner ℝ D.H _ D.chi (explicitApprox D rho N a)

noncomputable def approxNormSq
    (D : NBHilbertData)
    (rho : D.GeneratorFamily)
    (N : ℕ)
    (a : Fin N → ℝ) : ℝ :=
  ‖explicitApprox D rho N a‖ ^ 2

theorem residualEnergy_expand
    (D : NBHilbertData)
    (rho : D.GeneratorFamily)
    (N : ℕ)
    (a : Fin N → ℝ) :
    residualEnergy D rho N a =
      ‖D.chi‖ ^ 2 - 2 * targetInner D rho N a + approxNormSq D rho N a := by
  unfold residualEnergy targetInner approxNormSq
  exact norm_sub_sq_real D.chi (explicitApprox D rho N a)

/-! ### G5 — diagonal / near / far partition -/

inductive EnergyPairRegion where
  | diagonal
  | near
  | far
deriving DecidableEq, Repr

noncomputable def energyPairRegion
    {N : ℕ}
    (delta : ℝ)
    (i j : Fin N) : EnergyPairRegion :=
  if i = j then .diagonal
  else if |Real.log (((i.val + 1 : ℕ) : ℝ) / ((j.val + 1 : ℕ) : ℝ))| ≤ delta
       then .near
       else .far

theorem energyPairRegion_cases
    {N : ℕ}
    (delta : ℝ)
    (i j : Fin N) :
    energyPairRegion delta i j = .diagonal ∨
    energyPairRegion delta i j = .near ∨
    energyPairRegion delta i j = .far := by
  unfold energyPairRegion
  split_ifs <;> simp


/-! ### G8 — concrete finite Gram far kernel

This is the exact finite-dimensional quadratic kernel attached to the certified
generator family.  It is independent of the later arithmetic identification of
the Gram entries with Vasyunin/cotangent formulas.
-/

noncomputable def gramEntry
    (D : NBHilbertData)
    (rho : D.GeneratorFamily)
    {N : ℕ}
    (i j : Fin N) : ℝ :=
  @inner ℝ D.H _ (rho i) (rho j)

noncomputable def gramPairTerm
    (D : NBHilbertData)
    (rho : D.GeneratorFamily)
    {N : ℕ}
    (a : Fin N → ℝ)
    (i j : Fin N) : ℝ :=
  a i * a j * gramEntry D rho i j

noncomputable def gramQuadratic
    (D : NBHilbertData)
    (rho : D.GeneratorFamily)
    (N : ℕ)
    (a : Fin N → ℝ) : ℝ :=
  ∑ i : Fin N, ∑ j : Fin N, gramPairTerm D rho a i j

noncomputable def gramRegionSum
    (D : NBHilbertData)
    (rho : D.GeneratorFamily)
    (N : ℕ)
    (delta : ℝ)
    (a : Fin N → ℝ)
    (r : EnergyPairRegion) : ℝ :=
  ∑ i : Fin N, ∑ j : Fin N,
    if energyPairRegion delta i j = r
    then gramPairTerm D rho a i j
    else 0

noncomputable def KDiagConcrete
    (D : NBHilbertData) (rho : D.GeneratorFamily)
    (N : ℕ) (delta : ℝ) (a : Fin N → ℝ) : ℝ :=
  Real.log N * gramRegionSum D rho N delta a .diagonal

noncomputable def KNearConcrete
    (D : NBHilbertData) (rho : D.GeneratorFamily)
    (N : ℕ) (delta : ℝ) (a : Fin N → ℝ) : ℝ :=
  Real.log N * gramRegionSum D rho N delta a .near

noncomputable def KFarConcrete
    (D : NBHilbertData) (rho : D.GeneratorFamily)
    (N : ℕ) (delta : ℝ) (a : Fin N → ℝ) : ℝ :=
  Real.log N * gramRegionSum D rho N delta a .far

theorem gramQuadratic_partition
    (D : NBHilbertData)
    (rho : D.GeneratorFamily)
    (N : ℕ)
    (delta : ℝ)
    (a : Fin N → ℝ) :
    gramQuadratic D rho N a =
      gramRegionSum D rho N delta a .diagonal +
      gramRegionSum D rho N delta a .near +
      gramRegionSum D rho N delta a .far := by
  unfold gramQuadratic gramRegionSum
  rw [← Finset.sum_add_distrib, ← Finset.sum_add_distrib]
  apply Finset.sum_congr rfl
  intro i hi
  rw [← Finset.sum_add_distrib, ← Finset.sum_add_distrib]
  apply Finset.sum_congr rfl
  intro j hj
  rcases energyPairRegion_cases delta i j with h | h | h
  · simp [h]
  · simp [h]
  · simp [h]

theorem KConcrete_partition
    (D : NBHilbertData)
    (rho : D.GeneratorFamily)
    (N : ℕ)
    (delta : ℝ)
    (a : Fin N → ℝ) :
    Real.log N * gramQuadratic D rho N a =
      KDiagConcrete D rho N delta a +
      KNearConcrete D rho N delta a +
      KFarConcrete D rho N delta a := by
  rw [gramQuadratic_partition D rho N delta a]
  simp [KDiagConcrete, KNearConcrete, KFarConcrete, mul_add]


/-! ### Arithmetic-route formal closure

These lemmas connect the exact Gram partition to the residual-energy frontier.
They add no analytic estimate and create no producer inhabitant.
-/

theorem approxNormSq_eq_gramQuadratic
    (D : NBHilbertData)
    (rho : D.GeneratorFamily)
    (N : ℕ)
    (a : Fin N → ℝ) :
    approxNormSq D rho N a = gramQuadratic D rho N a := by
  unfold approxNormSq
  rw [← real_inner_self_eq_norm_sq]
  unfold explicitApprox gramQuadratic gramPairTerm gramEntry
  simp only [sum_inner, inner_sum, inner_smul_left, inner_smul_right,
    map_real_smul, starRingEnd_apply]
  apply Finset.sum_congr rfl
  intro i hi
  rw [Finset.mul_sum]
  apply Finset.sum_congr rfl
  intro j hj
  rw [real_inner_comm]
  simp
  ring

theorem residualEnergy_region_split
    (D : NBHilbertData)
    (rho : D.GeneratorFamily)
    (N : ℕ)
    (delta : ℝ)
    (a : Fin N → ℝ) :
    residualEnergy D rho N a =
      ‖D.chi‖ ^ 2 - 2 * targetInner D rho N a +
        gramRegionSum D rho N delta a .diagonal +
        gramRegionSum D rho N delta a .near +
        gramRegionSum D rho N delta a .far := by
  rw [residualEnergy_expand, approxNormSq_eq_gramQuadratic,
    gramQuadratic_partition]
  ring

noncomputable def regularEnergyPart
    (D : NBHilbertData)
    (rho : D.GeneratorFamily)
    (N : ℕ)
    (delta : ℝ)
    (a : Fin N → ℝ) : ℝ :=
  ‖D.chi‖ ^ 2 - 2 * targetInner D rho N a +
    gramRegionSum D rho N delta a .diagonal +
    gramRegionSum D rho N delta a .near

theorem residualEnergy_eq_regular_add_far
    (D : NBHilbertData)
    (rho : D.GeneratorFamily)
    (N : ℕ)
    (delta : ℝ)
    (a : Fin N → ℝ) :
    residualEnergy D rho N a =
      regularEnergyPart D rho N delta a +
      gramRegionSum D rho N delta a .far := by
  rw [residualEnergy_region_split]
  unfold regularEnergyPart
  ring




/-! ### G8 — concrete certificate target -/

noncomputable def ConcreteKFar
    (D : NBHilbertData)
    (rho : D.GeneratorFamily)
    (delta : ℝ)
    (coeff : ∀ N, Fin N → ℝ) : ℕ → ℝ :=
  fun N => KFarConcrete D rho N delta (coeff N)

def ConcreteKFarOpenFrontier
    (D : NBHilbertData)
    (rho : D.GeneratorFamily)
    (delta : ℝ)
    (coeff : ∀ N, Fin N → ℝ) : Prop :=
  Nonempty (KFarCertificate (ConcreteKFar D rho delta coeff))

theorem concreteKFar_of_parts
    (D : NBHilbertData)
    (rho : D.GeneratorFamily)
    (delta : ℝ)
    (coeff : ∀ N, Fin N → ℝ)
    (smooth arith : ℕ → ℝ)
    (N0 : ℕ)
    (hdecomp :
      ∀ N, N0 ≤ N →
        ConcreteKFar D rho delta coeff N = smooth N + arith N)
    (hs : SmoothTailCertificate smooth)
    (ha : ArithmeticTailCertificate arith)
    (hsN0 : hs.N0 ≤ N0)
    (haN0 : ha.N0 ≤ N0) :
    ConcreteKFarOpenFrontier D rho delta coeff := by
  exact ⟨KFarCertificate.ofParts
    (ConcreteKFar D rho delta coeff) smooth arith N0
    hdecomp hs ha hsN0 haN0⟩


/-! ### G8 — external arithmetic source adapter contract

The external source supplies a block estimate.  This project must prove that the
exact weighted/gcd/far-region arithmetic tail is dominated by those blocks.
-/

structure ArithmeticBlockEstimate where
  blockBound : ℕ → ℕ → ℝ
  blockBound_nonneg : ∀ b D, 0 ≤ blockBound b D

structure ArithmeticAdapterContract
    (arith : ℕ → ℝ) where
  N0 : ℕ
  C2 : ℝ
  C2_nonneg : 0 ≤ C2
  source : ArithmeticBlockEstimate
  transport :
    ∀ N, N0 ≤ N →
      |arith N| ≤ C2 / Real.log N

def ArithmeticAdapterContract.toCertificate
    {arith : ℕ → ℝ}
    (A : ArithmeticAdapterContract arith)
    (hlog : ∀ N, A.N0 ≤ N → 0 < Real.log N) :
    ArithmeticTailCertificate arith :=
  {
    N0 := A.N0
    C2 := A.C2
    C2_nonneg := A.C2_nonneg
    log_pos := hlog
    bound := A.transport
  }

def ArithmeticAdapterOpenFrontier (arith : ℕ → ℝ) : Prop :=
  Nonempty (ArithmeticAdapterContract arith)


/-! ### Canonical OPEN_MATH certificate: unconditional zero-residue control

This is intentionally abstract: the project audit establishes that this is the
single material analytic gate after the unconditional BCF decomposition.
No inhabitant is supplied here.
-/

structure ZeroResidueControlCertificate
    (residueError : ℕ → ℝ) where
  N0 : ℕ
  majorant : ℕ → ℝ
  majorant_nonneg : ∀ N, 0 ≤ majorant N
  majorant_tendsto_zero :
    Filter.Tendsto majorant Filter.atTop (nhds 0)
  residue_bound :
    ∀ N, N0 ≤ N → |residueError N| ≤ majorant N

namespace ZeroResidueControlCertificate

theorem residue_tendsto_zero
    {residueError : ℕ → ℝ}
    (Z : ZeroResidueControlCertificate residueError) :
    Filter.Tendsto residueError Filter.atTop (nhds 0) := by
  rw [tendsto_zero_iff_norm_tendsto_zero]
  have habs :
      Filter.Tendsto (fun N => |residueError N|) Filter.atTop (nhds 0) := by
    apply squeeze_zero'
    · filter_upwards with N
      exact abs_nonneg (residueError N)
    · filter_upwards [Filter.eventually_ge_atTop Z.N0] with N hN
      exact Z.residue_bound N hN
    · exact Z.majorant_tendsto_zero
  simpa [Real.norm_eq_abs] using habs

end ZeroResidueControlCertificate

def ZeroResidueControlOpenFrontier
    (residueError : ℕ → ℝ) : Prop :=
  Nonempty (ZeroResidueControlCertificate residueError)

def ZERO_RESIDUE_SUM_UNCONDITIONAL_CONTROL_STATE : String := "OPEN_MATH"


/-! ### Minimal OPEN_MATH cut: direct DN certificate

Every analytic route is reduced to the same eventual vanishing upper bound on the
concrete Báez-Duarte distance.  Constructing any route datum remains the sole
mathematical obligation; the transport below is kernel-checked and assumption-free.
-/

structure DNBoundCertificate
    (D : NBHilbertData)
    (rho : D.GeneratorFamily) where
  N0 : ℕ
  eps : ℕ → ℝ
  eps_nonneg : ∀ N, 0 ≤ eps N
  eps_tendsto_zero :
    Filter.Tendsto eps Filter.atTop (nhds 0)
  dn_bound :
    ∀ N, N0 ≤ N → D.DN rho N ≤ eps N

namespace DNBoundCertificate

noncomputable def patchedEps
    {D : NBHilbertData}
    {rho : D.GeneratorFamily}
    (C : DNBoundCertificate D rho) : ℕ → ℝ :=
  fun N => if N < C.N0 then D.DN rho N else C.eps N

theorem patchedEps_nonneg
    {D : NBHilbertData}
    {rho : D.GeneratorFamily}
    (C : DNBoundCertificate D rho) :
    ∀ N, 0 ≤ C.patchedEps N := by
  intro N
  by_cases hN : N < C.N0
  · simp [patchedEps, hN, D.DN_nonneg rho N]
  · simp [patchedEps, hN, C.eps_nonneg N]

theorem dn_le_patchedEps
    {D : NBHilbertData}
    {rho : D.GeneratorFamily}
    (C : DNBoundCertificate D rho) :
    ∀ N, D.DN rho N ≤ C.patchedEps N := by
  intro N
  by_cases hN : N < C.N0
  · simp [patchedEps, hN]
  · have hN0 : C.N0 ≤ N := Nat.le_of_not_gt hN
    simpa [patchedEps, hN] using C.dn_bound N hN0

theorem patchedEps_tendsto_zero
    {D : NBHilbertData}
    {rho : D.GeneratorFamily}
    (C : DNBoundCertificate D rho) :
    Filter.Tendsto C.patchedEps Filter.atTop (nhds 0) := by
  apply C.eps_tendsto_zero.congr'
  filter_upwards [Filter.eventually_ge_atTop C.N0] with N hN
  simp [patchedEps, Nat.not_lt.mpr hN]

noncomputable def toVanishingUpperBound
    {D : NBHilbertData}
    {rho : D.GeneratorFamily}
    (C : DNBoundCertificate D rho) :
    D.VanishingUpperBound rho :=
  {
    eps := C.patchedEps
    eps_nonneg := C.patchedEps_nonneg
    dn_le := C.dn_le_patchedEps
    eps_tendsto_zero := C.patchedEps_tendsto_zero
  }

noncomputable def toVanishingProducer
    {D : NBHilbertData}
    {rho : D.GeneratorFamily}
    (C : DNBoundCertificate D rho) :
    Riemann.full.VanishingProducer :=
  {
    D := D
    rho := rho
    vanishing := C.toVanishingUpperBound
  }

end DNBoundCertificate

def AnalyticTailSolution.toDNBoundCertificate
    {D : NBHilbertData}
    {rho : D.GeneratorFamily}
    (S : AnalyticTailSolution D rho) :
    DNBoundCertificate D rho :=
  {
    N0 := S.N0
    eps := S.epsTail
    eps_nonneg := S.epsTail_nonneg
    eps_tendsto_zero := S.epsTail_tendsto_zero
    dn_bound := fun N hN => S.DN_tail_le N hN
  }

structure GlobalCancellationData
    (D : NBHilbertData)
    (rho : D.GeneratorFamily) where
  certificate : DNBoundCertificate D rho

structure AlmostOrthogonalityData
    (D : NBHilbertData)
    (rho : D.GeneratorFamily) where
  certificate : DNBoundCertificate D rho

structure ArithmeticTransformData
    (D : NBHilbertData)
    (rho : D.GeneratorFamily) where
  certificate : DNBoundCertificate D rho

structure NewApproximantData
    (D : NBHilbertData)
    (rho : D.GeneratorFamily) where
  solution : AnalyticTailSolution D rho

inductive OpenMathProducer
    (D : NBHilbertData)
    (rho : D.GeneratorFamily) where
  | globalCancellation (d : GlobalCancellationData D rho)
  | almostOrthogonality (d : AlmostOrthogonalityData D rho)
  | arithmeticTransform (d : ArithmeticTransformData D rho)
  | newApproximant (d : NewApproximantData D rho)

def producer_closes_open_math
    {D : NBHilbertData}
    {rho : D.GeneratorFamily}
    (P : OpenMathProducer D rho) :
    DNBoundCertificate D rho := by
  cases P with
  | globalCancellation d => exact d.certificate
  | almostOrthogonality d => exact d.certificate
  | arithmeticTransform d => exact d.certificate
  | newApproximant d => exact d.solution.toDNBoundCertificate

noncomputable def producer_to_vanishing
    {D : NBHilbertData}
    {rho : D.GeneratorFamily}
    (P : OpenMathProducer D rho) :
    Riemann.full.VanishingProducer :=
  (producer_closes_open_math P).toVanishingProducer

structure ArithmeticRouteSolution
    (D : NBHilbertData)
    (rho : D.GeneratorFamily) where
  N0 : ℕ
  delta : ℝ
  coeff : ∀ N, Fin N → ℝ
  epsRegular : ℕ → ℝ
  epsFar : ℕ → ℝ
  epsRegular_nonneg : ∀ N, 0 ≤ epsRegular N
  epsFar_nonneg : ∀ N, 0 ≤ epsFar N
  epsRegular_tendsto_zero :
    Filter.Tendsto epsRegular Filter.atTop (nhds 0)
  epsFar_tendsto_zero :
    Filter.Tendsto epsFar Filter.atTop (nhds 0)
  regular_bound :
    ∀ N, N0 ≤ N →
      regularEnergyPart D rho N delta (coeff N) ≤ epsRegular N
  far_bound :
    ∀ N, N0 ≤ N →
      gramRegionSum D rho N delta (coeff N) .far ≤ epsFar N

namespace ArithmeticRouteSolution

variable
    {D : NBHilbertData}
    {rho : D.GeneratorFamily}

noncomputable def toAnalyticTailSolution
    (S : ArithmeticRouteSolution D rho) :
    AnalyticTailSolution D rho :=
  {
    N0 := S.N0
    coeff := S.coeff
    epsTail := fun N => S.epsRegular N + S.epsFar N
    epsTail_nonneg := fun N =>
      add_nonneg (S.epsRegular_nonneg N) (S.epsFar_nonneg N)
    epsTail_tendsto_zero := by
      simpa using S.epsRegular_tendsto_zero.add S.epsFar_tendsto_zero
    energy_le := fun N hN => by
      rw [residualEnergy_eq_regular_add_far]
      exact add_le_add (S.regular_bound N hN) (S.far_bound N hN)
  }

noncomputable def toDNBoundCertificate
    (S : ArithmeticRouteSolution D rho) :
    DNBoundCertificate D rho :=
  S.toAnalyticTailSolution.toDNBoundCertificate

noncomputable def toArithmeticTransformData
    (S : ArithmeticRouteSolution D rho) :
    ArithmeticTransformData D rho :=
  { certificate := S.toDNBoundCertificate }

noncomputable def toOpenMathProducer
    (S : ArithmeticRouteSolution D rho) :
    OpenMathProducer D rho :=
  .arithmeticTransform S.toArithmeticTransformData

end ArithmeticRouteSolution

def OPEN_MATH_MINCUT_STATE : String :=
  "READY_CONDITIONAL__NEEDS_ONE_OPEN_MATH_PRODUCER_INHABITANT"


/-! ### OPEN_MATH producer architecture

The remaining mathematical frontier is not tied to one representation.
Any one of the following producer routes is sufficient provided it produces
a genuine vanishing majorant for the exact residue error.
-/

inductive ZeroResidueProducerKind where
  | globalCancellation
  | almostOrthogonality
  | arithmeticTransform
  | newApproximant
deriving DecidableEq, Repr

structure ZeroResidueProducer
    (residueError : ℕ → ℝ) where
  kind : ZeroResidueProducerKind
  N0 : ℕ
  eps : ℕ → ℝ
  eps_nonneg : ∀ N, 0 ≤ eps N
  eps_tendsto_zero :
    Filter.Tendsto eps Filter.atTop (nhds 0)
  closes_error :
    ∀ N, N0 ≤ N → |residueError N| ≤ eps N

namespace ZeroResidueProducer

def toControlCertificate
    {residueError : ℕ → ℝ}
    (P : ZeroResidueProducer residueError) :
    ZeroResidueControlCertificate residueError :=
  {
    N0 := P.N0
    majorant := P.eps
    majorant_nonneg := P.eps_nonneg
    majorant_tendsto_zero := P.eps_tendsto_zero
    residue_bound := P.closes_error
  }

theorem closes_open_math_control
    {residueError : ℕ → ℝ}
    (P : ZeroResidueProducer residueError) :
    ZeroResidueControlOpenFrontier residueError := by
  exact ⟨P.toControlCertificate⟩

theorem residue_tendsto_zero
    {residueError : ℕ → ℝ}
    (P : ZeroResidueProducer residueError) :
    Filter.Tendsto residueError Filter.atTop (nhds 0) :=
  P.toControlCertificate.residue_tendsto_zero

end ZeroResidueProducer

def ZERO_RESIDUE_PRODUCER_STATE : String :=
  "OPEN_MATH__NEEDS_ONE_INHABITANT_OF_FOUR_ROUTES"

end Riemann.claims
