namespace LeanAuditKit

/-- A certificate can only exist when it contains an actual producer term for P. -/
structure ProducerCertificate (P : Prop) where
  producer : P

def certify {P : Prop} (producer : P) : ProducerCertificate P :=
  ⟨producer⟩

theorem certificate_yields_producer {P : Prop} (c : ProducerCertificate P) : P :=
  c.producer

/-- Fail-closed regression: without a term of False, there is no certificate for False. -/
theorem no_false_certificate : ¬ Nonempty (ProducerCertificate False) := by
  intro h
  rcases h with ⟨c⟩
  exact c.producer

end LeanAuditKit
