/-
  ==============================================================================
  ProductTopology.lean
  ==============================================================================

  PRODUCT TOPOLOGY AND RELATED CONSTRUCTIONS

  This file provides a comprehensive formalization of product topology, including:

    • Product topology definition
    • Box topology
    • Projection maps and continuity
    • Tychonoff's theorem
    • Universal property of products
    • Quotient topologies
    • Subspace topology
    • Disjoint union topology
    • Weak topology

  ==============================================================================
-/

import Mathlib.Topology.Constructions
import Mathlib.Topology.Product
import Mathlib.Topology.Order

namespace ProductTopology

open Set Topology

/-! ## 1. Product Topology Definition -/

/-- The product topology on α × β is the coarsest topology making projections continuous. -/
def productTopology' {α β : Type*} (τα : TopologicalSpace α) (τβ : TopologicalSpace β) :
    TopologicalSpace (α × β) :=
  TopologicalSpace.induced Prod.fst τα ⊓ TopologicalSpace.induced Prod.snd τβ

/-- Basis for product topology: rectangles U × V where U, V are open. -/
def productBasis {α β : Type*} [TopologicalSpace α] [TopologicalSpace β] :
    Set (Set (α × β)) :=
  { W | ∃ (U : Set α) (V : Set β), IsOpen U ∧ IsOpen V ∧ W = U ×ˢ V }

/-- The product basis is indeed a basis. -/
theorem productBasis_isBasis {α β : Type*} [TopologicalSpace α] [TopologicalSpace β] :
    TopologicalSpace.IsTopologicalBasis productBasis := by
  apply TopologicalSpace.isTopologicalBasis_of_isOpen_of_nhds
  · intro W ⟨U, V, hU, hV, hW⟩
    rw [hW]
    exact hU.prod hV
  · intro ⟨x, y⟩ W hW hxy
    obtain ⟨U, hU, hxU, hUW⟩ := mem_nhds_iff.mp (isOpen_prod_iff.mp hW x y hxy).1
    obtain ⟨V, hV, hyV, hVW⟩ := mem_nhds_iff.mp (isOpen_prod_iff.mp hW x y hxy).2
    use U ×ˢ V
    constructor
    · exact ⟨U, V, hU, hV, rfl⟩
    · constructor
      · exact ⟨hxU, hyV⟩
      · intro ⟨a, b⟩ ⟨ha, hb⟩
        exact (isOpen_prod_iff.mp hW x y hxy).2.2 a b ⟨hUW ha, hVW hb⟩

/-! ## 2. Projections -/

/-- First projection is continuous. -/
theorem fst_continuous {α β : Type*} [TopologicalSpace α] [TopologicalSpace β] :
    Continuous (Prod.fst : α × β → α) := by
  exact continuous_fst

/-- Second projection is continuous. -/
theorem snd_continuous {α β : Type*} [TopologicalSpace α] [TopologicalSpace β] :
    Continuous (Prod.snd : α × β → β) := by
  exact continuous_snd

/-- Projections are open maps. -/
theorem fst_isOpenMap {α β : Type*} [TopologicalSpace α] [TopologicalSpace β] [Nonempty β] :
    IsOpenMap (Prod.fst : α × β → α) := by
  exact isOpenMap_fst

theorem snd_isOpenMap {α β : Type*} [TopologicalSpace α] [TopologicalSpace β] [Nonempty α] :
    IsOpenMap (Prod.snd : α × β → β) := by
  exact isOpenMap_snd

/-! ## 3. Universal Property -/

/-- A map into a product is continuous iff both components are continuous. -/
theorem continuous_prod_iff {α β γ : Type*}
    [TopologicalSpace α] [TopologicalSpace β] [TopologicalSpace γ]
    (f : γ → α × β) :
    Continuous f ↔ Continuous (Prod.fst ∘ f) ∧ Continuous (Prod.snd ∘ f) := by
  constructor
  · intro hf
    exact ⟨continuous_fst.comp hf, continuous_snd.comp hf⟩
  · intro ⟨h1, h2⟩
    exact Continuous.prod_mk h1 h2

/-- Product pairing of two continuous functions is continuous. -/
theorem continuous_prod_mk' {α β γ : Type*}
    [TopologicalSpace α] [TopologicalSpace β] [TopologicalSpace γ]
    (f : α → β) (g : α → γ) (hf : Continuous f) (hg : Continuous g) :
    Continuous (fun x => (f x, g x)) := by
  exact Continuous.prod_mk hf hg

