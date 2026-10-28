import ROZC.Provenance

namespace ROZC

def dnZeroLimitLedger : BridgeProvenance :=
  { name := "DNToZero_iff_DNLimit_eq_zero"
    sourceRepository := "ShantiDraconis/m-core-riemann"
    sourceAnchor := "ad3011f14bdab32161205e053fa925bc8c851ad4:lean/MCore/RH/NB/ZeroLimitFrontier.lean"
    status := EvidenceStatus.kernelProved }

def baezDuarteCriterionLedger : BridgeProvenance :=
  { name := "Baez-Duarte RH criterion interface"
    sourceRepository := "ShantiDraconis/m-core-riemann"
    sourceAnchor := "18e707a6b1f807d166c6fb31e839f3f98326c5e4:audit/R1_BAEZ_DUARTE_INTERFACE.json"
    status := EvidenceStatus.externalAudited }

def hilbertClosureLedger : BridgeProvenance :=
  { name := "closure-to-finite-distance bridge"
    sourceRepository := "ShantiDraconis/m-core-riemann"
    sourceAnchor := "ad3011f14bdab32161205e053fa925bc8c851ad4:audit/R1_BAEZ_DUARTE_INTERFACE.json"
    status := EvidenceStatus.externalAudited }

def weightedBilinearLedger : BridgeProvenance :=
  { name := "weighted modular bilinear decay to DN"
    sourceRepository := "ShantiDraconis/m-core-riemann"
    sourceAnchor := "R2 terminal producer"
    status := EvidenceStatus.openBridge }

theorem dn_zero_limit_is_locally_closed :
    LocallyClosed dnZeroLimitLedger := by
  rfl

theorem weighted_bilinear_not_locally_closed :
    ¬ LocallyClosed weightedBilinearLedger := by
  intro h
  cases h

#print axioms dn_zero_limit_is_locally_closed
#print axioms weighted_bilinear_not_locally_closed

end ROZC
