import AxiomaticMillenium.Claims

namespace AxiomaticMillenium

inductive RequirementStatus where
  | missing
  | proposed
  | measured
  | sourceVerified
  deriving Repr, DecidableEq, BEq

structure ClosureRequirement where
  id : String
  description : String
  status : RequirementStatus
  deriving Repr, DecidableEq

structure DomainChecklist where
  domain : String
  target : String
  gap : Pattern
  requirements : List ClosureRequirement
  witnessDescription : String
  closureStatement : String
  claimStatus : ClaimStatus
  deriving Repr, DecidableEq

def ClosureRequirement.closed (r : ClosureRequirement) : Bool :=
  match r.status with
  | RequirementStatus.sourceVerified => true
  | _ => false

def DomainChecklist.ready (c : DomainChecklist) : Bool :=
  c.requirements.all ClosureRequirement.closed

theorem empty_requirements_ready
    (domain target witness closure : String)
    (g : Pattern) (status : ClaimStatus) :
    (DomainChecklist.ready
      { domain := domain
        target := target
        gap := g
        requirements := []
        witnessDescription := witness
        closureStatement := closure
        claimStatus := status }) = true := by
  rfl

theorem missing_requirement_blocks
    (c : DomainChecklist) (r : ClosureRequirement)
    (h : r.status = RequirementStatus.missing) :
    DomainChecklist.ready { c with requirements := r :: c.requirements } = false := by
  unfold DomainChecklist.ready
  simp [ClosureRequirement.closed, h]

/-- A checklist does not itself close a mathematical gap.
It only records the hypotheses needed to instantiate a closure operator. -/
structure ChecklistInstantiation where
  checklist : DomainChecklist
  operatorVerified : Bool
  assumptionsVerified : Bool
  targetBridgeVerified : Bool
  deriving Repr, DecidableEq

def ChecklistInstantiation.closed (x : ChecklistInstantiation) : Bool :=
  x.checklist.ready &&
  x.operatorVerified &&
  x.assumptionsVerified &&
  x.targetBridgeVerified

end AxiomaticMillenium
