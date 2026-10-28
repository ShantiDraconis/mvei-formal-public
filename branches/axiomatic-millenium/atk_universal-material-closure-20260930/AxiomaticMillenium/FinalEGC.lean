import AxiomaticMillenium.RootContract
import AxiomaticMillenium.PvsNPRootContract

namespace AxiomaticMillenium

/-- A final certificate may only target a root whose statement hash has been
explicitly frozen.  Metadata alone cannot satisfy this witness. -/
structure RootFreezeWitness (r : FrozenRoot) : Prop where
  statusFrozen : r.hashStatus = RootHashStatus.frozen
  nonzeroHash : r.statementHash ≠ 0
  concreteHashScheme : r.hashScheme ≠ "UNINSTANTIATED"

/-- Strong final EGC: unlike ConditionalExternalGlobalCertificate, this object
contains a kernel term for the exact frozen root and a proof that the root
fingerprint/hash has been frozen.  The transitive dependency closure is not
persisted; only direct dependencies are stored. -/
structure FinalExternalGlobalCertificate (C : RootContract) where
  freeze : RootFreezeWitness C.root
  term : C.root.statement
  directDeps : List Name
  metadataFingerprint : String

/-- The current generic P-vs-NP root is deliberately not frozen: its official
machine model is still an open source obligation. -/
theorem pvsnp_abstract_root_not_frozen
    (M : PvsNPOfficialModel) :
    (pvsnpFrozenRoot M).hashStatus ≠ RootHashStatus.frozen := by
  simp [pvsnpFrozenRoot]

/-- Fail-closed theorem: no final EGC can inhabit the current abstract P-vs-NP
root contract.  A conditional EGC remains available, but promotion to final
requires a separately frozen concrete official model/root. -/
theorem pvsnp_no_final_egc_while_root_unfrozen
    (M : PvsNPOfficialModel)
    (I : PvsNPFrontierInputs)
    (W : PvsNPClosureWitness M I) :
    ¬ Nonempty (FinalExternalGlobalCertificate (pvsnpRootContract M I W)) := by
  intro h
  rcases h with ⟨cert⟩
  have hs := cert.freeze.statusFrozen
  simp [pvsnpRootContract, pvsnpFrozenRoot] at hs

end AxiomaticMillenium
