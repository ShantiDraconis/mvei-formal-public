import AxiomaticMillenium.PvsNPRootContract

namespace AxiomaticMillenium

/-- Canonical abstract schema string for the current P-vs-NP root contract.
This is NOT the frozen FinalRoot expression hash: the official model is still
uninstantiated. -/
def pvsnpAbstractRootSchema : String :=
  "PVSNP_SCHEMA_V1:not(forall L, officialP L iff officialNP L):P01ConstructionGap+P02Target+ExternalModelMatch"

/-- First 64 bits of SHA-256(pvsnpAbstractRootSchema), stored as audit metadata.
It fingerprints the abstract contract schema only. -/
def pvsnpAbstractRootSchemaHash : UInt64 :=
  9044241701005326146

theorem pvsnpAbstractRootSchemaHash_nonzero :
    pvsnpAbstractRootSchemaHash ≠ 0 := by
  decide

/-- A concrete FinalRoot hash may only be frozen after the official model is
instantiated. This proposition records the present distinction explicitly. -/
def PvsNPFinalRootHashReady (M : PvsNPOfficialModel) : Prop :=
  M.modelFingerprint ≠ ""

end AxiomaticMillenium
