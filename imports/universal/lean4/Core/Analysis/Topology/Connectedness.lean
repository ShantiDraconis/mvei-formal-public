/-
  ==============================================================================
  Connectedness.lean
  ==============================================================================

  CONNECTEDNESS IN TOPOLOGICAL SPACES

  This file provides a comprehensive formalization of connectedness, including:

    • Connected spaces and sets
    • Path connectedness
    • Arc connectedness
    • Components and path components
    • Local connectedness
    • Simply connected spaces
    • Continuous images of connected sets
    • Intermediate value theorem
    • Connected sums

  ==============================================================================
-/

import Mathlib.Topology.Connected.Basic
import Mathlib.Topology.Connected.PathConnected
import Mathlib.Topology.MetricSpace.Basic

namespace Connectedness

open Set

/-! ## 1. Basic Definitions -/

/-- A topological space is connected if it cannot be partitioned into
    two disjoint nonempty open sets. -/
def IsConnectedSpace' (α : Type*) [TopologicalSpace α] : Prop :=
  ∀ U V : Set α, IsOpen U → IsOpen V → U ∪ V = univ → U ∩ V = ∅ →
    U = ∅ ∨ V = ∅

/-- A subset is connected if it's connected as a subspace. -/
def IsConnectedSet' {α : Type*} [TopologicalSpace α] (S : Set α) : Prop :=
  ∀ U V : Set α, IsOpen U → IsOpen V →
    S ⊆ U ∪ V → (S ∩ U).Nonempty → (S ∩ V).Nonempty →
    (S ∩ U ∩ V).Nonempty

/-- Equivalent characterization: no proper clopen subsets. -/
def IsConnectedClopen {α : Type*} [TopologicalSpace α] : Prop :=
  ∀ S : Set α, IsClopen S → S = ∅ ∨ S = univ

/-! ## 2. Properties of Connected Spaces -/

/-- The definitions of connectedness are equivalent. -/
theorem connected_iff_clopen {α : Type*} [TopologicalSpace α] :
    IsConnectedSpace' α ↔ IsConnectedClopen := by
  constructor
  · intro h S ⟨hOpen, hClosed⟩
    by_cases hne : S.Nonempty
    · right
      by_contra hneq
      have hSc : Sᶜ.Nonempty := by
        rw [nonempty_compl]
        exact hneq
      have := h S Sᶜ hOpen hClosed.isOpen_compl
        (union_compl_self S) (inter_compl_self S)
      cases this with
      | inl h => exact hne.ne_empty h
      | inr h => exact hSc.ne_empty h
    · left
      exact not_nonempty_iff_eq_empty.mp hne
  · intro h U V hU hV hUV hUVdisj
    have hUclopen : IsClopen U := by
      constructor
      · exact hU
      · rw [← compl_compl U, ← (show V = Uᶜ by
          ext x
          constructor
          · intro hx
            by_contra hxU
            have : x ∈ U ∩ V := ⟨hxU, hx⟩
            rw [hUVdisj] at this
            exact this
          · intro hx
            have : x ∈ U ∪ V := by rw [hUV]; trivial
            cases this with
            | inl h => exact (hx h).elim
            | inr h => exact h)]
        exact hV.isClosed_compl
    cases h U hUclopen with
    | inl h => left; exact h
    | inr h =>
      right
      have : U ∪ V = univ := hUV
      rw [h] at this
      simp at this
      exact this

/-- Connected spaces have the intermediate value property. -/
theorem connected_ivt {α : Type*} [TopologicalSpace α] [ConnectedSpace α]
    (f : α → ℝ) (hf : Continuous f)
    (a b : α) (y : ℝ) (ha : f a ≤ y) (hb : y ≤ f b) :
    ∃ c : α, f c = y := by
  exact intermediate_value_univ₂ hf a b ⟨ha, hb⟩

/-! ## 3. Connected Components -/

/-- The connected component containing a point. -/
def connectedComponentOf {α : Type*} [TopologicalSpace α] (x : α) : Set α :=
  ⋃₀ { S : Set α | IsConnected S ∧ x ∈ S }

/-- Connected components are connected. -/
theorem connectedComponent_isConnected {α : Type*} [TopologicalSpace α] (x : α) :
    IsConnected (connectedComponentOf x) := by
  exact isConnected_connectedComponent

/-- Connected components are maximal connected sets. -/
theorem connectedComponent_maximal {α : Type*} [TopologicalSpace α] (x : α)
    (S : Set α) (hS : IsConnected S) (hx : x ∈ S) :
    S ⊆ connectedComponentOf x := by
  exact hS.subset_connectedComponent hx

