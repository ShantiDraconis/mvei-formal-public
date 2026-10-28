import Mathlib

/-!
# Exact formalization of the gateway action model

This file proves algebraic facts about a cost model. The names `connectionProxy`
and `massProxy` are uninterpreted gateway parameters; no theorem here states or
implies P = NP, the Riemann hypothesis, or a Yang-Mills mass gap.
-/

namespace GatewayModel

structure Measurements where
  llama : ℚ
  gpt : ℚ
  claude : ℚ
  aesGcm : ℚ
  teardown : ℚ

def Measurements.total (m : Measurements) : ℚ :=
  m.llama + m.gpt + m.claude + m.aesGcm + m.teardown

structure Parameters where
  alpha : ℚ
  beta : ℚ
  eNorm : ℚ
  decayLambda : ℚ
  connectionProxy : ℚ

def measured : Measurements := ⟨4/5, 6/5, 11/10, 1/200, 1/20⟩
def params : Parameters := ⟨1/10, 10887/100000, 3/10, 1/5, 7/10⟩

def action (alpha beta t e : ℚ) : ℚ := alpha * t^2 - beta * e^2
def betaCritical (alpha t e : ℚ) : ℚ := alpha * t^2 / e^2
def massProxy (beta e : ℚ) : ℚ := beta * e

theorem measured_total : measured.total = 631/200 := by norm_num [measured, Measurements.total]

theorem reported_action :
    action params.alpha params.beta measured.total params.eNorm = 4928021/5000000 := by
  norm_num [action, params, measured, Measurements.total]

theorem corrected_beta_five_example :
    action (1/10) 5 measured.total (3/10) = 218161/400000 := by
  norm_num [action, measured, Measurements.total]

theorem critical_beta_exact :
    betaCritical (1/10) measured.total (3/10) = 398161/36000 := by
  norm_num [betaCritical, measured, Measurements.total]

theorem action_at_critical (alpha t e : ℚ) (he : e ≠ 0) :
    action alpha (betaCritical alpha t e) t e = 0 := by
  field_simp [action, betaCritical, he]

theorem mass_proxy_exact : massProxy params.beta params.eNorm = 32661/1000000 := by
  norm_num [massProxy, params]

theorem positive_action_means_temporal_dominates
    (alpha beta t e : ℚ) (h : 0 < action alpha beta t e) :
    beta * e^2 < alpha * t^2 := by
  simpa [action, sub_pos] using h

theorem negative_action_means_exodus_dominates
    (alpha beta t e : ℚ) (h : action alpha beta t e < 0) :
    alpha * t^2 < beta * e^2 := by
  simpa [action, sub_neg] using h

end GatewayModel
