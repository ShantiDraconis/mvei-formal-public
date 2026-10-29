/-
Universe00/Core/Status.lean

Status tracking for epistemic discipline.

Law 5 (Traceability): Everything the system claims is labeled as
PROVED, ASSUMED, or CONJECTURAL.

This is the foundation of "not becoming a cult" - every claim has
transparent epistemic status.

Status: PROVED (core type definition)
-/

namespace Universe00.Core

/-!
## EpistemicStatus

The epistemic status of a claim, theorem, or construction.
-/

inductive EpistemicStatus : Type where
  | Proved : String → EpistemicStatus       -- Formally verified (file reference)
  | Assumed : String → EpistemicStatus      -- Explicit axiom (registry reference)
  | Conjectural : String → EpistemicStatus  -- Research program (rationale)
  | Computational : String → EpistemicStatus -- Verified by computation (bounds)
  deriving Repr, BEq

namespace EpistemicStatus

/-!
## Status Properties
-/

/-- Check if status represents verified truth -/
def isVerified : EpistemicStatus → Bool
  | Proved _ => true
  | Computational _ => true  -- Within bounds
  | _ => false

/-- Check if status requires trust in axioms -/
def requiresTrust : EpistemicStatus → Bool
  | Assumed _ => true
  | _ => false

/-- Check if status is uncertain -/
def isUncertain : EpistemicStatus → Bool
  | Conjectural _ => true
  | _ => false

/-- Get description/reference -/
def getReference : EpistemicStatus → String
  | Proved ref => ref
  | Assumed ref => ref
  | Conjectural ref => ref
  | Computational ref => ref

/-!
## Status Composition

When combining results with different statuses,
we must track the weakest status.
-/

/-- Combine two statuses (conservative) -/
def combine : EpistemicStatus → EpistemicStatus → EpistemicStatus
  | Conjectural r1, _ => Conjectural r1  -- Conjecture weakens everything
  | _, Conjectural r2 => Conjectural r2
  | Assumed r1, Assumed r2 => Assumed s!"{r1}, {r2}"
  | Assumed r, _ => Assumed r
  | _, Assumed r => Assumed r
  | Computational r1, Computational r2 => Computational s!"{r1} ∧ {r2}"
  | Computational r, _ => Computational r
  | _, Computational r => Computational r
  | Proved r1, Proved r2 => Proved s!"{r1} ∧ {r2}"

/-- Combine a list of statuses -/
def combineList : List EpistemicStatus → EpistemicStatus
  | [] => Proved "trivial"
  | [s] => s
  | s :: ss => combine s (combineList ss)

end EpistemicStatus

/-!
## Claim

A mathematical claim with its epistemic status attached.
-/

structure Claim (α : Type u) where
  statement : α
  status : EpistemicStatus
  source : String  -- Where this claim originated
  deriving Repr

namespace Claim

/-!
## Claim Operations
-/

/-- Create a proved claim -/
def proved {α : Type u} (stmt : α) (proof_file : String) (source : String) : 
    Claim α :=
  ⟨stmt, EpistemicStatus.Proved proof_file, source⟩

/-- Create an assumed claim (axiom) -/
def assumed {α : Type u} (stmt : α) (axiom_id : String) (source : String) : 
    Claim α :=
  ⟨stmt, EpistemicStatus.Assumed axiom_id, source⟩

/-- Create a conjectural claim -/
def conjectural {α : Type u} (stmt : α) (rationale : String) 
    (source : String) : Claim α :=
  ⟨stmt, EpistemicStatus.Conjectural rationale, source⟩

/-- Combine two claims (conjunction) -/
def and {α β : Type u} (c1 : Claim α) (c2 : Claim β) : 
    Claim (α × β) :=
  ⟨(c1.statement, c2.statement),
   EpistemicStatus.combine c1.status c2.status,
   s!"{c1.source} ∧ {c2.source}"⟩

/-- Apply a function to a claim's statement -/
def map {α β : Type u} (f : α → β) (c : Claim α) : Claim β :=
  ⟨f c.statement, c.status, c.source⟩

/-!
## Status Verification
-/

/-- Check if claim is formally verified -/
def isProved (c : Claim α) : Bool :=
  c.status.isVerified

/-- Check if claim requires trust -/
def requiresTrust (c : Claim α) : Bool :=
  c.status.requiresTrust

/-- Check if claim is conjectural -/
def isConjectural (c : Claim α) : Bool :=
  c.status.isUncertain

end Claim

/-!
## Registry Entry

An entry in the governance registry (axioms, laws, conjectures).
-/

structure RegistryEntry where
  id : String
  category : String  -- "axiom", "law", "conjecture"
  statement : String
  status : EpistemicStatus
  file : String
  dependencies : List String
  deriving Repr

/-!
## Traceability

Functions for tracking epistemic status through the system.
-/

namespace Traceability

/-- Verify that a status claim matches registry -/
def verify (entry : RegistryEntry) (claimed_status : EpistemicStatus) : Bool :=
  entry.status == claimed_status

/-- Get all dependencies of a claim recursively -/
partial def getDependencies (registry : List RegistryEntry) (id : String) : 
    List String :=
  match registry.find? (·.id == id) with
  | none => []
  | some entry => 
      entry.id :: (entry.dependencies.bind (getDependencies registry))

/-- Check if a claim ultimately depends on conjectural statements -/
def dependsOnConjecture (registry : List RegistryEntry) (id : String) : Bool :=
  let deps := getDependencies registry id
  deps.any fun dep =>
    match registry.find? (·.id == dep) with
    | none => false
    | some entry => entry.status.isUncertain

end Traceability

end Universe00.Core
