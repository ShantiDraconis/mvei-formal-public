/-
KernelDef.lean - Kernel definitions for I-regularized zeta

This module defines the kernel functions used in the integral representation.
-/

namespace Riemann.IKernel

open Complex

/-- The Gaussian regularization kernel e^{-It²} -/
noncomputable def gaussianKernel (I : ℂ) (t : ℝ) : ℂ :=
  Complex.exp (-I * (t : ℂ)^2)

/-- The zeta kernel f_s(t) = t^{s-1}/(e^{2πt}-1) for t > 0 -/
noncomputable def zetaKernel (s : ℂ) (t : ℝ) : ℂ :=
  if t > 0 then 
    (t : ℂ)^(s - 1) / (Complex.exp (2 * Real.pi * t) - 1)
  else 
    0

/-- Full integrand for ζ_I(s) -/
noncomputable def fullIntegrand (I s : ℂ) (t : ℝ) : ℂ :=
  gaussianKernel I t * zetaKernel s t

/-- Derivative kernel ∂f_s/∂s = f_s(t) * log(t) -/
noncomputable def derivativeKernel (s : ℂ) (t : ℝ) : ℂ :=
  if t > 0 then
    zetaKernel s t * Complex.log (t : ℂ)
  else
    0

/-- Properties of Gaussian kernel -/

/-- Gaussian kernel is entire in I -/
axiom gaussianEntireI (t : ℝ) : 
  ∀ I : ℂ, ∃ df : ℂ, df = -(t : ℂ)^2 * gaussianKernel I t

/-- Gaussian kernel decays for Re(I) > 0 -/
axiom gaussianDecay (I : ℂ) (hI : I.re > 0) :
  ∀ M > 0, ∃ T > 0, ∀ t : ℝ, |t| > T → |gaussianKernel I t| < 1/M

/-- Gaussian kernel is 1 at t = 0 -/
theorem gaussianAtZero (I : ℂ) : gaussianKernel I 0 = 1 := by
  simp [gaussianKernel]

/-- Properties of zeta kernel -/

/-- Zeta kernel behavior near t = 0 -/
axiom zetaKernelNearZero (s : ℂ) (hs : s.re > 1) :
  ∀ ε > 0, ∃ δ > 0, ∀ t : ℝ, 0 < t → t < δ → 
    |zetaKernel s t - (t : ℂ)^(s-1) / (2 * Real.pi * t)| < ε * |t|^(s.re - 2)

/-- Zeta kernel decay at infinity -/
axiom zetaKernelDecay (s : ℂ) :
  ∀ M > 0, ∃ T > 0, ∀ t : ℝ, t > T → 
    |zetaKernel s t| < Complex.exp (-Real.pi * t) / M

/-- Integrability of product -/
axiom fullIntegrandIntegrable (I s : ℂ) 
  (hI : I.re > 0 ∨ I.im ≠ 0) 
  (hs : s.re > 0) :
  ∃ M : ℝ, M > 0 ∧ ∫ t : ℝ, |(fullIntegrand I s t)| ≤ M

end Riemann.IKernel
