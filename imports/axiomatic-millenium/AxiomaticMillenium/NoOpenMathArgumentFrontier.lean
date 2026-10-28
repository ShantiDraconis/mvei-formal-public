import AxiomaticMillenium.TruthClosureStateMatrix

namespace AxiomaticMillenium

/--
Producer discipline: a terminal theorem is not a material producer merely
because it consumes an assumption equivalent to its own endpoint.
-/
inductive ProducerDependencyClass where
  | primitiveData
  | classicalKnownTheorem
  | specialCase
  | sufficientStrictlyStronger
  | endpointEquivalent
  | endpointItself
  deriving Repr, DecidableEq, BEq

inductive ProducerRole where
  | producer
  | consumerOnly
  | reductionOnly
  | falsification
  deriving Repr, DecidableEq, BEq

structure PrimitiveFrontier where
  lane : String
  forbiddenEndpointArgument : String
  primitiveGoal : String
  roleOfCurrentFinalAPI : ProducerRole
  dependencyClassOfCurrentFinalAPI : ProducerDependencyClass
  reason : String
  deriving Repr, DecidableEq

def rhPrimitiveFrontier : PrimitiveFrontier :=
  { lane := "RH"
    forbiddenEndpointArgument := "FiniteSpanApproximatesChi / DNLimit=0 / OpenMathResidual / LogMajorantCertificate as an assumed argument"
    primitiveGoal :=
      "derive explicit closed formulas or unconditional estimates for concrete Gram/target entries and construct coefficients c_N from arithmetic data with a proved energy bound"
    roleOfCurrentFinalAPI := .consumerOnly
    dependencyClassOfCurrentFinalAPI := .endpointEquivalent
    reason := "all final APIs consume a vanishing/density/majorant object; the new mathematics must create the finite-N coefficient estimate from concrete rho and chi data" }

def pnpPrimitiveFrontier : PrimitiveFrontier :=
  { lane := "PVSNP"
    forbiddenEndpointArgument := "UniversalFailure / G21Pointwise / UniversalCounterexampleProducer / SameInputSemanticDiagonalProducer as an assumed argument"
    primitiveGoal :=
      "construct, from the syntax and operational semantics of each concrete polynomial-time machine, an effective compiler and canonical SAT encoding with verified same-input semantic preservation and polynomial size/clock bounds"
    roleOfCurrentFinalAPI := .consumerOnly
    dependencyClassOfCurrentFinalAPI := .endpointEquivalent
    reason := "Kleene/SAT bridge currently stores the missing semantic realizer; a producer must build it from machine syntax and Cook-Levin style encoding" }

def nsPrimitiveFrontier : PrimitiveFrontier :=
  { lane := "NS"
    forbiddenEndpointArgument := "ActualNSToSignedGainCore / BulkAbsorption / ExceptionalTailControl as assumed terminal arguments"
    primitiveGoal :=
      "derive a signed Biot-Savart/CZ cancellation estimate directly from the vorticity PDE and local-energy identity, with one full factor r/rhoStar and explicit constants"
    roleOfCurrentFinalAPI := .reductionOnly
    dependencyClassOfCurrentFinalAPI := .sufficientStrictlyStronger
    reason := "bulk/tail packages consume the open analytic estimate; the primitive mathematics is the signed kernel cancellation" }

def hodgePrimitiveFrontier : PrimitiveFrontier :=
  { lane := "HODGE"
    forbiddenEndpointArgument := "ConcreteAlgebraicityPayload / HodgePositiveTerminalProducer / UnconditionalHodgeCertificate as assumed arguments"
    primitiveGoal :=
      "construct actual algebraic cycles and rational coefficients from concrete geometric input (X,p,alpha) using valid cycle-class, spread, specialization, or known-case geometry"
    roleOfCurrentFinalAPI := .consumerOnly
    dependencyClassOfCurrentFinalAPI := .endpointEquivalent
    reason := "unconditional certificate is explicitly equivalent to the missing payload; only construction of cycles is material progress" }

def bsdPrimitiveFrontier : PrimitiveFrontier :=
  { lane := "BSD"
    forbiddenEndpointArgument := "GroundedBSDHabitant / rankLaw / leadingLaw as assumed arguments"
    primitiveGoal :=
      "bind a genuine elliptic curve to computable arithmetic and analytic invariants, then derive rank comparison and the refined leading identity from independent theorems on a proved domain"
    roleOfCurrentFinalAPI := .consumerOnly
    dependencyClassOfCurrentFinalAPI := .endpointEquivalent
    reason := "GroundedBSDHabitant is the desired theorem packaged as data; it must be constructed from curve-level arithmetic/analytic machinery" }

def ymPrimitiveFrontier : PrimitiveFrontier :=
  { lane := "YM"
    forbiddenEndpointArgument := "B60ConcretePhysicalAdapter / B60FieldBundle / FINAL_ROOT as assumed arguments"
    primitiveGoal :=
      "construct one nondegenerate regulated 4D gauge model with physical-model binding, reflection positivity, transfer operator, uniform physical spectral lower bound and verified continuum/thermodynamic limit preservation"
    roleOfCurrentFinalAPI := .falsification
    dependencyClassOfCurrentFinalAPI := .endpointItself
    reason := "current B60 is inhabited by a degenerate Unit/True model, proving it is not a faithful terminal target; physical binding must be strengthened before any positive certificate" }

def bealPrimitiveFrontier : PrimitiveFrontier :=
  { lane := "BEAL"
    forbiddenEndpointArgument := "GCDLowerBoundProducer / BealAcceptedClosureObject / UniversalCommonPrimeCertificate as assumed arguments"
    primitiveGoal :=
      "from an arbitrary admissible Beal equation under gcd(a,b,c)=1, derive a local/modular contradiction using valuations, conductor/level lowering and elimination with all hypotheses discharged"
    roleOfCurrentFinalAPI := .consumerOnly
    dependencyClassOfCurrentFinalAPI := .endpointEquivalent
    reason := "accepted closure object contains exactly the universal common-prime theorem; it cannot count as a producer" }

def allPrimitiveFrontiers : List PrimitiveFrontier :=
  [rhPrimitiveFrontier, pnpPrimitiveFrontier, nsPrimitiveFrontier,
   hodgePrimitiveFrontier, bsdPrimitiveFrontier, ymPrimitiveFrontier,
   bealPrimitiveFrontier]

def endpointEquivalentConsumerCount : Nat :=
  allPrimitiveFrontiers.foldl
    (fun n f =>
      if f.dependencyClassOfCurrentFinalAPI == .endpointEquivalent
      then n + 1 else n) 0

theorem primitive_frontier_count :
    allPrimitiveFrontiers.length = 7 := by
  decide

theorem endpoint_equivalent_consumers_are_five :
    endpointEquivalentConsumerCount = 5 := by
  decide

end AxiomaticMillenium