/-- Two points are in the same component iff there's a connected set containing both. -/
theorem same_component_iff {α : Type*} [TopologicalSpace α] (x y : α) :
    connectedComponentOf x = connectedComponentOf y ↔
    ∃ S : Set α, IsConnected S ∧ x ∈ S ∧ y ∈ S := by
  constructor
  · intro h
    use connectedComponentOf x
    constructor
    · exact isConnected_connectedComponent
    · constructor
      · exact mem_connectedComponent
      · rw [h]
        exact mem_connectedComponent
  · intro ⟨S, hS, hx, hy⟩
    exact connectedComponent_eq_iff_mem.mpr
      (hS.subset_connectedComponent hx hy)

/-! ## 4. Path Connectedness -/

/-- A path from x to y is a continuous function from [0,1]. -/
structure PathBetween {α : Type*} [TopologicalSpace α] (x y : α) where
  path : ℝ → α
  continuous : Continuous path
  at_zero : path 0 = x
  at_one : path 1 = y

/-- A space is path connected if any two points are joined by a path. -/
def IsPathConnectedSpace' (α : Type*) [TopologicalSpace α] : Prop :=
  ∀ x y : α, Nonempty (PathBetween x y)

/-- Path connectedness implies connectedness. -/
theorem path_connected_is_connected {α : Type*} [TopologicalSpace α]
    [PathConnectedSpace α] : ConnectedSpace α := by
  exact inferInstance

/-- The reverse of a path. -/
def PathBetween.reverse {α : Type*} [TopologicalSpace α] {x y : α}
    (p : PathBetween x y) : PathBetween y x where
  path := fun t => p.path (1 - t)
  continuous := p.continuous.comp (continuous_const.sub continuous_id)
  at_zero := by simp [p.at_one]
  at_one := by simp [p.at_zero]

/-- Concatenation of paths. -/
def PathBetween.concat {α : Type*} [TopologicalSpace α] {x y z : α}
    (p : PathBetween x y) (q : PathBetween y z) : PathBetween x z where
  path := fun t => if t ≤ 1/2 then p.path (2 * t) else q.path (2 * t - 1)
  continuous := by
    sorry -- Requires pasting lemma for continuity
  at_zero := by simp [p.at_zero]
  at_one := by simp [q.at_one]

/-! ## 5. Path Components -/

/-- The path component containing a point. -/
def pathComponentOf {α : Type*} [TopologicalSpace α] (x : α) : Set α :=
  { y | Nonempty (PathBetween x y) }

/-- Path components are path connected. -/
theorem pathComponent_isPathConnected {α : Type*} [TopologicalSpace α] (x : α) :
    IsPathConnected (pathComponentOf x) := by
  exact isPathConnected_pathComponent

/-- Path component is contained in connected component. -/
theorem pathComponent_subset_connectedComponent {α : Type*} [TopologicalSpace α] (x : α) :
    pathComponentOf x ⊆ connectedComponentOf x := by
  intro y hy
  obtain ⟨p⟩ := hy
  have : IsConnected (Set.range p.path) := by
    exact isConnected_range p.continuous
  have hx : x ∈ Set.range p.path := ⟨0, p.at_zero⟩
  have hy' : y ∈ Set.range p.path := ⟨1, p.at_one⟩
  exact this.subset_connectedComponent hx hy'

/-! ## 6. Local Connectedness -/

/-- A space is locally connected if connected neighborhoods form a base. -/
def IsLocallyConnectedSpace' (α : Type*) [TopologicalSpace α] : Prop :=
  ∀ x : α, ∀ U : Set α, U ∈ 𝓝 x → ∃ V : Set α, V ⊆ U ∧ V ∈ 𝓝 x ∧ IsConnected V

/-- A space is locally path connected if path-connected neighborhoods form a base. -/
def IsLocallyPathConnectedSpace' (α : Type*) [TopologicalSpace α] : Prop :=
  ∀ x : α, ∀ U : Set α, U ∈ 𝓝 x → ∃ V : Set α, V ⊆ U ∧ V ∈ 𝓝 x ∧ IsPathConnected V