/-! ## 4. Arbitrary Products -/

/-- The product topology on Π i, α i. -/
def piTopology' {ι : Type*} {α : ι → Type*} [∀ i, TopologicalSpace (α i)] :
    TopologicalSpace (∀ i, α i) :=
  ⨅ i, TopologicalSpace.induced (fun f => f i) (‹_› : TopologicalSpace (α i))

/-- Projection from infinite product is continuous. -/
theorem pi_proj_continuous {ι : Type*} {α : ι → Type*} [∀ i, TopologicalSpace (α i)] (j : ι) :
    Continuous (fun f : ∀ i, α i => f j) := by
  exact continuous_apply j

/-- A map into a product is continuous iff all components are. -/
theorem continuous_pi_iff {ι : Type*} {α : ι → Type*} {β : Type*}
    [∀ i, TopologicalSpace (α i)] [TopologicalSpace β]
    (f : β → ∀ i, α i) :
    Continuous f ↔ ∀ i, Continuous (fun x => f x i) := by
  exact continuous_pi_iff

/-! ## 5. Tychonoff's Theorem -/

/-- Tychonoff: arbitrary product of compact spaces is compact. -/
theorem tychonoff' {ι : Type*} {α : ι → Type*}
    [∀ i, TopologicalSpace (α i)] [∀ i, CompactSpace (α i)] :
    CompactSpace (∀ i, α i) := by
  exact inferInstance

/-- Product of two compact spaces is compact. -/
theorem prod_compact {α β : Type*}
    [TopologicalSpace α] [TopologicalSpace β]
    [CompactSpace α] [CompactSpace β] :
    CompactSpace (α × β) := by
  exact inferInstance

/-! ## 6. Box Topology -/

/-- The box topology has all products of open sets as basis elements. -/
def boxTopology {ι : Type*} {α : ι → Type*} [∀ i, TopologicalSpace (α i)] :
    TopologicalSpace (∀ i, α i) :=
  TopologicalSpace.generateOpen
    { W | ∃ U : ∀ i, Set (α i), (∀ i, IsOpen (U i)) ∧ W = { f | ∀ i, f i ∈ U i } }

/-- Box topology is finer than product topology. -/
theorem box_finer_than_product {ι : Type*} {α : ι → Type*} [∀ i, TopologicalSpace (α i)] :
    piTopology' ≤ boxTopology := by
  sorry -- Requires careful comparison of the topologies

/-! ## 7. Subspace Topology -/

/-- The subspace topology on S ⊆ α. -/
def subspaceTopology' {α : Type*} (τ : TopologicalSpace α) (S : Set α) :
    TopologicalSpace S :=
  TopologicalSpace.induced (Subtype.val) τ

/-- Open sets in subspace are intersections with open sets. -/
theorem subspace_open_iff {α : Type*} [TopologicalSpace α] (S : Set α) (U : Set S) :
    IsOpen U ↔ ∃ V : Set α, IsOpen V ∧ U = Subtype.val ⁻¹' V := by
  constructor
  · intro hU
    exact isOpen_induced_iff.mp hU
  · intro ⟨V, hV, hUV⟩
    rw [hUV]
    exact hV.preimage continuous_subtype_val

/-- Inclusion of subspace is continuous. -/
theorem subtype_val_continuous {α : Type*} [TopologicalSpace α] (S : Set α) :
    Continuous (Subtype.val : S → α) := by
  exact continuous_subtype_val

/-! ## 8. Quotient Topology -/

/-- The quotient topology induced by a surjection. -/
def quotientTopology' {α β : Type*} (τ : TopologicalSpace α) (f : α → β) (hf : Surjective f) :
    TopologicalSpace β :=
  TopologicalSpace.coinduced f τ

