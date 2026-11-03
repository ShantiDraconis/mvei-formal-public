import FormalSuite.I.Universal.FinalProof
import FormalSuite.I.Universal.DomainBridges
import FormalSuite.I.Universal.SNMultistateGap

namespace FormalSuite.I.Universal

/-- Kernel-side payload for the mathematical external certificate.
Cross-domain bridges are attached only as a fail-closed registry and are not
premises of the mathematical claim. -/
structure FundamentalIExternalCertificate where
  theorem_name : String
  claim : FundamentalIClaim
  final_proof : FundamentalIFinalProof
  bridge_registry : List DomainBridge
  bridges_fail_closed : ∀ b ∈ bridge_registry, b.status = .open
  riemann_terminal_gap_shape : GapShape
  riemann_terminal_gap_open : riemann_terminal_gap_shape = .F1_VANISHING

def fundamentalIExternalCertificate : FundamentalIExternalCertificate where
  theorem_name := "FundamentalITheorem"
  claim := FundamentalIClaim_proved
  final_proof := fundamentalIFinalProof
  bridge_registry := fundamentalIBridges
  bridges_fail_closed := all_registered_bridges_start_open
  riemann_terminal_gap_shape := SNGapShape
  riemann_terminal_gap_open := rfl

theorem FUNDAMENTAL_I_EXTERNAL_CERTIFICATE :
    FundamentalIClaim :=
  fundamentalIExternalCertificate.claim

/-- Cross-domain interpretation is explicitly not part of the mathematical
claim: every registered bridge is still open at certificate construction. -/
theorem FUNDAMENTAL_I_EXTERNAL_BRIDGES_FAIL_CLOSED :
    ∀ b ∈ fundamentalIExternalCertificate.bridge_registry,
      b.status = .open :=
  fundamentalIExternalCertificate.bridges_fail_closed

#print axioms FUNDAMENTAL_I_EXTERNAL_CERTIFICATE
#print axioms FUNDAMENTAL_I_EXTERNAL_BRIDGES_FAIL_CLOSED
#print axioms certificate_closes_terminal_gap

end FormalSuite.I.Universal
