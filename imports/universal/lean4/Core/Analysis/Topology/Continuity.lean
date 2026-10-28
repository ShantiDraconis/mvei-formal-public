/-
  ==============================================================================
  Continuity.lean
  ==============================================================================

  CONTINUITY IN TOPOLOGICAL AND METRIC SPACES

  This file provides a comprehensive formalization of continuity, including:

    • Topological continuity
    • Sequential continuity
    • Epsilon-delta continuity
    • Uniform continuity
    • Lipschitz continuity
    • Hölder continuity
    • Semicontinuity
    • Continuity of compositions
    • Homeomorphisms (preview)

  ==============================================================================
-/

import Mathlib.Topology.Basic
import Mathlib.Topology.ContinuousFunction.Basic
import Mathlib.Topology.UniformSpace.Basic
import Mathlib.Analysis.SpecialFunctions.Pow.Continuity

namespace ContinuityTheory

open Set Filter Topology

/-! ## 1. Topological Continuity -/

/-- A function is continuous at a point if preimages of neighborhoods are neighborhoods. -/
def ContinuousAtPoint {α β : Type*} [TopologicalSpace α] [TopologicalSpace β]
    (f : α → β) (x : α) : Prop :=
  ∀ U : Set β, U ∈ 𝓝 (f x) → f ⁻¹' U ∈ 𝓝 x

/-- Global continuity: continuous at every point. -/
def ContinuousGlobal {α β : Type*} [TopologicalSpace α] [TopologicalSpace β]
    (f : α → β) : Prop :=
  ∀ x, ContinuousAtPoint f x

