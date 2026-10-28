import AxiomaticMillenium.Pattern

namespace AxiomaticMillenium

inductive EvidenceStatus where
  | sourceVerified
  | historyReported
  | sourcePartial
  | missing
  deriving Repr, DecidableEq, BEq

inductive ProblemState where
  | openProblem
  | closedProblem
  | referenceCase
  deriving Repr, DecidableEq, BEq

structure ProblemRecord where
  id : String
  title : String
  state : ProblemState
  signature : Signature
  evidence : EvidenceStatus
  source : String
  note : String
  deriving Repr, DecidableEq

def ProblemRecord.publicationEligible (p : ProblemRecord) : Bool :=
  p.evidence == EvidenceStatus.sourceVerified

def sigUBR : Signature :=
  { U := depth100, B := depth100, R := depth100 }

def sigUBNC : Signature :=
  { U := depth100, B := depth100, N := depth100, C := depth100 }

def sigUBRNC : Signature :=
  { U := depth100, B := depth100, R := depth100, N := depth100, C := depth100 }

def sigUBRNCF : Signature :=
  { U := depth100, B := depth100, R := depth100, N := depth100, C := depth100, F := depth100 }

def millenniumDeclared : List ProblemRecord := [
  { id := "BEAL", title := "Beal", state := ProblemState.openProblem,
    signature := {U:=depth100,B:=depth100,Z:=depth100}, evidence := EvidenceStatus.sourcePartial,
    source := "ledger", note := "declared; requires source-edge verification" },
  { id := "RH", title := "Riemann", state := ProblemState.openProblem,
    signature := sigUBNC, evidence := EvidenceStatus.sourcePartial, source := "ledger", note := "declared" },
  { id := "HODGE", title := "Hodge", state := ProblemState.openProblem,
    signature := sigUBR, evidence := EvidenceStatus.sourcePartial, source := "ledger", note := "declared" },
  { id := "YM", title := "Yang-Mills", state := ProblemState.openProblem,
    signature := sigUBRNCF, evidence := EvidenceStatus.sourcePartial, source := "ledger", note := "declared" },
  { id := "PNP_P01", title := "P vs NP / P01", state := ProblemState.openProblem,
    signature := sigUBR, evidence := EvidenceStatus.sourcePartial, source := "ledger", note := "partial source coverage" },
  { id := "PNP_G21", title := "P vs NP / G21", state := ProblemState.openProblem,
    signature := {U:=depth100,B:=depth100,N:=depth100,F:=depth100}, evidence := EvidenceStatus.sourcePartial,
    source := "ledger", note := "partial source coverage" },
  { id := "BSD", title := "BSD", state := ProblemState.openProblem,
    signature := {U:=depth100,B:=depth100,R:=depth100,F:=depth100,Z:=depth100},
    evidence := EvidenceStatus.sourcePartial, source := "ledger", note := "declared" },
  { id := "NS", title := "Navier-Stokes", state := ProblemState.openProblem,
    signature := sigUBRNC, evidence := EvidenceStatus.sourcePartial, source := "ledger", note := "declared" }
]

def externalSeed : List ProblemRecord := [
  { id := "LIOUVILLE_FOURIER_UNIFORMITY", title := "Liouville Fourier uniformity",
    state := ProblemState.openProblem, signature := {B:=depth50,N:=depth100,C:=depth75},
    evidence := EvidenceStatus.missing, source := "MISSING", note := "seed hypothesis N+C+B" },
  { id := "JACOBIAN", title := "Jacobian Conjecture",
    state := ProblemState.openProblem, signature := {B:=depth75,C:=depth100},
    evidence := EvidenceStatus.missing, source := "MISSING", note := "seed hypothesis B+C" },
  { id := "STEENROD_REALIZABILITY", title := "Steenrod realizability family",
    state := ProblemState.openProblem, signature := {R:=depth100},
    evidence := EvidenceStatus.missing, source := "MISSING", note := "seed hypothesis R" },
  { id := "CD_LOCAL_GLOBAL", title := "CD local-to-global reference case",
    state := ProblemState.referenceCase, signature := {C:=depth100},
    evidence := EvidenceStatus.missing, source := "MISSING", note := "source pending" },
  { id := "CHOWLA", title := "Chowla conjecture family",
    state := ProblemState.openProblem, signature := {N:=depth75,C:=depth50,B:=depth50},
    evidence := EvidenceStatus.missing, source := "MISSING", note := "seed only" },
  { id := "SARNAK", title := "Sarnak Möbius disjointness family",
    state := ProblemState.openProblem, signature := {N:=depth75,C:=depth50,B:=depth50},
    evidence := EvidenceStatus.missing, source := "MISSING", note := "seed only" },
  { id := "INVARIANT_SUBSPACE", title := "Invariant Subspace Problem",
    state := ProblemState.openProblem, signature := {B:=depth50,I:=depth100},
    evidence := EvidenceStatus.missing, source := "MISSING", note := "seed only" }
]

theorem externalSeed_not_publication_ready :
    ∀ p ∈ externalSeed, p.publicationEligible = false := by
  intro p hp
  simp [externalSeed] at hp
  rcases hp with rfl | rfl | rfl | rfl | rfl | rfl | rfl <;> rfl

end AxiomaticMillenium
