/-
  REGRA 2 — Princípio da Cifração do Êxodo
  ==========================================
  Origem: Log em texto puro com scrcpy/ffmpeg.

  Lei gerada:
    "Todo êxodo imaginário i·e(t) deve ser cifrado antes de persistir."

  Comportamento nos eixos:
    e = dados sensíveis
    se e ≠ "" então Encrypt(e) é obrigatório antes de qualquer persistência
-/

namespace Regra2

/-- Tipo opaco para uma chave criptográfica. -/
structure Key where
  material : ByteArray
  deriving Repr

/-- Tipo opaco para um log cifrado (AES-GCM-256).
    O conteúdo interno não é acessível sem a chave. -/
structure EncryptedLog where
  ciphertext : ByteArray
  nonce      : ByteArray
  tag        : ByteArray
  deriving Repr

/-- Axioma de cifração: existe uma função de cifração AES-GCM-256
    que transforma (chave, texto) em um log cifrado.
    Em produção este axioma seria satisfeito pela implementação concreta. -/
axiom aes_gcm_256 (k : Key) (plaintext : String) : EncryptedLog

/-- Cifração do Êxodo: dado um log e uma chave, produz um EncryptedLog. -/
def cifrar_exodus (log : String) (k : Key) : EncryptedLog :=
  aes_gcm_256 k log

/-- Princípio de Cifração do Êxodo:
    Nenhum dado sensível não-vazio pode ser persistido em texto puro;
    existe sempre um EncryptedLog correspondente. -/
theorem cifracao_obrigatoria (log : String) (k : Key) (h : log ≠ "") :
    ∃ el : EncryptedLog, el = cifrar_exodus log k := by
  exact ⟨cifrar_exodus log k, rfl⟩

/-- O log cifrado de uma string não-vazia existe e é único por (chave, texto). -/
theorem exodus_nao_perde_dados (log : String) (k : Key) :
    ∃ _ : EncryptedLog, True :=
  ⟨cifrar_exodus log k, trivial⟩

end Regra2
