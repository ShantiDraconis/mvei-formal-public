/-!
# OffCriticalProgram.lean

Programa de pesquisa auditável sobre zeros fora da linha crítica de ζ(s).
Quatro eixos independentes; nenhum axioma RH é assumido ou provado.

Estado por eixo:
- **Eixo 1** — geometria local: provado completamente (0 sorry).
- **Eixo 2** — defeito global: definições fechadas; conjecturas marcadas sorry.
- **Eixo 3** — janela espectral: identidade algébrica provada; cotas abertas.
- **Eixo 4** — correlação V_Ω: estrutura definida; contraexemplo computado.

Dependência: `import Mathlib` (Lean 4 + Mathlib4).
-/

import Mathlib.Data.Real.Basic
import Mathlib.Data.Complex.Basic
import Mathlib.Analysis.SpecialFunctions.ExpDeriv
import Mathlib.Analysis.SpecialFunctions.Log.Basic
import Mathlib.Analysis.SpecialFunctions.Pow.Real
import Mathlib.Tactic

namespace OffCritical

/-! ──────────────────────────────────────────────────────────────────────────
    EIXO 1 — Geometria Local Off-Critical
    Referência: local_rigidity_zero_iff — 0 sorry neste eixo.
    ────────────────────────────────────────────────────────────────────────── -/

section Axis1

/-- Desvio da linha crítica: δ = β − 1/2, onde ρ = β + iγ. -/
def delta (β : ℝ) : ℝ := β - 1 / 2

/-- Raio crítico ao quadrado: R_c² = γ² + 1/4. -/
def R_c_sq (γ : ℝ) : ℝ := γ ^ 2 + 1 / 4

/-- |ρ|² = β² + γ². -/
def R_plus_sq (β γ : ℝ) : ℝ := β ^ 2 + γ ^ 2

/-- |1 − ρ|² = (1 − β)² + γ². -/
def R_minus_sq (β γ : ℝ) : ℝ := (1 - β) ^ 2 + γ ^ 2

/-- Defeito de paridade local: Δ_par = δ². -/
def Delta_par (β : ℝ) : ℝ := delta β ^ 2

/--
**Teorema de rigidez local** (Eixo 1, 0 sorry):
O defeito de paridade coincide com o excesso dos raios sobre o raio crítico,
  Δ_par(β) = (R₊²(β,γ) + R₋²(β,γ)) / 2 − R_c²(γ).
Equivalentemente, δ² = (|ρ|² + |1−ρ|²)/2 − (γ² + 1/4).
-/
theorem local_rigidity_zero_iff (β γ : ℝ) :
    Delta_par β = (R_plus_sq β γ + R_minus_sq β γ) / 2 - R_c_sq γ := by
  unfold Delta_par delta R_plus_sq R_minus_sq R_c_sq
  ring

/-- Corolário: na linha crítica (δ = 0) vale Δ_par = 0. -/
theorem on_critical_line_iff (γ : ℝ) :
    Delta_par (1 / 2) = 0 := by
  unfold Delta_par delta; ring

end Axis1

/-! ──────────────────────────────────────────────────────────────────────────
    EIXO 2 — Defeito Global e Perda de Sensibilidade
    Definições fechadas; conjecturas sobre decaimento e precisão marcadas sorry.
    ────────────────────────────────────────────────────────────────────────── -/

section Axis2

open Axis1

/-- Amplitude: A(β,γ) = γ² + 1/4 + δ². -/
noncomputable def amplitude (β γ : ℝ) : ℝ :=
  γ ^ 2 + 1 / 4 + delta β ^ 2

/--
Denominador P = A² − δ².
Fatoração: P = (γ² + (β−1)²)(γ² + β²) = |ρ|² · |1−ρ|².
-/
noncomputable def denom_P (β γ : ℝ) : ℝ :=
  amplitude β γ ^ 2 - delta β ^ 2

/-- Fatoração explícita de P em termos dos raios. -/
theorem denom_P_factored (β γ : ℝ) :
    denom_P β γ = R_plus_sq β γ * R_minus_sq β γ := by
  unfold denom_P amplitude delta R_plus_sq R_minus_sq
  ring

/-- P ≥ 0 para todos β, γ reais (segue da fatoração como produto de somas de quadrados). -/
theorem denom_P_nonneg (β γ : ℝ) : 0 ≤ denom_P β γ := by
  rw [denom_P_factored]
  unfold R_plus_sq R_minus_sq
  positivity

