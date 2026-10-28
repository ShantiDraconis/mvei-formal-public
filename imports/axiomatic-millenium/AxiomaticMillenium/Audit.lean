import AxiomaticMillenium.Registry

namespace AxiomaticMillenium

inductive SystemFailureClass where
  | infrastructure
  | build
  | proofEngineering
  | mathematicalObstruction
  | unknown
  deriving Repr, DecidableEq, BEq

inductive ObservationStatus where
  | verifiedSource
  | sourcePartial
  | historyReported
  | unobserved
  deriving Repr, DecidableEq, BEq

structure FailEvent where
  id : String
  repository : String
  runId : Nat
  sha : String
  job : String
  step : String
  familyId : String
  failureClass : SystemFailureClass
  observed : ObservationStatus
  deriving Repr, DecidableEq

structure RepairEvent where
  id : String
  familyId : String
  failSha : String
  repairSha : String
  greenRunId : Nat
  greenSha : String
  descendantVerified : Bool
  domainIntersectionVerified : Bool
  subsequentGreenVerified : Bool
  actor : Option String := none
  deriving Repr, DecidableEq

def RepairEvent.valid (r : RepairEvent) : Bool :=
  r.descendantVerified &&
  r.domainIntersectionVerified &&
  r.subsequentGreenVerified

theorem repair_valid_iff (r : RepairEvent) :
    r.valid = true ↔
      r.descendantVerified = true ∧
      r.domainIntersectionVerified = true ∧
      r.subsequentGreenVerified = true := by
  simp [RepairEvent.valid, and_assoc]

def sameShaRecovery (failSha greenSha : String) : Bool :=
  failSha == greenSha

theorem same_sha_is_retry (sha : String) :
    sameShaRecovery sha sha = true := by
  simp [sameShaRecovery]

structure RootCauseFamily where
  id : String
  signature : String
  eventCount : Nat
  classification : SystemFailureClass
  mathematicallyRelevant : Bool
  deriving Repr, DecidableEq

def setupLeanFamily : RootCauseFamily where
  id := "P-vs-NP/setup-lean"
  signature := "Final Proof Miner/mine/Setup Lean"
  eventCount := 40
  classification := SystemFailureClass.unknown
  mathematicallyRelevant := false

theorem setupLean_not_math_evidence :
    setupLeanFamily.mathematicallyRelevant = false := rfl

def RepairEvent.actorAttributable (r : RepairEvent) : Bool :=
  r.actor.isSome && r.valid

end AxiomaticMillenium
