/-
  ==============================================================================
  BaireCategory.lean
  ==============================================================================

  BAIRE CATEGORY THEOREM AND APPLICATIONS

  This file provides a comprehensive formalization of the Baire category theorem
  and its applications, including:

    • Nowhere dense and meager sets
    • First and second category sets
    • Baire spaces
    • Baire category theorem
    • Applications to functional analysis
    • Generic properties
    • Residual sets

  ==============================================================================
-/

import Mathlib.Topology.Baire.Basic
import Mathlib.Topology.MetricSpace.Baire
import Mathlib.Analysis.NormedSpace.BanachSteinhaus

namespace BaireCategoryTheory

open Set Filter Topology

/-! ## 1. Nowhere Dense Sets -/

/-- A set is nowhere dense if its closure has empty interior. -/
def IsNowhereDense' {α : Type*} [TopologicalSpace α] (S : Set α) : Prop :=
  interior (closure S) = ∅

/-- Equivalent characterization: complement of closure is dense. -/
theorem nowhere_dense_iff_compl_dense {α : Type*} [TopologicalSpace α] (S : Set α) :
    IsNowhereDense' S ↔ Dense (closure S)ᶜ := by
  constructor
  · intro h
    rw [dense_iff_inter_open]
    intro U hU hUne
    by_contra hcontra
    push_neg at hcontra
    have : U ⊆ closure S := by
      intro x hx
      by_contra hxnot
      exact hcontra ⟨hx, hxnot⟩
    have : U ⊆ interior (closure S) := by
      exact interior_maximal this hU
    rw [h] at this
    exact hUne.not_subset_empty this
  · intro h
    by_contra hne
    push_neg at hne
    obtain ⟨x, hx⟩ := nonempty_iff_ne_empty.mpr hne
    have hxcl : x ∈ closure S := interior_subset hx
    have : (closure S)ᶜ ∈ 𝓝 x → False := by
      intro hn
      exact absurd hxcl (mem_compl_iff _ _ ▸ mem_of_mem_nhds hn)
    apply this
    exact h.interior_eq ▸ isOpen_interior.mem_nhds hx

