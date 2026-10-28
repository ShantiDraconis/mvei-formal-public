
import AxiomaticMillenium.DualInhabitantMining
import AxiomaticMillenium.GlobalResolutionEnvelope

namespace AxiomaticMillenium

/--
Closure inhabitant for one exact proposition.
It packages an actual material resolution and therefore can always be
projected to a classical MathematicalOutcome.
-/
structure ClosureInhabitant (P : Prop) where
  resolution : ExactMaterialResolution P

def ClosureInhabitant.toOutcome
    {P : Prop} (C : ClosureInhabitant P) :
    MathematicalOutcome P :=
  C.resolution.toOutcome

/--
A branch-complete closure inhabitant for a downstream target Q.
This is the exact object needed when the open proposition P is not itself the
final target: it carries both branch maps, so any exact material resolution of
P closes Q.
-/
structure ExactResolutionBridge (P Q : Prop) where
  bridge : BranchCompleteBridge P Q

def ExactResolutionBridge.close
    {P Q : Prop}
    (B : ExactResolutionBridge P Q)
    (R : ExactMaterialResolution P) : Q :=
  B.bridge.run R.toOutcome

/--
For the special case where the target is the conjecture itself, exact
resolution means precisely one of the two material mathematical outcomes.
-/
abbrev ExactConjectureResolution (P : Prop) :=
  ExactMaterialResolution P

def exactResolution_of_positive
    {P : Prop} (h : PositiveInhabitant P) :
    ExactConjectureResolution P :=
  .positive h

def exactResolution_of_negative
    {P : Prop} (h : NegativeInhabitant P) :
    ExactConjectureResolution P :=
  .negative h

/--
Optional explicit contradictory package.  It is represented separately from
ExactMaterialResolution because, in classical Lean, it collapses to False.
-/
structure BothInhabitant (P : Prop) where
  positive : PositiveInhabitant P
  negative : NegativeInhabitant P

theorem BothInhabitant.false
    {P : Prop} (B : BothInhabitant P) :
    False :=
  B.negative.refute B.positive.proof

/--
Resolution classifier that can represent all four audit states while keeping
mathematical extraction fail-closed.
-/
inductive ResolutionState (P : Prop) : Type where
  | positive : PositiveInhabitant P -> ResolutionState P
  | negative : NegativeInhabitant P -> ResolutionState P
  | both : BothInhabitant P -> ResolutionState P
  | openMath : ResolutionState P

def ResolutionState.hasExactResolution
    {P : Prop} : ResolutionState P -> Prop
  | .positive _ => True
  | .negative _ => True
  | .both _ => True
  | .openMath => False

def ResolutionState.toExact?
    {P : Prop} : ResolutionState P -> Option (ExactMaterialResolution P)
  | .positive h => some (.positive h)
  | .negative h => some (.negative h)
  | .both h => some (.positive h.positive)
  | .openMath => none

/--
If a both-state exists, every proposition follows classically, but we expose
that only through the contradiction and never classify it as a normal proof
of P.
-/
theorem close_from_both
    {P Q : Prop}
    (B : BothInhabitant P) : Q :=
  False.elim B.false

/--
Lane-specific exact inhabitant description.  These are type descriptions,
not claims that the inhabitants currently exist.
-/
structure LaneExactInhabitants where
  lane : String
  positive : String
  negative : String
  closure : String
  bridge : String
  deriving Repr, DecidableEq

def rhExactInhabitants : LaneExactInhabitants :=
  { lane := "RH"
    positive := "PositiveInhabitant(FiniteSpanApproximatesChi concreteGeneratorFamily)"
    negative := "NegativeInhabitant(FiniteSpanApproximatesChi concreteGeneratorFamily)"
    closure := "ExactConjectureResolution(FiniteSpanApproximatesChi concreteGeneratorFamily)"
    bridge := "positive -> RH endpoint; negative -> RH refutation endpoint" }

def pnpExactInhabitants : LaneExactInhabitants :=
  { lane := "PNP"
    positive := "PositiveInhabitant(UniversalFailure CanonicalSAT)"
    negative := "PositiveInhabitant(InP CanonicalSAT), equivalent to NegativeInhabitant(UniversalFailure CanonicalSAT)"
    closure := "ExactConjectureResolution(UniversalFailure CanonicalSAT)"
    bridge := "UniversalFailure -> P!=NP; InP SAT + completeness transfer -> P=NP" }

def nsExactInhabitants : LaneExactInhabitants :=
  { lane := "NS"
    positive := "PositiveInhabitant(NS_BULK_TAIL_OPEN_MATH)"
    negative := "NegativeInhabitant(NS_BULK_TAIL_OPEN_MATH)"
    closure := "ExactConjectureResolution(NS_BULK_TAIL_OPEN_MATH)"
    bridge := "positive -> SignedGainCore route; negative requires an actual NS trajectory obstruction" }

def hodgeExactInhabitants : LaneExactInhabitants :=
  { lane := "HODGE"
    positive := "PositiveInhabitant(ConcreteAlgebraicityPayload)"
    negative := "NegativeInhabitant(ConcreteAlgebraicityPayload on genuine geometry)"
    closure := "ExactConjectureResolution(ConcreteAlgebraicityPayload)"
    bridge := "positive -> graded Hodge endpoint; negative -> genuine nonalgebraic rational Hodge class" }

def bsdExactInhabitants : LaneExactInhabitants :=
  { lane := "BSD"
    positive := "PositiveInhabitant(Nonempty GroundedBSDHabitant)"
    negative := "NegativeInhabitant(BSD rank/refined law on a genuine elliptic curve)"
    closure := "ExactConjectureResolution(BSD concrete endpoint)"
    bridge := "positive -> BSD rank+refined identity; negative -> genuine elliptic-curve counterexample" }

def ymExactInhabitants : LaneExactInhabitants :=
  { lane := "YM"
    positive := "PositiveInhabitant(B60FieldOpenMath)"
    negative := "NegativeInhabitant(B60FieldOpenMath for genuine regulated 4D construction)"
    closure := "ExactConjectureResolution(B60FieldOpenMath)"
    bridge := "positive -> FINAL_ROOT; negative -> physical no-gap/continuum obstruction" }

def bealExactInhabitants : LaneExactInhabitants :=
  { lane := "BEAL"
    positive := "PositiveInhabitant(GCDLowerBoundProducer)"
    negative := "PositiveInhabitant(exists d, BealCounterexample d)"
    closure := "ExactConjectureResolution(BealConjecture)"
    bridge := "positive -> Beal proof; negative -> Beal refutation certificate" }

def exactInhabitantAtlas : List LaneExactInhabitants :=
  [rhExactInhabitants, pnpExactInhabitants, nsExactInhabitants,
   hodgeExactInhabitants, bsdExactInhabitants, ymExactInhabitants,
   bealExactInhabitants]

theorem exact_inhabitant_atlas_has_seven :
    exactInhabitantAtlas.length = 7 := by
  decide

#print axioms AxiomaticMillenium.BothInhabitant.false
#print axioms AxiomaticMillenium.close_from_both

end AxiomaticMillenium
