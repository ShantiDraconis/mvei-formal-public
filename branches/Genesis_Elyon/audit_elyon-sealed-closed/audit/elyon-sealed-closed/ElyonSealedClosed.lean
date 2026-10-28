inductive CertificationClass
  | uncertified
  | certified
deriving DecidableEq, Repr

inductive ElyonState
  | sealedClosed
  | reviewPending
  | symbolicTransitionApproved
deriving DecidableEq, Repr

structure ElyonGateSet where
  gate1 : Bool
  gate2 : Bool
  gate3 : Bool
  gate4 : Bool
  gate5 : Bool
  gate6 : Bool
  gate7 : Bool
  gate8 : Bool
deriving DecidableEq, Repr

def allGatesPass (g : ElyonGateSet) : Bool :=
  g.gate1 && g.gate2 && g.gate3 && g.gate4 &&
  g.gate5 && g.gate6 && g.gate7 && g.gate8

def nextElyonState {α : Type}
    (cert : CertificationClass)
    (gates : ElyonGateSet)
    (_payload : α) : ElyonState :=
  match cert with
  | CertificationClass.uncertified => ElyonState.sealedClosed
  | CertificationClass.certified =>
      if allGatesPass gates
      then ElyonState.reviewPending
      else ElyonState.sealedClosed

theorem uncertified_any_payload_stays_sealed
    {α : Type}
    (gates : ElyonGateSet)
    (payload : α) :
    nextElyonState CertificationClass.uncertified gates payload =
      ElyonState.sealedClosed := by
  rfl

theorem certified_failed_gate_stays_sealed
    {α : Type}
    (gates : ElyonGateSet)
    (payload : α)
    (h : allGatesPass gates = false) :
    nextElyonState CertificationClass.certified gates payload =
      ElyonState.sealedClosed := by
  rw [nextElyonState, h]
  rfl

theorem certified_all_gates_enters_review_only
    {α : Type}
    (gates : ElyonGateSet)
    (payload : α)
    (h : allGatesPass gates = true) :
    nextElyonState CertificationClass.certified gates payload =
      ElyonState.reviewPending := by
  rw [nextElyonState, h]
  rfl

theorem no_automatic_symbolic_approval
    {α : Type}
    (cert : CertificationClass)
    (gates : ElyonGateSet)
    (payload : α) :
    nextElyonState cert gates payload ≠
      ElyonState.symbolicTransitionApproved := by
  cases cert with
  | uncertified =>
      intro h
      change ElyonState.sealedClosed =
        ElyonState.symbolicTransitionApproved at h
      cases h
  | certified =>
      cases hpass : allGatesPass gates with
      | false =>
          intro h
          rw [nextElyonState, hpass] at h
          cases h
      | true =>
          intro h
          rw [nextElyonState, hpass] at h
          cases h

#print axioms uncertified_any_payload_stays_sealed
#print axioms certified_failed_gate_stays_sealed
#print axioms certified_all_gates_enters_review_only
#print axioms no_automatic_symbolic_approval
