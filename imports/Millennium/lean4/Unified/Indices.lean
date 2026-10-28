import Unified.Kernel

namespace Unified

/-
  Named indices (documental) for the 38 coordinates.
  These provide semantic meaning to each component of Θ.
-/

/-- Riemann Hypothesis parameters (indices 0-5) -/
def idx_α_RH  : ι := ⟨0, by decide⟩
def idx_β_RH  : ι := ⟨1, by decide⟩
def idx_ω_RH  : ι := ⟨2, by decide⟩
def idx_δ_RH  : ι := ⟨3, by decide⟩
def idx_γ_RH  : ι := ⟨4, by decide⟩
def idx_ε_RH  : ι := ⟨5, by decide⟩

/-- Navier-Stokes parameters (indices 6-11) -/
def idx_ν_NS  : ι := ⟨6, by decide⟩
def idx_d_eff : ι := ⟨7, by decide⟩
def idx_λ_NS  : ι := ⟨8, by decide⟩
def idx_μ_NS  : ι := ⟨9, by decide⟩
def idx_κ_NS  : ι := ⟨10, by decide⟩
def idx_ρ_NS  : ι := ⟨11, by decide⟩

/-- P vs NP parameters (indices 12-17) -/
def idx_c_PNP : ι := ⟨12, by decide⟩
def idx_k_PNP : ι := ⟨13, by decide⟩
def idx_n_PNP : ι := ⟨14, by decide⟩
def idx_m_PNP : ι := ⟨15, by decide⟩
def idx_s_PNP : ι := ⟨16, by decide⟩
def idx_t_PNP : ι := ⟨17, by decide⟩

/-- Yang-Mills parameters (indices 18-23) -/
def idx_g_YM  : ι := ⟨18, by decide⟩
def idx_Λ_YM  : ι := ⟨19, by decide⟩
def idx_m_YM  : ι := ⟨20, by decide⟩
def idx_θ_YM  : ι := ⟨21, by decide⟩
def idx_ξ_YM  : ι := ⟨22, by decide⟩
def idx_η_YM  : ι := ⟨23, by decide⟩

/-- Hodge Conjecture parameters (indices 24-29) -/
def idx_p_H   : ι := ⟨24, by decide⟩
def idx_q_H   : ι := ⟨25, by decide⟩
def idx_d_H   : ι := ⟨26, by decide⟩
def idx_k_H   : ι := ⟨27, by decide⟩
def idx_χ_H   : ι := ⟨28, by decide⟩
def idx_τ_H   : ι := ⟨29, by decide⟩

/-- Birch and Swinnerton-Dyer parameters (indices 30-37) -/
def idx_r_BSD : ι := ⟨30, by decide⟩
def idx_L_BSD : ι := ⟨31, by decide⟩
def idx_Ω_BSD : ι := ⟨32, by decide⟩
def idx_R_BSD : ι := ⟨33, by decide⟩
def idx_c_BSD : ι := ⟨34, by decide⟩
def idx_Sha   : ι := ⟨35, by decide⟩
def idx_w_BSD : ι := ⟨36, by decide⟩
def idx_σ_BSD : ι := ⟨37, by decide⟩

/-- Get value at a specific index -/
def get (θ : Θ) (i : ι) : ℝ := θ i

/-- Set value at a specific index -/
def set (θ : Θ) (i : ι) (x : ℝ) : Θ := 
  fun j => if j = i then x else θ j

/-- Helper: extract RH subvector -/
def getRHParams (θ : Θ) : Fin 6 → ℝ :=
  fun i => θ ⟨i.val, by omega⟩

/-- Helper: extract NS subvector -/
def getNSParams (θ : Θ) : Fin 6 → ℝ :=
  fun i => θ ⟨6 + i.val, by omega⟩

/-- Helper: extract PNP subvector -/
def getPNPParams (θ : Θ) : Fin 6 → ℝ :=
  fun i => θ ⟨12 + i.val, by omega⟩

/-- Helper: extract YM subvector -/
def getYMParams (θ : Θ) : Fin 6 → ℝ :=
  fun i => θ ⟨18 + i.val, by omega⟩

/-- Helper: extract Hodge subvector -/
def getHodgeParams (θ : Θ) : Fin 6 → ℝ :=
  fun i => θ ⟨24 + i.val, by omega⟩

/-- Helper: extract BSD subvector -/
def getBSDParams (θ : Θ) : Fin 8 → ℝ :=
  fun i => θ ⟨30 + i.val, by omega⟩

end Unified
