
import AxiomaticMillenium.ExactResolutionInhabitants
import AxiomaticMillenium.BridgeClosureRegistry

namespace AxiomaticMillenium

inductive MaterialClosureStatus where
  | closedPositive
  | closedNegative
  | closedBoth
  | openMath
  deriving Repr, DecidableEq, BEq

structure MaterialClosureGate where
  lane : String
  positiveTarget : String
  negativeTarget : String
  status : MaterialClosureStatus
  evidence : String
  deriving Repr, DecidableEq

def rhMaterialGate : MaterialClosureGate :=
  { lane := "RH"
    positiveTarget := "FiniteSpanApproximatesChi / LogMajorantCertificate"
    negativeTarget := "not FiniteSpanApproximatesChi on the concrete generator family"
    status := .openMath
    evidence := "no exact positive or negative inhabitant found in repository mining" }

def pnpMaterialGate : MaterialClosureGate :=
  { lane := "PNP"
    positiveTarget := "UniversalCounterexampleProducer / UniversalFailure CanonicalSAT"
    negativeTarget := "PolyDTMRealization CanonicalSAT plus same-model NP-completeness transfer"
    status := .openMath
    evidence := "orientation and bridges closed; no material lower-bound witness or SAT decider/completeness materializer found" }

def nsMaterialGate : MaterialClosureGate :=
  { lane := "NS"
    positiveTarget := "ActualNSBulkTailProducer"
    negativeTarget := "exact negation witnessed by a genuine ActualNS trajectory"
    status := .openMath
    evidence := "no terminal inhabitant; existing countertests only falsify auxiliary routes" }

def hodgeMaterialGate : MaterialClosureGate :=
  { lane := "HODGE"
    positiveTarget := "ConcreteAlgebraicityPayload"
    negativeTarget := "genuine nonalgebraic rational Hodge class"
    status := .openMath
    evidence := "no exact terminal inhabitant; abstract semantic countermodels do not count" }

def bsdMaterialGate : MaterialClosureGate :=
  { lane := "BSD"
    positiveTarget := "GroundedBSDHabitant / genuine BSDResolutionMechanism"
    negativeTarget := "genuine elliptic-curve violation of rank or refined formula"
    status := .openMath
    evidence := "abstractRankCounterexample refutes only an overbroad interface" }

def ymMaterialGate : MaterialClosureGate :=
  { lane := "YM"
    positiveTarget := "B60ConcretePhysicalAdapter / B60FieldBundle"
    negativeTarget := "genuine physical obstruction to the regulated 4D mass-gap target"
    status := .openMath
    evidence := "no exact terminal positive or negative inhabitant found" }

def bealMaterialGate : MaterialClosureGate :=
  { lane := "BEAL"
    positiveTarget := "GCDLowerBoundProducer"
    negativeTarget := "exists d : BealData, BealCounterexample d"
    status := .openMath
    evidence := "negative type is exact, but no concrete BealData counterexample witness was found" }

def materialClosureGates : List MaterialClosureGate :=
  [rhMaterialGate, pnpMaterialGate, nsMaterialGate, hodgeMaterialGate,
   bsdMaterialGate, ymMaterialGate, bealMaterialGate]

def materialOpenCount : Nat :=
  materialClosureGates.foldl
    (fun n g => if g.status == .openMath then n + 1 else n) 0

def materialClosedCount : Nat :=
  materialClosureGates.length - materialOpenCount

theorem material_gate_count_seven :
    materialClosureGates.length = 7 := by decide

theorem material_open_count_seven :
    materialOpenCount = 7 := by decide

theorem material_closed_count_zero :
    materialClosedCount = 0 := by decide

/--
A material lane may be promoted only by an exact positive or exact negative
inhabitant. Structural resolution envelopes and closed wiring are insufficient.
-/
def promotePositive {P : Prop}
    (h : PositiveInhabitant P) :
    ExactMaterialResolution P :=
  .positive h

def promoteNegative {P : Prop}
    (h : NegativeInhabitant P) :
    ExactMaterialResolution P :=
  .negative h

end AxiomaticMillenium
