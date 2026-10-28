/-
  ==============================================================================
  NormedSpaces.lean
  ==============================================================================

  NORMED VECTOR SPACES - FOUNDATIONAL THEORY

  This file provides a comprehensive formalization of normed vector spaces,
  including:

    • Basic definitions (norm, normed space axioms)
    • Normed vector space structure
    • Induced metric from norm
    • Bounded linear operators
    • Equivalent norms
    • Quotient normed spaces
    • Finite-dimensional normed spaces
    • Completeness and Banach spaces (preview)

  ==============================================================================
-/

import Mathlib.Analysis.Normed.Field.Basic
import Mathlib.Analysis.Normed.Group.Basic
import Mathlib.Topology.MetricSpace.Basic

namespace NormedSpaces

/-! ## 1. Basic Definitions -/

/-- A seminorm on a vector space over a field K. -/
structure Seminorm (K : Type*) (V : Type*) [Field K] [AddCommGroup V] [Module K V] where
  toFun : V → ℝ
  nonneg : ∀ v, 0 ≤ toFun v
  smul : ∀ (a : K) (v : V), toFun (a • v) = ‖a‖ * toFun v
  triangle : ∀ v w, toFun (v + w) ≤ toFun v + toFun w

/-- A norm is a seminorm where only zero has norm zero. -/
structure NormAxioms (K : Type*) (V : Type*) [Field K] [AddCommGroup V] [Module K V]
    extends Seminorm K V where
  eq_zero : ∀ v, toFun v = 0 → v = 0

/-- Normed space axioms bundled as a structure. -/
structure NormedSpaceStructure (K : Type*) (V : Type*) [NormedField K] [AddCommGroup V] [Module K V] where
  norm : V → ℝ
  norm_nonneg : ∀ v, 0 ≤ norm v
  norm_eq_zero : ∀ v, norm v = 0 ↔ v = 0
  norm_add_le : ∀ v w, norm (v + w) ≤ norm v + norm w
  norm_smul : ∀ (a : K) (v : V), norm (a • v) = ‖a‖ * norm v

/-! ## 2. Properties of Norms -/

variable {K : Type*} {V : Type*} [NormedField K] [AddCommGroup V] [Module K V]

/-- The norm of zero is zero. -/
theorem norm_zero (N : NormedSpaceStructure K V) : N.norm 0 = 0 := by
  rw [N.norm_eq_zero]

/-- The norm of the negative is the same as the norm. -/
theorem norm_neg (N : NormedSpaceStructure K V) (v : V) : N.norm (-v) = N.norm v := by
  have h1 : N.norm (-v) = N.norm ((-1 : K) • v) := by simp
  rw [h1, N.norm_smul]
  simp [norm_neg_one]

/-- Reverse triangle inequality. -/
theorem norm_sub_le (N : NormedSpaceStructure K V) (v w : V) :
    |N.norm v - N.norm w| ≤ N.norm (v - w) := by
  have h1 : N.norm v ≤ N.norm (v - w) + N.norm w := by
    calc N.norm v = N.norm ((v - w) + w) := by ring_nf
         _ ≤ N.norm (v - w) + N.norm w := N.norm_add_le _ _
  have h2 : N.norm w ≤ N.norm (w - v) + N.norm v := by
    calc N.norm w = N.norm ((w - v) + v) := by ring_nf
         _ ≤ N.norm (w - v) + N.norm v := N.norm_add_le _ _
  have h3 : N.norm (w - v) = N.norm (v - w) := by
    calc N.norm (w - v) = N.norm (-(v - w)) := by ring_nf
         _ = N.norm (v - w) := norm_neg N _
  rw [h3] at h2
  exact abs_sub_le_iff.mpr ⟨by linarith, by linarith⟩

/-! ## 3. Induced Metric from Norm -/

/-- Every normed space induces a metric space structure. -/
def inducedMetric (N : NormedSpaceStructure K V) : MetricSpaces.PremetricSpace V where
  dist := fun v w => N.norm (v - w)
  dist_nonneg := fun v w => N.norm_nonneg _
  dist_sym := fun v w => by
    calc N.norm (v - w) = N.norm (-(w - v)) := by ring_nf
         _ = N.norm (w - v) := norm_neg N _
  dist_triangle := fun v w z => by
    calc N.norm (v - z) = N.norm ((v - w) + (w - z)) := by ring_nf
         _ ≤ N.norm (v - w) + N.norm (w - z) := N.norm_add_le _ _

/-! ## 4. Bounded Linear Operators -/

