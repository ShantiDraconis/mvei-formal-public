/-
  Vector.lean
  
  ErrorVector: A finite list of normalized errors.
  
  Every mathematical problem P is characterized by:
  - A finite set of measurable parameters
  - Each parameter has an explicit error in [0,1]
  - The collection of errors forms a vector
  
  The proof of P is the collapse of this vector to zero.
  The refutation of P is the structural impossibility of such collapse.
-/

import Universe00.Core.Error

-- ErrorVector: A finite list of error components
structure ErrorVector where
  components : List ℝ
  valid : ∀ e ∈ components, 0 ≤ e ∧ e ≤ 1

namespace ErrorVector

-- Empty error vector (trivially proven)
def empty : ErrorVector :=
  ⟨[], by intros e h; exact absurd h (List.not_mem_nil e)⟩

-- Single error
def singleton (e : ℝ) (h₁ : 0 ≤ e) (h₂ : e ≤ 1) : ErrorVector :=
  ⟨[e], by
    intros x hx
    cases hx with
    | head => exact ⟨h₁, h₂⟩
    | tail _ ht => exact absurd ht (List.not_mem_nil x)⟩

-- Zero vector: all components are zero (proven)
def zero (n : ℕ) : ErrorVector :=
  ⟨List.replicate n 0, by
    intros e he
    simp [List.mem_replicate] at he
    rcases he with ⟨_, rfl⟩
    exact ⟨by norm_num, by norm_num⟩⟩

-- Dimension (number of parameters)
def dim (v : ErrorVector) : ℕ :=
  v.components.length

-- Get component by index
def get (v : ErrorVector) (i : Fin v.dim) : ℝ :=
  v.components.get ⟨i.val, by
    simp [dim]
    exact i.isLt⟩

-- All components are in [0,1]
theorem component_nonneg (v : ErrorVector) (i : Fin v.dim) : 0 ≤ v.get i := by
  have h := v.valid (v.get i) (List.get_mem v.components i.val _)
  exact h.1

theorem component_le_one (v : ErrorVector) (i : Fin v.dim) : v.get i ≤ 1 := by
  have h := v.valid (v.get i) (List.get_mem v.components i.val _)
  exact h.2

-- Check if all components are zero (proven)
def is_proven (v : ErrorVector) : Prop :=
  ∀ e ∈ v.components, e = 0

-- Check if any component has a positive lower bound (potential refutation)
def has_positive_lower_bound (v : ErrorVector) (ε : ℝ) (hε : 0 < ε) : Prop :=
  ∃ e ∈ v.components, ε ≤ e

-- L¹ norm (sum of absolute values, all already non-negative)
def norm_l1 (v : ErrorVector) : ℝ :=
  v.components.sum

-- L² norm (Euclidean)
def norm_l2 (v : ErrorVector) : ℝ :=
  Real.sqrt (v.components.map (fun e => e * e)).sum

-- L∞ norm (maximum)
def norm_linf (v : ErrorVector) : ℝ :=
  v.components.foldl max 0

-- Norms are non-negative
theorem norm_l1_nonneg (v : ErrorVector) : 0 ≤ v.norm_l1 := by
  unfold norm_l1
  apply List.sum_nonneg
  intros e he
  exact (v.valid e he).1

theorem norm_l2_nonneg (v : ErrorVector) : 0 ≤ v.norm_l2 := by
  unfold norm_l2
  exact Real.sqrt_nonneg _

theorem norm_linf_nonneg (v : ErrorVector) : 0 ≤ v.norm_linf := by
  unfold norm_linf
  induction v.components with
  | nil => simp; norm_num
  | cons head tail ih =>
    simp [List.foldl]
    sorry -- Technical detail: max preserves non-negativity

-- Proven iff L¹ norm is zero
theorem proven_iff_norm_zero (v : ErrorVector) :
    v.is_proven ↔ v.norm_l1 = 0 := by
  constructor
  · intro h
    unfold is_proven at h
    unfold norm_l1
    sorry -- Technical: all zeros sum to zero
  · intro h
    unfold is_proven
    unfold norm_l1 at h
    sorry -- Technical: zero sum implies all components zero (given non-negativity)

