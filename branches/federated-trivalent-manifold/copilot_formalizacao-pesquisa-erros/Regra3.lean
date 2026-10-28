-- Regra 3: Separação de Domínio Criptográfico
-- Erro original: mesmo HKDF para Llama, GPT e Claude
-- Lei gerada: "Cada transição federada tem domínio criptográfico distinto"
-- Nos eixos: z = dimensão de separação, e1 ≠ e2

/-- Tipo opaco para segredos-mestre. -/
opaque MasterSecret : Type

/-- Tipo opaco para chaves derivadas. -/
opaque DerivedKey : Type

/-- Primitiva HKDF abstracta: deriva uma chave a partir do segredo e de uma label de domínio. -/
opaque hkdf : MasterSecret → String → DerivedKey

/-- Axioma de separação de domínio:
    Labels distintas produzem chaves distintas para qualquer segredo-mestre. -/
axiom hkdf_domain_separation (master : MasterSecret) (l1 l2 : String) :
    l1 ≠ l2 → hkdf master l1 ≠ hkdf master l2

/-- Enum dos domínios de transição federada. -/
inductive Dominio where
  | LlamaParaGPT    : Dominio
  | GPTParaClaude   : Dominio
  | ClaudeParaLlama : Dominio
  deriving DecidableEq, Repr

/-- Converte um domínio para a sua label canónica. -/
def Dominio.label : Dominio → String
  | .LlamaParaGPT    => "llama->gpt"
  | .GPTParaClaude   => "gpt->claude"
  | .ClaudeParaLlama => "claude->llama"

/-- Domínios distintos têm labels distintas. -/
theorem Dominio.label_injective (d1 d2 : Dominio) :
    d1 ≠ d2 → d1.label ≠ d2.label := by
  intro h
  cases d1 <;> cases d2 <;> simp_all [Dominio.label]

/-- Deriva a chave para um domínio de transição. -/
def chave_dominio (master : MasterSecret) (d : Dominio) : DerivedKey :=
  hkdf master d.label

/-- Regra 3 — Separação de Domínio:
    Transições federadas distintas têm chaves criptográficas distintas. -/
theorem Regra3_SeparacaoDominio (master : MasterSecret) (d1 d2 : Dominio)
    (h : d1 ≠ d2) :
    chave_dominio master d1 ≠ chave_dominio master d2 := by
  unfold chave_dominio
  exact hkdf_domain_separation master d1.label d2.label (Dominio.label_injective d1 d2 h)

/-- Corolário principal: as chaves Llama→GPT e GPT→Claude são sempre distintas. -/
corollary k_llama_gpt_ne_k_gpt_claude (master : MasterSecret) :
    chave_dominio master .LlamaParaGPT ≠ chave_dominio master .GPTParaClaude :=
  Regra3_SeparacaoDominio master .LlamaParaGPT .GPTParaClaude (by decide)

/-- Corolário: as três chaves federadas são duas a duas distintas. -/
theorem tres_chaves_distintas (master : MasterSecret) :
    let k1 := chave_dominio master .LlamaParaGPT
    let k2 := chave_dominio master .GPTParaClaude
    let k3 := chave_dominio master .ClaudeParaLlama
    k1 ≠ k2 ∧ k2 ≠ k3 ∧ k1 ≠ k3 :=
  ⟨Regra3_SeparacaoDominio master _ _ (by decide),
   Regra3_SeparacaoDominio master _ _ (by decide),
   Regra3_SeparacaoDominio master _ _ (by decide)⟩
