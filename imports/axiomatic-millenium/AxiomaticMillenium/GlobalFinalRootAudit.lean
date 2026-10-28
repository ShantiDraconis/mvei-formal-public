import AxiomaticMillenium.MaterializerMiningLedger
import AxiomaticMillenium.TruthClosureStateMatrix

namespace AxiomaticMillenium

inductive RootClosureState where
  | openMath
  | conditional
  | sourceCandidate
  | verified
  | refuted
  deriving Repr, DecidableEq, BEq

structure FinalRootAuditRecord where
  problem : String
  exactTerminal : String
  rootState : RootClosureState
  hasExactProducerType : Bool
  hasVerifiedInhabitant : Bool
  hasConditionalClosureTheorem : Bool
  hasNegativeRouteEvidence : Bool
  note : String
  deriving Repr, DecidableEq

def rhFinalRootAudit : FinalRootAuditRecord :=
  { problem := "RH"
    exactTerminal := "FiniteSpanApproximatesChi / logarithmic coefficient majorant"
    rootState := .conditional
    hasExactProducerType := true
    hasVerifiedInhabitant := false
    hasConditionalClosureTheorem := true
    hasNegativeRouteEvidence := false
    note := "Coefficient-energy/log-majorant producer implies FINAL_ROOT; no unconditional inhabitant." }

def bealFinalRootAudit : FinalRootAuditRecord :=
  { problem := "BEAL"
    exactTerminal := "GCDLowerBoundProducer / universal CommonPrime"
    rootState := .conditional
    hasExactProducerType := true
    hasVerifiedInhabitant := false
    hasConditionalClosureTheorem := true
    hasNegativeRouteEvidence := false
    note := "Universal common-prime certificate closes Beal; no universal witness supplied." }

def pnpFinalRootAudit : FinalRootAuditRecord :=
  { problem := "PVSNP"
    exactTerminal := "SAT-in-NP subroot + UniversalFailure canonical SAT"
    rootState := .sourceCandidate
    hasExactProducerType := true
    hasVerifiedInhabitant := false
    hasConditionalClosureTheorem := true
    hasNegativeRouteEvidence := true
    note := "P01 source branch contains canonical_sat_in_np_closed; terminal UniversalFailure remains open. Literal fixed-point route is negative evidence." }

def nsFinalRootAudit : FinalRootAuditRecord :=
  { problem := "NS"
    exactTerminal := "ActualNSToSignedGainCore"
    rootState := .conditional
    hasExactProducerType := true
    hasVerifiedInhabitant := false
    hasConditionalClosureTheorem := true
    hasNegativeRouteEvidence := true
    note := "Bulk+tail strict budget closes SignedGainCore; genuine PDE producer remains open. Fixed-delta route is negative evidence." }

def hodgeFinalRootAudit : FinalRootAuditRecord :=
  { problem := "HODGE"
    exactTerminal := "ConcreteAlgebraicityPayload / H01 universal material producer"
    rootState := .conditional
    hasExactProducerType := true
    hasVerifiedInhabitant := false
    hasConditionalClosureTheorem := true
    hasNegativeRouteEvidence := false
    note := "Universal material producer closes Hodge endpoint; no universal algebraicity inhabitant." }

def bsdFinalRootAudit : FinalRootAuditRecord :=
  { problem := "BSD"
    exactTerminal := "GroundedBSDHabitant on genuine elliptic-curve domain"
    rootState := .conditional
    hasExactProducerType := true
    hasVerifiedInhabitant := false
    hasConditionalClosureTheorem := true
    hasNegativeRouteEvidence := true
    note := "Same-curve rank+refined identities close the interface; abstract unrelated-data universalization is refuted." }

def ymFinalRootAudit : FinalRootAuditRecord :=
  { problem := "YM"
    exactTerminal := "B60FieldBundle / B60ConcretePhysicalAdapter"
    rootState := .conditional
    hasExactProducerType := true
    hasVerifiedInhabitant := false
    hasConditionalClosureTheorem := true
    hasNegativeRouteEvidence := true
    note := "B60 field bundle closes FINAL_ROOT; phantom/trivial physical-interface routes are invalidated; no genuine B60 inhabitant." }

def finalRootAudit : List FinalRootAuditRecord :=
  [rhFinalRootAudit, bealFinalRootAudit, pnpFinalRootAudit, nsFinalRootAudit,
   hodgeFinalRootAudit, bsdFinalRootAudit, ymFinalRootAudit]

def exactProducerTypeCount : Nat :=
  finalRootAudit.foldl (fun n r => if r.hasExactProducerType then n+1 else n) 0

def verifiedTerminalInhabitantCount : Nat :=
  finalRootAudit.foldl (fun n r => if r.hasVerifiedInhabitant then n+1 else n) 0

def conditionalClosureCount : Nat :=
  finalRootAudit.foldl (fun n r => if r.hasConditionalClosureTheorem then n+1 else n) 0

def negativeRouteEvidenceCount : Nat :=
  finalRootAudit.foldl (fun n r => if r.hasNegativeRouteEvidence then n+1 else n) 0

def terminalOpenCount : Nat :=
  finalRootAudit.foldl
    (fun n r => if r.hasVerifiedInhabitant then n else n+1) 0

/-- Historical explicit material-atom decomposition before accepting any
unverified source candidate. -/
def verifiedMaterialAtomCount : Nat := 10

/-- P01 is one of the ten atoms.  The advanced source branch contains a
candidate inhabitant, so source-level planning may treat nine atoms as
remaining, but this is not a verified/certified count. -/
def sourceCandidateAdjustedMaterialAtomCount : Nat := 9

theorem final_root_audit_has_seven_lanes :
    finalRootAudit.length = 7 := by decide

theorem all_seven_have_exact_producer_types :
    exactProducerTypeCount = 7 := by decide

theorem no_verified_terminal_inhabitant_yet :
    verifiedTerminalInhabitantCount = 0 := by decide

theorem all_seven_have_conditional_closure :
    conditionalClosureCount = 7 := by decide

theorem four_lanes_have_negative_route_evidence :
    negativeRouteEvidenceCount = 4 := by decide

theorem all_seven_terminal_roots_remain_open_verified :
    terminalOpenCount = 7 := by decide

theorem verified_atoms_ten :
    verifiedMaterialAtomCount = 10 := rfl

theorem source_candidate_adjusted_atoms_nine :
    sourceCandidateAdjustedMaterialAtomCount = 9 := rfl

end AxiomaticMillenium