/-- Equivalent characterization via preimages of open sets. -/
theorem continuous_iff_preimage_open {α β : Type*}
    [TopologicalSpace α] [TopologicalSpace β] (f : α → β) :
    Continuous f ↔ ∀ U : Set β, IsOpen U → IsOpen (f ⁻¹' U) := by
  exact continuous_def

/-- Equivalent characterization via preimages of closed sets. -/
theorem continuous_iff_preimage_closed {α β : Type*}
    [TopologicalSpace α] [TopologicalSpace β] (f : α → β) :
    Continuous f ↔ ∀ C : Set β, IsClosed C → IsClosed (f ⁻¹' C) := by
  constructor
  · intro hf C hC
    exact hC.preimage hf
  · intro h
    rw [continuous_def]
    intro U hU
    rw [← isOpen_compl_iff, ← preimage_compl]
    exact (h Uᶜ hU.isClosed_compl).isOpen_compl

/-! ## 2. Sequential Continuity -/

/-- Sequential continuity: preserves convergent sequences. -/
def SequentiallyContinuousAt {α β : Type*}
    [TopologicalSpace α] [TopologicalSpace β] (f : α → β) (x : α) : Prop :=
  ∀ seq : ℕ → α, Tendsto seq atTop (𝓝 x) → Tendsto (f ∘ seq) atTop (𝓝 (f x))

/-- In first-countable spaces, continuity equals sequential continuity. -/
theorem continuous_iff_seq_continuous {α β : Type*}
    [TopologicalSpace α] [FirstCountableTopology α] [TopologicalSpace β]
    (f : α → β) (x : α) :
    ContinuousAt f x ↔ SequentiallyContinuousAt f x := by
  constructor
  · intro hf seq hseq
    exact hf.tendsto.comp hseq
  · intro hf
    rw [ContinuousAt, tendsto_def]
    intro U hU
    by_contra h
    simp only [mem_map, mem_nhds_iff] at h
    push_neg at h
    sorry -- Requires construction using first-countability

/-! ## 3. Epsilon-Delta Continuity -/

/-- ε-δ continuity for metric spaces. -/
def EpsilonDeltaContinuousAt {α β : Type*}
    [PseudoMetricSpace α] [PseudoMetricSpace β] (f : α → β) (x : α) : Prop :=
  ∀ ε > 0, ∃ δ > 0, ∀ y, dist x y < δ → dist (f x) (f y) < ε

/-- ε-δ continuity is equivalent to topological continuity in metric spaces. -/
theorem epsilon_delta_iff_continuous {α β : Type*}
    [PseudoMetricSpace α] [PseudoMetricSpace β] (f : α → β) (x : α) :
    EpsilonDeltaContinuousAt f x ↔ ContinuousAt f x := by
  constructor
  · intro h
    rw [Metric.continuousAt_iff]
    exact h
  · intro h
    rw [Metric.continuousAt_iff] at h
    exact h

/-! ## 4. Uniform Continuity -/

/-- Uniform continuity on a set. -/
def UniformlyContinuousOnSet {α β : Type*}
    [PseudoMetricSpace α] [PseudoMetricSpace β] (f : α → β) (S : Set α) : Prop :=
  ∀ ε > 0, ∃ δ > 0, ∀ x y ∈ S, dist x y < δ → dist (f x) (f y) < ε

/-- Uniform continuity globally. -/
def UniformlyContinuousGlobal {α β : Type*}
    [PseudoMetricSpace α] [PseudoMetricSpace β] (f : α → β) : Prop :=
  ∀ ε > 0, ∃ δ > 0, ∀ x y, dist x y < δ → dist (f x) (f y) < ε

/-- Uniform continuity implies continuity. -/
theorem uniform_continuous_is_continuous {α β : Type*}
    [PseudoMetricSpace α] [PseudoMetricSpace β] (f : α → β)
    (h : UniformContinuous f) : Continuous f := by
  exact h.continuous

/-- Continuous function on compact set is uniformly continuous. -/
theorem continuous_on_compact_uniform {α β : Type*}
    [PseudoMetricSpace α] [PseudoMetricSpace β]
    (f : α → β) (K : Set α) (hK : IsCompact K) (hf : ContinuousOn f K) :
    UniformContinuousOn f K := by
  exact hK.uniformContinuousOn_of_continuous hf

/-! ## 5. Lipschitz Continuity -/

/-- Lipschitz continuity with constant K. -/
def IsLipschitzWith {α β : Type*}
    [PseudoMetricSpace α] [PseudoMetricSpace β] (K : ℝ≥0) (f : α → β) : Prop :=
  ∀ x y, dist (f x) (f y) ≤ K * dist x y

/-- Lipschitz functions are uniformly continuous. -/
theorem lipschitz_uniformly_continuous {α β : Type*}
    [PseudoMetricSpace α] [PseudoMetricSpace β]
    (K : ℝ≥0) (f : α → β) (h : LipschitzWith K f) :
    UniformContinuous f := by
  exact h.uniformContinuous

/-- Composition of Lipschitz functions is Lipschitz. -/
theorem lipschitz_comp {α β γ : Type*}
    [PseudoMetricSpace α] [PseudoMetricSpace β] [PseudoMetricSpace γ]
    (K₁ K₂ : ℝ≥0) (f : β → γ) (g : α → β)
    (hf : LipschitzWith K₁ f) (hg : LipschitzWith K₂ g) :
    LipschitzWith (K₁ * K₂) (f ∘ g) := by
  exact hf.comp hg

/-- Locally Lipschitz functions. -/
def IsLocallyLipschitz {α β : Type*}
    [PseudoMetricSpace α] [PseudoMetricSpace β] (f : α → β) : Prop :=
  ∀ x, ∃ K : ℝ≥0, ∃ r > 0, ∀ y z, dist x y < r → dist x z < r →
    dist (f y) (f z) ≤ K * dist y z

/-! ## 6. Hölder Continuity -/

/-- Hölder continuity with exponent α and constant C. -/
def IsHolderWith {X Y : Type*}
    [PseudoMetricSpace X] [PseudoMetricSpace Y]
    (C : ℝ≥0) (α : ℝ) (f : X → Y) : Prop :=
  0 < α ∧ α ≤ 1 ∧ ∀ x y, dist (f x) (f y) ≤ C * dist x y ^ α

/-- Lipschitz is Hölder with exponent 1. -/
theorem lipschitz_is_holder_one {X Y : Type*}
    [PseudoMetricSpace X] [PseudoMetricSpace Y]
    (K : ℝ≥0) (f : X → Y) (h : LipschitzWith K f) :
    IsHolderWith K 1 f := by
  constructor
  · linarith
  constructor
  · linarith
  · intro x y
    simp only [rpow_one]
    exact h.dist_le_mul x y

/-- Hölder continuity implies continuity. -/
theorem holder_is_continuous {X Y : Type*}
    [PseudoMetricSpace X] [PseudoMetricSpace Y]
    (C : ℝ≥0) (α : ℝ) (f : X → Y) (h : IsHolderWith C α f) :
    Continuous f := by
  rw [Metric.continuous_iff]
  intro x ε hε
  obtain ⟨hα_pos, _, hH⟩ := h
  use (ε / C) ^ (1 / α)
  constructor
  · positivity
  · intro y hy
    calc dist (f x) (f y) ≤ C * dist x y ^ α := hH x y
      _ < C * ((ε / C) ^ (1 / α)) ^ α := by
          apply mul_lt_mul_of_pos_left
          · apply Real.rpow_lt_rpow (dist_nonneg) hy hα_pos
          · exact_mod_cast C.pos
      _ = ε := by
          rw [← Real.rpow_natCast, ← Real.rpow_mul]
          · simp [hα_pos.ne']
          · positivity

/-! ## 7. Semicontinuity -/

/-- Lower semicontinuity at a point. -/
def LowerSemicontinuousAt {α : Type*} [TopologicalSpace α]
    (f : α → ℝ) (x : α) : Prop :=
  ∀ y < f x, ∀ᶠ z in 𝓝 x, y < f z

/-- Upper semicontinuity at a point. -/
def UpperSemicontinuousAt {α : Type*} [TopologicalSpace α]
    (f : α → ℝ) (x : α) : Prop :=
  ∀ y > f x, ∀ᶠ z in 𝓝 x, f z < y

/-- Continuous iff both lower and upper semicontinuous. -/
theorem continuous_iff_semicontinuous {α : Type*} [TopologicalSpace α]
    (f : α → ℝ) (x : α) :
    ContinuousAt f x ↔ LowerSemicontinuousAt f x ∧ UpperSemicontinuousAt f x := by
  constructor
  · intro hf
    constructor
    · intro y hy
      exact hf.eventually (isOpen_Ioi.mem_nhds hy)
    · intro y hy
      exact hf.eventually (isOpen_Iio.mem_nhds hy)
  · intro ⟨hL, hU⟩
    rw [Metric.continuousAt_iff]
    intro ε hε
    have hL' := hL (f x - ε) (by linarith)
    have hU' := hU (f x + ε) (by linarith)
    rw [Filter.Eventually, mem_nhds_iff] at hL' hU'
    obtain ⟨U₁, hU₁sub, hU₁open, hxU₁⟩ := hL'
    obtain ⟨U₂, hU₂sub, hU₂open, hxU₂⟩ := hU'
    rw [Metric.isOpen_iff] at hU₁open hU₂open
    obtain ⟨δ₁, hδ₁_pos, hδ₁⟩ := hU₁open x hxU₁
    obtain ⟨δ₂, hδ₂_pos, hδ₂⟩ := hU₂open x hxU₂
    use min δ₁ δ₂
    constructor
    · exact lt_min hδ₁_pos hδ₂_pos
    · intro y hy
      have hy₁ : y ∈ U₁ := hδ₁ (lt_of_lt_of_le hy (min_le_left _ _))
      have hy₂ : y ∈ U₂ := hδ₂ (lt_of_lt_of_le hy (min_le_right _ _))
      have hL'' := hU₁sub hy₁
      have hU'' := hU₂sub hy₂
      rw [Real.dist_eq, abs_lt]
      constructor <;> linarith

/-! ## 8. Continuity of Compositions -/

/-- Composition of continuous functions is continuous. -/
theorem continuous_comp' {α β γ : Type*}
    [TopologicalSpace α] [TopologicalSpace β] [TopologicalSpace γ]
    (f : β → γ) (g : α → β) (hf : Continuous f) (hg : Continuous g) :
    Continuous (f ∘ g) := by
  exact hf.comp hg

/-- Continuity at a point composes. -/
theorem continuousAt_comp' {α β γ : Type*}
    [TopologicalSpace α] [TopologicalSpace β] [TopologicalSpace γ]
    (f : β → γ) (g : α → β) (x : α)
    (hf : ContinuousAt f (g x)) (hg : ContinuousAt g x) :
    ContinuousAt (f ∘ g) x := by
  exact hf.comp hg

/-! ## 9. Continuous Maps as a Type -/

/-- The type of continuous functions between topological spaces. -/
structure ContinuousMap' (α β : Type*) [TopologicalSpace α] [TopologicalSpace β] where
  toFun : α → β
  continuous_toFun : Continuous toFun

/-- Continuous functions form a category with identity and composition. -/
def ContinuousMap'.id (α : Type*) [TopologicalSpace α] : ContinuousMap' α α where
  toFun := id
  continuous_toFun := continuous_id

def ContinuousMap'.comp {α β γ : Type*}
    [TopologicalSpace α] [TopologicalSpace β] [TopologicalSpace γ]
    (g : ContinuousMap' β γ) (f : ContinuousMap' α β) : ContinuousMap' α γ where
  toFun := g.toFun ∘ f.toFun
  continuous_toFun := g.continuous_toFun.comp f.continuous_toFun

/-! ## 10. Pointwise Operations on Continuous Functions -/

/-- Sum of continuous functions is continuous. -/
theorem continuous_add {α : Type*} {β : Type*}
    [TopologicalSpace α] [TopologicalSpace β] [Add β] [ContinuousAdd β]
    (f g : α → β) (hf : Continuous f) (hg : Continuous g) :
    Continuous (f + g) := by
  exact hf.add hg

/-- Product of continuous functions is continuous. -/
theorem continuous_mul {α : Type*} {β : Type*}
    [TopologicalSpace α] [TopologicalSpace β] [Mul β] [ContinuousMul β]
    (f g : α → β) (hf : Continuous f) (hg : Continuous g) :
    Continuous (f * g) := by
  exact hf.mul hg

/-- Scalar multiplication of continuous functions is continuous. -/
theorem continuous_smul' {α : Type*} {R : Type*} {M : Type*}
    [TopologicalSpace α] [TopologicalSpace R] [TopologicalSpace M]
    [SMul R M] [ContinuousSMul R M]
    (c : α → R) (f : α → M) (hc : Continuous c) (hf : Continuous f) :
    Continuous (fun x => c x • f x) := by
  exact hc.smul hf

/-! ## 11. Extension Theorems -/

/-- Tietze extension theorem statement. -/
theorem tietze_extension {α : Type*} [TopologicalSpace α] [NormalSpace α]
    (C : Set α) (hC : IsClosed C) (f : C → ℝ) (hf : Continuous f) :
    ∃ g : α → ℝ, Continuous g ∧ ∀ x : C, g x = f x := by
  exact ⟨_, ContinuousMap.exists_extension_forall_mem_of_closedEmbedding
    ⟨f, hf⟩ (closedEmbedding_subtype_val hC) ⟨Set.univ, trivial, Set.univ_nonempty⟩⟩

/-! ## 12. Continuity in Normed Spaces -/

/-- Linear maps between normed spaces are continuous iff bounded. -/
theorem linear_continuous_iff_bounded {K : Type*} {V W : Type*}
    [NontriviallyNormedField K]
    [NormedAddCommGroup V] [NormedSpace K V]
    [NormedAddCommGroup W] [NormedSpace K W]
    (f : V →ₗ[K] W) :
    Continuous f ↔ ∃ C, ∀ v, ‖f v‖ ≤ C * ‖v‖ := by
  constructor
  · intro hf
    exact f.bound_of_continuous hf
  · intro ⟨C, hC⟩
    exact f.continuous_of_bound C hC

end ContinuityTheory
