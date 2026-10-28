namespace AxiomaticMillenium

inductive RootHashStatus where
  | uninstantiated
  | declared
  | frozen
  deriving Repr, DecidableEq, BEq

structure FrozenRoot where
  statement : Prop
  fingerprint : String
  declaredBase : List Name
  statementHash : UInt64 := 0
  hashScheme : String := "UNINSTANTIATED"
  hashStatus : RootHashStatus := .uninstantiated

abbrev AtomKey := UInt64

structure AtomSpace where
  term : AtomKey → Prop

/-- Mathlib-free finite atom set: list representation plus a kernel-checked
no-duplicates invariant. -/
structure Frontier where
  atoms : List AtomKey
  nodup : atoms.Nodup

/-- Canonical frontier representation: AtomKey is itself the frozen hash/key,
so strictly increasing order gives deterministic set serialization. -/
structure CanonicalFrontier extends Frontier where
  ordered : atoms.Pairwise (fun a b => a < b)

structure ReductionGraph where
  children : AtomKey → List AtomKey
  childrenNodup : ∀ a, (children a).Nodup
  rank : AtomKey → Nat
  decreases : ∀ parent child,
    child ∈ children parent → rank child < rank parent

structure ReducedFrontier where
  frontier : Frontier
  reductions : ReductionGraph
  terminal : ∀ a, a ∈ frontier.atoms → reductions.children a = []

structure RootContract where
  root : FrozenRoot
  atomSpace : AtomSpace
  closureSchema : Frontier → Prop
  closureSound : ∀ f : Frontier,
    (∀ a, a ∈ f.atoms → atomSpace.term a) →
    closureSchema f →
    root.statement

structure ProvenMinimal (C : RootContract) where
  frontier : Frontier
  schema : C.closureSchema frontier
  coversRoot : (∀ a, a ∈ frontier.atoms → C.atomSpace.term a) → C.root.statement
  minimality :
    ∀ s : Frontier,
      s.atoms.length < frontier.atoms.length →
      ¬ ((∀ a, a ∈ s.atoms → C.atomSpace.term a) → C.root.statement)

structure CandidateMinimal (C : RootContract) where
  frontier : Frontier
  schema : C.closureSchema frontier
  coversRoot : (∀ a, a ∈ frontier.atoms → C.atomSpace.term a) → C.root.statement
  searchBound : Nat
  noSmallerFoundWithinBound :
    ∀ s : List AtomKey,
      s.Nodup →
      s.length < frontier.atoms.length →
      s.length ≤ searchBound →
      ¬ ((∀ a, a ∈ s → C.atomSpace.term a) → C.root.statement)

def frontierCost (cost : AtomKey → Nat) (f : Frontier) : Nat :=
  f.atoms.foldl (fun acc a => acc + cost a) 0

def isProgress (cost : AtomKey → Nat) (before after : Frontier) : Prop :=
  frontierCost cost after < frontierCost cost before

structure ExternalGlobalCertificate (C : RootContract) where
  term : C.root.statement
  directDeps : List Name
  metadataFingerprint : String

structure ConditionalExternalGlobalCertificate (C : RootContract) where
  frontier : Frontier
  schema : C.closureSchema frontier
  directDeps : List Name
  metadataFingerprint : String

def ConditionalExternalGlobalCertificate.termIfFrontier
    {C : RootContract}
    (egc : ConditionalExternalGlobalCertificate C)
    (h : ∀ a, a ∈ egc.frontier.atoms → C.atomSpace.term a) :
    C.root.statement :=
  C.closureSound egc.frontier h egc.schema

structure PvsNPOfficialModel where
  Language : Type
  officialP : Language → Prop
  officialNP : Language → Prop
  modelFingerprint : String

def pvsnpSeparationStatement (M : PvsNPOfficialModel) : Prop :=
  ¬ ∀ L, M.officialP L ↔ M.officialNP L

def pvsnpFrozenRoot (M : PvsNPOfficialModel) : FrozenRoot :=
  { statement := pvsnpSeparationStatement M
    fingerprint := "PVSNP-SEPARATION:" ++ M.modelFingerprint
    declaredBase := [] }

end AxiomaticMillenium
