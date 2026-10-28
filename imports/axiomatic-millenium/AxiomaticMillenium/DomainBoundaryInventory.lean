import AxiomaticMillenium.Pattern

namespace AxiomaticMillenium

inductive Domain where
  | mathematics
  | physics
  | biology
  | chemistryEngineering
  | neuroscience
  deriving Repr, DecidableEq, BEq

inductive EvidenceGrade where
  | sourceVerified
  | sourceVerifiedProgram
  | sourceVerifiedMethod
  | sourceVerifiedInCore
  | sourceVerifiedPartial
  | sourceVerifiedContested
  | partialSourceVerified
  | sourcePointerPending
  | missing
  | hypothesis
  deriving Repr, DecidableEq, BEq

structure DomainBoundary where
  id : String
  domain : Domain
  signature : Signature
  evidence : EvidenceGrade
  deriving Repr, DecidableEq

/-- Publication-grade positive promotion is deliberately stricter than
"has some source pointer": only direct/source-verified classes are eligible.
Partial, contested, pending, missing and hypothesis records remain fail-closed. -/
def EvidenceGrade.certifiable : EvidenceGrade → Bool
  | .sourceVerified
  | .sourceVerifiedProgram
  | .sourceVerifiedMethod
  | .sourceVerifiedInCore => true
  | _ => false

def DomainBoundary.certifiable (b : DomainBoundary) : Bool :=
  b.evidence.certifiable

theorem missing_not_certifiable :
    EvidenceGrade.missing.certifiable = false := rfl

theorem hypothesis_not_certifiable :
    EvidenceGrade.hypothesis.certifiable = false := rfl

theorem partial_not_certifiable :
    EvidenceGrade.partialSourceVerified.certifiable = false := rfl

theorem contested_not_certifiable :
    EvidenceGrade.sourceVerifiedContested.certifiable = false := rfl

/-- Cross-domain signature agreement is only a candidate relation. -/
structure CrossDomainCandidate where
  source : DomainBoundary
  target : DomainBoundary
  shared : Pattern
  exactHypothesesMatched : Bool
  operatorInstantiated : Bool
  deriving Repr, DecidableEq

def CrossDomainCandidate.promotable (c : CrossDomainCandidate) : Bool :=
  c.source.certifiable &&
  c.target.certifiable &&
  c.exactHypothesesMatched &&
  c.operatorInstantiated

theorem no_operator_no_promotion
    (s t : DomainBoundary)
    (p : Pattern)
    (h : Bool) :
    (CrossDomainCandidate.mk s t p h false).promotable = false := by
  simp [CrossDomainCandidate.promotable]

theorem no_exact_hypothesis_match_no_promotion
    (s t : DomainBoundary)
    (p : Pattern)
    (h : Bool) :
    (CrossDomainCandidate.mk s t p false h).promotable = false := by
  simp [CrossDomainCandidate.promotable]

end AxiomaticMillenium
