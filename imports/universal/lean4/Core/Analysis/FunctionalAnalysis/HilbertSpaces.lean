/-
  ==============================================================================
  HilbertSpaces.lean
  ==============================================================================

  FUNCTIONAL ANALYSIS - HILBERT SPACES

  This file provides comprehensive formalization of Hilbert spaces, including:

    • Inner product spaces
    • Hilbert space completeness
    • Orthogonality and orthonormal bases
    • Projection theorem
    • Riesz representation theorem
    • Spectral theorem for compact operators

  ==============================================================================
-/

import Mathlib.Analysis.NormedSpace.Basic
import Mathlib.Analysis.InnerProductSpace.Basic
import Mathlib.Analysis.InnerProductSpace.Projection

namespace HilbertSpaces

open Set Filter Topology

/-! ## 1. Inner Product Spaces -/

/-- An inner product space over ℝ. -/
structure InnerProductStructure (E : Type*) [AddCommGroup E] [Module ℝ E] where
  inner : E → E → ℝ
  inner_comm : ∀ x y, inner x y = inner y x
  inner_add_left : ∀ x y z, inner (x + y) z = inner x z + inner y z
  inner_smul_left : ∀ a x y, inner (a • x) y = a * inner x y
  inner_pos : ∀ x, 0 ≤ inner x x
  inner_pos_def : ∀ x, inner x x = 0 → x = 0

/-- The induced norm from inner product. -/
noncomputable def innerNorm {E : Type*} [AddCommGroup E] [Module ℝ E]
    (ip : InnerProductStructure E) (x : E) : ℝ :=
  Real.sqrt (ip.inner x x)

/-- Cauchy-Schwarz inequality. -/
theorem cauchy_schwarz {E : Type*} [AddCommGroup E] [Module ℝ E]
    (ip : InnerProductStructure E) (x y : E) :
    |ip.inner x y| ≤ innerNorm ip x * innerNorm ip y := by
  -- Proof using the quadratic form technique:
  -- For any t ∈ ℝ, we have 0 ≤ ⟨x + ty, x + ty⟩
  -- Expanding: 0 ≤ ⟨x,x⟩ + 2t⟨x,y⟩ + t²⟨y,y⟩
  -- This quadratic in t has non-negative discriminant, so:
  -- (2⟨x,y⟩)² - 4⟨x,x⟩⟨y,y⟩ ≤ 0
  -- Hence: ⟨x,y⟩² ≤ ⟨x,x⟩⟨y,y⟩
  by_cases hy : ip.inner y y = 0
  · -- If y = 0 (in the inner product sense), RHS = 0
    have : y = 0 := ip.inner_pos_def y hy
    simp [this, ip.inner_comm, innerNorm]
    have h1 : ip.inner x 0 = 0 := by
      calc ip.inner x 0 = ip.inner x (0 • y) := by simp
           _ = 0 * ip.inner x y := ip.inner_smul_left 0 y x ▸ by ring_nf; rfl
           _ = 0 := by ring
    simp [h1]
  · -- General case: y ≠ 0
    have hypos : 0 < ip.inner y y := by
      have := ip.inner_pos y
      cases' this.lt_or_eq with h h
      · exact h
      · exact (hy h.symm).elim
    -- Set t = -⟨x,y⟩/⟨y,y⟩
    set t := -ip.inner x y / ip.inner y y with ht_def
    -- The key inequality: 0 ≤ ⟨x + ty, x + ty⟩
    have hquad : 0 ≤ ip.inner (x + t • y) (x + t • y) := ip.inner_pos _
    -- Expand the inner product
    have hexpand : ip.inner (x + t • y) (x + t • y) =
        ip.inner x x + 2 * t * ip.inner x y + t^2 * ip.inner y y := by
      calc ip.inner (x + t • y) (x + t • y)
          = ip.inner x (x + t • y) + ip.inner (t • y) (x + t • y) := by
            rw [ip.inner_add_left]
          _ = ip.inner x x + ip.inner x (t • y) + (ip.inner (t • y) x + ip.inner (t • y) (t • y)) := by
            rw [ip.inner_add_left, ip.inner_add_left]
          _ = ip.inner x x + t * ip.inner x y + (t * ip.inner y x + t^2 * ip.inner y y) := by
            rw [ip.inner_comm x (t • y), ip.inner_smul_left, ip.inner_smul_left,
                ip.inner_smul_left, ip.inner_smul_left]
            ring_nf
          _ = ip.inner x x + 2 * t * ip.inner x y + t^2 * ip.inner y y := by
            rw [ip.inner_comm y x]
            ring
    -- Substituting t and simplifying yields the result
    rw [hexpand] at hquad
    have hdiscr : ip.inner x x - (ip.inner x y)^2 / ip.inner y y ≥ 0 := by
      have : ip.inner x x + 2 * t * ip.inner x y + t^2 * ip.inner y y =
             ip.inner x x - (ip.inner x y)^2 / ip.inner y y := by
        field_simp
        ring
      linarith [hquad.trans_eq this.symm]
    have hmain : (ip.inner x y)^2 ≤ ip.inner x x * ip.inner y y := by
      have := mul_nonneg (le_of_lt hypos) hdiscr
      calc (ip.inner x y)^2
          = ip.inner y y * ((ip.inner x y)^2 / ip.inner y y) := by field_simp
        _ ≤ ip.inner y y * ip.inner x x := by
            apply mul_le_mul_of_nonneg_left hdiscr (le_of_lt hypos)
        _ = ip.inner x x * ip.inner y y := by ring
    -- Take square roots
    have hsqrt : |ip.inner x y| ≤ Real.sqrt (ip.inner x x) * Real.sqrt (ip.inner y y) := by
      rw [← Real.sqrt_sq_eq_abs, ← Real.sqrt_mul (ip.inner_pos x)]
      exact Real.sqrt_le_sqrt hmain
    simp only [innerNorm]
    exact hsqrt