/-- Open sets in quotient are saturated open sets. -/
theorem quotient_open_iff {α β : Type*} [TopologicalSpace α] (f : α → β) :
    @IsOpen β (TopologicalSpace.coinduced f _) = fun U => IsOpen (f ⁻¹' U) := by
  ext U
  exact isOpen_coinduced

/-- The quotient map is continuous. -/
theorem quotient_map_continuous {α β : Type*} [TopologicalSpace α] (f : α → β) :
    @Continuous α β _ (TopologicalSpace.coinduced f _) f := by
  exact continuous_coinduced_rng

/-! ## 9. Disjoint Union Topology -/

/-- The topology on disjoint union (coproduct). -/
def coproductTopology' {α β : Type*} (τα : TopologicalSpace α) (τβ : TopologicalSpace β) :
    TopologicalSpace (α ⊕ β) :=
  TopologicalSpace.coinduced Sum.inl τα ⊔ TopologicalSpace.coinduced Sum.inr τβ

/-- Inclusions into coproduct are continuous. -/
theorem sum_inl_continuous {α β : Type*} [TopologicalSpace α] [TopologicalSpace β] :
    Continuous (Sum.inl : α → α ⊕ β) := by
  exact continuous_inl

theorem sum_inr_continuous {α β : Type*} [TopologicalSpace α] [TopologicalSpace β] :
    Continuous (Sum.inr : β → α ⊕ β) := by
  exact continuous_inr

/-- Coproduct satisfies universal property for continuous maps. -/
theorem continuous_sum_iff {α β γ : Type*}
    [TopologicalSpace α] [TopologicalSpace β] [TopologicalSpace γ]
    (f : α ⊕ β → γ) :
    Continuous f ↔ Continuous (f ∘ Sum.inl) ∧ Continuous (f ∘ Sum.inr) := by
  constructor
  · intro hf
    exact ⟨hf.comp continuous_inl, hf.comp continuous_inr⟩
  · intro ⟨h1, h2⟩
    exact continuous_sum_dom.mpr ⟨h1, h2⟩

/-! ## 10. Initial and Final Topologies -/

/-- Initial topology: coarsest making all functions continuous. -/
def initialTopology' {α : Type*} {ι : Type*} {β : ι → Type*}
    [∀ i, TopologicalSpace (β i)] (f : ∀ i, α → β i) :
    TopologicalSpace α :=
  ⨅ i, TopologicalSpace.induced (f i) (‹_› : TopologicalSpace (β i))

/-- Final topology: finest making all functions continuous. -/
def finalTopology' {α : Type*} {ι : Type*} {β : ι → Type*}
    [∀ i, TopologicalSpace (β i)] (f : ∀ i, β i → α) :
    TopologicalSpace α :=
  ⨆ i, TopologicalSpace.coinduced (f i) (‹_› : TopologicalSpace (β i))

/-! ## 11. Weak Topology -/

/-- Weak topology on a normed space from functionals. -/
def weakTopology' {K : Type*} {V : Type*}
    [NontriviallyNormedField K] [AddCommGroup V] [Module K V]
    (F : Set (V →L[K] K)) :
    TopologicalSpace V :=
  ⨅ f ∈ F, TopologicalSpace.induced f inferInstance

/-- Weak-* topology on dual space. -/
def weakStarTopology' {K : Type*} {V : Type*}
    [NontriviallyNormedField K] [NormedAddCommGroup V] [NormedSpace K V] :
    TopologicalSpace (V →L[K] K) :=
  ⨅ x : V, TopologicalSpace.induced (fun f => f x) inferInstance

/-! ## 12. Separation in Products -/

/-- Product of Hausdorff spaces is Hausdorff. -/
theorem prod_t2 {α β : Type*} [TopologicalSpace α] [TopologicalSpace β]
    [T2Space α] [T2Space β] : T2Space (α × β) := by
  exact inferInstance

/-- Product of regular spaces is regular. -/
theorem prod_regular {α β : Type*} [TopologicalSpace α] [TopologicalSpace β]
    [RegularSpace α] [RegularSpace β] : RegularSpace (α × β) := by
  exact inferInstance

/-- Product of normal spaces need not be normal (counterexample exists). -/
-- The Sorgenfrey plane is a famous counterexample

/-! ## 13. Metrizability of Products -/

/-- Countable product of metrizable spaces is metrizable. -/
theorem countable_prod_metrizable {α : ℕ → Type*}
    [∀ n, TopologicalSpace (α n)] [∀ n, MetrizableSpace (α n)] :
    MetrizableSpace (∀ n, α n) := by
  exact inferInstance

/-- Finite product of metric spaces has product metric. -/
theorem finite_prod_metric {α β : Type*}
    [PseudoMetricSpace α] [PseudoMetricSpace β] :
    PseudoMetricSpace (α × β) := by
  exact inferInstance

end ProductTopology