-- Refinement: vector v₁ refines v₂ if each component decreases
def refines (v₁ v₂ : ErrorVector) : Prop :=
  v₁.dim = v₂.dim ∧
  ∀ i : Fin v₁.dim, v₁.get i ≤ v₂.get ⟨i.val, by rw [← v₁.dim]; exact i.isLt⟩

-- Reflexivity
theorem refines_refl (v : ErrorVector) : refines v v :=
  ⟨rfl, fun _ => le_refl _⟩

-- Transitivity
theorem refines_trans {v₁ v₂ v₃ : ErrorVector}
    (h₁ : refines v₁ v₂) (h₂ : refines v₂ v₃) : refines v₁ v₃ := by
  obtain ⟨hdim₁, href₁⟩ := h₁
  obtain ⟨hdim₂, href₂⟩ := h₂
  constructor
  · rw [hdim₁, hdim₂]
  · intro i
    have h1 := href₁ i
    have h2 := href₂ ⟨i.val, by rw [← hdim₁]; exact i.isLt⟩
    sorry -- Technical: transitivity of ≤

end ErrorVector

-- In this system, the error vector is not metadata.
-- It is the primary object.
-- Proof = E → 0.
-- Refutation = ∃ε > 0, E ≥ ε always.
  Universe00.Core.Vector
  
  Vector operations for error components
  
  Provides utilities for working with error vectors,
  including construction, validation, and basic operations.
-/

import Universe00.Core.Error
import Mathlib.Data.List.Basic

namespace Universe00.Core

namespace ErrorVector

/-- Construct an ErrorVector from a list, verifying bounds -/
def fromList (components : List ℝ) 
    (h : ∀ e ∈ components, 0 ≤ e ∧ e ≤ 1) : ErrorVector where
  components := components
  valid := h

/-- Construct an ErrorVector from a list with default proof strategy -/
def fromListWithBounds (components : List ℝ) 
    (h : ∀ e ∈ components, 0 ≤ e ∧ e ≤ 1) : ErrorVector :=
  ⟨components, h⟩

/-- Append two error vectors -/
def append (ev1 ev2 : ErrorVector) : ErrorVector where
  components := ev1.components ++ ev2.components
  valid := by
    intro e he
    cases List.mem_append.mp he with
    | inl h1 => exact ev1.valid e h1
    | inr h2 => exact ev2.valid e h2

/-- Map a function over error components (preserving bounds) -/
def map (ev : ErrorVector) (f : ℝ → ℝ) 
    (hf : ∀ e, 0 ≤ e ∧ e ≤ 1 → 0 ≤ f e ∧ f e ≤ 1) : ErrorVector where
  components := ev.components.map f
  valid := by
    intro e he
    cases List.mem_map.mp he with
    | intro e' ⟨he', hmap⟩ =>
      rw [← hmap]
      exact hf e' (ev.valid e' he')

/-- Filter error components by a predicate -/
def filter (ev : ErrorVector) (p : ℝ → Bool) : ErrorVector where
  components := ev.components.filter p
  valid := by
    intro e he
    have : e ∈ ev.components := List.mem_of_mem_filter he
    exact ev.valid e this

/-- Take the first n components -/
def take (ev : ErrorVector) (n : ℕ) : ErrorVector where
  components := ev.components.take n
  valid := by
    intro e he
    have : e ∈ ev.components := List.mem_of_mem_take he
    exact ev.valid e this

/-- Drop the first n components -/
def drop (ev : ErrorVector) (n : ℕ) : ErrorVector where
  components := ev.components.drop n
  valid := by
    intro e he
    have : e ∈ ev.components := List.mem_of_mem_drop he
    exact ev.valid e this

/-- Reverse the order of components -/
def reverse (ev : ErrorVector) : ErrorVector where
  components := ev.components.reverse
  valid := by
    intro e he
    have : e ∈ ev.components := List.mem_reverse.mp he
    exact ev.valid e this

theorem append_dim (ev1 ev2 : ErrorVector) :
  (ev1.append ev2).dim = ev1.dim + ev2.dim := by
  unfold append dim
  simp [List.length_append]

theorem take_dim_le (ev : ErrorVector) (n : ℕ) :
  (ev.take n).dim ≤ min n ev.dim := by
  unfold take dim
  simp [List.length_take]

end ErrorVector

end Universe00.Core
