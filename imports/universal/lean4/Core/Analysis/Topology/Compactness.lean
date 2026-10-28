/-
  ==============================================================================
  Compactness.lean
  ==============================================================================

  COMPACTNESS IN TOPOLOGICAL AND METRIC SPACES

  This file provides a comprehensive formalization of compactness, including:

    • Open cover definition of compactness
    • Sequential compactness
    • Limit point compactness
    • Compactness in metric spaces
    • Heine-Borel theorem
    • Properties of compact sets
    • Continuous images of compact sets
    • Compact Hausdorff spaces
    • Local compactness
    • Compactification

  ==============================================================================
-/

import Mathlib.Topology.Compactness.Compact
import Mathlib.Topology.MetricSpace.Basic
import Mathlib.Topology.Separation.Basic

namespace Compactness

open Set

/-! ## 1. Basic Definitions -/

/-- A set is compact if every open cover has a finite subcover. -/
def IsCompactCover {α : Type*} (τ : Set (Set α) → Prop) (K : Set α) : Prop :=
  ∀ 𝒰 : Set (Set α), (∀ U ∈ 𝒰, τ {U}) →
    K ⊆ ⋃₀ 𝒰 → ∃ 𝒱 : Finset (Set α), ↑𝒱 ⊆ 𝒰 ∧ K ⊆ ⋃₀ ↑𝒱

/-- Sequential compactness: every sequence has a convergent subsequence. -/
def IsSequentiallyCompact {α : Type*} (M : MetricSpaces.PremetricSpace α) (K : Set α) : Prop :=
  ∀ seq : ℕ → α, (∀ n, seq n ∈ K) →
    ∃ (subseq : ℕ → ℕ) (L : α), StrictMono subseq ∧ L ∈ K ∧
      MetricSpaces.ConvergesTo M (seq ∘ subseq) L

/-- Limit point compactness: every infinite subset has a limit point. -/
def IsLimitPointCompact {α : Type*} (M : MetricSpaces.PremetricSpace α) (K : Set α) : Prop :=
  ∀ S : Set α, S ⊆ K → S.Infinite →
    ∃ x ∈ K, ∀ ε > 0, ∃ y ∈ S, y ≠ x ∧ M.dist x y < ε

/-- Total boundedness: can be covered by finitely many ε-balls. -/
def IsTotallyBounded {α : Type*} (M : MetricSpaces.PremetricSpace α) (K : Set α) : Prop :=
  ∀ ε > 0, ∃ F : Finset α, K ⊆ ⋃ x ∈ F, MetricSpaces.openBall M x ε

/-! ## 2. Equivalence in Metric Spaces -/

/-- In metric spaces, compactness is equivalent to sequential compactness. -/
theorem compact_iff_seq_compact {α : Type*} (M : MetricSpaces.MetricSpaceAxioms α)
    (K : Set α) :
    IsSequentiallyCompact M.toPremetricSpace K ↔
    (IsTotallyBounded M.toPremetricSpace K ∧
     ∀ seq : ℕ → α, (∀ n, seq n ∈ K) → MetricSpaces.IsCauchy M.toPremetricSpace seq →
       ∃ L ∈ K, MetricSpaces.ConvergesTo M.toPremetricSpace seq L) := by
  sorry -- Deep theorem requiring substantial infrastructure

/-- Sequential compactness implies limit point compactness. -/
theorem seq_compact_implies_limit_point_compact {α : Type*}
    (M : MetricSpaces.PremetricSpace α) (K : Set α)
    (h : IsSequentiallyCompact M K) : IsLimitPointCompact M K := by
  intro S hSK hS_inf
  -- Choose a sequence of distinct points from S
  sorry -- Requires choice and careful construction

/-! ## 3. Properties of Compact Sets -/

/-- Compact subsets of Hausdorff spaces are closed. -/
theorem compact_of_hausdorff_is_closed {α : Type*} [TopologicalSpace α] [T2Space α]
    (K : Set α) (hK : IsCompact K) : IsClosed K := by
  exact hK.isClosed

/-- Closed subsets of compact sets are compact. -/
theorem closed_subset_compact {α : Type*} [TopologicalSpace α]
    (K : Set α) (hK : IsCompact K) (C : Set α) (hC : IsClosed C) (hCK : C ⊆ K) :
    IsCompact C := by
  exact hK.of_isClosed_subset hC hCK

