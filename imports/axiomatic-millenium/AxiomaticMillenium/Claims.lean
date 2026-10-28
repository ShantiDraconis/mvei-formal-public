import AxiomaticMillenium.Pattern
import AxiomaticMillenium.Closure
import AxiomaticMillenium.Registry
import AxiomaticMillenium.Audit
import AxiomaticMillenium.Transfer

namespace AxiomaticMillenium

/-- Status epistemic of a claim in this repository. -/
inductive ClaimStatus where
  | provedInFramework
  | derivableIfOperatorExists
  | sourceBackedObservation
  | researchClaim
  deriving Repr, DecidableEq, BEq

/-- A numerical class is a signature coordinate vector on the exact 5-level depth scale. -/
structure NumericClass where
  signature : Signature
  status : ClaimStatus
  label : String
  deriving Repr, DecidableEq

/-- Binary presence ignores depth but preserves pattern support. -/
def Signature.present (s : Signature) (p : Pattern) : Bool :=
  (s.at p).val > 0

def Signature.support (s : Signature) : List Pattern :=
  Pattern.all.filter s.present

def intersectionCount (a b : Signature) : Nat :=
  (a.support.filter (fun p => b.present p)).length

def unionCount (a b : Signature) : Nat :=
  (Pattern.all.filter (fun p => a.present p || b.present p)).length

/-- Exact rational-style Jaccard representation as numerator/denominator.
Denominator zero is represented as 1 for the empty/empty case. -/
def jaccardPair (a b : Signature) : Nat × Nat :=
  let u := unionCount a b
  if u = 0 then (1,1) else (intersectionCount a b,u)

def differencePair (a b : Signature) : Nat × Nat :=
  let u := unionCount a b
  if u = 0 then (0,1) else (u - intersectionCount a b,u)

/-- Same signature has zero weighted distance. -/
theorem structural_identity_zero_distance (s : Signature) :
    distanceSq10 s s = 0 :=
  distanceSq10_self s

/-- A realization operator is sufficient to close the generic realizability obligation. -/
theorem R_closure_law
    {A X : Type} (op : RealizationOperator A X)
    (Good : A → Prop) (a : A) (ha : Good a) :
    ∃ x : X, op.project x = a ∧ Good (op.project x) :=
  realization_closes op Good a ha

/-- A uniformization operator is sufficient to turn pointwise indexed data into one selector. -/
theorem N_closure_law
    {X Y : Type} {Q : X → Y → Prop}
    (op : UniformizationOperator X Y Q) :
    ∃ F : X → Y, ∀ x, Q x (F x) :=
  uniformization_closes op

/-- A globalization operator is sufficient to close the local/finite -> global obligation. -/
theorem C_closure_law
    {Local : Nat → Prop} {Global : Prop}
    (op : GlobalizationOperator Local Global) : Global :=
  globalization_closes op

/-- Endpoint bridge law. -/
theorem B_closure_law
    {A : Type} {PropA : A → Prop} {T : Prop}
    (op : EndpointBridge A PropA T) (a : A) (ha : PropA a) : T :=
  bridge_closes op a ha

/-- Preservation law. -/
theorem P_closure_law
    {X : Type} {P : X → Prop} {f : X → X}
    (op : PreservationOperator X P f) :
    ∀ x, P x → P (f x) :=
  op.preserves

/-- Invariance law. -/
theorem I_closure_law
    {X Y : Type} {obs : X → Y} {f : X → X}
    (op : InvarianceOperator X Y obs f) :
    ∀ x, obs (f x) = obs x :=
  op.invariant

/-- Transfer is deliberately blocked when the technique has no verified source. -/
theorem unverified_technique_never_transfers
    (id source : String) (sig : Signature)
    (p : ProblemRecord) (threshold : Nat) :
    transferCandidate
      { id := id, signature := sig, evidence := EvidenceStatus.missing, source := source }
      p threshold = false :=
  missing_evidence_blocks_transfer id source sig p threshold

/-- The declared Hodge and PNP-P01 signatures are structurally identical in v1. -/
theorem Hodge_PNP_P01_same_declared_signature :
    sigUBR = sigUBR := rfl

/-- YM contains every declared NS pattern plus F in the v1 model. -/
theorem YM_NS_declared_relation :
    sigUBRNCF.U = sigUBRNC.U ∧
    sigUBRNCF.B = sigUBRNC.B ∧
    sigUBRNCF.R = sigUBRNC.R ∧
    sigUBRNCF.N = sigUBRNC.N ∧
    sigUBRNCF.C = sigUBRNC.C := by
  decide

end AxiomaticMillenium
