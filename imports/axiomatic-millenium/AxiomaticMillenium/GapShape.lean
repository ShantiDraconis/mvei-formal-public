import AxiomaticMillenium.AreaBoundaryMap

namespace AxiomaticMillenium

inductive GapShape where
  | formulationInconsistency | transferImpossibility | identification
  | realization | endpointBridge | uniformity | control
  deriving Repr, DecidableEq, BEq

inductive AtomType where
  | definition | theorem | witness | bound
  deriving Repr, DecidableEq, BEq

structure PendingAtom where
  id : String
  shape : GapShape
  atomType : AtomType
  order : Nat
  statement : String
  deriving Repr, DecidableEq

inductive QuantifierStructure where
  | forallExists | forallEpsExistsDelta | forallNatExistsNat
  | existsForall | piOne | other
  deriving Repr, DecidableEq, BEq

structure ReferenceCase where
  id : String
  shape : GapShape
  domain : String
  operator : String
  proved : Bool
  transfersTo : List String := []
  transferRule : String := "requires_explicit_theorem"
  proofStructure : String
  deriving Repr, DecidableEq

def ReferenceCase.directlyTransfersTo (r : ReferenceCase) (target : String) : Bool :=
  r.transfersTo.contains target

theorem empty_reference_transfer_is_blocked
    (r : ReferenceCase) (h : r.transfersTo = []) (target : String) :
    r.directlyTransfersTo target = false := by
  simp [ReferenceCase.directlyTransfersTo, h]

structure TransferFailureWitness where
  operatorId : String
  sourceDomain : String
  targetDomain : String
  preservationClaim : String
  witnessId : String
  witnessRefutesTransfer : Prop
  witnessProof : witnessRefutesTransfer

structure StructuralTransferFailure (w : TransferFailureWitness) where
  statement : Prop
  proof : statement

structure TransferRefutation where
  failure : TransferFailureWitness
  structural : StructuralTransferFailure failure

inductive NegativeClosure where
  | partialNegative | closedNegative
  deriving Repr, DecidableEq, BEq

def transferNegativeClosure
    (w : TransferFailureWitness)
    (structural : Option (StructuralTransferFailure w)) : NegativeClosure :=
  match structural with
  | none => .partialNegative
  | some _ => .closedNegative

theorem transfer_without_structural_proof_is_partial (w : TransferFailureWitness) :
    transferNegativeClosure w none = .partialNegative := rfl

def GapShape.routerAttackable : GapShape → Bool
  | .control => false
  | _ => true

theorem control_never_enters_attack_queue :
    GapShape.control.routerAttackable = false := rfl

end AxiomaticMillenium
