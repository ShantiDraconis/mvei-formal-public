import AxiomaticMillenium.Registry
import AxiomaticMillenium.Transfer
import AxiomaticMillenium.TaxonomyBoundary

namespace AxiomaticMillenium

/-- A source-verified producer boundary.  The signature contains only
publication-certified pattern edges.  Omitted edges are not asserted false. -/
structure VerifiedBoundary where
  id : String
  project : String
  signature : Signature
  sourceRecord : String
  terminal : String
  evidence : EvidenceStatus := EvidenceStatus.sourceVerified
  deriving Repr, DecidableEq

def VerifiedBoundary.asProblemRecord (b : VerifiedBoundary) : ProblemRecord :=
  { id := b.id
    title := b.project
    state := ProblemState.openProblem
    signature := b.signature
    evidence := b.evidence
    source := b.sourceRecord
    note := b.terminal }

def sigUB : Signature :=
  { U := depth100, B := depth100 }

def sigB : Signature :=
  { B := depth100 }

def sigUBF : Signature :=
  { U := depth100, B := depth100, F := depth100 }

def sigBZ : Signature :=
  { B := depth100, Z := depth100 }

def sigBC : Signature :=
  { B := depth100, C := depth100 }

def sigBCF : Signature :=
  { B := depth100, C := depth100, F := depth100 }


def hodgeBoundary : VerifiedBoundary :=
  { id := "HODGE", project := "Hodge", signature := sigUBR,
    sourceRecord := "HODGE-ALGEBRAICITY-SURJECTIVITY",
    terminal := "Rational Hodge class -> algebraic-cycle realization" }

def ymBoundary : VerifiedBoundary :=
  { id := "YM", project := "Yang-Mills", signature := {U:=depth100,B:=depth100,R:=depth100,C:=depth100},
    sourceRecord := "YM-MASS-GAP-PHYSICAL-BRIDGE",
    terminal := "4D continuum construction + positive mass gap endpoint" }

def pnpP01Boundary : VerifiedBoundary :=
  { id := "PNP_P01", project := "P vs NP / P01", signature := sigUBR,
    sourceRecord := "PNP-P01-CONSTRUCTION-OPEN",
    terminal := "P01MachineConstruction / p01_closed_no_hypothesis" }

def nsBoundary : VerifiedBoundary :=
  { id := "NS", project := "Navier-Stokes", signature := sigBCF,
    sourceRecord := "NS-GLOBAL-CLOSURE + NS-AMPLITUDE-FIXED-DELTA-NOGO",
    terminal := "ActualNS -> genuine signed-depletion/G1 producer -> regularity; amplitude-invariant fixed-delta formulation is formally falsified" }

/-- Publication-verified producer map mirrored from
cross-problem-evidence/data/producers_verified.json. -/
def verifiedBoundaries : List VerifiedBoundary := [
  { id := "BEAL", project := "Beal", signature := sigUB,
    sourceRecord := "BEAL-TERMINAL-BRIDGE",
    terminal := "Common-prime endpoint" },
  { id := "RH", project := "Riemann", signature := sigB,
    sourceRecord := "RH-LIMIT-CLOSURE",
    terminal := "Axiom-free classical endpoint / limit closure" },
  hodgeBoundary,
  ymBoundary,
  pnpP01Boundary,
  { id := "PNP_G21", project := "P vs NP / G21", signature := sigUBF,
    sourceRecord := "PNP-TVCON-OPEN",
    terminal := "Semantic G21 producer; literal fixed-point route remains falsified" },
  { id := "BSD", project := "BSD", signature := sigBZ,
    sourceRecord := "BSD-NORMALIZATION-BRIDGE",
    terminal := "Rank/leading-coefficient canonical identification" },
  nsBoundary
]

theorem verifiedBoundaries_publication_eligible :
    ∀ b ∈ verifiedBoundaries, (b.asProblemRecord).publicationEligible = true := by
  intro b hb
  simp [verifiedBoundaries, hodgeBoundary, ymBoundary, pnpP01Boundary, nsBoundary] at hb
  rcases hb with rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl <;> rfl

/-- Sharing a pattern is only a transfer candidate.  Exact theorem transfer
still requires source evidence, target assumptions, and an instantiated
operator, as enforced by TransferObligation.closed. -/
def boundaryTransferObligation
    (source target : VerifiedBoundary)
    (shared : Pattern)
    (operatorId : String)
    (targetAssumptionsVerified operatorInstantiationVerified : Bool) :
    TransferObligation :=
  { sourceProblem := source.id
    targetProblem := target.id
    sharedPattern := shared
    operatorId := operatorId
    sourceVerified := source.evidence == EvidenceStatus.sourceVerified
    targetAssumptionsVerified := targetAssumptionsVerified
    operatorInstantiationVerified := operatorInstantiationVerified }

theorem uninstantiated_operator_blocks_boundary_transfer
    (source target : VerifiedBoundary)
    (shared : Pattern)
    (operatorId : String)
    (hTarget : Bool) :
    (boundaryTransferObligation source target shared operatorId hTarget false).closed = false := by
  simp [boundaryTransferObligation, TransferObligation.closed]

/-- Falsified routes remain firewalled even when another producer shares the
same broader pattern signature. -/
theorem falsified_route_cannot_be_reused
    {S : Prop} (f : FalsifiedFormulation S) : ¬ S :=
  F_firewall f


/-- PNP P01 and Hodge share the declared R-pattern, but the repository
deliberately keeps the mathematical transfer open until both target
hypotheses and a concrete realization operator are verified. -/
def pnpP01HodgeRTransfer
    (targetAssumptionsVerified operatorInstantiationVerified : Bool) :
    TransferObligation :=
  boundaryTransferObligation
    hodgeBoundary
    pnpP01Boundary
    Pattern.R
    "RealizationOperator/RBasis"
    targetAssumptionsVerified
    operatorInstantiationVerified

theorem pnpP01_hodge_R_transfer_fail_closed_without_operator
    (hTarget : Bool) :
    (pnpP01HodgeRTransfer hTarget false).closed = false := by
  simp [pnpP01HodgeRTransfer, boundaryTransferObligation,
    TransferObligation.closed, verifiedBoundaries, hodgeBoundary, pnpP01Boundary]

/-- YM and NS share C, but a source globalization theorem is not itself an
instantiation for either target PDE/QFT endpoint. -/
def ymNsCTransfer
    (targetAssumptionsVerified operatorInstantiationVerified : Bool) :
    TransferObligation :=
  boundaryTransferObligation
    ymBoundary
    nsBoundary
    Pattern.C
    "GlobalizationOperator/CBasis"
    targetAssumptionsVerified
    operatorInstantiationVerified

theorem ym_ns_C_transfer_fail_closed_without_operator
    (hTarget : Bool) :
    (ymNsCTransfer hTarget false).closed = false := by
  simp [ymNsCTransfer, boundaryTransferObligation,
    TransferObligation.closed, verifiedBoundaries, ymBoundary, nsBoundary]

end AxiomaticMillenium
