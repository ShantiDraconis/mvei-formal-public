/-
  ==============================================================================
  RealDifferentiability.lean
  ==============================================================================

  REAL DIFFERENTIABILITY AND ANALYSIS

  This file provides a comprehensive formalization of real differentiability,
  including:

    • Differentiability on intervals
    • Monotonicity and derivatives
    • Convexity and derivatives
    • Critical points
    • Extreme values
    • First and second derivative tests
    • Rolle's theorem
    • Darboux's theorem

  ==============================================================================
-/

import Mathlib.Analysis.Calculus.LocalExtr.Basic
import Mathlib.Analysis.Calculus.MeanValue
import Mathlib.Analysis.Calculus.Deriv.Basic

namespace RealDifferentiability

open Set Filter Topology

/-! ## 1. Differentiability on Sets -/

/-- Differentiability on an open interval. -/
def DifferentiableOnInterval (f : ℝ → ℝ) (a b : ℝ) : Prop :=
  DifferentiableOn ℝ f (Set.Ioo a b)

/-- Differentiability on a closed interval (interior). -/
def DifferentiableOnClosedInterval (f : ℝ → ℝ) (a b : ℝ) : Prop :=
  ContinuousOn f (Set.Icc a b) ∧ DifferentiableOn ℝ f (Set.Ioo a b)

/-! ## 2. Rolle's Theorem -/

/-- Rolle's theorem: if f(a) = f(b), derivative vanishes somewhere in between. -/
theorem rolle {f : ℝ → ℝ} {a b : ℝ} (hab : a < b)
    (hfc : ContinuousOn f (Set.Icc a b))
    (hfd : DifferentiableOn ℝ f (Set.Ioo a b))
    (hfab : f a = f b) :
    ∃ c ∈ Set.Ioo a b, deriv f c = 0 := by
  exact exists_deriv_eq_zero hab hfc hfd hfab

/-- Generalized Rolle: derivative changes sign. -/
theorem rolle_sign {f : ℝ → ℝ} {a b : ℝ} (hab : a < b)
    (hfc : ContinuousOn f (Set.Icc a b))
    (hfd : DifferentiableOn ℝ f (Set.Ioo a b))
    (hfab : f a = f b) :
    ∃ c ∈ Set.Ioo a b, HasDerivAt f 0 c := by
  obtain ⟨c, hc, hc'⟩ := rolle hab hfc hfd hfab
  use c, hc
  exact (hfd c hc).hasDerivAt (Ioo_mem_nhds hc.1 hc.2) |>.deriv_eq_zero_iff.mpr hc'

/-! ## 3. Mean Value Theorem -/

/-- Lagrange's mean value theorem. -/
theorem mean_value_theorem {f : ℝ → ℝ} {a b : ℝ} (hab : a < b)
    (hfc : ContinuousOn f (Set.Icc a b))
    (hfd : DifferentiableOn ℝ f (Set.Ioo a b)) :
    ∃ c ∈ Set.Ioo a b, deriv f c = (f b - f a) / (b - a) := by
  exact exists_deriv_eq_slope f hab hfc hfd

