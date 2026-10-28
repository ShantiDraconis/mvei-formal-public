import AxiomaticMillenium.CrossProblemRelationMatrix

namespace AxiomaticMillenium

inductive ErrorShape where
  | quantitativeDecay
  | strictMargin
  | semanticMismatch
  | representationObstruction
  | equalityResidual
  | positiveGap
  | exclusionObstruction
  deriving Repr, DecidableEq, BEq

inductive ClosureShape where
  | limitToZero
  | universalCounterexample
  | strictSubcriticalBudget
  | universalRepresentation
  | coupledEqualities
  | uniformPositiveGapAndLimit
  | universalExclusion
  deriving Repr, DecidableEq, BEq

inductive GeometryShape where
  | hilbertProjection
  | computationSemantics
  | pdeVorticityScaling
  | algebraicCycleCohomology
  | ellipticArithmeticGeometry
  | gaugeSpectralContinuum
  | diophantineModular
  deriving Repr, DecidableEq, BEq

inductive ProofShape where
  | explicitApproximationThenLimit
  | diagonalAdversaryThenContradiction
  | identityCancellationBudgetRegularity
  | realizationThenSurjectivity
  | bindDomainThenEqualityThenRefinedIdentity
  | regulatedConstructionUniformGapThenLimit
  | assumeCoprimeThenContradiction
  deriving Repr, DecidableEq, BEq

structure ProblemParameterProfile where
  problem : String
  errorShape : ErrorShape
  closureShape : ClosureShape
  geometryShape : GeometryShape
  proofShape : ProofShape
  errorParameter : String
  closureParameter : String
  geometricParameters : List String
  rigidDifference : String
  deriving Repr, DecidableEq

def rhParameterProfile : ProblemParameterProfile :=
  { problem := "RH"
    errorShape := .quantitativeDecay
    closureShape := .limitToZero
    geometryShape := .hilbertProjection
    proofShape := .explicitApproximationThenLimit
    errorParameter := "DN_N or coefficientEnergy(c_N); target <= K/log(N+2)"
    closureParameter := "DN_N -> 0 / finite-span density"
    geometricParameters := ["L2(0,infinity)", "finite spans V_N", "Gram matrix G_N", "projection P_N"]
    rigidDifference := "analytic zero-distribution content hidden in the asymptotic coefficient/Gram estimate" }

def pnpParameterProfile : ProblemParameterProfile :=
  { problem := "PVSNP"
    errorShape := .semanticMismatch
    closureShape := .universalCounterexample
    geometryShape := .computationSemantics
    proofShape := .diagonalAdversaryThenContradiction
    errorParameter := "timeout OR semantic mismatch CorrectAt(M,x)"
    closureParameter := "forall polynomial-time M, exists same-input x_M where M fails"
    geometricParameters := ["machine state space", "circuit encoding", "tableau/SAT encoding", "self-reference code space"]
    rigidDifference := "discrete semantic diagonalization with polynomial size/clock preservation" }

def nsParameterProfile : ProblemParameterProfile :=
  { problem := "NS"
    errorShape := .strictMargin
    closureShape := .strictSubcriticalBudget
    geometryShape := .pdeVorticityScaling
    proofShape := .identityCancellationBudgetRegularity
    errorParameter := "theta, cBulk, deltaTail, signed stretch; require cBulk+deltaTail<1"
    closureParameter := "uniform signed depletion / subcritical budget"
    geometricParameters := ["vorticity direction xi", "rhoStar", "Campanato radius r", "near/far regions", "Biot-Savart kernel"]
    rigidDifference := "signed PDE cancellation at critical scaling; unsigned estimates are insufficient" }

def hodgeParameterProfile : ProblemParameterProfile :=
  { problem := "HODGE"
    errorShape := .representationObstruction
    closureShape := .universalRepresentation
    geometryShape := .algebraicCycleCohomology
    proofShape := .realizationThenSurjectivity
    errorParameter := "class alpha modulo rational span of algebraic cycle classes"
    closureParameter := "forall X,p,alpha, produce sum_i q_i[Z_i]=alpha"
    geometricParameters := ["smooth projective X", "codimension p", "Hodge class alpha", "cycle-class map", "families/specialization"]
    rigidDifference := "geometric realization of cohomology classes by actual algebraic cycles" }

def bsdParameterProfile : ProblemParameterProfile :=
  { problem := "BSD"
    errorShape := .equalityResidual
    closureShape := .coupledEqualities
    geometryShape := .ellipticArithmeticGeometry
    proofShape := .bindDomainThenEqualityThenRefinedIdentity
    errorParameter := "rank residual ord_{s=1}L-rank(E(Q)); refined leading-coefficient mismatch"
    closureParameter := "rank equality AND refined coefficient identity on the same genuine curve"
    geometricParameters := ["elliptic curve E/Q", "height pairing", "regulator", "Selmer/Sha", "periods", "local reductions"]
    rigidDifference := "two-stage analytic/arithmetic comparison with normalization and same-curve binding" }

