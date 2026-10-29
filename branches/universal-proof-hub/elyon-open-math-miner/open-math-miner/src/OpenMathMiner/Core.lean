namespace OpenMathMiner

inductive QuantifierShape
  | exists
  | forall
  | forallExists
  | existsForall
  deriving Repr, DecidableEq

inductive EvidenceState
  | sourceDiscovered
  | certificateDiscovered
  | structuralMatch
  | bridgeCandidate
  | bridgeCertified
  | closed
  deriving Repr, DecidableEq

structure Signature where
  name : String
  Input : Type
  Output : Type
  admissible : Input → Prop
  relation : Input → Output → Prop

def Solved (S : Signature) : Prop :=
  ∀ x : S.Input, S.admissible x → ∃ y : S.Output, S.relation x y

structure CertificateRef where
  repository : String
  commit : String
  path : String
  state : EvidenceState
  deriving Repr

end OpenMathMiner
