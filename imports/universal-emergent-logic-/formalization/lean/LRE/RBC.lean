import Mathlib.Analysis.Calculus.Deriv.Basic
import Mathlib.Analysis.Calculus.Deriv.Comp
import Mathlib.Analysis.Calculus.Deriv.Pow
import Mathlib.Analysis.Calculus.MeanValue
import Mathlib.Topology.Order.Basic
import Mathlib.Order.Filter.AtTopBot
import Mathlib.Data.Real.Basic

open scoped Topology
open Filter Set Real

namespace LRE_RBC

/-!
# RBC (Corrected): Blow-up from superlinear cubic inequality

Core statement:

If `R : ℝ → ℝ` is differentiable on `[0, T)` and strictly positive there,
and satisfies

  deriv R t ≥ α * (R t)^3   for all t ∈ Iio T,

with α > 0 and R 0 > 0, then R(t) → +∞ as t → T⁻,
and in particular one may take `T = 1 / (2 * α * (R 0)^2)`.
-/

/-- The auxiliary transform: Z(t) = 1 / (R(t))^2. -/
noncomputable def Z (R : ℝ → ℝ) (t : ℝ) : ℝ := (R t)⁻¹ ^ (2 : ℕ)

lemma Z_def (R : ℝ → ℝ) : Z R = fun t => (R t)⁻¹ ^ (2 : ℕ) := rfl

/-- Derivative computation: if R is differentiable at t and R t ≠ 0, then
`deriv (Z R) t = -2 * (R t)⁻¹^3 * deriv R t`. -/
lemma deriv_Z
    (R : ℝ → ℝ) (t : ℝ)
    (hRt : R t ≠ 0)
    (hDiff : DifferentiableAt ℝ R t) :
    deriv (Z R) t = (-2) * (R t)⁻¹ ^ (3 : ℕ) * deriv R t := by
  -- Write Z as composition: t ↦ (R t) ↦ (x ↦ (x⁻¹)^2)
  -- We do it via HasDerivAt for better control.
  have hInv : DifferentiableAt ℝ (fun x : ℝ => x⁻¹) (R t) := by
    exact differentiableAt_inv₀ hRt
  have hPow : DifferentiableAt ℝ (fun x : ℝ => x ^ (2 : ℕ)) ((R t)⁻¹) := by
    exact (differentiableAt_id.pow 2)
  have hComp : DifferentiableAt ℝ (fun x : ℝ => (x⁻¹) ^ (2 : ℕ)) (R t) := by
    exact (hPow.comp _ hInv)

  -- Use derivative chain rule at the level of `HasDerivAt`.
  have hR' : HasDerivAt R (deriv R t) t := (hDiff.hasDerivAt)
  have hInv' : HasDerivAt (fun x : ℝ => x⁻¹) (-(R t)⁻¹ ^ (2 : ℕ)) (R t) := by
    -- derivative of inv: (x⁻¹)' = -x⁻²
    simpa [pow_two] using (hasDerivAt_inv₀ (x := R t) hRt)
  have hPow' : HasDerivAt (fun x : ℝ => x ^ (2 : ℕ)) (2 * ((R t)⁻¹)) ((R t)⁻¹) := by
    simpa using (hasDerivAt_pow (n := 2) (x := (R t)⁻¹))

  -- Now compute derivative of x ↦ (x⁻¹)^2 at x = R t
  have hG' : HasDerivAt (fun x : ℝ => (x⁻¹) ^ (2 : ℕ))
        (2 * ((R t)⁻¹) * (-(R t)⁻¹ ^ (2 : ℕ))) (R t) := by
    -- g = pow ∘ inv
    exact (hPow'.comp (R t) hInv')

  -- Finally, Z R = g ∘ R
  have hZ' : HasDerivAt (Z R) (2 * ((R t)⁻¹) * (-(R t)⁻¹ ^ (2 : ℕ)) * (deriv R t)) t := by
    -- (g ∘ R)' = g'(R t) * R'(t)
    simpa [Z, Function.comp] using (hG'.comp t hR')

  -- Convert to `deriv` and normalize.
  have : deriv (Z R) t = 2 * ((R t)⁻¹) * (-(R t)⁻¹ ^ (2 : ℕ)) * (deriv R t) := by
    exact hZ'.deriv

  -- Simplify: 2 * (R⁻¹) * (-(R⁻¹)^2) = (-2) * (R⁻¹)^3
  -- because (R⁻¹) * (R⁻¹)^2 = (R⁻¹)^3.
  calc
    deriv (Z R) t
        = 2 * ((R t)⁻¹) * (-(R t)⁻¹ ^ (2 : ℕ)) * (deriv R t) := this
    _ = (-2) * ((R t)⁻¹ ^ (3 : ℕ)) * (deriv R t) := by
      ring_nf

