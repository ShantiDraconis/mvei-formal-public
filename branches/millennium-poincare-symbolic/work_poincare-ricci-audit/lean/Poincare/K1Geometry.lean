import Mathlib

open Set MeasureTheory intervalIntegral

namespace Poincare

/--
Explicit real-analysis model for the volume of a radius-r ball in a
round three-sphere of radius a. The identification with an actual
Riemannian geodesic ball is intentionally isolated in RoundS3GeometricBridge.
-/
noncomputable def roundS3ModelVolume (a r : ℝ) : ℝ :=
  4 * Real.pi * a ^ 3 * ∫ u in (0 : ℝ)..r / a, Real.sin u ^ 2

/--
Cleared curvature-scale condition corresponding to
sqrt(12)/a^2 <= 1/r^2 for positive a,r.
-/
def RoundS3CurvatureScale (a r : ℝ) : Prop :=
  Real.sqrt 12 * r ^ 2 ≤ a ^ 2

/-- The curvature-scale hypothesis forces the normalized radius r/a to be <= 1. -/
theorem roundS3_curvatureScale_implies_r_le_a
    {a r : ℝ} (ha : 0 < a) (hr : 0 ≤ r)
    (hscale : RoundS3CurvatureScale a r) :
    r ≤ a := by
  have hsqrt : (1 : ℝ) ≤ Real.sqrt 12 := by
    exact Real.one_le_sqrt.mpr (by norm_num)
  have hr2 : r ^ 2 ≤ a ^ 2 := by
    calc
      r ^ 2 = 1 * r ^ 2 := by ring
      _ ≤ Real.sqrt 12 * r ^ 2 :=
        mul_le_mul_of_nonneg_right hsqrt (sq_nonneg r)
      _ ≤ a ^ 2 := hscale
  nlinarith

/--
Mathlib v4.19.0 supplies the Taylor lower bound
u - u^3/4 < sin u for 0<u<=1. Together with u^3<=u this yields
(3/4)u <= sin u on [0,1].
-/
theorem sin_three_four_lower
    {u : ℝ} (hu0 : 0 ≤ u) (hu1 : u ≤ 1) :
    (3 / 4 : ℝ) * u ≤ Real.sin u := by
  rcases hu0.eq_or_lt with rfl | hu
  · simp
  · have hsin : u - u ^ 3 / 4 < Real.sin u :=
      Real.sin_gt_sub_cube hu hu1
    have hfactor : 0 ≤ u * (1 - u) * (1 + u) := by
      exact mul_nonneg
        (mul_nonneg hu0 (sub_nonneg.mpr hu1))
        (by linarith)
    have hcube : u ^ 3 ≤ u := by
      nlinarith [hfactor]
    nlinarith [hsin, hcube]

theorem sin_sq_lower
    {u : ℝ} (hu0 : 0 ≤ u) (hu1 : u ≤ 1) :
    ((3 / 4 : ℝ) * u) ^ 2 ≤ Real.sin u ^ 2 := by
  have h := sin_three_four_lower hu0 hu1
  have hleft : 0 ≤ (3 / 4 : ℝ) * u := by positivity
  have hright : 0 ≤ Real.sin u := le_trans hleft h
  have hprod :
      0 ≤ (Real.sin u - (3 / 4 : ℝ) * u) *
        (Real.sin u + (3 / 4 : ℝ) * u) := by
    exact mul_nonneg (sub_nonneg.mpr h) (add_nonneg hright hleft)
  nlinarith [hprod]

/--
On 0<=x<=1, the sine-square integral is at least (3/16)x^3.
-/
theorem integral_sin_sq_lower
    {x : ℝ} (hx0 : 0 ≤ x) (hx1 : x ≤ 1) :
    (3 / 16 : ℝ) * x ^ 3 ≤ ∫ u in (0 : ℝ)..x, Real.sin u ^ 2 := by
  have hpoly :
      IntervalIntegrable (fun u : ℝ => ((3 / 4 : ℝ) * u) ^ 2)
        volume 0 x := by
    exact ((continuous_const.mul continuous_id).pow 2).intervalIntegrable _ _
  have hsin :
      IntervalIntegrable (fun u : ℝ => Real.sin u ^ 2)
        volume 0 x := by
    exact (Real.continuous_sin.pow 2).intervalIntegrable _ _
  have hmono :
      (∫ u in (0 : ℝ)..x, ((3 / 4 : ℝ) * u) ^ 2)
        ≤ ∫ u in (0 : ℝ)..x, Real.sin u ^ 2 := by
    exact intervalIntegral.integral_mono_on hx0 hpoly hsin fun u hu =>
      sin_sq_lower hu.1 (hu.2.trans hx1)
  have hcalc :
      (∫ u in (0 : ℝ)..x, ((3 / 4 : ℝ) * u) ^ 2)
        = (3 / 16 : ℝ) * x ^ 3 := by
    calc
      (∫ u in (0 : ℝ)..x, ((3 / 4 : ℝ) * u) ^ 2)
          = ∫ u in (0 : ℝ)..x, (9 / 16 : ℝ) * u ^ 2 := by
              congr with u
              ring
      _ = (9 / 16 : ℝ) * (∫ u in (0 : ℝ)..x, u ^ 2) := by
              rw [intervalIntegral.integral_const_mul]
      _ = (3 / 16 : ℝ) * x ^ 3 := by
              rw [integral_pow]
              ring
  rw [← hcalc]
  exact hmono

