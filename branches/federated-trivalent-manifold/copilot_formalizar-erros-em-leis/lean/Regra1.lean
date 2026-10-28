/-
  REGRA 1 — Princípio do Teardown Obrigatório
  ============================================
  Origem: Erro de porta 0.0.0.0:5555 aberta em todas as interfaces.

  Lei gerada:
    "Todo estado com porta aberta deve ter transição provada para fechado."

  Comportamento nos eixos:
    x = 0.0.0.0  (abertura total)
    t = tempo de vida limitado
    e = exposição que deve ser zerada pelo teardown
-/

namespace Regra1

/-- Representação do estado de um serviço de rede. -/
structure SystemState where
  port       : String
  port_open  : Bool
  deriving Repr

/-- Teardown fecha a porta sem alterar nenhuma outra parte do estado. -/
def teardown (s : SystemState) : SystemState :=
  { s with port_open := false }

/-- Princípio do Teardown Obrigatório:
    Para todo estado com a porta 0.0.0.0:5555 aberta existe uma transição
    provada para o estado fechado. -/
theorem teardown_obrigatorio (s : SystemState)
    (h_port : s.port = "0.0.0.0:5555")
    (h_open : s.port_open = true) :
    ∃ s' : SystemState, s' = teardown s ∧ s'.port_open = false := by
  exact ⟨teardown s, rfl, by simp [teardown]⟩

/-- Corolário: o teardown é idempotente — aplicá-lo duas vezes
    produz o mesmo resultado que aplicá-lo uma vez. -/
theorem teardown_idempotente (s : SystemState) :
    teardown (teardown s) = teardown s := by
  simp [teardown]

end Regra1