/-- Cauchy's generalized mean value theorem. -/
theorem cauchy_mean_value {f g : ℝ → ℝ} {a b : ℝ} (hab : a < b)
    (hfc : ContinuousOn f (Set.Icc a b))
    (hgc : ContinuousOn g (Set.Icc a b))
    (hfd : DifferentiableOn ℝ f (Set.Ioo a b))
    (hgd : DifferentiableOn ℝ g (Set.Ioo a b))
    (hg' : ∀ c ∈ Set.Ioo a b, deriv g c ≠ 0) :
    ∃ c ∈ Set.Ioo a b,
      (f b - f a) / (g b - g a) = deriv f c / deriv g c := by
  -- Cauchy's MVT: Apply Rolle's theorem to the auxiliary function
  -- h(x) = (f(b) - f(a)) * g(x) - (g(b) - g(a)) * f(x)
  -- Then h(a) = f(b)g(a) - g(b)f(a) = h(b), so ∃c: h'(c) = 0
  -- h'(c) = (f(b) - f(a)) * g'(c) - (g(b) - g(a)) * f'(c) = 0
  -- Rearranging: (f(b) - f(a)) / (g(b) - g(a)) = f'(c) / g'(c)
  
  -- First, g(b) ≠ g(a) since g' ≠ 0 everywhere (by Rolle's theorem contrapositive)
  have hgne : g b ≠ g a := by
    by_contra heq
    -- If g(a) = g(b), then by Rolle's theorem ∃c: g'(c) = 0, contradiction
    obtain ⟨c, hc, hc'⟩ := exists_deriv_eq_zero hab hgc hgd heq.symm
    exact hg' c hc hc'
  
  -- Define auxiliary function h
  set h := fun x => (f b - f a) * g x - (g b - g a) * f x with hh_def
  
  -- h is continuous on [a,b] and differentiable on (a,b)
  have hhc : ContinuousOn h (Set.Icc a b) := by
    apply ContinuousOn.sub
    · exact ContinuousOn.mul continuousOn_const hgc
    · exact ContinuousOn.mul continuousOn_const hfc
  
  have hhd : DifferentiableOn ℝ h (Set.Ioo a b) := by
    apply DifferentiableOn.sub
    · exact DifferentiableOn.mul differentiableOn_const hgd
    · exact DifferentiableOn.mul differentiableOn_const hfd
  
  -- h(a) = h(b)
  have hhab : h a = h b := by
    simp only [hh_def]
    ring
  
  -- Apply Rolle's theorem to h
  obtain ⟨c, hc, hhc'⟩ := exists_deriv_eq_zero hab hhc hhd hhab
  
  use c, hc
  
  -- deriv h c = 0 means (f b - f a) * g'(c) = (g b - g a) * f'(c)
  have hderiv : deriv h c = (f b - f a) * deriv g c - (g b - g a) * deriv f c := by
    simp only [hh_def]
    rw [deriv_sub, deriv_mul_const, deriv_mul_const]
    · exact (hfd c hc).differentiableAt (Ioo_mem_nhds hc.1 hc.2)
    · exact (hgd c hc).differentiableAt (Ioo_mem_nhds hc.1 hc.2)
  
  rw [hderiv] at hhc'
  -- (f b - f a) * g'(c) = (g b - g a) * f'(c)
  have heq : (f b - f a) * deriv g c = (g b - g a) * deriv f c := by linarith
  
  -- Divide both sides by (g b - g a) * g'(c)
  field_simp [hgne, hg' c hc]
  linarith [heq]

/-! ## 4. Monotonicity and Derivatives -/

/-- Nonnegative derivative implies nondecreasing. -/
theorem nonneg_deriv_mono {f : ℝ → ℝ} {a b : ℝ}
    (hfc : ContinuousOn f (Set.Icc a b))
    (hfd : DifferentiableOn ℝ f (Set.Ioo a b))
    (hf' : ∀ x ∈ Set.Ioo a b, 0 ≤ deriv f x) :
    MonotoneOn f (Set.Icc a b) := by
  exact monotoneOn_of_deriv_nonneg (convex_Icc a b) hfc hfd.continuousOn hf'

/-- Positive derivative implies strictly increasing. -/
theorem pos_deriv_strict_mono {f : ℝ → ℝ} {a b : ℝ}
    (hfc : ContinuousOn f (Set.Icc a b))
    (hfd : DifferentiableOn ℝ f (Set.Ioo a b))
    (hf' : ∀ x ∈ Set.Ioo a b, 0 < deriv f x) :
    StrictMonoOn f (Set.Icc a b) := by
  exact strictMonoOn_of_deriv_pos (convex_Icc a b) hfc hfd hf'

/-- Nonpositive derivative implies nonincreasing. -/
theorem nonpos_deriv_anti {f : ℝ → ℝ} {a b : ℝ}
    (hfc : ContinuousOn f (Set.Icc a b))
    (hfd : DifferentiableOn ℝ f (Set.Ioo a b))
    (hf' : ∀ x ∈ Set.Ioo a b, deriv f x ≤ 0) :
    AntitoneOn f (Set.Icc a b) := by
  exact antitoneOn_of_deriv_nonpos (convex_Icc a b) hfc hfd.continuousOn hf'

/-- Negative derivative implies strictly decreasing. -/
theorem neg_deriv_strict_anti {f : ℝ → ℝ} {a b : ℝ}
    (hfc : ContinuousOn f (Set.Icc a b))
    (hfd : DifferentiableOn ℝ f (Set.Ioo a b))
    (hf' : ∀ x ∈ Set.Ioo a b, deriv f x < 0) :
    StrictAntiOn f (Set.Icc a b) := by
  exact strictAntiOn_of_deriv_neg (convex_Icc a b) hfc hfd hf'

/-! ## 5. Convexity and Derivatives -/

/-- Convex function has nondecreasing derivative. -/
theorem convex_deriv_mono {f : ℝ → ℝ} {S : Set ℝ}
    (hS : Convex ℝ S) (hf : ConvexOn ℝ S f)
    (hfd : DifferentiableOn ℝ f S) :
    MonotoneOn (deriv f) S := by
  -- For a convex function, the derivative is monotone increasing.
  -- Proof: For x < y in S, the slope from x to any point z ∈ (x,y) 
  -- is ≤ slope from z to y (by convexity).
  -- As z → x⁺, this slope → f'(x).
  -- As z → y⁻, the slope from x to z → f'(y).
  -- Hence f'(x) ≤ f'(y).
  intro x hx y hy hxy
  -- Use the fact that for convex f: f'(x) ≤ (f(y) - f(x))/(y-x) ≤ f'(y)
  by_cases hne : x = y
  · simp [hne]
  · have hlt : x < y := lt_of_le_of_ne hxy hne
    -- The derivative at x is bounded above by the secant slope
    have hsec_upper : deriv f x ≤ (f y - f x) / (y - x) := by
      have hconv := ConvexOn.slope_mono_adjacent hf hx hy hlt
      exact hconv.1
    -- The secant slope is bounded above by the derivative at y  
    have hsec_lower : (f y - f x) / (y - x) ≤ deriv f y := by
      have hconv := ConvexOn.slope_mono_adjacent hf hx hy hlt
      exact hconv.2
    linarith

/-- Nonnegative second derivative implies convex. -/
theorem nonneg_second_deriv_convex {f : ℝ → ℝ} {a b : ℝ}
    (hfc : ContDiffOn ℝ 2 f (Set.Icc a b))
    (hf'' : ∀ x ∈ Set.Ioo a b, 0 ≤ deriv (deriv f) x) :
    ConvexOn ℝ (Set.Icc a b) f := by
  -- A function with non-negative second derivative is convex.
  -- Proof: f'' ≥ 0 means f' is non-decreasing (by integration).
  -- Non-decreasing derivative implies convexity.
  -- Standard characterization: f(λx + (1-λ)y) ≤ λf(x) + (1-λ)f(y)
  apply convexOn_of_deriv2_nonneg (convex_Icc a b)
  · exact hfc.continuousOn
  · intro x hx
    exact (hfc.differentiableOn le_rfl).differentiableAt (Icc_mem_nhds hx.1 hx.2)
  · intro x hx
    -- f is twice differentiable in the interior
    have h1 : ContDiffAt ℝ 2 f x := hfc.contDiffAt (Icc_mem_nhds hx.1 hx.2)
    exact h1.differentiableAt (by norm_num : 1 ≤ 2) |>.deriv
  · intro x hx
    exact hf'' x hx

/-- Strictly positive second derivative implies strictly convex. -/
theorem pos_second_deriv_strict_convex {f : ℝ → ℝ} {a b : ℝ}
    (hfc : ContDiffOn ℝ 2 f (Set.Icc a b))
    (hf'' : ∀ x ∈ Set.Ioo a b, 0 < deriv (deriv f) x) :
    StrictConvexOn ℝ (Set.Icc a b) f := by
  -- Strictly positive second derivative implies strict convexity.
  -- The proof follows from the second derivative test:
  -- If f'' > 0 strictly, then f' is strictly increasing,
  -- which implies strict convexity.
  apply strictConvexOn_of_deriv2_pos (convex_Icc a b)
  · exact hfc.continuousOn
  · intro x hx
    exact (hfc.differentiableOn le_rfl).differentiableAt (Icc_mem_nhds hx.1 hx.2)
  · intro x hx
    have h1 : ContDiffAt ℝ 2 f x := hfc.contDiffAt (Icc_mem_nhds hx.1 hx.2)
    exact h1.differentiableAt (by norm_num : 1 ≤ 2) |>.deriv
  · intro x hx
    exact hf'' x hx

/-! ## 6. Critical Points -/

/-- A critical point is where the derivative vanishes. -/
def IsCriticalPoint (f : ℝ → ℝ) (x : ℝ) : Prop :=
  DifferentiableAt ℝ f x ∧ deriv f x = 0

/-- Local extrema occur at critical points (Fermat's theorem). -/
theorem local_extremum_critical {f : ℝ → ℝ} {x : ℝ}
    (hf : DifferentiableAt ℝ f x)
    (hmax : IsLocalMax f x) :
    IsCriticalPoint f x := by
  exact ⟨hf, hmax.deriv_eq_zero hf⟩

/-- Local minimum version. -/
theorem local_min_critical {f : ℝ → ℝ} {x : ℝ}
    (hf : DifferentiableAt ℝ f x)
    (hmin : IsLocalMin f x) :
    IsCriticalPoint f x := by
  exact ⟨hf, hmin.deriv_eq_zero hf⟩

/-! ## 7. First Derivative Test -/

/-- First derivative test for local maximum. -/
theorem first_deriv_test_max {f : ℝ → ℝ} {c : ℝ}
    (hfc : ContinuousAt f c)
    (hfd : ∀ᶠ x in 𝓝 c, DifferentiableAt ℝ f x)
    (hpos : ∀ᶠ x in 𝓝[<] c, 0 < deriv f x)
    (hneg : ∀ᶠ x in 𝓝[>] c, deriv f x < 0) :
    IsLocalMax f c := by
  -- First derivative test: if f' > 0 on (c-δ, c) and f' < 0 on (c, c+δ),
  -- then f has a local maximum at c.
  -- Proof: f is increasing before c and decreasing after c.
  rw [isLocalMax_iff]
  -- Get the neighborhoods where the derivative signs hold
  obtain ⟨δ₁, hδ₁_pos, hδ₁⟩ := (nhdsWithin_hasBasis nhds_basis_Ioo_pos _).mem_iff.mp hpos
  obtain ⟨δ₂, hδ₂_pos, hδ₂⟩ := (nhdsWithin_hasBasis nhds_basis_Ioo_pos _).mem_iff.mp hneg
  set δ := min δ₁ δ₂ with hδ_def
  have hδ_pos : 0 < δ := lt_min hδ₁_pos hδ₂_pos
  use Set.Ioo (c - δ) (c + δ)
  constructor
  · exact Ioo_mem_nhds (by linarith) (by linarith)
  · intro x hx
    by_cases hxc : x = c
    · simp [hxc]
    · by_cases hxlt : x < c
      · -- x < c: f is increasing on [x, c], so f(x) ≤ f(c)
        have hpos' : ∀ y ∈ Set.Ioo x c, 0 < deriv f y := by
          intro y hy
          apply hδ₁
          constructor
          · exact lt_of_lt_of_le hy.1 (le_of_lt hx.2)
          · exact hy.2
        -- Use MVT: f(c) - f(x) = f'(ξ)(c - x) > 0 for some ξ ∈ (x, c)
        have := strictMonoOn_of_deriv_pos (convex_Icc x c)
          (hfc.continuousOn.mono (Set.Ioo_subset_Icc_self.trans (Set.Icc_subset_Ioo hx.1 (by linarith))))
          (fun y hy => (hfd.self_of_nhds).differentiableAt.mono (Set.Ioo_subset_Icc_self hy))
          hpos'
        linarith [this (Set.left_mem_Icc.mpr (le_of_lt hxlt)) (Set.right_mem_Icc.mpr (le_of_lt hxlt)) hxlt]
      · -- x > c: f is decreasing on [c, x], so f(x) ≤ f(c)
        push_neg at hxlt
        have hxgt : c < x := lt_of_le_of_ne hxlt (Ne.symm hxc)
        have hneg' : ∀ y ∈ Set.Ioo c x, deriv f y < 0 := by
          intro y hy
          apply hδ₂
          constructor
          · exact hy.1
          · exact lt_of_lt_of_le hy.2 (le_of_lt hx.2)
        -- Use MVT: f(x) - f(c) = f'(ξ)(x - c) < 0 for some ξ ∈ (c, x)
        have := strictAntiOn_of_deriv_neg (convex_Icc c x)
          (hfc.continuousOn.mono (Set.Ioo_subset_Icc_self.trans (Set.Icc_subset_Ioo (by linarith) hx.2)))
          (fun y hy => (hfd.self_of_nhds).differentiableAt.mono (Set.Ioo_subset_Icc_self hy))
          hneg'
        linarith [this (Set.left_mem_Icc.mpr (le_of_lt hxgt)) (Set.right_mem_Icc.mpr (le_of_lt hxgt)) hxgt]

/-- First derivative test for local minimum. -/
theorem first_deriv_test_min {f : ℝ → ℝ} {c : ℝ}
    (hfc : ContinuousAt f c)
    (hfd : ∀ᶠ x in 𝓝 c, DifferentiableAt ℝ f x)
    (hneg : ∀ᶠ x in 𝓝[<] c, deriv f x < 0)
    (hpos : ∀ᶠ x in 𝓝[>] c, 0 < deriv f x) :
    IsLocalMin f c := by
  -- First derivative test for minimum: if f' < 0 on (c-δ, c) and f' > 0 on (c, c+δ),
  -- then f has a local minimum at c.
  -- Apply the maximum test to -f
  have hmax : IsLocalMax (-f) c := by
    apply first_deriv_test_max
    · exact hfc.neg
    · filter_upwards [hfd] with x hx using hx.neg
    · filter_upwards [hneg] with x hx
      simp only [Pi.neg_apply, deriv_neg']
      linarith
    · filter_upwards [hpos] with x hx
      simp only [Pi.neg_apply, deriv_neg']
      linarith
  rw [isLocalMin_iff]
  obtain ⟨U, hU, hmax'⟩ := hmax
  use U, hU
  intro x hx
  have := hmax' hx
  simp only [Pi.neg_apply] at this
  linarith

/-! ## 8. Second Derivative Test -/

/-- Second derivative test for local maximum. -/
theorem second_deriv_test_max {f : ℝ → ℝ} {c : ℝ}
    (hf : ContDiffAt ℝ 2 f c)
    (hf' : deriv f c = 0)
    (hf'' : deriv (deriv f) c < 0) :
    IsLocalMax f c := by
  -- Second derivative test: if f'(c) = 0 and f''(c) < 0, then c is a local maximum.
  -- Proof: f''(c) < 0 means f' is strictly decreasing near c.
  -- Since f'(c) = 0, we have f' > 0 for x < c and f' < 0 for x > c (near c).
  -- By first derivative test, c is a local maximum.
  
  -- f'' is continuous at c (since f is C²)
  have hcont_f'' : ContinuousAt (deriv (deriv f)) c := by
    exact hf.differentiableAt (by norm_num : 1 ≤ 2) |>.deriv.continuousAt
  
  -- Since f''(c) < 0 and f'' is continuous, f'' < 0 in a neighborhood of c
  have hneg_nbhd : ∀ᶠ x in 𝓝 c, deriv (deriv f) x < 0 := by
    exact hcont_f''.eventually_lt continuousAt_const hf''
  
  -- f' is differentiable near c
  have hf'_diff : ∀ᶠ x in 𝓝 c, DifferentiableAt ℝ (deriv f) x := by
    have : ContDiffAt ℝ 1 (deriv f) c := hf.deriv
    exact this.eventually_differentiableAt le_rfl
  
  -- Since f''(c) < 0, f' is strictly decreasing near c
  -- And f'(c) = 0, so f' > 0 for x < c and f' < 0 for x > c
  
  -- Apply first derivative test
  apply first_deriv_test_max
  · exact hf.continuousAt
  · exact hf.differentiableAt le_rfl |>.eventually
  · -- f' > 0 for x < c (since f' is decreasing and f'(c) = 0)
    rw [Filter.eventually_iff] at hneg_nbhd ⊢
    obtain ⟨U, hUo, hUc, hU⟩ := mem_nhds_iff.mp hneg_nbhd
    use U ∩ Set.Iio c
    constructor
    · exact Filter.inter_mem (mem_nhdsWithin_of_mem_nhds (hUo.mem_nhds hUc)) self_mem_nhdsWithin
    · intro x ⟨hxU, hxc⟩
      -- By MVT on [x, c]: f'(c) - f'(x) = f''(ξ)(c - x) for some ξ ∈ (x, c)
      -- f''(ξ) < 0 and c - x > 0, so f'(c) - f'(x) < 0, i.e., f'(x) > f'(c) = 0
      have hlt : x < c := hxc
      have hdiff : DifferentiableOn ℝ (deriv f) (Set.Ioo x c) := by
        intro y hy
        have : y ∈ U := hUo.mem_nhds (hU y (Set.Ioo_subset_Iio_self hy))
        sorry -- Technical: need to show differentiability in the interval
      sorry -- Apply MVT to get f'(x) > 0
  · -- f' < 0 for x > c (similar argument)
    sorry -- Similar to above

/-- Second derivative test for local minimum. -/
theorem second_deriv_test_min {f : ℝ → ℝ} {c : ℝ}
    (hf : ContDiffAt ℝ 2 f c)
    (hf' : deriv f c = 0)
    (hf'' : 0 < deriv (deriv f) c) :
    IsLocalMin f c := by
  -- Second derivative test: if f'(c) = 0 and f''(c) > 0, then c is a local minimum.
  -- Apply the maximum test to -f
  have hmax : IsLocalMax (-f) c := by
    apply second_deriv_test_max
    · exact hf.neg
    · simp [deriv_neg', hf']
    · simp only [deriv_neg']
      have : deriv (deriv (-f)) c = -deriv (deriv f) c := by
        congr 1
        ext x
        simp [deriv_neg']
      rw [this]
      linarith
  rw [isLocalMin_iff]
  obtain ⟨U, hU, hmax'⟩ := hmax
  use U, hU
  intro x hx
  have := hmax' hx
  simp only [Pi.neg_apply] at this
  linarith

/-! ## 9. Darboux's Theorem -/

/-- Darboux's theorem: derivatives have intermediate value property. -/
theorem darboux {f : ℝ → ℝ} {a b : ℝ} (hab : a < b)
    (hfd : DifferentiableOn ℝ f (Set.Icc a b))
    {y : ℝ} (hy : y ∈ Set.Ioo (deriv f a) (deriv f b) ∪
                   Set.Ioo (deriv f b) (deriv f a)) :
    ∃ c ∈ Set.Ioo a b, deriv f c = y := by
  -- Darboux's theorem: The derivative satisfies the intermediate value property,
  -- even though the derivative may not be continuous.
  -- Proof: Consider g(x) = f(x) - yx. 
  -- If y is between f'(a) and f'(b), then g'(a) and g'(b) have opposite signs.
  -- Since g is continuous on [a,b], g attains its extremum at some c ∈ (a,b).
  -- At an interior extremum, g'(c) = 0, so f'(c) = y.
  
  -- Define g(x) = f(x) - yx
  set g := fun x => f x - y * x with hg_def
  
  have hgd : DifferentiableOn ℝ g (Set.Icc a b) := by
    apply DifferentiableOn.sub hfd
    exact (differentiableOn_id.mul_const y)
  
  have hgc : ContinuousOn g (Set.Icc a b) := hgd.continuousOn
  
  -- g'(x) = f'(x) - y
  have hg' : ∀ x ∈ Set.Ioo a b, deriv g x = deriv f x - y := by
    intro x hx
    have : DifferentiableAt ℝ g x := (hgd x (Set.Ioo_subset_Icc_self hx)).differentiableAt
      (Icc_mem_nhds hx.1 hx.2)
    simp [hg_def, deriv_sub, deriv_mul_const]
  
  cases hy with
  | inl h =>
    -- y ∈ (f'(a), f'(b)): f'(a) < y < f'(b)
    have ha' : deriv g a < 0 := by
      have : deriv g a = deriv f a - y := by
        simp [hg_def, deriv_sub, deriv_mul_const]
      rw [this]; linarith [h.1]
    have hb' : deriv g b > 0 := by
      have : deriv g b = deriv f b - y := by
        simp [hg_def, deriv_sub, deriv_mul_const]
      rw [this]; linarith [h.2]
    -- g has a minimum in (a, b) since g'(a) < 0 and g'(b) > 0
    -- The continuous function g on [a,b] attains its minimum
    obtain ⟨c, ⟨hca, hcb⟩, hmin⟩ := hgc.isMinOn_of_isCompact isCompact_Icc
      ⟨a, Set.left_mem_Icc.mpr (le_of_lt hab)⟩
    -- c must be in (a, b), not at the endpoints
    have hc_int : c ∈ Set.Ioo a b := by
      constructor
      · by_contra hle
        push_neg at hle
        have hca' : c = a := le_antisymm hle hca
        -- g'(a) < 0 means g decreases from a, so a is not a minimum
        sorry -- Technical argument using derivative sign
      · by_contra hle
        push_neg at hle
        have hcb' : c = b := le_antisymm hcb hle
        -- g'(b) > 0 means g increases to b, so b is not a minimum
        sorry -- Technical argument using derivative sign
    -- At interior minimum, g'(c) = 0
    have hg'c : deriv g c = 0 := by
      have hmin' : IsLocalMin g c := by
        rw [isLocalMin_iff]
        use Set.Icc a b
        constructor
        · exact Icc_mem_nhds hc_int.1 hc_int.2
        · intro x hx
          exact hmin hx
      exact hmin'.deriv_eq_zero ((hgd c (Set.Ioo_subset_Icc_self hc_int)).differentiableAt
        (Icc_mem_nhds hc_int.1 hc_int.2))
    use c, hc_int
    rw [hg' c hc_int] at hg'c
    linarith
  | inr h =>
    -- y ∈ (f'(b), f'(a)): f'(b) < y < f'(a) (similar argument for maximum)
    have ha' : deriv g a > 0 := by
      have : deriv g a = deriv f a - y := by
        simp [hg_def, deriv_sub, deriv_mul_const]
      rw [this]; linarith [h.2]
    have hb' : deriv g b < 0 := by
      have : deriv g b = deriv f b - y := by
        simp [hg_def, deriv_sub, deriv_mul_const]
      rw [this]; linarith [h.1]
    -- Similar argument using maximum instead of minimum
    sorry -- Symmetric argument

/-- Derivatives cannot have jump discontinuities. -/
theorem deriv_no_jump {f : ℝ → ℝ} {x : ℝ}
    (hf : DifferentiableAt ℝ f x) :
    ¬∃ L₁ L₂, L₁ ≠ L₂ ∧
      Tendsto (deriv f) (𝓝[<] x) (𝓝 L₁) ∧
      Tendsto (deriv f) (𝓝[>] x) (𝓝 L₂) := by
  sorry -- Consequence of Darboux

/-! ## 10. Inverse Function Theorem (Real) -/

/-- Local inverse exists when derivative is nonzero. -/
theorem local_inverse_exists {f : ℝ → ℝ} {a : ℝ}
    (hf : ContDiffAt ℝ 1 f a)
    (hf' : deriv f a ≠ 0) :
    ∃ (g : ℝ → ℝ) (U : Set ℝ), a ∈ U ∧ IsOpen U ∧
      (∀ x ∈ U, g (f x) = x) ∧
      DifferentiableOn ℝ g (f '' U) := by
  sorry -- Real inverse function theorem

/-- Derivative of inverse. -/
theorem deriv_inverse_at {f g : ℝ → ℝ} {a : ℝ}
    (hf : ContDiffAt ℝ 1 f a)
    (hf' : deriv f a ≠ 0)
    (hg : ∀ᶠ x in 𝓝 a, g (f x) = x) :
    deriv g (f a) = 1 / deriv f a := by
  sorry -- Derivative of inverse

/-! ## 11. Inflection Points -/

/-- An inflection point is where concavity changes. -/
def IsInflectionPoint (f : ℝ → ℝ) (x : ℝ) : Prop :=
  ContDiffAt ℝ 2 f x ∧
  (∀ᶠ y in 𝓝[<] x, deriv (deriv f) y * deriv (deriv f) x < 0) ∧
  (∀ᶠ y in 𝓝[>] x, deriv (deriv f) y * deriv (deriv f) x < 0)

/-- Second derivative zero at inflection (necessary but not sufficient). -/
theorem inflection_second_deriv_zero {f : ℝ → ℝ} {x : ℝ}
    (h : IsInflectionPoint f x)
    (hcont : ContinuousAt (deriv (deriv f)) x) :
    deriv (deriv f) x = 0 := by
  sorry -- By continuity and sign change

/-! ## 12. Lipschitz Derivatives -/

/-- Bounded derivative implies Lipschitz. -/
theorem bounded_deriv_lipschitz {f : ℝ → ℝ} {S : Set ℝ} {M : ℝ}
    (hS : Convex ℝ S)
    (hf : DifferentiableOn ℝ f S)
    (hM : ∀ x ∈ S, |deriv f x| ≤ M) :
    LipschitzOnWith (Real.toNNReal M) f S := by
  sorry -- Mean value theorem application

/-- Lipschitz constant equals supremum of derivative. -/
theorem lipschitz_const_eq_sup_deriv {f : ℝ → ℝ} {a b : ℝ}
    (hf : DifferentiableOn ℝ f (Set.Icc a b))
    (hcont : ContinuousOn (deriv f) (Set.Icc a b)) :
    ∃ K, LipschitzOnWith K f (Set.Icc a b) ∧
         K = ⟨sSup {|deriv f x| | x ∈ Set.Icc a b}, sorry⟩ := by
  sorry -- Optimal Lipschitz constant

end RealDifferentiability
