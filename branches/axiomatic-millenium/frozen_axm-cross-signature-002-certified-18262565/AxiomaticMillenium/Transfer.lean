import AxiomaticMillenium.Registry

namespace AxiomaticMillenium

structure ClosureTechnique where
  id : String
  signature : Signature
  evidence : EvidenceStatus
  source : String
  deriving Repr, DecidableEq

/-- A transfer candidate is fail-closed:
both sides need source-verified evidence and the weighted squared distance
must be below the caller-supplied threshold. -/
def transferCandidate
    (tech : ClosureTechnique)
    (problem : ProblemRecord)
    (threshold : Nat) : Bool :=
  (tech.evidence == EvidenceStatus.sourceVerified) &&
  problem.publicationEligible &&
  decide (distanceSq10 tech.signature problem.signature ≤ threshold)

theorem missing_evidence_blocks_transfer
    (id source : String) (s : Signature)
    (p : ProblemRecord) (t : Nat) :
    transferCandidate
      { id := id, signature := s, evidence := EvidenceStatus.missing, source := source }
      p t = false := by
  rfl

theorem identical_UBR_distance_zero :
    distanceSq10 sigUBR sigUBR = 0 :=
  distanceSq10_self sigUBR

/-- This repository certifies similarity of formal gap signatures only.
Mathematical transfer still requires an instantiated closure theorem/operator. -/
structure TransferObligation where
  sourceProblem : String
  targetProblem : String
  sharedPattern : Pattern
  operatorId : String
  sourceVerified : Bool
  targetAssumptionsVerified : Bool
  operatorInstantiationVerified : Bool
  deriving Repr, DecidableEq

def TransferObligation.closed (o : TransferObligation) : Bool :=
  o.sourceVerified &&
  o.targetAssumptionsVerified &&
  o.operatorInstantiationVerified

end AxiomaticMillenium
