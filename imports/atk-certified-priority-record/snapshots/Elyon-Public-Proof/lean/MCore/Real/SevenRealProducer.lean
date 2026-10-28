import MCore.Real.BridgeSeven

namespace MCore.Real.SevenCertificateBridge

/-- Minimal state space for fail-closed resolution of a concrete endpoint. -/
inductive ResolutionState where
  | indeterminate
  | resolved (ep : SevenEndpoint)

/-- A resolution step exists only from actual seven-way evidence at that endpoint. -/
inductive ResolutionStep :
    ResolutionState → ResolutionState → Prop where
  | resolve {ep : SevenEndpoint} (e : E ep) :
      ResolutionStep .indeterminate (.resolved ep)

abbrev ResolutionPath :=
  Relation.ReflTransGen ResolutionStep

/-- No default inhabitant exists: endpoint evidence and an actual path are required. -/
structure RealProducer where
  endpoint : SevenEndpoint
  evidence : E endpoint
  path : ResolutionPath .indeterminate (.resolved endpoint)

/-- Construct a producer only from already inhabited concrete evidence and path. -/
def buildRealProducer
    {ep : SevenEndpoint}
    (e : E ep)
    (p : ResolutionPath .indeterminate (.resolved ep)) :
    RealProducer where
  endpoint := ep
  evidence := e
  path := p

end MCore.Real.SevenCertificateBridge
