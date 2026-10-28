namespace MCore.Research

inductive FinalExternalMode where
  | singleProducer
  | sevenCertificates
  | closedEmpty
  deriving DecidableEq, Repr

structure FinalExternalBranchState where
  mode : FinalExternalMode
  sourceAnchor : String
  endpoint : String
  producerCount : Nat
  requiredProducers : Nat
  finalRoot : Option String
  issued : Bool
  deriving Repr

def branchState : FinalExternalBranchState :=
  { mode := .sevenCertificates
    sourceAnchor := "SEVEN_CERTIFICATES"
    endpoint := "FinalExternalGap"
    producerCount := 0
    requiredProducers := 7
    finalRoot := none
    issued := false }

theorem failClosed_until_root :
    branchState.finalRoot = none → branchState.issued = false := by
  intro _
  rfl

theorem seven_required :
    branchState.requiredProducers = 7 := by
  rfl

theorem not_complete_initially :
    branchState.producerCount < branchState.requiredProducers := by
  decide

end MCore.Research