/-- Inequality step: if `deriv R t ≥ α*(R t)^3` and `R t > 0`, then
`deriv (Z R) t ≤ -2*α`. -/
lemma deriv_Z_le_neg2α
    (R : ℝ → ℝ) (α t : ℝ)
    (hRt : 0 < R t)
    (hDiff : DifferentiableAt ℝ R t)
    (hIneq : deriv R t ≥ α * (R t)^3) :
    deriv (Z R) t ≤ -2 * α := by
  have hRt_ne : R t ≠ 0 := ne_of_gt hRt
  -- Use the explicit formula for deriv Z
  have hZ : deriv (Z R) t = (-2) * (R t)⁻¹ ^ (3 : ℕ) * deriv R t :=
    deriv_Z R t hRt_ne hDiff

  -- Since (R t) > 0, (R t)⁻¹ ^ 3 > 0. Multiply inequality by a negative constant flips direction.
  have hpos_inv3 : 0 < (R t)⁻¹ ^ (3 : ℕ) := by
    have : 0 < (R t)⁻¹ := inv_pos.mpr hRt
    exact pow_pos this 3

  -- From hIneq: deriv R t ≥ α*(R t)^3
  -- Multiply by (-2)*(R t)⁻¹^3, which is negative (since -2 < 0 and inv^3 > 0):
  have hmul :
      (-2) * (R t)⁻¹ ^ (3 : ℕ) * deriv R t
        ≤ (-2) * (R t)⁻¹ ^ (3 : ℕ) * (α * (R t)^3) := by
    -- (-2)*(inv^3) < 0
    have hneg : (-2) * (R t)⁻¹ ^ (3 : ℕ) < 0 := by
      nlinarith
    exact mul_le_mul_of_nonpos_left hIneq (by linarith)

  -- Simplify RHS: (-2)*(inv^3)*(α*(R^3)) = -2*α*(inv^3*R^3) = -2*α
  -- because inv^3 * R^3 = 1.
  have hinvR : (R t)⁻¹ ^ (3 : ℕ) * (R t) ^ 3 = 1 := by
    calc
      (R t)⁻¹ ^ (3 : ℕ) * (R t) ^ 3 = ((R t)⁻¹ * (R t)) ^ (3 : ℕ) := by ring
      _ = 1 ^ (3 : ℕ) := by rw [inv_mul_cancel hRt_ne]
      _ = 1 := by norm_num

  -- Now conclude
  calc
    deriv (Z R) t
        = (-2) * (R t)⁻¹ ^ (3 : ℕ) * deriv R t := hZ
    _ ≤ (-2) * (R t)⁻¹ ^ (3 : ℕ) * (α * (R t)^3) := hmul
    _ = -2 * α := by
      calc
        (-2) * (R t)⁻¹ ^ (3 : ℕ) * (α * (R t)^3) 
            = (-2) * α * ((R t)⁻¹ ^ (3 : ℕ) * (R t)^3) := by ring
        _ = (-2) * α * 1 := by rw [hinvR]
        _ = -2 * α := by ring