/-- A linear map between normed spaces is bounded if the operator norm is finite. -/
structure BoundedLinearMap (K : Type*) (V W : Type*)
    [NormedField K] [AddCommGroup V] [Module K V] [AddCommGroup W] [Module K W]
    (NV : NormedSpaceStructure K V) (NW : NormedSpaceStructure K W) where
  toFun : V → W
  map_add : ∀ v₁ v₂, toFun (v₁ + v₂) = toFun v₁ + toFun v₂
  map_smul : ∀ (a : K) (v : V), toFun (a • v) = a • toFun v
  bound : ℝ
  bound_nonneg : 0 ≤ bound
  le_bound : ∀ v, NW.norm (toFun v) ≤ bound * NV.norm v

/-- The operator norm of a bounded linear map. -/
noncomputable def operatorNorm {K V W : Type*}
    [NormedField K] [AddCommGroup V] [Module K V] [AddCommGroup W] [Module K W]
    (NV : NormedSpaceStructure K V) (NW : NormedSpaceStructure K W)
    (T : BoundedLinearMap K V W NV NW) : ℝ :=
  sSup { NW.norm (T.toFun v) / NV.norm v | (v : V) (hv : v ≠ 0) }

/-- The composition of bounded linear maps is bounded. -/
def BoundedLinearMap.comp {K V W U : Type*}
    [NormedField K]
    [AddCommGroup V] [Module K V]
    [AddCommGroup W] [Module K W]
    [AddCommGroup U] [Module K U]
    (NV : NormedSpaceStructure K V)
    (NW : NormedSpaceStructure K W)
    (NU : NormedSpaceStructure K U)
    (S : BoundedLinearMap K W U NW NU)
    (T : BoundedLinearMap K V W NV NW) :
    BoundedLinearMap K V U NV NU where
  toFun := S.toFun ∘ T.toFun
  map_add := fun v₁ v₂ => by simp [T.map_add, S.map_add]
  map_smul := fun a v => by simp [T.map_smul, S.map_smul]
  bound := S.bound * T.bound
  bound_nonneg := mul_nonneg S.bound_nonneg T.bound_nonneg
  le_bound := fun v => by
    calc NU.norm (S.toFun (T.toFun v))
        ≤ S.bound * NW.norm (T.toFun v) := S.le_bound _
      _ ≤ S.bound * (T.bound * NV.norm v) := by
          apply mul_le_mul_of_nonneg_left (T.le_bound v) S.bound_nonneg
      _ = (S.bound * T.bound) * NV.norm v := by ring

/-! ## 5. Equivalent Norms -/

/-- Two norms are equivalent if they define the same topology. -/
def EquivalentNorms (N₁ N₂ : NormedSpaceStructure K V) : Prop :=
  ∃ c₁ c₂ : ℝ, c₁ > 0 ∧ c₂ > 0 ∧
    (∀ v, N₁.norm v ≤ c₁ * N₂.norm v) ∧
    (∀ v, N₂.norm v ≤ c₂ * N₁.norm v)

/-- Equivalence of norms is reflexive. -/
theorem EquivalentNorms.refl (N : NormedSpaceStructure K V) : EquivalentNorms N N := by
  use 1, 1
  simp [le_refl]

/-- Equivalence of norms is symmetric. -/
theorem EquivalentNorms.symm {N₁ N₂ : NormedSpaceStructure K V}
    (h : EquivalentNorms N₁ N₂) : EquivalentNorms N₂ N₁ := by
  obtain ⟨c₁, c₂, hc₁, hc₂, h₁, h₂⟩ := h
  exact ⟨c₂, c₁, hc₂, hc₁, h₂, h₁⟩

/-- Equivalence of norms is transitive. -/
theorem EquivalentNorms.trans {N₁ N₂ N₃ : NormedSpaceStructure K V}
    (h₁₂ : EquivalentNorms N₁ N₂) (h₂₃ : EquivalentNorms N₂ N₃) :
    EquivalentNorms N₁ N₃ := by
  obtain ⟨c₁, c₂, hc₁, hc₂, h₁, h₂⟩ := h₁₂
  obtain ⟨d₁, d₂, hd₁, hd₂, h₃, h₄⟩ := h₂₃
  use c₁ * d₁, c₂ * d₂
  constructor; · positivity
  constructor; · positivity
  constructor
  · intro v
    calc N₁.norm v ≤ c₁ * N₂.norm v := h₁ v
         _ ≤ c₁ * (d₁ * N₃.norm v) := by
           apply mul_le_mul_of_nonneg_left (h₃ v) (le_of_lt hc₁)
         _ = (c₁ * d₁) * N₃.norm v := by ring
  · intro v
    calc N₃.norm v ≤ d₂ * N₂.norm v := h₄ v
         _ ≤ d₂ * (c₂ * N₁.norm v) := by
           apply mul_le_mul_of_nonneg_left (h₂ v) (le_of_lt hd₂)
         _ = (c₂ * d₂) * N₁.norm v := by ring

