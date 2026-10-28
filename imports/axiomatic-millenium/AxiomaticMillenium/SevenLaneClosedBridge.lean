import AxiomaticMillenium.SevenLaneClosureArchitecture

namespace AxiomaticMillenium

/-- CLOSED transport layer for one lane.  These are bridge descriptions backed
by the source-verified bridge registry; they are not material inhabitants. -/
structure ClosedBridgeLane where
  lane : String
  transports : List String
  bridgeState : BridgeState
  deriving Repr, DecidableEq

def closedBridgeOf (L : LaneClosureArchitecture) : ClosedBridgeLane :=
  { lane := L.lane
    transports := L.closedBridge
    bridgeState := .closed }

def sevenLaneClosedBridges : List ClosedBridgeLane :=
  sevenLaneArchitectures.map closedBridgeOf

def allBridgeStatesClosed : Bool :=
  sevenLaneClosedBridges.all (fun B => B.bridgeState == .closed)

theorem closed_bridge_has_seven_lanes :
    sevenLaneClosedBridges.length = 7 := by
  decide

theorem every_refined_bridge_is_closed :
    allBridgeStatesClosed = true := by
  decide

theorem registry_and_refined_bridge_counts_agree :
    closedBridgeCount = sevenLaneClosedBridges.length := by
  decide

#print axioms AxiomaticMillenium.closed_bridge_has_seven_lanes
#print axioms AxiomaticMillenium.every_refined_bridge_is_closed
#print axioms AxiomaticMillenium.registry_and_refined_bridge_counts_agree

end AxiomaticMillenium