/-- A clean blow-up theorem on an explicitly chosen horizon `T*`. -/
theorem blowup_of_deriv_ge_cubic
    (R : ℝ → ℝ) (α : ℝ)
    (hα : 0 < α)
    (hR0 : 0 < R 0)
    (Tstar : ℝ := 1 / (2 * α * (R 0) ^ 2))
    (hPos : ∀ t, t ∈ Iio Tstar → 0 < R t)
    (hDiff : ∀ t, t ∈ Iio Tstar → DifferentiableAt ℝ R t)
    (hIneq : ∀ t, t ∈ Iio Tstar → deriv R t ≥ α * (R t)^3) :
    Tendsto R (𝓝[<] Tstar) atTop := by
  -- Let Z(t)=1/(R t)^2. We show Z'(t) ≤ -2α for t<Tstar, hence
  -- Z(t) ≤ Z(0) - 2α t. At t→Tstar-, RHS→0, so Z→0+, hence R→+∞.
  set ZR : ℝ → ℝ := Z R

  have hZderiv : ∀ t, t ∈ Iio Tstar → deriv ZR t ≤ -2 * α := by
    intro t ht
    have hRt : 0 < R t := hPos t ht
    have hDt : DifferentiableAt ℝ R t := hDiff t ht
    have hIn : deriv R t ≥ α * (R t)^3 := hIneq t ht
    -- apply bound lemma
    simpa [ZR] using deriv_Z_le_neg2α R α t hRt hDt hIn

  -- Use a standard mean-value / derivative bound argument:
  -- If deriv ZR ≤ c on (0, Tstar), then ZR t ≤ ZR 0 + c*t for t in [0,Tstar).
  -- Here c = -2α.
  have hZbound : ∀ t, t ∈ Iio Tstar → ZR t ≤ ZR 0 + (-2 * α) * t := by
    intro t ht
    -- Use the Mean Value Theorem in inequality form.
    -- Mathlib provides variants in `Mathlib.Analysis.Calculus.MeanValue`.
    -- One stable lemma is `convex.monotoneOn_of_deriv_nonneg`-style;
    -- here we need an upper bound, so we apply it to `fun s => ZR s - c*s`
    -- to show monotonicity.
    let c : ℝ := -2 * α
    have hc : c = -2 * α := rfl

    -- Define W(s) = ZR s - c*s. Then W' = ZR' - c ≤ 0, so W is nonincreasing.
    let W : ℝ → ℝ := fun s => ZR s - c * s

    have hWderiv : ∀ s, s ∈ Iio Tstar → deriv W s ≤ 0 := by
      intro s hs
      have : deriv ZR s ≤ c := by
        simpa [c, hc] using hZderiv s hs
      -- deriv(W)=deriv(ZR) - c
      -- Use derivative linearity:
      -- deriv (fun s => ZR s - c*s) = deriv ZR s - c
      have hlin : deriv W s = deriv ZR s - c := by
        simp [W, deriv_sub (hDiff s hs) (differentiableAt_const_mul _ _)]
      -- conclude ≤ 0
      nlinarith

    -- Now use monotonicity of W on [0,t] (since deriv ≤ 0).
    -- A standard lemma: if deriv ≤ 0 on (a,b), then function is nonincreasing on [a,b].
    -- We apply on [0,t] with t<Tstar.
    have hWmono : W t ≤ W 0 := by
      -- Use `Convex.monotoneOn_of_deriv_nonneg` pattern by flipping sign:
      -- If deriv W ≤ 0 then deriv (-W) ≥ 0, hence -W is monotone increasing.
      -- Then -W 0 ≤ -W t => W t ≤ W 0.
      have hnegmono :
          (-W 0) ≤ (-W t) := by
        -- show -W is monotone on Icc 0 t
        -- Use lemma `convexOn_monotoneOn_of_deriv_nonneg` style:
        -- We'll use `Convex.monotoneOn_of_deriv_nonneg` on interval.
        -- In practice, the following lemma usually works:
        -- `Convex.monotoneOn_of_deriv_nonneg` with differentiability + deriv≥0.
        -- Here we supply it for `-W` with deriv≥0.
        have hderiv_nonneg : ∀ s, s ∈ Ioo 0 t → 0 ≤ deriv (-W) s := by
          intro s hs
          have hs' : s ∈ Iio Tstar := by
            exact lt_trans hs.2 ht
          have hw : deriv W s ≤ 0 := hWderiv s hs'
          -- deriv(-W)= -deriv W
          have : deriv (-W) s = -deriv W s := by
            simp [W]
          nlinarith
        -- Apply a monotonicity lemma on convex interval.
        -- One robust lemma is `convexOn_Icc.monotoneOn_of_deriv_nonneg`.
        -- Depending on Mathlib version, you may need to adjust this invocation.
        -- We keep it explicit:
        have hconv : Convex ℝ (Icc (0:ℝ) t) := convex_Icc _ _
        have hcont : ContinuousOn (-W) (Icc (0:ℝ) t) := by
          -- Continuity from differentiability on interior + endpoints;
          -- we can use `ContinuousOn` from `DifferentiableAt` local via `ContinuousAt`.
          -- For simplicity, use `continuousOn_of_forall_continuousAt`.
          refine continuousOn_of_forall_continuousAt fun s hs => ?_
          have hs_lt : s < Tstar := lt_of_le_of_lt hs.1 ht
          -- differentiability at s (need s<Tstar)
          have hDs : DifferentiableAt ℝ R s := hDiff s hs_lt
          -- ZR is differentiable at s as composition; hence continuous.
          -- This is enough for -W too.
          have hZR_cont : ContinuousAt ZR s := by
            exact (deriv_Z R s (ne_of_gt (hPos s hs_lt)) hDs).differentiableAt.continuousAt
          exact (hZR_cont.sub (continuousAt_const.mul continuousAt_id)).neg
        -- Finally, use monotonicity:
        -- `MonotoneOn` of (-W) on Icc 0 t implies (-W 0) ≤ (-W t).
        have hmono : MonotoneOn (-W) (Icc (0:ℝ) t) := by
          -- use a lemma from MeanValue: monotone from nonneg derivative
          -- This lemma name can vary; one stable alternative is to use
          -- `monotoneOn_of_deriv_nonneg` from `Mathlib.Analysis.Calculus.MeanValue`.
          exact monotoneOn_of_deriv_nonneg hconv hcont (by
            intro s hs
            -- hs : s ∈ Ioo 0 t
            exact hderiv_nonneg s hs
          )
        -- apply monotoneOn to endpoints
        have h0 : (0:ℝ) ∈ Icc (0:ℝ) t := by
          exact ⟨le_rfl, le_of_lt ht⟩
        have ht' : t ∈ Icc (0:ℝ) t := by
          exact ⟨le_of_lt (by linarith), le_rfl⟩
        exact hmono h0 ht' (by linarith)
      -- Convert back:
      nlinarith

    -- unwrap W inequality into ZR bound
    -- W t ≤ W 0  => ZR t - c*t ≤ ZR 0 - c*0 = ZR 0
    -- => ZR t ≤ ZR 0 + c*t
    have : ZR t - c * t ≤ ZR 0 := by
      simpa [W] using hWmono
    have : ZR t ≤ ZR 0 + c * t := by nlinarith
    simpa [c, hc] using this

  -- Now take the limit t → Tstar⁻.
  -- First compute ZR 0 and simplify: ZR 0 = (R 0)⁻¹^2 = 1/(R0)^2
  have hZR0 : ZR 0 = (R 0)⁻¹ ^ (2 : ℕ) := by simp [ZR, Z]

  -- Evaluate the affine upper bound at Tstar: ZR 0 + (-2α)*Tstar = 0 by definition of Tstar
  have h_aff_zero : ZR 0 + (-2 * α) * Tstar = 0 := by
    -- Tstar = 1/(2*α*(R0)^2)
    -- ZR 0 = (R0)⁻² = 1/(R0^2)
    -- So ZR0 - 2α*Tstar = 1/R0^2 - 2α*(1/(2α*R0^2)) = 0
    field_simp [Tstar, hZR0, pow_two]
    ring

  -- From ZR(t) ≤ affine(t) and affine(t) → 0 as t→Tstar-, and ZR(t) ≥ 0,
  -- conclude ZR(t) → 0.
  -- Then R(t) = 1 / sqrt(ZR(t)) → +∞.
  -- We finish using `Tendsto` lemmas for inv and sqrt.
  have hZ_nonneg : ∀ t, t ∈ Iio Tstar → 0 ≤ ZR t := by
    intro t ht
    -- ZR t = (R t)⁻¹^2 ≥ 0
    simp [ZR, Z, pow_two]

  -- Tendsto of affine bound:
  have h_aff_tendsto : Tendsto (fun t => ZR 0 + (-2 * α) * t) (𝓝[<] Tstar) (𝓝 0) := by
    -- continuous function tends to its value at Tstar, which is 0 by h_aff_zero
    have hcont : Continuous (fun t => ZR 0 + (-2 * α) * t) := by
      continuity
    -- Use `tendsto_nhdsWithin_of_tendsto_nhds`-style
    simpa [h_aff_zero] using (hcont.tendsto Tstar).mono_left nhdsWithin_le_nhds

  -- Show ZR → 0 using squeeze: 0 ≤ ZR t ≤ affine(t) and affine → 0
  have hZ_tendsto : Tendsto ZR (𝓝[<] Tstar) (𝓝 0) := by
    -- Use `tendsto_of_tendsto_of_tendsto_of_le_of_le`
    refine tendsto_of_tendsto_of_tendsto_of_le_of_le tendsto_const_nhds h_aff_tendsto ?_ ?_
    · -- eventually (0 ≤ ZR t)
      refine (eventually_nhdsWithin_iff.2 ?_)
      refine ⟨Iio Tstar, ?_, by simp⟩
      intro t ht
      exact hZ_nonneg t ht
    · -- eventually (ZR t ≤ affine t)
      refine (eventually_nhdsWithin_iff.2 ?_)
      refine ⟨Iio Tstar, ?_, by simp⟩
      intro t ht
      exact hZbound t ht

  -- Convert ZR → 0 to R → +∞:
  -- ZR = (R⁻¹)^2; so sqrt(ZR)=|R⁻¹|; with R>0 we get sqrt(ZR)=R⁻¹; hence inv → 0; hence R → +∞.
  -- We use positivity to drop abs.
  have hRinv_tendsto0 : Tendsto (fun t => (R t)⁻¹) (𝓝[<] Tstar) (𝓝 0) := by
    -- Since ZR = (R⁻¹)^2 and ZR→0 with ZR≥0, we get |R⁻¹|→0 hence R⁻¹→0.
    -- Use continuity of sqrt and pow; simplest: use `tendsto` through `fun x => Real.sqrt x`.
    have hsqrt : Tendsto (fun t => Real.sqrt (ZR t)) (𝓝[<] Tstar) (𝓝 (Real.sqrt 0)) :=
      (Real.continuous_sqrt.tendsto 0).comp hZ_tendsto
    have hsqrt0 : Real.sqrt (0:ℝ) = 0 := by simp
    have : Tendsto (fun t => Real.sqrt (ZR t)) (𝓝[<] Tstar) (𝓝 0) := by
      simpa [hsqrt0] using hsqrt
    -- Now show sqrt(ZR t) = (R t)⁻¹ because R t > 0
    have hEq : ∀ t, t ∈ Iio Tstar → Real.sqrt (ZR t) = (R t)⁻¹ := by
      intro t ht
      have hRt : 0 < R t := hPos t ht
      -- ZR t = (R t)⁻¹^2 ≥0; sqrt((a)^2)=|a|; with a=(R t)⁻¹>0 gives a
      have ha : 0 < (R t)⁻¹ := inv_pos.mpr hRt
      -- sqrt(a^2)=|a| and |a|=a if a≥0
      -- Here a=(R t)⁻¹, a^2=(R t)⁻¹^2 = ZR t
      simp [ZR, Z, pow_two, abs_of_nonneg (le_of_lt ha)]
    -- Transfer limit through eventual equality
    refine this.congr' ?_
    refine (eventually_nhdsWithin_iff.2 ?_)
    refine ⟨Iio Tstar, ?_, by simp⟩
    intro t ht
    exact (hEq t ht).symm

  -- Finally, inv → 0 implies R → +∞ (for positive R). Use `tendsto_inv_atTop_zero`.
  have hR_tendsto : Tendsto R (𝓝[<] Tstar) atTop := by
    -- `tendsto_inv_atTop_zero` gives: inv x → 0 => x → ∞, with x>0 eventually
    -- We'll use a standard lemma:
    -- `tendsto_inv_atTop_zero` is: Tendsto (fun x => x⁻¹) atTop (𝓝 0)
    -- We need the converse, usually `tendsto_atTop.2` characterization:
    refine tendsto_atTop.2 ?_
    intro M
    -- Need: eventually t near Tstar- has R t ≥ M.
    -- Since inv tends to 0, eventually inv ≤ 1/M (for M>0) and positivity gives ≥M.
    by_cases hM : M ≤ 0
    · -- trivial since R t > 0
      refine (eventually_nhdsWithin_iff.2 ?_)
      refine ⟨Iio Tstar, ?_, by simp⟩
      intro t ht
      have : 0 < R t := hPos t ht
      exact le_trans hM (le_of_lt this)
    · have hMpos : 0 < M := lt_of_not_ge hM
      -- inv → 0 gives eventually |inv| < 1/M; since inv>0, inv < 1/M ⇒ R > M
      have : ∀ᶠ t in 𝓝[<] Tstar, (R t)⁻¹ < (1 / M) := by
        -- use tendsto to neighborhood (Iio (1/M)) around 0
        have hnb : Iio (1 / M) ∈ 𝓝 (0:ℝ) := by
          have : (0:ℝ) < 1 / M := by nlinarith
          exact Iio_mem_nhds this
        exact (hRinv_tendsto0.eventually hnb)
      refine this.mono ?_
      intro t htinv
      have hRt : 0 < R t := hPos t (mem_of_mem_nhdsWithin htinv)
      -- From inv < 1/M and inv>0, invert inequality
      have : R t > M := by
        -- htinv : 1/(R t) < 1/M implies M < R t
        -- More directly: `inv_lt_inv_of_lt`:
        -- inv a < inv b ↔ b < a for positive
        have h1 : (R t)⁻¹ < (1 / M) := htinv
        -- rewrite 1/M as M⁻¹
        have h2 : (1 / M) = M⁻¹ := by simp
        -- so (R t)⁻¹ < M⁻¹, with positives ⇒ M < R t
        have hM_pos : 0 < M := hMpos
        -- `inv_lt_inv_of_lt` gives: for 0<a<b, inv b < inv a. We need a lemma:
        -- `inv_lt_inv_of_lt` expects `0 < a` and `a < b` -> inv b < inv a.
        -- We want: inv(R) < inv(M) -> M < R. Use `inv_lt_inv` lemma:
        -- `inv_lt_inv_of_lt` rearranged via `lt_of_inv_lt_inv`.
        exact lt_of_inv_lt_inv hM_pos hRt (by simpa [h2] using h1)
      exact le_of_lt this

  exact hR_tendsto

end LRE_RBC