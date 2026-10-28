import LeanAuditKit.Core
import LeanAuditKit.Manifest
import LeanAuditKit.ProducerCertificate

namespace LeanAuditKit

inductive LaneId
  | core
  | manifest
  | producer
  deriving Repr, DecidableEq

def importedLanes : List LaneId :=
  [LaneId.core, LaneId.manifest, LaneId.producer]

theorem importedLanes_nonempty : importedLanes ≠ [] := by
  decide

theorem producerLane_present : LaneId.producer ∈ importedLanes := by
  decide

end LeanAuditKit
