namespace ROZC

/-- Evidence status used by ROZC to prevent semantic promotion of external inputs. -/
inductive EvidenceStatus where
  | kernelProved
  | externalAudited
  | openBridge
  deriving Repr, DecidableEq

/-- Provenance record for a mathematical bridge. -/
structure BridgeProvenance where
  name : String
  sourceRepository : String
  sourceAnchor : String
  status : EvidenceStatus

/-- Only kernel-proved evidence is locally closed. -/
def LocallyClosed (p : BridgeProvenance) : Prop :=
  p.status = EvidenceStatus.kernelProved

theorem kernel_status_locally_closed
    (name repo anchor : String) :
    LocallyClosed {
      name := name
      sourceRepository := repo
      sourceAnchor := anchor
      status := EvidenceStatus.kernelProved
    } := by
  rfl

/-- Open bridges are not locally closed. -/
theorem open_bridge_not_locally_closed
    (name repo anchor : String) :
    ¬ LocallyClosed {
      name := name
      sourceRepository := repo
      sourceAnchor := anchor
      status := EvidenceStatus.openBridge
    } := by
  intro h
  cases h

#print axioms kernel_status_locally_closed
#print axioms open_bridge_not_locally_closed

end ROZC
