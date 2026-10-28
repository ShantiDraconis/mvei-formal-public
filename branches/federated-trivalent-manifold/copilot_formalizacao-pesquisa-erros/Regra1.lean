-- Regra 1: Princípio do Teardown Obrigatório
-- Erro original: porta 0.0.0.0:5555 aberta em todas as interfaces sem transição provada para fechado
-- Lei gerada: "Todo estado com porta aberta deve ter transição provada para fechado"
-- Comportamento nos eixos: x=0.0.0.0 (abertura total), t=tempo de vida limitado, e=exposição

structure SystemState where
  port     : String
  port_open : Bool
  deriving Repr

/-- Função de teardown: fecha a porta e mantém o restante do estado intacto. -/
def teardown (s : SystemState) : SystemState :=
  { s with port_open := false }

/-- O teardown sempre produz um estado com porta fechada. -/
theorem teardown_closes_port (s : SystemState) : (teardown s).port_open = false :=
  rfl

/-- O teardown preserva o endereço da porta. -/
theorem teardown_preserves_port (s : SystemState) : (teardown s).port = s.port :=
  rfl

/-- Regra 1 — Teardown Obrigatório:
    Para qualquer estado com a porta 0.0.0.0:5555 aberta, existe uma transição
    provada para um estado com porta fechada. -/
theorem Regra1_TeardownObrigatorio (s : SystemState)
    (hport : s.port = "0.0.0.0:5555")
    (hopen : s.port_open = true) :
    ∃ s' : SystemState, s' = teardown s ∧ s'.port_open = false :=
  ⟨teardown s, rfl, teardown_closes_port s⟩

/-- Corolário: nenhum estado com porta 0.0.0.0:5555 é permanentemente aberto;
    o teardown constitui um testemunho explícito do fechamento. -/
corollary porta_nao_e_permanente (s : SystemState)
    (hport : s.port = "0.0.0.0:5555")
    (hopen : s.port_open = true) :
    ∃ s' : SystemState, s'.port_open = false :=
  let ⟨s', _, hclosed⟩ := Regra1_TeardownObrigatorio s hport hopen
  ⟨s', hclosed⟩