/--
The explicit analytic round-S3 volume model has the certified lower bound
(3*pi/4) r^3 whenever a>0 and 0<=r<=a.
-/
theorem roundS3_model_volume_lower
    {a r : ℝ} (ha : 0 < a) (hr : 0 ≤ r) (hra : r ≤ a) :
    (3 * Real.pi / 4) * r ^ 3 ≤ roundS3ModelVolume a r := by
  have hx0 : 0 ≤ r / a := div_nonneg hr ha.le
  have hx1 : r / a ≤ 1 := (div_le_one ha).2 hra
  have hint :
      (3 / 16 : ℝ) * (r / a) ^ 3
        ≤ ∫ u in (0 : ℝ)..r / a, Real.sin u ^ 2 :=
    integral_sin_sq_lower hx0 hx1
  have hcoef : 0 ≤ 4 * Real.pi * a ^ 3 := by positivity
  have hmul := mul_le_mul_of_nonneg_left hint hcoef
  rw [roundS3ModelVolume]
  calc
    (3 * Real.pi / 4) * r ^ 3
        = (4 * Real.pi * a ^ 3) * ((3 / 16 : ℝ) * (r / a) ^ 3) := by
            field_simp [ne_of_gt ha] <;> ring
    _ ≤ (4 * Real.pi * a ^ 3) *
          (∫ u in (0 : ℝ)..r / a, Real.sin u ^ 2) := hmul

theorem two_lt_three_pi_div_four :
    (2 : ℝ) < 3 * Real.pi / 4 := by
  nlinarith [Real.pi_gt_three]

/-- The explicit round-S3 analytic model is kappa=2 noncollapsed. -/
theorem roundS3_model_kappa_two
    {a r : ℝ} (ha : 0 < a) (hr : 0 ≤ r) (hra : r ≤ a) :
    2 * r ^ 3 ≤ roundS3ModelVolume a r := by
  have hc : (2 : ℝ) ≤ 3 * Real.pi / 4 :=
    le_of_lt two_lt_three_pi_div_four
  have hr3 : 0 ≤ r ^ 3 := by positivity
  exact le_trans
    (mul_le_mul_of_nonneg_right hc hr3)
    (roundS3_model_volume_lower ha hr hra)

/-- Complete analytic chain: curvature scale -> normalized radius -> volume -> kappa=2. -/
theorem roundS3_curvatureScale_model_kappa_two
    {a r : ℝ} (ha : 0 < a) (hr : 0 ≤ r)
    (hscale : RoundS3CurvatureScale a r) :
    2 * r ^ 3 ≤ roundS3ModelVolume a r := by
  exact roundS3_model_kappa_two ha hr
    (roundS3_curvatureScale_implies_r_le_a ha hr hscale)

/--
Single semantic firewall between the kernel-checked analytic model and an
actual round-S3 Riemannian ball. A future geometric realization must construct
this structure; it is not postulated as an axiom.
-/
structure RoundS3GeometricBridge where
  a : ℝ
  r : ℝ
  actualVolume : ℝ
  radius_pos : 0 < a
  ballRadius_nonneg : 0 ≤ r
  curvatureScale : RoundS3CurvatureScale a r
  volume_eq_model : actualVolume = roundS3ModelVolume a r

theorem roundS3_geometricBridge_kappa_two
    (G : RoundS3GeometricBridge) :
    2 * G.r ^ 3 ≤ G.actualVolume := by
  rw [G.volume_eq_model]
  exact roundS3_curvatureScale_model_kappa_two
    G.radius_pos G.ballRadius_nonneg G.curvatureScale

end Poincare
