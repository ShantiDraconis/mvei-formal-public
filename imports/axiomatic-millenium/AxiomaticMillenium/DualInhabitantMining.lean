
import AxiomaticMillenium.TwoSidedClosure
import AxiomaticMillenium.MaterializerMiningLedger

namespace AxiomaticMillenium

/-- Genuine positive material inhabitant of a proposition. -/
structure PositiveInhabitant (P : Prop) where
  proof : P

/-- Genuine negative material inhabitant: a proof of the exact negation. -/
structure NegativeInhabitant (P : Prop) where
  refute : P -> False

/--
Exact material resolution.  Unlike a status tag, each constructor carries
the proof object needed by the corresponding branch.
-/
inductive ExactMaterialResolution (P : Prop) : Type where
  | positive : PositiveInhabitant P -> ExactMaterialResolution P
  | negative : NegativeInhabitant P -> ExactMaterialResolution P

def PositiveInhabitant.toOutcome
    {P : Prop} (h : PositiveInhabitant P) :
    MathematicalOutcome P :=
  .proved h.proof

def NegativeInhabitant.toOutcome
    {P : Prop} (h : NegativeInhabitant P) :
    MathematicalOutcome P :=
  .refuted h.refute

def ExactMaterialResolution.toOutcome
    {P : Prop} :
    ExactMaterialResolution P -> MathematicalOutcome P
  | .positive h => h.toOutcome
  | .negative h => h.toOutcome

theorem positive_negative_exclusive
    {P : Prop}
    (hp : PositiveInhabitant P)
    (hn : NegativeInhabitant P) :
    False :=
  hn.refute hp.proof

/--
Classical logic provides a resolution envelope, but this theorem is explicitly
separate from mining: it does not tell us which constructor is backed by a
repository-produced proof object.
-/
theorem exactMaterialResolution_classically_total
    (P : Prop) :
    Nonempty (ExactMaterialResolution P) := by
  rcases Classical.em P with hp | hn
  · exact ⟨.positive ⟨hp⟩⟩
  · exact ⟨.negative ⟨hn⟩⟩

inductive SideMiningStatus where
  | found
  | candidateUnverified
  | absent
  | interfaceCountermodelOnly
  | routeFalsifiedOnly
  deriving Repr, DecidableEq, BEq

structure DualInhabitantMiningRecord where
  lane : String
  positiveTarget : String
  positiveStatus : SideMiningStatus
  negativeTarget : String
  negativeStatus : SideMiningStatus
  positiveSource : String
  negativeSource : String
  note : String
  deriving Repr, DecidableEq

def rhDualMining : DualInhabitantMiningRecord :=
  { lane := "RH"
    positiveTarget := "SplitLogMajorantCertificate / LogMajorantCertificate"
    positiveStatus := .absent
    negativeTarget := "not(FiniteSpanApproximatesChi concreteGeneratorFamily)"
    negativeStatus := .absent
    positiveSource := "atk/rh-log-majorant-split-20261001"
    negativeSource := "none found"
    note := "zero-residue obstruction falsifies a strategy, not the RH terminal target" }

def pnpDualMining : DualInhabitantMiningRecord :=
  { lane := "PNP"
    positiveTarget := "UniversalFailure(CanonicalSAT) / UniversalCounterexampleProducer"
    positiveStatus := .absent
    negativeTarget := "InP(CanonicalSAT), equivalent to not UniversalFailure(CanonicalSAT)"
    negativeStatus := .absent
    positiveSource := "atk/p02-two-sided-orientation-20261001"
    negativeSource := "atk/p02-two-sided-orientation-20261001"
    note := "two-sided orientation is formalized; neither material branch is mined as an explicit inhabitant" }

def nsDualMining : DualInhabitantMiningRecord :=
  { lane := "NS"
    positiveTarget := "ActualNSBulkTailProducer"
    positiveStatus := .absent
    negativeTarget := "not(ActualNSBulkTailProducer)"
    negativeStatus := .absent
    positiveSource := "atk/ns-bulk-tail-material-producer-20261001"
    negativeSource := "none found"
    note := "snapshot/coherence countertests do not refute the exact ActualNS producer" }

def hodgeDualMining : DualInhabitantMiningRecord :=
  { lane := "HODGE"
    positiveTarget := "H01UniversalMaterialProducer / ConcreteHodgeMaterialTarget"
    positiveStatus := .absent
    negativeTarget := "not(ConcreteAlgebraicityPayload) on genuine geometry"
    negativeStatus := .interfaceCountermodelOnly
    positiveSource := "atk/hodge-material-target-hardening-20261001"
    negativeSource := "audit/ATK_HODGE_SEMANTIC_INTERFACE_COUNTERAUDIT.lean"
    note := "toy semantic countermodel attacks an abstract interface, not the concrete Hodge conjecture" }

def bsdDualMining : DualInhabitantMiningRecord :=
  { lane := "BSD"
    positiveTarget := "GroundedBSDHabitant / BSDResolutionMechanism"
    positiveStatus := .absent
    negativeTarget := "genuine elliptic curve with rank or refined BSD failure"
    negativeStatus := .interfaceCountermodelOnly
    positiveSource := "atk/bsd-grounded-habitant"
    negativeSource := "audit/ATK_BSD_ABSTRACT_TYPE_COUNTERAUDIT.lean"
    note := "abstractRankCounterexample refutes only the overbroad abstract Nat interface" }

def ymDualMining : DualInhabitantMiningRecord :=
  { lane := "YM"
    positiveTarget := "B60FieldBundle / B60ConcretePhysicalAdapter"
    positiveStatus := .absent
    negativeTarget := "not(B60FieldBundle) for the genuine regulated 4D construction"
    negativeStatus := .absent
    positiveSource := "atk/ym-b60-field-bundle-20261001"
    negativeSource := "none found"
    note := "legacy/triviality firewalls do not refute the genuine physical target" }

def bealDualMining : DualInhabitantMiningRecord :=
  { lane := "BEAL"
    positiveTarget := "BealUniversalCommonPrimeCertificate / GCDLowerBoundProducer"
    positiveStatus := .absent
    negativeTarget := "exists d : BealData, BealCounterexample d"
    negativeStatus := .absent
    positiveSource := "cert/beal-final-math-chain-213c5dc1"
    negativeSource := "lean/MCore/BealSpecification.lean + K8.lean"
    note := "negative type is exact (NoCommonPrime iff BealCounterexample), but no witness d was found" }

def dualInhabitantMiningLedger : List DualInhabitantMiningRecord :=
  [rhDualMining, pnpDualMining, nsDualMining, hodgeDualMining,
   bsdDualMining, ymDualMining, bealDualMining]

theorem dual_mining_has_seven_lanes :
    dualInhabitantMiningLedger.length = 7 := by
  decide

#print axioms AxiomaticMillenium.positive_negative_exclusive
#print axioms AxiomaticMillenium.exactMaterialResolution_classically_total

end AxiomaticMillenium