/-- Finite union of compact sets is compact. -/
theorem finite_union_compact {α : Type*} [TopologicalSpace α]
    (K₁ K₂ : Set α) (hK₁ : IsCompact K₁) (hK₂ : IsCompact K₂) :
    IsCompact (K₁ ∪ K₂) := by
  exact hK₁.union hK₂

/-- Intersection of compact and closed is compact. -/
theorem inter_compact_closed {α : Type*} [TopologicalSpace α]
    (K : Set α) (hK : IsCompact K) (C : Set α) (hC : IsClosed C) :
    IsCompact (K ∩ C) := by
  exact hK.inter_right hC

/-! ## 4. Heine-Borel Theorem -/

/-- Statement of Heine-Borel: In ℝⁿ, compact iff closed and bounded. -/
def HeineBorelProperty (α : Type*) [TopologicalSpace α] [MetricSpace α] : Prop :=
  ∀ K : Set α, IsCompact K ↔ (IsClosed K ∧ Bornology.IsBounded K)

/-- ℝ satisfies Heine-Borel. -/
theorem heine_borel_real : HeineBorelProperty ℝ := by
  intro K
  constructor
  · intro hK
    exact ⟨hK.isClosed, hK.isBounded⟩
  · intro ⟨hClosed, hBounded⟩
    exact isCompact_of_isClosed_isBounded hClosed hBounded

/-! ## 5. Continuous Images -/

/-- Continuous image of compact is compact. -/
theorem continuous_image_compact {α β : Type*} [TopologicalSpace α] [TopologicalSpace β]
    (f : α → β) (hf : Continuous f) (K : Set α) (hK : IsCompact K) :
    IsCompact (f '' K) := by
  exact hK.image hf

/-- Continuous function on compact set is bounded. -/
theorem continuous_on_compact_bounded {α : Type*} [TopologicalSpace α]
    (f : α → ℝ) (hf : Continuous f) (K : Set α) (hK : IsCompact K) (hne : K.Nonempty) :
    Bornology.IsBounded (f '' K) := by
  exact (hK.image hf).isBounded

/-- Continuous function on compact attains maximum. -/
theorem continuous_attains_max {α : Type*} [TopologicalSpace α]
    (f : α → ℝ) (hf : Continuous f) (K : Set α) (hK : IsCompact K) (hne : K.Nonempty) :
    ∃ x ∈ K, ∀ y ∈ K, f y ≤ f x := by
  exact hK.exists_isMaxOn hne hf.continuousOn

/-- Continuous function on compact attains minimum. -/
theorem continuous_attains_min {α : Type*} [TopologicalSpace α]
    (f : α → ℝ) (hf : Continuous f) (K : Set α) (hK : IsCompact K) (hne : K.Nonempty) :
    ∃ x ∈ K, ∀ y ∈ K, f x ≤ f y := by
  exact hK.exists_isMinOn hne hf.continuousOn

/-! ## 6. Uniform Continuity -/

/-- Continuous function on compact is uniformly continuous. -/
theorem compact_uniform_continuous {α β : Type*} [PseudoMetricSpace α] [PseudoMetricSpace β]
    (f : α → β) (hf : Continuous f) (K : Set α) (hK : IsCompact K) :
    UniformContinuousOn f K := by
  exact hK.uniformContinuousOn_of_continuous hf.continuousOn

/-! ## 7. Compactness and Products -/

/-- Tychonoff's theorem: Product of compact spaces is compact. -/
theorem tychonoff {ι : Type*} {α : ι → Type*} [∀ i, TopologicalSpace (α i)]
    (hK : ∀ i, IsCompact (Set.univ : Set (α i))) :
    IsCompact (Set.univ : Set (∀ i, α i)) := by
  exact isCompact_univ_pi (fun i => hK i)

/-- Product of two compact sets is compact. -/
theorem product_compact {α β : Type*} [TopologicalSpace α] [TopologicalSpace β]
    (K : Set α) (L : Set β) (hK : IsCompact K) (hL : IsCompact L) :
    IsCompact (K ×ˢ L) := by
  exact hK.prod hL

/-! ## 8. Local Compactness -/