def ymParameterProfile : ProblemParameterProfile :=
  { problem := "YM"
    errorShape := .positiveGap
    closureShape := .uniformPositiveGapAndLimit
    geometryShape := .gaugeSpectralContinuum
    proofShape := .regulatedConstructionUniformGapThenLimit
    errorParameter := "regulated spectral gap gamma(a,L), physical ratio gamma(a,L)/a"
    closureParameter := "uniform positive lower bound surviving cutoff/volume and continuum limit"
    geometricParameters := ["lattice/regulator a", "volume L", "gauge measure", "physical Hilbert space", "Hamiltonian", "vacuum/excitation"]
    rigidDifference := "same-construction QFT reconstruction plus cutoff-independent mass gap" }

def bealParameterProfile : ProblemParameterProfile :=
  { problem := "BEAL"
    errorShape := .exclusionObstruction
    closureShape := .universalExclusion
    geometryShape := .diophantineModular
    proofShape := .assumeCoprimeThenContradiction
    errorParameter := "gcd(a,b,c)=1 as forbidden residual branch"
    closureParameter := "forall BealData, gcd(a,b,c)>1 / CommonPrime"
    geometricParameters := ["exponents x,y,z", "valuations", "local primes", "Frey-type curve", "conductor/newform data"]
    rigidDifference := "uniform elimination of every admissible coprime generalized-Fermat solution" }

def allParameterProfiles : List ProblemParameterProfile :=
  [rhParameterProfile, pnpParameterProfile, nsParameterProfile,
   hodgeParameterProfile, bsdParameterProfile, ymParameterProfile,
   bealParameterProfile]

structure SharedParameterFamily where
  name : String
  members : List String
  sharedMechanism : String
  nonsharedRigidPart : String
  deriving Repr, DecidableEq

def quantitativeLimitFamily : SharedParameterFamily :=
  { name := "QUANTITATIVE_LIMIT"
    members := ["RH", "NS", "YM"]
    sharedMechanism :=
      "finite/local/regulator-scale control must carry a strict quantitative margin uniformly to an asymptotic/global/continuum endpoint"
    nonsharedRigidPart :=
      "RH uses Hilbert approximation decay; NS uses signed PDE depletion; YM uses a spectral gap and QFT continuum reconstruction" }

def realizationFamily : SharedParameterFamily :=
  { name := "REALIZATION"
    members := ["HODGE", "PVSNP", "YM"]
    sharedMechanism :=
      "an abstract/semantic object must be realized by one admissible concrete object before the endpoint bridge can fire"
    nonsharedRigidPart :=
      "cycle realization, finite-machine realization, and physical Hilbert/gauge realization are different semantics" }

def arithmeticIdentityFamily : SharedParameterFamily :=
  { name := "ARITHMETIC_IDENTITY_EXCLUSION"
    members := ["BSD", "BEAL"]
    sharedMechanism :=
      "global arithmetic conclusion is reached only after local/global arithmetic data are bound to one genuine object"
    nonsharedRigidPart :=
      "BSD proves coupled equalities for elliptic curves; Beal excludes every coprime exponential Diophantine solution" }

def analyticArithmeticFamily : SharedParameterFamily :=
  { name := "ANALYTIC_ARITHMETIC"
    members := ["RH", "BSD"]
    sharedMechanism :=
      "analytic data are converted into a rigid arithmetic/structural endpoint through a normalization-sensitive bridge"
    nonsharedRigidPart :=
      "RH is zero-distribution via approximation; BSD is L-function order/leading coefficient versus curve arithmetic" }

def negativeKnowledgeFamily : SharedParameterFamily :=
  { name := "FALSIFICATION_FIREWALL"
    members := ["PVSNP", "NS"]
    sharedMechanism :=
      "a formally falsified intermediate route is preserved as negative knowledge and replaced without reopening it"
    nonsharedRigidPart :=
      "P02 falsifies a literal self-reference formulation; NS falsifies an amplitude-invariant fixed-delta route" }

def sharedParameterFamilies : List SharedParameterFamily :=
  [quantitativeLimitFamily, realizationFamily, arithmeticIdentityFamily,
   analyticArithmeticFamily, negativeKnowledgeFamily]

theorem parameter_profile_count :
    allParameterProfiles.length = 7 := by
  decide

theorem shared_parameter_family_count :
    sharedParameterFamilies.length = 5 := by
  decide

end AxiomaticMillenium
