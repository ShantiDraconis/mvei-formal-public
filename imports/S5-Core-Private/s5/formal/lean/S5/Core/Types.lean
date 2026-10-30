/-
S5-Core-Private: Types module
Defines core types for claims, evidence, and formal structures.
-/

namespace S5.Core

/-- Claim identifier -/
def ClaimID := String

/-- Source/Evidence identifier -/
def SourceID := String

/-- SHA256 hash for evidence verification -/
def Hash := String

/-- Track identifier (A = novel logic, B = classical alternative) -/
inductive Track where
  | A : Track  -- Novel approaches
  | B : Track  -- Classical approaches
  deriving Repr, DecidableEq

/-- Claim status -/
inductive ClaimStatus where
  | open : ClaimStatus
  | proven : ClaimStatus
  | refuted : ClaimStatus
  | pending_review : ClaimStatus
  deriving Repr, DecidableEq

/-- Claim kind -/
inductive ClaimKind where
  | conjecture : ClaimKind
  | theorem : ClaimKind
  | lemma : ClaimKind
  | hypothesis : ClaimKind
  | definition : ClaimKind
  deriving Repr, DecidableEq

/-- Evidence structure -/
structure Evidence where
  sourceId : SourceID
  hash : Hash
  deriving Repr

/-- Claim structure -/
structure Claim where
  id : ClaimID
  domain : String
  target : String
  kind : ClaimKind
  statement : String
  tracks : List Track
  evidence : List Evidence
  status : ClaimStatus
  deriving Repr

end S5.Core
