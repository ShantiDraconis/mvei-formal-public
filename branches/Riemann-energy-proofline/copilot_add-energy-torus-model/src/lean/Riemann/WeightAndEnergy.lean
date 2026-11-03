/-
  WeightAndEnergy.lean
  
  Definitions of weight function w(t), potential U(σ,t), and energy functional E(σ).
-/

import Mathlib.Analysis.Calculus.Deriv.Basic
import Mathlib.MeasureTheory.Integral.IntervalIntegral
import Riemann.BasicZetaXi

namespace Riemann

open MeasureTheory Complex

/-- Weight function w : ℝ → ℝ with w(t) > 0 -/
structure WeightFunction where
  w : ℝ → ℝ
  positive : ∀ t : ℝ, 0 < w t
  measurable : Measurable w

/-- Cutoff parameter T > 0 -/
structure CutoffParam where
  T : ℝ
  T_pos : 0 < T

/-- Potential U(σ, t) = |ξ(σ + it)|² -/
noncomputable def potential (σ t : ℝ) : ℝ := 
  Complex.normSq (xi (σ + t * I))

/-- The energy functional E(σ) = ∫₀ᵀ w(t) |ξ(σ + it)|² dt -/
noncomputable def energyFunctional (w : WeightFunction) (T : CutoffParam) (σ : ℝ) : ℝ := 
  ∫ t in (0 : ℝ)..T.T, w.w t * potential σ t

/-- Abbreviation for E(σ) -/
abbrev E (w : WeightFunction) (T : CutoffParam) := energyFunctional w T

/-- The first derivative E'(σ) -/
noncomputable def E' (w : WeightFunction) (T : CutoffParam) (σ : ℝ) : ℝ := 
  deriv (E w T) σ

/-- The second derivative E''(σ) -/
noncomputable def E'' (w : WeightFunction) (T : CutoffParam) (σ : ℝ) : ℝ := 
  deriv (E' w T) σ

/-- Axiom: E is twice differentiable on (0,1) -/
axiom E_twice_differentiable (w : WeightFunction) (T : CutoffParam) : 
  ∀ σ : ℝ, 0 < σ → σ < 1 → DifferentiableAt ℝ (E' w T) σ

/-- Axiom: E(σ) is well-defined and finite for σ ∈ (0,1) -/
axiom E_finite (w : WeightFunction) (T : CutoffParam) (σ : ℝ) 
    (hσ : 0 < σ ∧ σ < 1) : (E w T σ).toReal < ⊤

end Riemann
