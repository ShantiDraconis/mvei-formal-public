/-
  REGRA 7 — Trivalência Obrigatória
  ===================================
  Origem: Uso de lógica booleana {0, 1} para problemas matemáticos abertos.

  Lei gerada:
    "Todo problema do milênio vive em 1/2 até que haja prova de 0 ou 1."

  Os três valores:
    Falso  (0)   — refutado formalmente
    Meio   (1/2) — condicional, aberto, regime atual
    Verdade (1)  — provado formalmente
-/

namespace Regra7

/-- Tipo trivalente: os três regimes epistemológicos possíveis. -/
inductive Trivalente where
  | Falso   : Trivalente   -- 0: refutado
  | Meio    : Trivalente   -- 1/2: aberto / condicional
  | Verdade : Trivalente   -- 1: provado
  deriving Repr, DecidableEq

open Trivalente in
/-- Todo problema do milênio começa no regime Meio. -/
def regime_inicial : Trivalente := Meio

/-- Negação trivalente (Kleene forte). -/
def neg : Trivalente → Trivalente
  | Falso   => Verdade
  | Meio    => Meio
  | Verdade => Falso

/-- Conjunção trivalente (Kleene forte). -/
def conj : Trivalente → Trivalente → Trivalente
  | Falso,   _       => Falso
  | _,       Falso   => Falso
  | Meio,    _       => Meio
  | _,       Meio    => Meio
  | Verdade, Verdade => Verdade

/-- Disjunção trivalente (Kleene forte). -/
def disj : Trivalente → Trivalente → Trivalente
  | Verdade, _       => Verdade
  | _,       Verdade => Verdade
  | Meio,    _       => Meio
  | _,       Meio    => Meio
  | Falso,   Falso   => Falso

-- Propriedades básicas da lógica trivalente de Kleene

theorem neg_neg (v : Trivalente) : neg (neg v) = v := by
  cases v <;> rfl

theorem conj_comm (a b : Trivalente) : conj a b = conj b a := by
  cases a <;> cases b <;> rfl

theorem disj_comm (a b : Trivalente) : disj a b = disj b a := by
  cases a <;> cases b <;> rfl

/-- Meio não é Falso nem Verdade — é irredutível sem novo axioma. -/
theorem meio_nao_e_falso : Trivalente.Meio ≠ Trivalente.Falso := by decide

theorem meio_nao_e_verdade : Trivalente.Meio ≠ Trivalente.Verdade := by decide

/-- Trivalência Obrigatória:
    Um problema não provado nem refutado reside no regime Meio. -/
def trivalencia_obrigatoria (v : Trivalente)
    (h_nao_provado  : v ≠ Trivalente.Verdade)
    (h_nao_refutado : v ≠ Trivalente.Falso) :
    v = Trivalente.Meio := by
  cases v
  · exact absurd rfl h_nao_refutado
  · rfl
  · exact absurd rfl h_nao_provado

/-- Os 7 Problemas do Milênio estão no regime Meio. -/
structure MillenniumProblem where
  name   : String
  status : Trivalente
  deriving Repr

def PvsNP    : MillenniumProblem := ⟨"P vs NP",              Trivalente.Meio⟩
def Riemann  : MillenniumProblem := ⟨"Hipótese de Riemann",  Trivalente.Meio⟩
def Hodge    : MillenniumProblem := ⟨"Conjectura de Hodge",  Trivalente.Meio⟩
def NavierS  : MillenniumProblem := ⟨"Navier-Stokes",        Trivalente.Meio⟩
def YangMills: MillenniumProblem := ⟨"Yang-Mills",           Trivalente.Meio⟩
def BSD      : MillenniumProblem := ⟨"Birch-Swinnerton-Dyer",Trivalente.Meio⟩
-- Poincaré foi resolvido por Perelman (2003) → Verdade
def Poincare : MillenniumProblem := ⟨"Conjectura de Poincaré",Trivalente.Verdade⟩

theorem poincare_provado : Poincare.status = Trivalente.Verdade := rfl

theorem pvsnp_aberto : PvsNP.status = Trivalente.Meio := rfl

end Regra7