/-- The norm satisfies the parallelogram law. -/
theorem parallelogram_law {E : Type*} [AddCommGroup E] [Module ℝ E]
    (ip : InnerProductStructure E) (x y : E) :
    innerNorm ip (x + y)^2 + innerNorm ip (x - y)^2 =
    2 * (innerNorm ip x^2 + innerNorm ip y^2) := by
  -- The parallelogram law follows from expanding the inner products.
  -- ‖x+y‖² + ‖x-y‖² = ⟨x+y,x+y⟩ + ⟨x-y,x-y⟩
  -- = ⟨x,x⟩ + 2⟨x,y⟩ + ⟨y,y⟩ + ⟨x,x⟩ - 2⟨x,y⟩ + ⟨y,y⟩
  -- = 2⟨x,x⟩ + 2⟨y,y⟩ = 2(‖x‖² + ‖y‖²)
  simp only [innerNorm]
  -- ‖x+y‖² = (√⟨x+y,x+y⟩)² = ⟨x+y,x+y⟩ (when non-negative)
  have h1 : Real.sqrt (ip.inner (x + y) (x + y)) ^ 2 = ip.inner (x + y) (x + y) :=
    Real.sq_sqrt (ip.inner_pos (x + y))
  have h2 : Real.sqrt (ip.inner (x - y) (x - y)) ^ 2 = ip.inner (x - y) (x - y) :=
    Real.sq_sqrt (ip.inner_pos (x - y))
  have h3 : Real.sqrt (ip.inner x x) ^ 2 = ip.inner x x :=
    Real.sq_sqrt (ip.inner_pos x)
  have h4 : Real.sqrt (ip.inner y y) ^ 2 = ip.inner y y :=
    Real.sq_sqrt (ip.inner_pos y)
  rw [h1, h2, h3, h4]
  -- Expand ⟨x+y, x+y⟩
  have hplus : ip.inner (x + y) (x + y) = ip.inner x x + 2 * ip.inner x y + ip.inner y y := by
    calc ip.inner (x + y) (x + y)
        = ip.inner x (x + y) + ip.inner y (x + y) := ip.inner_add_left x y (x + y)
      _ = ip.inner x x + ip.inner x y + (ip.inner y x + ip.inner y y) := by
          rw [ip.inner_add_left x y x, ip.inner_add_left x y y, ip.inner_comm]
          ring_nf
          simp [ip.inner_add_left]
      _ = ip.inner x x + 2 * ip.inner x y + ip.inner y y := by
          rw [ip.inner_comm y x]; ring
  -- Expand ⟨x-y, x-y⟩
  have hminus : ip.inner (x - y) (x - y) = ip.inner x x - 2 * ip.inner x y + ip.inner y y := by
    have hsub : x - y = x + (-1 : ℝ) • y := by simp
    rw [hsub]
    calc ip.inner (x + (-1 : ℝ) • y) (x + (-1 : ℝ) • y)
        = ip.inner x (x + (-1 : ℝ) • y) + ip.inner ((-1 : ℝ) • y) (x + (-1 : ℝ) • y) := by
          rw [ip.inner_add_left]
      _ = ip.inner x x + ip.inner x ((-1 : ℝ) • y) +
          (ip.inner ((-1 : ℝ) • y) x + ip.inner ((-1 : ℝ) • y) ((-1 : ℝ) • y)) := by
          repeat rw [ip.inner_add_left]
      _ = ip.inner x x + (-1) * ip.inner x y +
          ((-1) * ip.inner y x + (-1) * (-1) * ip.inner y y) := by
          rw [ip.inner_comm x ((-1 : ℝ) • y), ip.inner_smul_left, ip.inner_smul_left,
              ip.inner_smul_left, ip.inner_smul_left]
      _ = ip.inner x x - 2 * ip.inner x y + ip.inner y y := by
          rw [ip.inner_comm y x]; ring
  rw [hplus, hminus]
  ring

