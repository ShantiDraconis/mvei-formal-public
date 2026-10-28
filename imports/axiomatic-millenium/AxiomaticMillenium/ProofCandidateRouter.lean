import AxiomaticMillenium.OpenObligation
import AxiomaticMillenium.SemanticPattern
import AxiomaticMillenium.LiteratureBridge

namespace AxiomaticMillenium

inductive RouteLayer where
  | canonicalReuse
  | formalSource
  | semanticAdapter
  | literatureCandidate
  deriving Repr, DecidableEq, BEq

/-- Any successful route carries a real inhabitant of the exact target type. -/
structure RoutedCandidate (o : OpenObligation) where
  layer : RouteLayer
  candidate : ProofCandidate o
  provenance : String

inductive RouterResult (o : OpenObligation) where
  | found (route : RoutedCandidate o)
  | open (reason : String)

/-- Acceptance gate: routing metadata never matters more than the exact term. -/
theorem routed_candidate_closes
    {o : OpenObligation}
    (r : RoutedCandidate o) :
    o.target :=
  r.candidate.term

end AxiomaticMillenium
