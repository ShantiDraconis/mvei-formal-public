/-
  REGRA 5 — Conservação do Êxodo
  ================================
  Origem: Afirmar que S[γ] → 0 sem eliminar a vantagem do adversário i·e(t).

  Lei gerada:
    "Enquanto houver vantagem do adversário, há êxodo imaginário —
     o integral não colapsa para zero."

  Comportamento nos eixos:
    t acumula e; se e(t) ≠ 0 em algum instante, então ∫ i·e dt ≠ 0.
    O sistema permanece no regime 1/2 enquanto e não for anulado
    por um novo axioma matemático.
-/

namespace Regra5

/-- Tipo dos instantes de tempo (modelado como número natural discrteto). -/
abbrev Time := Nat

/-- Vantagem do adversário no instante t: um real não-negativo.
    Modelamos como Nat para manter o sistema construtivo e totalmente
    verificável sem bibliotecas de reais. -/
abbrev Advantage := Nat   -- 0 = nenhuma vantagem; > 0 = vantagem presente

/-- Uma trajetória de vantagem é uma função do tempo para Advantage. -/
def Trajectory := Time → Advantage

/-- Integral discreta de e ao longo de [0, T). -/
def integral_e (e : Trajectory) : Time → Nat
  | 0     => 0
  | t + 1 => integral_e e t + e t

/-- Conservação do Êxodo (Axioma):
    Se a vantagem do adversário é não-nula no instante t₀, então
    a integral acumulada a partir de t₀+1 é estritamente positiva.

    Este axioma captura o princípio físico: informação não desaparece;
    a vantagem acumulada persiste no integral enquanto não há axioma
    que a destrua. -/
axiom conservacao_exodus (e : Trajectory) (t₀ : Time) (h : e t₀ ≠ 0) :
    ∀ T : Time, T > t₀ → integral_e e T ≠ 0

/-- Corolário: se e for positiva em qualquer ponto,
    o sistema nunca atinge S[γ] = 0 apenas com o pipeline. -/
theorem sistema_nao_colapsa_sem_novo_axioma
    (e : Trajectory) (t₀ : Time) (h_adv : e t₀ ≠ 0) :
    ¬ (∀ T : Time, T > t₀ → integral_e e T = 0) := by
  intro hall
  exact conservacao_exodus e t₀ h_adv (t₀ + 1) (Nat.lt_succ_self t₀)
        (hall (t₀ + 1) (Nat.lt_succ_self t₀))

/-- Lemma auxiliar: a integral cresce monotonicamente. -/
theorem integral_monotone (e : Trajectory) (t : Time) :
    integral_e e t ≤ integral_e e (t + 1) := by
  simp [integral_e]

/-- O estado 1/2 é permanente enquanto a vantagem e não for zerada. -/
def regime_meio (e : Trajectory) (t : Time) : Prop :=
  e t ≠ 0

theorem regime_meio_implica_integral_positivo
    (e : Trajectory) (t₀ : Time) (h : regime_meio e t₀) :
    ∀ T, T > t₀ → integral_e e T ≠ 0 :=
  conservacao_exodus e t₀ h

end Regra5