/-- Peso individual: w(β,γ) = 2δ² / P. -/
noncomputable def weight_w (β γ : ℝ) : ℝ :=
  2 * delta β ^ 2 / denom_P β γ

/-- W₄ = 4w ≈ 8δ²/γ⁴ para |γ| grande. -/
noncomputable def W4 (β γ : ℝ) : ℝ := 4 * weight_w β γ

/-- w ≥ 0 quando P > 0. -/
theorem weight_w_nonneg (β γ : ℝ) (hP : 0 < denom_P β γ) : 0 ≤ weight_w β γ := by
  unfold weight_w
  positivity

/-- Defeito radial acumulado D_rad(Ω) = Σ_{ρ ∈ Ω} w_ρ. -/
noncomputable def D_rad (zeros : Finset (ℝ × ℝ)) : ℝ :=
  zeros.sum fun ρ => weight_w ρ.1 ρ.2

/-! Conjecturas abertas (sorry explícito): -/

/--
**Conjectura 2.1** (aberta): Decaimento γ⁻⁴.
Para zeros na linha crítica, τ(T) = D_rad({|γ| ≤ T}) / N(T) ≤ C · log T / T³.
-/
-- Enunciado formal requer enumeração dos zeros de ζ e hipóteses de distribuição.
axiom sensitivity_decay_conjecture :
    ∃ C : ℝ, C > 0 ∧ ∀ T : ℝ, T > 1 → True  -- placeholder formal

/--
**Conjectura 2.2** (aberta): W₄(δ,γ) < 8δ²/γ⁴ + O(δ²/γ⁶) para γ ≥ γ₀.
A precisão necessária para δ=0.1, γ≥10³ está abaixo de dupla precisão (7.99×10⁻¹⁴);
requer aritmética de intervalo com ≥ 200 dígitos.
-/
-- Verificação numérica: ver data/off-critical-w4.csv, linha δ=0.1, γ=1000.
theorem W4_asymptotic_sorry (β γ : ℝ) (hγ : 0 < γ) :
    W4 β γ = 8 * delta β ^ 2 / γ ^ 4 + (W4 β γ - 8 * delta β ^ 2 / γ ^ 4) := by
  ring  -- tautologia; cota assintótica fica em aberto

end Axis2

/-! ──────────────────────────────────────────────────────────────────────────
    EIXO 3 — Janela Espectral e Custo de Detecção
    Identidade algébrica X_{η,Δ} = (T/2π)^{Δ/c} quando η = c·d_médio provada.
    ────────────────────────────────────────────────────────────────────────── -/

section Axis3

open Real

/-- Custo espectral para detectar desvio η com janela Δ: X_{η,Δ} = e^{2πΔ/η}. -/
noncomputable def spectral_cost (η Δ : ℝ) : ℝ := exp (2 * π * Δ / η)

/-- Espaçamento médio entre zeros em altura T: d_médio(T) = 2π / log(T/2π). -/
noncomputable def mean_zero_spacing (T : ℝ) : ℝ := 2 * π / log (T / (2 * π))

/--
**Teorema 3.1**: Quando η = c · d_médio(T), o custo torna-se potencial:
  X_{η,Δ} = (T/2π)^{Δ/c}.
Não é superexponencial — a janela determina o expoente.
-/
theorem spectral_cost_power_law (c Δ T : ℝ) (hc : 0 < c) (hT : 2 * π < T) :
    spectral_cost (c * mean_zero_spacing T) Δ = (T / (2 * π)) ^ (Δ / c) := by
  have hπ : (0 : ℝ) < π := pi_pos
  have h2π : (0 : ℝ) < 2 * π := by positivity
  have harg : (0 : ℝ) < T / (2 * π) := by positivity
  have h1 : (1 : ℝ) < T / (2 * π) := by rwa [lt_div_iff h2π, one_mul]
  have hlog : (0 : ℝ) < log (T / (2 * π)) := log_pos h1
  rw [spectral_cost, mean_zero_spacing, rpow_def_of_pos harg]
  congr 1
  field_simp
  ring

/-- d_médio > 0 para T > 2π. -/
theorem mean_spacing_pos (T : ℝ) (hT : 2 * π < T) : 0 < mean_zero_spacing T := by
  unfold mean_zero_spacing
  have hπ := pi_pos
  have h2π : (0 : ℝ) < 2 * π := by positivity
  have h1 : (1 : ℝ) < T / (2 * π) := by rwa [lt_div_iff h2π, one_mul]
  have hlog : (0 : ℝ) < log (T / (2 * π)) := log_pos h1
  positivity