/-! ## 6. Unit Ball and Unit Sphere -/

/-- The open unit ball in a normed space. -/
def unitBall (N : NormedSpaceStructure K V) : Set V :=
  { v | N.norm v < 1 }

/-- The closed unit ball in a normed space. -/
def closedUnitBall (N : NormedSpaceStructure K V) : Set V :=
  { v | N.norm v ≤ 1 }

/-- The unit sphere in a normed space. -/
def unitSphere (N : NormedSpaceStructure K V) : Set V :=
  { v | N.norm v = 1 }

/-- The unit ball is convex. -/
theorem unitBall_convex (N : NormedSpaceStructure K V) :
    ∀ v w ∈ closedUnitBall N, ∀ t : ℝ, 0 ≤ t → t ≤ 1 →
      (1 - t) • v + t • w ∈ closedUnitBall N := by
  intro v hv w hw t ht0 ht1
  simp only [closedUnitBall, Set.mem_setOf_eq] at *
  sorry -- Requires more infrastructure about norms of combinations

/-! ## 7. Dual Spaces -/

/-- The dual space of a normed space (bounded linear functionals). -/
structure DualSpace (K : Type*) (V : Type*)
    [NormedField K] [AddCommGroup V] [Module K V]
    (N : NormedSpaceStructure K V) where
  functionals : Set (BoundedLinearMap K V K N ⟨norm, norm_nonneg, fun _ => norm_eq_zero, norm_add_le, norm_smul⟩)

/-- The dual norm is the operator norm of a functional. -/
noncomputable def dualNorm {K V : Type*} [NormedField K] [AddCommGroup V] [Module K V]
    (N : NormedSpaceStructure K V)
    (f : BoundedLinearMap K V K N ⟨norm, norm_nonneg, fun _ => norm_eq_zero, norm_add_le, norm_smul⟩) : ℝ :=
  sSup { ‖f.toFun v‖ / N.norm v | (v : V) (hv : v ≠ 0) }

/-! ## 8. Completeness -/

/-- A normed space is complete (Banach) if Cauchy sequences converge. -/
def IsComplete (N : NormedSpaceStructure K V) : Prop :=
  MetricSpaces.IsComplete V (MetricSpaces.MetricSpaceAxioms.mk
    (inducedMetric N)
    (fun v w => by
      simp only [inducedMetric]
      constructor
      · intro h
        have := N.norm_eq_zero (v - w)
        rw [this] at h
        linarith [show v - w = 0 from h, sub_eq_zero.mp h]
      · intro h
        simp [h, norm_zero N]))

/-! ## 9. Finite-Dimensional Normed Spaces -/

/-- All norms on a finite-dimensional space are equivalent (statement). -/
theorem finite_dim_norms_equivalent (K : Type*) (V : Type*)
    [NormedField K] [AddCommGroup V] [Module K V]
    [FiniteDimensional K V]
    (N₁ N₂ : NormedSpaceStructure K V) :
    EquivalentNorms N₁ N₂ := by
  sorry -- This is a deep theorem requiring significant infrastructure

/-- Finite-dimensional normed spaces are complete. -/
theorem finite_dim_complete (K : Type*) (V : Type*)
    [NormedField K] [AddCommGroup V] [Module K V]
    [FiniteDimensional K V]
    (N : NormedSpaceStructure K V) :
    IsComplete N := by
  sorry -- This requires the finite_dim_norms_equivalent theorem

/-! ## 10. Quotient Normed Spaces -/

/-- The quotient norm on V/W for a closed subspace W. -/
structure QuotientNorm (K V : Type*) [NormedField K] [AddCommGroup V] [Module K V]
    (N : NormedSpaceStructure K V) (W : Submodule K V) where
  norm : V ⧸ W → ℝ
  well_defined : ∀ v₁ v₂ : V, (v₁ : V ⧸ W) = (v₂ : V ⧸ W) →
    ∀ ε > 0, ∃ w ∈ W, N.norm (v₁ - w) < N.norm (v₂ - 0) + ε

/-- The infimum definition of quotient norm. -/
noncomputable def quotientNormInf (K V : Type*) [NormedField K] [AddCommGroup V] [Module K V]
    (N : NormedSpaceStructure K V) (W : Submodule K V) (q : V ⧸ W) : ℝ :=
  sInf { N.norm v | (v : V) (hv : (v : V ⧸ W) = q) }

end NormedSpaces