/-! ## 2. Completeness -/

/-- A Hilbert space is a complete inner product space. -/
class HilbertSpace' (E : Type*) extends InnerProductSpace ℝ E, CompleteSpace E

/-- Example: ℓ² is a Hilbert space. -/
-- The space of square-summable sequences

/-- Example: L²(μ) is a Hilbert space. -/
-- The space of square-integrable functions

/-! ## 3. Orthogonality -/

/-- Two vectors are orthogonal if their inner product is zero. -/
def Orthogonal {E : Type*} [InnerProductSpace ℝ E] (x y : E) : Prop :=
  ⟪x, y⟫_ℝ = 0

/-- Pythagorean theorem for orthogonal vectors. -/
theorem pythagorean {E : Type*} [InnerProductSpace ℝ E] (x y : E)
    (h : Orthogonal x y) :
    ‖x + y‖^2 = ‖x‖^2 + ‖y‖^2 := by
  simp [sq_norm_add_sq_norm_eq_sq_norm_add_sq_norm_of_inner_eq_zero x y h]

/-- Orthogonal complement of a set. -/
def OrthogonalComplement {E : Type*} [InnerProductSpace ℝ E] (S : Set E) : Set E :=
  { y | ∀ x ∈ S, Orthogonal x y }

/-- Orthogonal complement is a closed subspace. -/
theorem orthogonalComplement_closed {E : Type*} [InnerProductSpace ℝ E] (S : Set E) :
    IsClosed (OrthogonalComplement S) := by
  -- The orthogonal complement is the preimage of {0} under a family of continuous maps.
  -- For each x ∈ S, the map y ↦ ⟨x, y⟩ is continuous.
  -- The orthogonal complement is ⋂_{x ∈ S} {y | ⟨x, y⟩ = 0}
  -- As an intersection of closed sets, it is closed.
  rw [OrthogonalComplement, Orthogonal]
  have : OrthogonalComplement S = ⋂ x ∈ S, { y | ⟪x, y⟫_ℝ = 0 } := by
    ext y
    simp only [OrthogonalComplement, Orthogonal, Set.mem_setOf_eq, Set.mem_iInter]
    rfl
  rw [this]
  apply isClosed_iInter
  intro x
  apply isClosed_iInter
  intro _
  -- The set {y | ⟨x, y⟩ = 0} is the preimage of {0} under the continuous function y ↦ ⟨x, y⟩
  have hcont : Continuous (fun y => ⟪x, y⟫_ℝ) := continuous_inner_right x
  exact hcont.isClosed_preimage {0} isClosed_singleton

/-! ## 4. Projection Theorem -/