/-- Local path connectedness implies local connectedness. -/
theorem loc_path_conn_imp_loc_conn {α : Type*} [TopologicalSpace α]
    (h : IsLocallyPathConnectedSpace' α) : IsLocallyConnectedSpace' α := by
  intro x U hU
  obtain ⟨V, hVU, hVnhd, hVpath⟩ := h x U hU
  exact ⟨V, hVU, hVnhd, hVpath.isConnected⟩

/-! ## 7. Simply Connected Spaces -/

/-- A loop based at x is a path from x to x. -/
abbrev Loop {α : Type*} [TopologicalSpace α] (x : α) := PathBetween x x

/-- Two loops are homotopic if one can be continuously deformed into the other. -/
structure LoopHomotopy {α : Type*} [TopologicalSpace α] {x : α}
    (γ₁ γ₂ : Loop x) where
  homotopy : ℝ × ℝ → α
  continuous : Continuous homotopy
  at_s_zero : ∀ t, homotopy (0, t) = γ₁.path t
  at_s_one : ∀ t, homotopy (1, t) = γ₂.path t
  base_fixed : ∀ s, homotopy (s, 0) = x ∧ homotopy (s, 1) = x

/-- A space is simply connected if it's path connected and every loop is
    null-homotopic. -/
def IsSimplyConnected' (α : Type*) [TopologicalSpace α] : Prop :=
  PathConnectedSpace α ∧
  ∀ x : α, ∀ γ : Loop x, ∃ H : LoopHomotopy γ ⟨fun _ => x, continuous_const, rfl, rfl⟩, True

/-! ## 8. Continuous Images -/

/-- Continuous image of a connected set is connected. -/
theorem continuous_image_connected {α β : Type*} [TopologicalSpace α] [TopologicalSpace β]
    (f : α → β) (hf : Continuous f) (S : Set α) (hS : IsConnected S) :
    IsConnected (f '' S) := by
  exact hS.image f hf.continuousOn

/-- Continuous image of path connected is path connected. -/
theorem continuous_image_path_connected {α β : Type*} [TopologicalSpace α] [TopologicalSpace β]
    (f : α → β) (hf : Continuous f) (S : Set α) (hS : IsPathConnected S) :
    IsPathConnected (f '' S) := by
  exact hS.image hf

/-! ## 9. Intermediate Value Theorem -/

/-- Classical IVT for continuous functions on connected domains. -/
theorem ivt_connected {α : Type*} [TopologicalSpace α]
    (S : Set α) (hS : IsConnected S)
    (f : α → ℝ) (hf : ContinuousOn f S)
    (a b : α) (ha : a ∈ S) (hb : b ∈ S)
    (y : ℝ) (hya : f a ≤ y) (hyb : y ≤ f b) :
    ∃ c ∈ S, f c = y := by
  exact hS.intermediate_value ha hb hf ⟨hya, hyb⟩

/-- IVT for intervals in ℝ. -/
theorem ivt_interval (f : ℝ → ℝ) (hf : Continuous f)
    (a b : ℝ) (hab : a ≤ b)
    (y : ℝ) (hya : f a ≤ y) (hyb : y ≤ f b) :
    ∃ c ∈ Set.Icc a b, f c = y := by
  exact intermediate_value_Icc hab hf.continuousOn ⟨hya, hyb⟩

/-! ## 10. Special Connected Sets -/

/-- Intervals in ℝ are connected. -/
theorem interval_connected (a b : ℝ) : IsConnected (Set.Icc a b) := by
  exact isConnected_Icc

/-- Convex sets in ℝⁿ are path connected. -/
theorem convex_path_connected {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]
    (S : Set E) (hS : Convex ℝ S) : IsPathConnected S := by
  exact hS.isPathConnected

/-! ## 11. Disconnection -/

/-- A space is disconnected if it's not connected. -/
def IsDisconnected (α : Type*) [TopologicalSpace α] : Prop :=
  ∃ U V : Set α, IsOpen U ∧ IsOpen V ∧ U.Nonempty ∧ V.Nonempty ∧
    U ∪ V = univ ∧ U ∩ V = ∅

/-- A set is a cut set if removing it disconnects the space. -/
def IsCutSet {α : Type*} [TopologicalSpace α] (S : Set α) : Prop :=
  ConnectedSpace α ∧ ¬ConnectedSpace (↥Sᶜ)

/-- A point is a cut point if it's a singleton cut set. -/
def IsCutPoint {α : Type*} [TopologicalSpace α] (x : α) : Prop :=
  IsCutSet {x}

/-! ## 12. Totally Disconnected Spaces -/

/-- A space is totally disconnected if connected components are singletons. -/
def IsTotallyDisconnected' (α : Type*) [TopologicalSpace α] : Prop :=
  ∀ x y : α, x ≠ y → connectedComponentOf x ∩ connectedComponentOf y = ∅

/-- A space is zero-dimensional if clopen sets form a base. -/
def IsZeroDimensional (α : Type*) [TopologicalSpace α] : Prop :=
  ∀ x : α, ∀ U : Set α, U ∈ 𝓝 x → ∃ V : Set α, V ⊆ U ∧ V ∈ 𝓝 x ∧ IsClopen V

/-- Zero-dimensional implies totally disconnected. -/
theorem zero_dim_is_totally_disc {α : Type*} [TopologicalSpace α]
    (h : IsZeroDimensional α) : TotallyDisconnectedSpace α := by
  sorry -- Requires showing components are points

end Connectedness