/-!
Valores numéricos auditáveis (ver data/off-critical-spectral.csv):
| T      | d_médio  | X(Δ=0.1, c=0.5) |
|--------|----------|-----------------|
| 10⁶    | 0.5246   | 10.97           |
| 10⁸    | 0.3789   | 27.57           |
| 10¹⁰   | 0.2965   | 69.24           |
| 10¹²   | 0.2436   | 173.9           |

Para η = 0.01 com Δ = 0.1: X = e^{2π·0.1/0.01} ≈ 1.94×10²⁷ — computacionalmente inviável.
-/

end Axis3

/-! ──────────────────────────────────────────────────────────────────────────
    EIXO 4 — Estrutura de Correlação V_Ω
    V_Ω = Var(δ) − Var(γ) + 2i·Cov(δ,γ).  Não é igual a δ² em geral.
    ────────────────────────────────────────────────────────────────────────── -/

section Axis4

/-- Estatísticas de uma janela Ω de zeros ρ = (β, γ). -/
structure OmegaStats where
  /-- Variância de δ = β − 1/2 na janela. -/
  var_delta : ℝ
  /-- Variância de γ na janela. -/
  var_gamma : ℝ
  /-- Covariância de (δ, γ) na janela. -/
  cov_delta_gamma : ℝ

/-- V_Ω como número complexo: parte real = Var(δ) − Var(γ), parte imag. = 2·Cov(δ,γ). -/
noncomputable def V_Omega (s : OmegaStats) : ℂ :=
  ⟨s.var_delta - s.var_gamma, 2 * s.cov_delta_gamma⟩

/--
Para fibra única |Ω| = 1 (um zero isolado δ₀):
  Var(δ) = δ₀², Var(γ) = 0, Cov = 0 → V_Ω = δ₀² ≥ 0 (real não negativo).
-/
theorem V_Omega_single_fiber (δ₀ : ℝ) :
    (V_Omega ⟨δ₀ ^ 2, 0, 0⟩).re = δ₀ ^ 2 ∧
    (V_Omega ⟨δ₀ ^ 2, 0, 0⟩).im = 0 := by
  simp [V_Omega]

/--
**Contraexemplo**: dois zeros na linha crítica γ₁ = 14.13, γ₂ = 21.02.
Ambos com δ = 0, então Var(δ) = 0, Cov = 0, Var(γ) = ((γ₂−γ₁)/2)² > 0.
V_Ω = −Var(γ) < 0, logo V_Ω ≠ δ² = 0 — a igualdade V_Ω = δ² falha em geral.
-/
theorem V_Omega_can_be_negative : ∃ s : OmegaStats, (V_Omega s).re < 0 :=
  ⟨⟨0, ((21.02 - 14.13) / 2) ^ 2, 0⟩, by
    simp [V_Omega]
    norm_num⟩

/--
Valor explícito para o contraexemplo (γ₁=14.13, γ₂=21.02):
  V_Ω.re = −((6.89/2)²) ≈ −11.87.
-/
example : (V_Omega ⟨0, ((21.02 - 14.13) / 2) ^ 2, 0⟩).re = -((21.02 - 14.13) / 2) ^ 2 := by
  simp [V_Omega]

/-!
**Questão aberta 4.1**: Para janelas Ω = [T, T + H] com H = 10·d_médio(T),
como se comporta V_Ω em função de T? Mede clustering off-critical?
Estudo numérico recomendado para T ∈ {10⁶, 10⁸, 10¹⁰, 10¹²}.
-/

end Axis4

/-! ──────────────────────────────────────────────────────────────────────────
    RESUMO DE MATURIDADE
    ────────────────────────────────────────────────────────────────────────── -/

section Summary

/-!
| Eixo | Resultado                        | Estado                     |
|------|----------------------------------|----------------------------|
| 1    | local_rigidity_zero_iff          | Provado (ring)             |
| 2    | denom_P_nonneg                   | Provado (positivity)       |
| 3    | spectral_cost_power_law          | Provado                    |
| 4    | V_Omega_can_be_negative          | Provado (norm_num)         |
| 2    | sensitivity_decay_conjecture     | Aberto (axiom placeholder) |
| 2    | W4_asymptotic_sorry              | Aberto (cota numérica)     |
| 3    | cotas X para η = 0.01            | Aberto (X ≈ 10²⁷)         |
| 4    | V_Ω em janelas [T, T+H]          | Aberto (estudo numérico)   |

Nenhum axioma RH foi adicionado ou assumido.
-/

end Summary

end OffCritical