/-- A space is locally compact if every point has a compact neighborhood. -/
def IsLocallyCompactSpace (α : Type*) [TopologicalSpace α] : Prop :=
  ∀ x : α, ∃ K : Set α, IsCompact K ∧ K ∈ 𝓝 x

/-- Locally compact Hausdorff spaces have nice properties. -/
theorem locally_compact_hausdorff_regular {α : Type*} [TopologicalSpace α]
    [LocallyCompactSpace α] [T2Space α] : RegularSpace α := by
  exact inferInstance

/-! ## 9. Compactification -/

/-- One-point compactification adds a point at infinity. -/
structure OnePointCompactification (α : Type*) where
  val : Option α

/-- The one-point compactification of a locally compact space is compact. -/
theorem one_point_compact {α : Type*} [TopologicalSpace α] [LocallyCompactSpace α] :
    IsCompact (Set.univ : Set (OnePointCompactification α)) := by
  sorry -- Requires topology on OnePointCompactification

/-- Stone-Čech compactification exists for any Tychonoff space. -/
theorem stone_cech_exists {α : Type*} [TopologicalSpace α] [T3₅Space α] :
    ∃ (β : Type*) (_ : TopologicalSpace β) (_ : CompactSpace β) (i : α → β),
      Continuous i ∧ DenseRange i := by
  sorry -- Requires substantial construction

/-! ## 10. Lebesgue Number Lemma -/

/-- Lebesgue number: for compact metric spaces, open covers have a Lebesgue number. -/
theorem lebesgue_number_lemma {α : Type*} [PseudoMetricSpace α]
    (K : Set α) (hK : IsCompact K)
    (𝒰 : Set (Set α)) (h𝒰 : ∀ U ∈ 𝒰, IsOpen U) (hcover : K ⊆ ⋃₀ 𝒰) :
    ∃ δ > 0, ∀ x ∈ K, ∃ U ∈ 𝒰, Metric.ball x δ ⊆ U := by
  exact hK.exists_forall_ball_subset_sUnion h𝒰 hcover

/-! ## 11. Bolzano-Weierstrass -/

/-- Bolzano-Weierstrass: bounded sequences in ℝ have convergent subsequences. -/
theorem bolzano_weierstrass (seq : ℕ → ℝ) (hbounded : Bornology.IsBounded (Set.range seq)) :
    ∃ (subseq : ℕ → ℕ) (L : ℝ), StrictMono subseq ∧
      Filter.Tendsto (seq ∘ subseq) Filter.atTop (𝓝 L) := by
  obtain ⟨L, hL⟩ := isCompact_of_isClosed_isBounded isClosed_closure
    (hbounded.subset (subset_closure))
    |>.isSeqCompact (fun n => subset_closure (Set.mem_range_self n))
  exact ⟨L.choose, hL.choose.2, L.choose_spec.1, hL.choose_spec.2⟩

/-! ## 12. Relative Compactness -/

/-- A set is relatively compact if its closure is compact. -/
def IsRelativelyCompact {α : Type*} [TopologicalSpace α] (S : Set α) : Prop :=
  IsCompact (closure S)

/-- Relatively compact sets are bounded in metric spaces. -/
theorem relatively_compact_bounded {α : Type*} [PseudoMetricSpace α]
    (S : Set α) (h : IsRelativelyCompact S) : Bornology.IsBounded S := by
  exact h.isBounded.subset subset_closure

/-! ## 13. Countably Compact -/

/-- Countably compact: every countable open cover has a finite subcover. -/
def IsCountablyCompact {α : Type*} [TopologicalSpace α] (K : Set α) : Prop :=
  ∀ 𝒰 : ℕ → Set α, (∀ n, IsOpen (𝒰 n)) → K ⊆ ⋃ n, 𝒰 n →
    ∃ F : Finset ℕ, K ⊆ ⋃ n ∈ F, 𝒰 n

/-- Compact implies countably compact. -/
theorem compact_is_countably_compact {α : Type*} [TopologicalSpace α]
    (K : Set α) (hK : IsCompact K) : IsCountablyCompact K := by
  intro 𝒰 h𝒰 hcover
  have := hK.elim_finite_subcover (fun n => 𝒰 n) h𝒰
    (by simp only [iUnion_coe_set]; exact hcover)
  obtain ⟨F, hF⟩ := this
  exact ⟨F, hF⟩

end Compactness
