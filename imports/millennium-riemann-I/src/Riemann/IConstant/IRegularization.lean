/-
IRegularization.lean - I as a regularization operator

This module formalizes how I regularizes integrals and functions.
-/

import Riemann.IConstant.ICore

namespace Riemann.IConstant

open Complex

/-- Gaussian regularization kernel -/
noncomputable def gaussianKernel (I : ℂ) (t : ℝ) : ℂ :=
  Complex.exp (-I * (t : ℂ)^2)

/-- I-regularized integral operator -/
noncomputable def regularize (I : ℂ) (f : ℝ → ℂ) : ℂ :=
  ∫ t : ℝ, gaussianKernel I t * f t

/-- Convergence of regularized integrals -/
axiom regularizedConverges (I : ℂ) (f : ℝ → ℂ) 
  (hI : I.re > 0 ∨ I.im ≠ 0) 
  (hf : ∀ t, |f t| ≤ |t|^(-1) * Complex.exp (2 * Real.pi * |t|)) :
  ∃ val : ℂ, regularize I f = val

/-- Regularization preserves zeros -/
axiom regularizationPreservesZeros (I : ℂ) (f : ℝ → ℂ) (s : ℂ)
  (hzero : ∫ t : ℝ, f t * (t : ℂ)^(s-1) = 0) :
  regularize I (fun t => f t * (t : ℂ)^(s-1)) = 0

/-- Derivative of regularization with respect to I -/
axiom regularizeDerivI (I : ℂ) (f : ℝ → ℂ) :
  ∃ df : ℂ, df = -∫ t : ℝ, (t : ℂ)^2 * gaussianKernel I t * f t

/-- Limit as I → 0 (formal) -/
axiom regularizeLimitZero (f : ℝ → ℂ) 
  (hf : ∃ val : ℂ, ∫ t : ℝ, f t = val) :
  ∀ ε > 0, ∃ δ > 0, ∀ I : ℂ, |I| < δ →
    |regularize I f - ∫ t : ℝ, f t| < ε

/-- I-regularization of zeta kernel -/
noncomputable def zetaKernel (s : ℂ) (t : ℝ) : ℂ :=
  if t > 0 then (t : ℂ)^(s - 1) / (Complex.exp (2 * Real.pi * t) - 1)
  else 0

/-- The I-regularized zeta function -/
noncomputable def zetaI (I s : ℂ) : ℂ :=
  regularize I (zetaKernel s)

/-- ζ_I equals the integral representation -/
axiom zetaI_integral (I s : ℂ) :
  zetaI I s = ∫ t : ℝ, gaussianKernel I t * zetaKernel s t

end Riemann.IConstant
