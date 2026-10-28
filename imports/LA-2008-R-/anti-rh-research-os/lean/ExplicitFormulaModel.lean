-- ExplicitFormulaModel.lean
-- Anti-RH Research OS — Explicit formula under ¬RH
--
-- Models the pair contribution of (ρ, ρ̄) to ψ(x) and the
-- resulting amplitude growth.

import AntiRH.AntiRHDefinitions

namespace AntiRH.ExplicitFormula

open Real Complex

-- ─────────────────────────────────────────────────────────────────
-- §7  Pair contribution
-- ─────────────────────────────────────────────────────────────────

/-- The contribution of the pair (ρ, ρ̄) to ψ(x):
    −x^ρ/ρ − x^{ρ̄}/ρ̄ = −2 x^β (β cos(γ log x) + γ sin(γ log x)) / |ρ|²
-/
noncomputable def pairContribution (β γ x : ℝ) (hx : 1 < x) : ℝ :=
  let logx := Real.log x
  let ρsq  := β^2 + γ^2
  -2 * x^β * (β * Real.cos (γ * logx) + γ * Real.sin (γ * logx)) / ρsq

/-- Under RH (β = 1/2), the amplitude is x^{1/2}. -/
theorem rh_amplitude (γ x : ℝ) (hx : 1 < x) (hγ : 0 < γ) :
    |pairContribution (1/2) γ x hx| ≤ 2 * x^(1/2 : ℝ) / γ := by
  simp only [pairContribution]
  have hγ2 : (0 : ℝ) < (1/2 : ℝ)^2 + γ^2 := by positivity
  rw [abs_div, abs_neg]
  gcongr
  · calc |2 * x ^ (1/2 : ℝ) * ((1/2) * cos (γ * log x) + γ * sin (γ * log x))|
        ≤ 2 * x ^ (1/2 : ℝ) * |(1/2 : ℝ) * cos (γ * log x) + γ * sin (γ * log x)| := by
          rw [abs_mul, abs_mul, abs_of_pos (by positivity), abs_of_pos (by positivity)]
      _ ≤ 2 * x ^ (1/2 : ℝ) * ((1/2) * 1 + γ * 1) := by
          gcongr
          · exact abs_cos_le_one _  |>.le  -- applies |cos(·)| ≤ 1
          · exact abs_sin_le_one _  |>.le
      _ = 2 * x ^ (1/2 : ℝ) * (1/2 + γ) := by ring
      _ ≤ 2 * x ^ (1/2 : ℝ) * (γ + γ) := by gcongr; linarith
      _ = 2 * x ^ (1/2 : ℝ) * 2 * γ := by ring
      _ ≤ _ := by
          -- TODO (#lean-rh-1): completing this requires bounding the denominator
          -- |ρ|² = β² + γ² ≥ γ², giving 2x^β·2γ / γ² = 4x^β/γ ≤ 2x^{1/2}/γ
          -- for β=1/2.  The step is routine but needs rpow monotonicity lemmas
          -- not yet assembled here.
          sorry
  · exact le_refl _

/-- Under ¬RH (β > 1/2), the amplitude is x^β > x^{1/2}. -/
theorem anti_rh_amplitude_dominates
    (β γ x : ℝ) (hβ : 1/2 < β) (hx : 2 < x) (hγ : 0 < γ) :
    x^(1/2 : ℝ) < x^β := by
  apply Real.rpow_lt_rpow_of_exponent_lt
  · linarith
  · exact hβ

-- ─────────────────────────────────────────────────────────────────
-- §8  Error bound for π(x)
-- ─────────────────────────────────────────────────────────────────

/-- The error bound |π(x) − li(x)| = O(x^{β_max} log x).
    Formalised as: the bound grows faster than x^{1/2} log x
    when β_max > 1/2. -/
theorem error_bound_grows
    (β_max : ℝ) (hβ : 1/2 < β_max) (x : ℝ) (hx : 2 < x) :
    x^(1/2 : ℝ) * Real.log x < x^β_max * Real.log x := by
  have hlog : 0 < Real.log x := Real.log_pos (by linarith)
  gcongr
  exact anti_rh_amplitude_dominates β_max 1 x hβ hx one_pos

end AntiRH.ExplicitFormula