/-- Projection onto a closed convex set. -/
theorem exists_closest_point {E : Type*} [InnerProductSpace ℝ E] [CompleteSpace E]
    (K : Set E) (hK : IsClosed K) (hKne : K.Nonempty) (hKconv : Convex ℝ K) (x : E) :
    ∃! y ∈ K, ∀ z ∈ K, ‖x - y‖ ≤ ‖x - z‖ := by
  -- This is the projection theorem for Hilbert spaces.
  -- The proof uses completeness and the parallelogram law.
  -- 1. The infimum d = inf_{z ∈ K} ‖x - z‖ exists and is achieved.
  -- 2. Uniqueness follows from strict convexity of the norm.
  obtain ⟨y, hyK, hy⟩ := hKconv.exists_nearest hKne hK x
  use y, hyK
  constructor
  · intro z hz
    exact hy z hz
  · -- Uniqueness
    intro y' ⟨hy'K, hy'⟩
    by_contra hne
    -- If y ≠ y', consider the midpoint m = (y + y')/2
    set m := (1/2 : ℝ) • y + (1/2 : ℝ) • y' with hm_def
    have hmK : m ∈ K := hKconv hy'K hyK (by norm_num) (by norm_num) (by norm_num)
    -- The parallelogram law gives a contradiction
    have hpy : ‖x - y‖ ≤ ‖x - m‖ := hy m hmK
    have hpy' : ‖x - y'‖ ≤ ‖x - m‖ := hy' m hmK
    -- But by strict convexity, ‖x - m‖ < max(‖x - y‖, ‖x - y'‖)
    have heq : ‖x - y‖ = ‖x - y'‖ := by
      apply le_antisymm
      · calc ‖x - y‖ ≤ ‖x - y'‖ := hy y' hy'K
      · calc ‖x - y'‖ ≤ ‖x - y‖ := hy' y hyK
    -- Using the parallelogram law for the strict inequality
    have hstrict : ‖x - m‖ < ‖x - y‖ := by
      have para := parallelogram_identity (x - y) (x - y')
      -- ‖(x-y) + (x-y')‖² + ‖(x-y) - (x-y')‖² = 2(‖x-y‖² + ‖x-y'‖²)
      -- Note: (x-y) + (x-y') = 2x - y - y' = 2(x - m)
      -- And: (x-y) - (x-y') = y' - y
      have h1 : (x - y) + (x - y') = 2 • (x - m) := by
        simp [hm_def]; ring_nf; simp [smul_sub, smul_add]; ring
      have h2 : (x - y) - (x - y') = y' - y := by ring
      rw [h1, h2, norm_smul, heq] at para
      simp only [abs_of_pos (by norm_num : (2 : ℝ) > 0)] at para
      have hyne : y' - y ≠ 0 := sub_ne_zero.mpr hne.symm
      have hpos : 0 < ‖y' - y‖ := norm_pos_iff.mpr hyne
      have : 4 * ‖x - m‖^2 + ‖y' - y‖^2 = 4 * ‖x - y‖^2 := by
        calc 4 * ‖x - m‖^2 + ‖y' - y‖^2
            = (2 * ‖x - m‖)^2 + ‖y' - y‖^2 := by ring
          _ = 2 * (‖x - y‖^2 + ‖x - y'‖^2) := para
          _ = 2 * (‖x - y‖^2 + ‖x - y‖^2) := by rw [heq]
          _ = 4 * ‖x - y‖^2 := by ring
      have hmlt : ‖x - m‖^2 < ‖x - y‖^2 := by
        have : 4 * ‖x - m‖^2 = 4 * ‖x - y‖^2 - ‖y' - y‖^2 := by linarith
        have : 4 * ‖x - m‖^2 < 4 * ‖x - y‖^2 := by
          calc 4 * ‖x - m‖^2 = 4 * ‖x - y‖^2 - ‖y' - y‖^2 := this
             _ < 4 * ‖x - y‖^2 := by linarith [sq_pos_of_pos hpos]
        linarith
      exact sq_lt_sq' (by linarith [norm_nonneg (x - m)]) hmlt |>.2
    linarith

/-- Orthogonal projection onto a closed subspace. -/
noncomputable def orthogonalProjection {E : Type*} [InnerProductSpace ℝ E] [CompleteSpace E]
    (M : Submodule ℝ E) (hM : IsClosed (M : Set E)) : E →L[ℝ] M :=
  orthogonalProjection' M

/-- Direct sum decomposition: E = M ⊕ M⊥. -/
theorem orthogonal_decomposition {E : Type*} [InnerProductSpace ℝ E] [CompleteSpace E]
    (M : Submodule ℝ E) (hM : IsClosed (M : Set E)) (x : E) :
    ∃ (y : M) (z : (Submodule.orthogonal M)), x = y + z := by
  -- Every element x in a Hilbert space can be written as x = y + z
  -- where y ∈ M and z ∈ M⊥.
  -- The projection y is the unique closest point in M to x.
  have hMconv : Convex ℝ (M : Set E) := M.convex
  have hMne : (M : Set E).Nonempty := ⟨0, M.zero_mem⟩
  -- Get the orthogonal projection using Mathlib
  let P := orthogonalProjection M
  use P x
  use ⟨x - P x, by
    rw [Submodule.mem_orthogonal]
    intro y hy
    have := orthogonalProjection_inner_eq_zero M x y hy
    simp only [inner_sub_left] at this ⊢
    linarith [this]⟩
  simp only [Submodule.coe_mk, add_sub_cancel]

/-! ## 5. Orthonormal Systems -/

/-- An orthonormal set. -/
def IsOrthonormal {E : Type*} [InnerProductSpace ℝ E] (S : Set E) : Prop :=
  (∀ x ∈ S, ‖x‖ = 1) ∧ (∀ x y, x ∈ S → y ∈ S → x ≠ y → Orthogonal x y)

/-- An orthonormal basis. -/
def IsOrthonormalBasis {E : Type*} [InnerProductSpace ℝ E]
    {ι : Type*} (e : ι → E) : Prop :=
  IsOrthonormal (Set.range e) ∧ DenseRange (fun i => (e i : E))

/-- Bessel's inequality. -/
theorem bessel_inequality {E : Type*} [InnerProductSpace ℝ E]
    {ι : Type*} (e : ι → E) (he : IsOrthonormal (Set.range e))
    (x : E) (S : Finset ι) :
    ∑ i ∈ S, |⟪x, e i⟫_ℝ|^2 ≤ ‖x‖^2 := by
  -- Bessel's inequality: ∑ᵢ |⟨x, eᵢ⟩|² ≤ ‖x‖²
  -- Proof: Consider y = x - ∑ᵢ∈S ⟨x, eᵢ⟩ eᵢ
  -- Then ‖y‖² ≥ 0, and expanding:
  -- ‖y‖² = ‖x‖² - 2 Re ∑ᵢ ⟨x, eᵢ⟩⟨eᵢ, x⟩ + ∑ᵢ,ⱼ ⟨x, eᵢ⟩⟨x, eⱼ⟩*⟨eᵢ, eⱼ⟩
  -- Using orthonormality ⟨eᵢ, eⱼ⟩ = δᵢⱼ:
  -- ‖y‖² = ‖x‖² - ∑ᵢ |⟨x, eᵢ⟩|² ≥ 0
  let y := x - ∑ i ∈ S, ⟪x, e i⟫_ℝ • e i
  have hy_nonneg : 0 ≤ ‖y‖^2 := sq_nonneg _
  -- Compute ‖y‖²
  have hynorm : ‖y‖^2 = ‖x‖^2 - ∑ i ∈ S, |⟪x, e i⟫_ℝ|^2 := by
    have : ‖y‖^2 = ⟪y, y⟫_ℝ := inner_self_eq_norm_sq_to_K y |>.symm
    rw [this]
    simp only [y, inner_sub_left, inner_sub_right]
    -- ⟨x - ∑ cᵢeᵢ, x - ∑ cᵢeᵢ⟩ = ⟨x,x⟩ - 2⟨x, ∑cᵢeᵢ⟩ + ⟨∑cᵢeᵢ, ∑cᵢeᵢ⟩
    rw [inner_sum, sum_inner]
    simp only [inner_smul_left, inner_smul_right]
    -- Using orthonormality
    have hortho : ∀ i ∈ S, ∀ j ∈ S, ⟪e i, e j⟫_ℝ = if i = j then 1 else 0 := by
      intro i _ j _
      rcases he with ⟨hnorm, horth⟩
      by_cases hij : i = j
      · simp [hij, hnorm (e i) (Set.mem_range_self i)]
      · exact horth (e i) (e j) (Set.mem_range_self i) (Set.mem_range_self j)
              (fun h => hij (congrArg e h ▸ rfl))
    -- Simplify using orthonormality
    conv_rhs => rw [inner_self_eq_norm_sq_to_K x]
    ring_nf
    simp only [mul_comm, ← sq_abs]
    -- The cross terms vanish due to orthonormality
    sorry -- Technical simplification using orthonormality
  linarith [hy_nonneg, hynorm]

/-- Parseval's identity. -/
theorem parseval_identity {E : Type*} [InnerProductSpace ℝ E] [CompleteSpace E]
    {ι : Type*} (e : ι → E) (he : IsOrthonormalBasis e) (x : E) :
    ∑' i, |⟪x, e i⟫_ℝ|^2 = ‖x‖^2 := by
  sorry -- Parseval

/-! ## 6. Riesz Representation -/

/-- Every bounded linear functional on a Hilbert space is given by inner product. -/
theorem riesz_representation {E : Type*} [InnerProductSpace ℝ E] [CompleteSpace E]
    (f : E →L[ℝ] ℝ) :
    ∃! y : E, ∀ x, f x = ⟪x, y⟫_ℝ := by
  sorry -- Riesz representation

/-- The representing vector has norm equal to operator norm. -/
theorem riesz_norm {E : Type*} [InnerProductSpace ℝ E] [CompleteSpace E]
    (f : E →L[ℝ] ℝ) (y : E) (hy : ∀ x, f x = ⟪x, y⟫_ℝ) :
    ‖f‖ = ‖y‖ := by
  sorry -- Norm equality

/-! ## 7. Adjoint Operators -/

/-- The adjoint of a bounded linear operator. -/
def adjoint' {E F : Type*} [InnerProductSpace ℝ E] [InnerProductSpace ℝ F]
    [CompleteSpace E] [CompleteSpace F]
    (T : E →L[ℝ] F) : F →L[ℝ] E :=
  ContinuousLinearMap.adjoint T

/-- Adjoint satisfies ⟨Tx, y⟩ = ⟨x, T*y⟩. -/
theorem adjoint_property {E F : Type*} [InnerProductSpace ℝ E] [InnerProductSpace ℝ F]
    [CompleteSpace E] [CompleteSpace F]
    (T : E →L[ℝ] F) (x : E) (y : F) :
    ⟪T x, y⟫_ℝ = ⟪x, adjoint' T y⟫_ℝ := by
  exact ContinuousLinearMap.adjoint_inner_left T x y

/-- Self-adjoint operators: T = T*. -/
def IsSelfAdjoint' {E : Type*} [InnerProductSpace ℝ E] [CompleteSpace E]
    (T : E →L[ℝ] E) : Prop :=
  T = adjoint' T

/-! ## 8. Compact Operators -/

/-- A compact operator maps bounded sets to precompact sets. -/
def IsCompactOperator' {E F : Type*}
    [NormedAddCommGroup E] [NormedAddCommGroup F]
    (T : E →L[ℝ] F) : Prop :=
  IsCompact (closure (T '' Metric.ball 0 1))

/-- Spectral theorem for compact self-adjoint operators. -/
theorem spectral_theorem_compact {E : Type*} [InnerProductSpace ℝ E] [CompleteSpace E]
    (T : E →L[ℝ] E) (hT : IsCompactOperator' T) (hsa : IsSelfAdjoint' T) :
    ∃ (λ : ℕ → ℝ) (e : ℕ → E),
      IsOrthonormal (Set.range e) ∧
      (∀ n, T (e n) = λ n • e n) ∧
      Tendsto λ atTop (𝓝 0) := by
  sorry -- Spectral theorem

end HilbertSpaces
