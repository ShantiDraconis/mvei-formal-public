import AxiomaticMillenium.Pattern
import AxiomaticMillenium.Closure
import AxiomaticMillenium.Identification
import AxiomaticMillenium.Transfer
import AxiomaticMillenium.FrontierRED
import AxiomaticMillenium.FReformulationChain

namespace AxiomaticMillenium

/-- Refinement of the coarse F pattern used by the 001 snapshot. -/
inductive FSubtype where
  | formulation
  | transfer
  deriving Repr, DecidableEq, BEq

/--
Publication-v2 producer profile.
The signature remains the certified 9-coordinate structural signature.
Pending hypotheses are metadata obligations, not proofs.
-/
structure ProducerProfile where
  name : String
  signature : Signature
  gap : Pattern
  H_appeared : List String
  H_pending : List String
  claimStatus : ClaimStatus


/--
A mathematically impossible transfer is stronger than an open bridge:
for every valid source state A, the required bridge obligation P fails.
-/
structure NoGoTransfer (A B P : Prop) where
  prefixWitness : A
  impossible : A → ¬ P
  targetRequires : B → P

theorem NoGoTransfer.missing
    {A B P : Prop} (r : NoGoTransfer A B P) : ¬ P :=
  r.impossible r.prefixWitness

theorem NoGoTransfer.target_unreachable
    {A B P : Prop} (r : NoGoTransfer A B P) : ¬ B := by
  intro hB
  exact r.missing (r.targetRequires hB)

/--
Similarity is only a candidate selector. The exact three verification fields
remain data carried by TransferObligation; this theorem deliberately makes no
new mathematical inference from similarity alone.
-/
theorem closed_transfer_requires_closed_obligation
    (o : TransferObligation) :
    o.closed = true → o.closed = true :=
  fun h => h

/-- The two certified negative uses of F are intentionally distinguishable. -/
def g21FSubtype : FSubtype := .formulation
def nsFixedDeltaFSubtype : FSubtype := .transfer

theorem f_subtypes_distinct :
    g21FSubtype ≠ nsFixedDeltaFSubtype := by
  decide

end AxiomaticMillenium
