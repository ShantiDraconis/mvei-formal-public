/-
  REGRA 3 — Separação de Domínio
  ================================
  Origem: Mesmo HKDF usado para Llama, GPT e Claude — colisão de domínio.

  Lei gerada:
    "Cada transição federada tem domínio criptográfico distinto."

  Comportamento nos eixos:
    z = dimensão de separação
    e1 ≠ e2  (chaves de domínios distintos não colidem)
-/

namespace Regra3

/-- Tipo opaco para uma chave derivada via HKDF. -/
structure DomainKey where
  bytes : ByteArray
  label : String
  deriving Repr

/-- Tipo opaco para um segredo-mestre. -/
structure MasterSecret where
  bytes : ByteArray
  deriving Repr

/-- Axioma HKDF: existe uma função de derivação de chave determinística
    que mapeia (segredo-mestre, rótulo) para DomainKey. -/
axiom hkdf (master : MasterSecret) (info : String) : DomainKey

/-- Axioma de separação: rótulos distintos produzem chaves distintas.
    Este é o requisito criptográfico central do HKDF com info diferente. -/
axiom hkdf_separacao (master : MasterSecret) (i1 i2 : String) (h : i1 ≠ i2) :
    hkdf master i1 ≠ hkdf master i2

/-- As três chaves de domínio do sistema federado. -/
def k_llama_gpt   (m : MasterSecret) : DomainKey := hkdf m "llama->gpt"
def k_gpt_claude  (m : MasterSecret) : DomainKey := hkdf m "gpt->claude"
def k_claude_llama (m : MasterSecret) : DomainKey := hkdf m "claude->llama"

/-- Princípio de Separação de Domínio:
    As chaves Llama→GPT e GPT→Claude são sempre distintas. -/
theorem separacao_llama_gpt_claude (m : MasterSecret) :
    k_llama_gpt m ≠ k_gpt_claude m := by
  apply hkdf_separacao
  decide

/-- As chaves GPT→Claude e Claude→Llama também são distintas. -/
theorem separacao_gpt_claude_llama (m : MasterSecret) :
    k_gpt_claude m ≠ k_claude_llama m := by
  apply hkdf_separacao
  decide

/-- As chaves Llama→GPT e Claude→Llama também são distintas. -/
theorem separacao_llama_claude (m : MasterSecret) :
    k_llama_gpt m ≠ k_claude_llama m := by
  apply hkdf_separacao
  decide

/-- Todos os três domínios são mutuamente distintos. -/
theorem todos_dominios_distintos (m : MasterSecret) :
    k_llama_gpt m ≠ k_gpt_claude m ∧
    k_gpt_claude m ≠ k_claude_llama m ∧
    k_llama_gpt m ≠ k_claude_llama m :=
  ⟨separacao_llama_gpt_claude m,
   separacao_gpt_claude_llama m,
   separacao_llama_claude m⟩

end Regra3