/-- Finite union of nowhere dense sets is nowhere dense. -/
theorem nowhere_dense_union {α : Type*} [TopologicalSpace α]
    (S T : Set α) (hS : IsNowhereDense' S) (hT : IsNowhereDense' T) :
    IsNowhereDense' (S ∪ T) := by
  -- The closure of a finite union is the union of closures.
  -- The interior of a union of sets with empty interior is empty
  -- (in general, interior (A ∪ B) ⊇ interior A ∪ interior B, but we need the other direction).
  -- We use: closure(S ∪ T) = closure(S) ∪ closure(T)
  -- And: interior(A ∪ B) = ∅ if interior(A) = ∅ and interior(B) = ∅ and A, B are closed.
  rw [IsNowhereDense'] at *
  rw [closure_union]
  -- We need to show interior(closure S ∪ closure T) = ∅
  -- Since closure S and closure T are both closed with empty interior,
  -- their union also has empty interior in general position.
  by_contra hne
  push_neg at hne
  obtain ⟨x, hx⟩ := nonempty_iff_ne_empty.mpr hne
  rw [mem_interior_iff_mem_nhds] at hx
  -- x has a neighborhood contained in closure S ∪ closure T
  -- But both closure S and closure T are nowhere dense
  obtain ⟨U, hUo, hxU, hUsub⟩ := mem_nhds_iff.mp hx
  -- U is a nonempty open set contained in closure S ∪ closure T
  -- Since interior(closure S) = ∅ and interior(closure T) = ∅,
  -- U cannot be contained in either one alone.
  -- This requires showing that an open set cannot be covered by two nowhere dense closed sets.
  have hclS : IsClosed (closure S) := isClosed_closure
  have hclT : IsClosed (closure T) := isClosed_closure
  -- U ∩ (closure S)ᶜ is nonempty and open
  have hU_notS : (U ∩ (closure S)ᶜ).Nonempty := by
    by_contra hempty
    push_neg at hempty
    rw [Set.not_nonempty_iff_eq_empty, Set.inter_compl_self_eq_empty] at hempty
    -- This means U ⊆ closure S, contradicting interior(closure S) = ∅
    have : U ⊆ interior (closure S) := interior_maximal hempty hUo
    rw [hS] at this
    exact hxU.not_mem_empty (this (Set.mem_of_mem_of_subset hxU (Set.Subset.refl U)))
  obtain ⟨y, hyU, hyS⟩ := hU_notS
  -- y ∈ U but y ∉ closure S, so y ∈ closure T
  have hyT : y ∈ closure T := by
    have : y ∈ closure S ∪ closure T := hUsub hyU
    cases this with
    | inl h => exact (hyS h).elim
    | inr h => exact h
  -- But then the open set U ∩ (closure S)ᶜ contains y and is contained in closure T
  have hopen : IsOpen (U ∩ (closure S)ᶜ) := hUo.inter hclS.isOpen_compl
  have hysub : U ∩ (closure S)ᶜ ⊆ closure T := by
    intro z ⟨hzU, hzS⟩
    have : z ∈ closure S ∪ closure T := hUsub hzU
    cases this with
    | inl h => exact (hzS h).elim
    | inr h => exact h
  -- This means U ∩ (closure S)ᶜ ⊆ interior(closure T)
  have : U ∩ (closure S)ᶜ ⊆ interior (closure T) := interior_maximal hysub hopen
  rw [hT] at this
  exact hU_notS.not_subset_empty this

/-- Subset of nowhere dense is nowhere dense. -/
theorem nowhere_dense_subset {α : Type*} [TopologicalSpace α]
    (S T : Set α) (h : S ⊆ T) (hT : IsNowhereDense' T) :
    IsNowhereDense' S := by
  rw [IsNowhereDense'] at *
  apply eq_empty_of_subset_empty
  calc interior (closure S) ⊆ interior (closure T) := by
         apply interior_mono
         exact closure_mono h
    _ = ∅ := hT

/-! ## 2. Meager (First Category) Sets -/

/-- A set is meager (of first category) if it's a countable union of nowhere dense sets. -/
def IsMeager' {α : Type*} [TopologicalSpace α] (S : Set α) : Prop :=
  ∃ (f : ℕ → Set α), (∀ n, IsNowhereDense' (f n)) ∧ S ⊆ ⋃ n, f n

/-- A set is comeager (residual) if its complement is meager. -/
def IsComeager' {α : Type*} [TopologicalSpace α] (S : Set α) : Prop :=
  IsMeager' Sᶜ

/-- Countable union of meager sets is meager. -/
theorem meager_countable_union {α : Type*} [TopologicalSpace α]
    (S : ℕ → Set α) (h : ∀ n, IsMeager' (S n)) :
    IsMeager' (⋃ n, S n) := by
  -- Each S n is a countable union of nowhere dense sets.
  -- A countable union of countable unions is countable.
  -- We use a diagonal argument to enumerate all the nowhere dense sets.
  
  -- For each n, get the sequence of nowhere dense sets covering S n
  choose f hf using h
  -- f n : ℕ → Set α, with f n m nowhere dense and S n ⊆ ⋃ m, f n m
  
  -- Define a new sequence covering the union using the pairing function
  -- g k covers ⋃ n, S n where k encodes (n, m)
  use fun k => f (Nat.unpair k).1 (Nat.unpair k).2
  
  constructor
  · -- Each g k is nowhere dense
    intro k
    exact (hf (Nat.unpair k).1).1 (Nat.unpair k).2
  · -- ⋃ n, S n ⊆ ⋃ k, g k
    intro x hx
    rw [Set.mem_iUnion] at hx
    obtain ⟨n, hxn⟩ := hx
    have hxcover : x ∈ ⋃ m, f n m := (hf n).2 hxn
    rw [Set.mem_iUnion] at hxcover
    obtain ⟨m, hxm⟩ := hxcover
    rw [Set.mem_iUnion]
    use Nat.mkpair n m
    simp only [Nat.unpair_mkpair]
    exact hxm

/-- Nowhere dense sets are meager. -/
theorem nowhere_dense_is_meager {α : Type*} [TopologicalSpace α]
    (S : Set α) (h : IsNowhereDense' S) : IsMeager' S := by
  use fun n => if n = 0 then S else ∅
  constructor
  · intro n
    by_cases hn : n = 0
    · simp [hn, h]
    · simp [hn, IsNowhereDense']
  · intro x hx
    simp
    use 0
    simp [hx]

/-! ## 3. Baire Spaces -/

/-- A space is Baire if countable intersections of dense open sets are dense. -/
def IsBaireSpace' (α : Type*) [TopologicalSpace α] : Prop :=
  ∀ (U : ℕ → Set α), (∀ n, IsOpen (U n) ∧ Dense (U n)) →
    Dense (⋂ n, U n)

/-- Equivalent: the whole space is not meager. -/
theorem baire_iff_not_meager {α : Type*} [TopologicalSpace α] [Nonempty α] :
    IsBaireSpace' α ↔ ¬IsMeager' (univ : Set α) := by
  sorry -- Requires careful argument with complements

/-! ## 4. Baire Category Theorem -/

/-- Complete metric spaces are Baire spaces. -/
theorem complete_metric_is_baire {α : Type*} [PseudoMetricSpace α] [CompleteSpace α] :
    BaireSpace α := by
  exact inferInstance

/-- Locally compact Hausdorff spaces are Baire spaces. -/
theorem locally_compact_hausdorff_is_baire {α : Type*}
    [TopologicalSpace α] [LocallyCompactSpace α] [T2Space α] :
    BaireSpace α := by
  exact inferInstance

/-- Main Baire category theorem statement. -/
theorem baire_category_theorem {α : Type*} [TopologicalSpace α] [BaireSpace α]
    (U : ℕ → Set α) (hU : ∀ n, IsOpen (U n) ∧ Dense (U n)) :
    Dense (⋂ n, U n) := by
  exact dense_iInter_of_isOpen_nat (fun n => (hU n).1) (fun n => (hU n).2)

/-- Corollary: Gδ dense sets in Baire spaces are non-meager. -/
theorem dense_Gδ_not_meager {α : Type*} [TopologicalSpace α] [BaireSpace α]
    (S : Set α) (hopen : ∃ U : ℕ → Set α, (∀ n, IsOpen (U n)) ∧ S = ⋂ n, U n)
    (hdense : Dense S) :
    ¬IsMeager' S := by
  sorry -- Follows from Baire theorem

/-! ## 5. Residual Sets -/

/-- A residual set contains a dense Gδ. -/
def IsResidual' {α : Type*} [TopologicalSpace α] (S : Set α) : Prop :=
  ∃ G : Set α, G ⊆ S ∧ (∃ U : ℕ → Set α, (∀ n, IsOpen (U n)) ∧ G = ⋂ n, U n) ∧ Dense G

/-- Residual sets are comeager. -/
theorem residual_is_comeager {α : Type*} [TopologicalSpace α]
    (S : Set α) (h : IsResidual' S) : IsComeager' S := by
  sorry -- Follows from definitions

/-- Intersection of countably many residual sets is residual. -/
theorem residual_countable_inter {α : Type*} [TopologicalSpace α]
    (S : ℕ → Set α) (h : ∀ n, IsResidual' (S n)) :
    IsResidual' (⋂ n, S n) := by
  sorry -- Requires careful construction

/-! ## 6. Generic Properties -/

/-- A property is generic if the set of points satisfying it is residual. -/
def IsGenericProperty {α : Type*} [TopologicalSpace α]
    (P : α → Prop) : Prop :=
  IsResidual' { x | P x }

/-- In Baire spaces, generic properties are satisfied by "most" points. -/
theorem generic_dense_in_baire {α : Type*} [TopologicalSpace α] [BaireSpace α]
    (P : α → Prop) (h : IsGenericProperty P) :
    Dense { x | P x } := by
  obtain ⟨G, hGS, ⟨U, hU, hG⟩, hdense⟩ := h
  exact hdense.mono hGS

/-! ## 7. Applications to Functional Analysis -/

/-- Uniform boundedness principle (Banach-Steinhaus). -/
theorem uniform_boundedness {E F : Type*}
    [NormedAddCommGroup E] [NormedAddCommGroup F]
    [NormedSpace ℝ E] [NormedSpace ℝ F]
    [CompleteSpace E]
    (T : ι → E →L[ℝ] F)
    (h : ∀ x : E, ∃ C, ∀ i, ‖T i x‖ ≤ C) :
    ∃ C, ∀ i, ‖T i‖ ≤ C := by
  exact NormedAddGroupHom.equicontinuous_of_pointwiseBounded
    (fun i => (T i).toNormedAddGroupHom) h

/-- Open mapping theorem uses Baire category. -/
-- The proof relies on showing the image of the unit ball contains an open ball

/-- Closed graph theorem uses Baire category. -/
-- If graph is closed, the map is continuous

/-! ## 8. Existence of Pathological Objects -/

/-- There exists a continuous nowhere differentiable function. -/
theorem exists_continuous_nowhere_differentiable :
    ∃ f : ℝ → ℝ, Continuous f ∧ ∀ x, ¬DifferentiableAt ℝ f x := by
  sorry -- Baire category shows the set of such functions is residual

/-- Generic continuous functions are nowhere differentiable. -/
theorem generic_continuous_nowhere_diff :
    IsGenericProperty (fun f : C(Set.Icc (0 : ℝ) 1, ℝ) =>
      ∀ x ∈ Set.Ioo 0 1, ¬DifferentiableAt ℝ f x) := by
  sorry -- Application of Baire category

/-! ## 9. Category vs Measure -/

/-- Meager sets and null sets are different notions. -/
-- There exist meager sets of full measure (e.g., ℚ is meager but has measure 0)
-- There exist non-meager sets of measure 0 (complements of fat Cantor sets)

/-- The complement of ℚ in ℝ is comeager but has full measure. -/
theorem irrationals_comeager : IsComeager' (Set.univ \ (Set.range (↑· : ℚ → ℝ)) : Set ℝ) := by
  sorry -- ℚ is countable, hence meager

/-! ## 10. Topological Games -/

/-- Banach-Mazur game characterization of Baire spaces. -/
-- Player I wins iff the intersection is empty
-- Player II has a winning strategy iff the target is comeager

/-- A space is Baire iff Player II has no winning strategy in the Banach-Mazur game
    for the empty set. -/
-- This gives an alternative proof of Baire category theorem

/-! ## 11. Condensation Points -/

/-- A point is a condensation point if every neighborhood is uncountable. -/
def IsCondensationPoint {α : Type*} [TopologicalSpace α] (S : Set α) (x : α) : Prop :=
  ∀ U ∈ 𝓝 x, (S ∩ U).Countable → False

/-- The set of non-condensation points is countable (Cantor-Bendixson). -/
theorem countable_non_condensation {α : Type*}
    [TopologicalSpace α] [SecondCountableTopology α]
    (S : Set α) :
    { x ∈ S | ¬IsCondensationPoint S x }.Countable := by
  sorry -- Uses second countability

/-! ## 12. Perfect Sets -/

/-- A set is perfect if it's closed and has no isolated points. -/
def IsPerfect {α : Type*} [TopologicalSpace α] (S : Set α) : Prop :=
  IsClosed S ∧ ∀ x ∈ S, ∀ U ∈ 𝓝 x, ∃ y ∈ S, y ≠ x ∧ y ∈ U

/-- Non-empty perfect subsets of complete metric spaces are uncountable. -/
theorem perfect_uncountable {α : Type*} [MetricSpace α] [CompleteSpace α]
    (S : Set α) (hS : IsPerfect S) (hne : S.Nonempty) :
    ¬S.Countable := by
  sorry -- Uses Baire category on the perfect set

/-- Cantor-Bendixson theorem: closed sets decompose into perfect and countable parts. -/
theorem cantor_bendixson {α : Type*}
    [TopologicalSpace α] [PolishSpace α]
    (S : Set α) (hS : IsClosed S) :
    ∃ (P D : Set α), IsPerfect P ∧ D.Countable ∧ S = P ∪ D ∧ Disjoint P D := by
  sorry -- Transfinite induction on derived sets

end BaireCategoryTheory
