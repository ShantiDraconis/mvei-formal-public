import AxiomaticMillenium.GlobalOpenMathCut

namespace AxiomaticMillenium

inductive MaterializerClass where
  | exactProducer
  | strongerThanTarget
  | sufficientReduction
  | specialCase
  | evidenceOnly
  | falsifiedRoute
  | noProducer
  deriving Repr, DecidableEq, BEq

inductive InhabitantStatus where
  | inhabited
  | candidateUnverified
  | absent
  | refuted
  deriving Repr, DecidableEq, BEq

structure MaterializerMiningRecord where
  lane : String
  target : String
  classification : MaterializerClass
  inhabitant : InhabitantStatus
  sourceRepo : String
  sourceRef : String
  sourcePath : String
  residual : String
  deriving Repr, DecidableEq

def rhMaterializer : MaterializerMiningRecord :=
  { lane := "RH"
    target := "LogMajorantCertificate: exists K>=0, forall N, DN N <= K/log(N+2)"
    classification := .exactProducer
    inhabitant := .absent
    sourceRepo := "ShantiDraconis/m-core-riemann"
    sourceRef := "atk/rh-log-majorant-split-20261001"
    sourcePath := "lean/MCore/RH/NB/SplitLogMajorantProducer.lean"
    residual := "construct primary DN<=C1/log+R and residual R<=C2/log; K=C1+C2 then closes the exact log majorant" }

def p02Materializer : MaterializerMiningRecord :=
  { lane := "P02"
    target := "UniversalCounterexampleProducer / UniversalFailure canonical SAT"
    classification := .exactProducer
    inhabitant := .absent
    sourceRepo := "ShantiDraconis/m-core-p-vs-np"
    sourceRef := "atk/p02-consolidated-kernel-20261001"
    sourcePath := "lean/MCore/Real/P02UniversalFailureMinCut.lean"
    residual := "for every PolyDTMCandidate construct one canonical SAT input with timeout or semantic mismatch" }

def nsMaterializer : MaterializerMiningRecord :=
  { lane := "NS"
    target := "ActualNSToSignedGainCore"
    classification := .sufficientReduction
    inhabitant := .absent
    sourceRepo := "ShantiDraconis/navier-stokes-critical-barrier-audit"
    sourceRef := "atk/ns-bulk-tail-material-producer-20261001"
    sourcePath := "audit/producer-first/ActualNSBulkTailProducer.lean"
    residual := "inhabit ActualNSBulkTailProducer from genuine PDE: universal cBulk,deltaTail, split, BulkAbsorption, ExceptionalTailControl, and subcritical budget" }

def hodgeMaterializer : MaterializerMiningRecord :=
  { lane := "HODGE"
    target := "ConcreteHodgeMaterialTarget / ConcreteAlgebraicityPayload"
    classification := .sufficientReduction
    inhabitant := .absent
    sourceRepo := "ShantiDraconis/m-core-hodge"
    sourceRef := "atk/hodge-material-target-hardening-20261001"
    sourcePath := "lean/MCore/BackwardAudit/H01UniversalMaterialProducer.lean"
    residual := "construct H01MinimalForwardPayload pointwise for every X,p,alpha; existing theorem only consumes it" }

def bsdMaterializer : MaterializerMiningRecord :=
  { lane := "BSD"
    target := "GroundedBSDHabitant on one genuine elliptic-curve carrier"
    classification := .exactProducer
    inhabitant := .absent
    sourceRepo := "ShantiDraconis/m-core-bsd"
    sourceRef := "atk/bsd-grounded-habitant"
    sourcePath := "lean/MCore/GroundedBSDHabitant.lean"
    residual := "same-curve analytic rank = algebraic rank, positive finite Sha witness, and refined leading identity" }

def ymMaterializer : MaterializerMiningRecord :=
  { lane := "YM"
    target := "B60FieldBundle / B60ConcretePhysicalAdapter"
    classification := .sufficientReduction
    inhabitant := .absent
    sourceRepo := "ShantiDraconis/m-core-yang-mills"
    sourceRef := "atk/ym-b60-field-bundle-20261001"
    sourcePath := "lean/MCore/YangMills/A1/B60FieldBundle.lean"
    residual := "supply same-construction physical maps, K23 construction, K25 uniform clustering, K27 uniform gap+limit witness, excitation and K30 transfer witness" }

def bealMaterializer : MaterializerMiningRecord :=
  { lane := "BEAL"
    target := "BealUniversalCommonPrimeCertificate / GCDLowerBoundProducer"
    classification := .exactProducer
    inhabitant := .absent
    sourceRepo := "ShantiDraconis/m-core-beal"
    sourceRef := "cert/beal-final-math-chain-213c5dc1"
    sourcePath := "lean/MCore/BealFinalMathematicalChain.lean"
    residual := "construct universal CommonPrime witness for every BealData; B01/B02 do not manufacture endpoint" }



def p02BoundedSameInputFalsified : MaterializerMiningRecord :=
  { lane := "P02-BOUNDED-SAME-INPUT"
    target := "UniformBoundedSameInputProducer"
    classification := .falsifiedRoute
    inhabitant := .refuted
    sourceRepo := "ShantiDraconis/m-core-p-vs-np"
    sourceRef := "frozen/p02-bounded-same-input-falsified-e78e171e"
    sourcePath := "certificates/P02_BOUNDED_SAME_INPUT_RED_FROZEN.md"
    residual := "formally refuted by strict-growth obstruction; kernel CI run 35930277832 succeeded" }

def p02SemanticAlignmentFalsified : MaterializerMiningRecord :=
  { lane := "P02-SEMANTIC-ALIGNMENT"
    target := "SemanticAlignmentCore"
    classification := .falsifiedRoute
    inhabitant := .refuted
    sourceRepo := "ShantiDraconis/m-core-p-vs-np"
    sourceRef := "frozen/p02-semantic-alignment-countermodel-green-af7ae1de"
    sourcePath := "lean/MCore/Real/P02SemanticAlignmentCountermodel.lean"
    residual := "4-state discriminator candidate refutes weakened alignment route; do not reopen" }



def p02TwoSidedOrientation : MaterializerMiningRecord :=
  { lane := "P02-TWO-SIDED"
    target := "UniversalFailure(CanonicalSAT) OR InP(CanonicalSAT)"
    classification := .exactProducer
    inhabitant := .candidateUnverified
    sourceRepo := "ShantiDraconis/m-core-p-vs-np"
    sourceRef := "atk/p02-two-sided-orientation-20261001"
    sourcePath := "lean/MCore/Real/P02TwoSidedOrientation.lean"
    residual := "lowerBound branch closes PneqNP using recovered P01; polynomial branch exposes PolyDTMRealization SAT; SAT-in-P to global equality still needs canonical NP-completeness transfer" }



def pnpEqualityBranchMinCut : MaterializerMiningRecord :=
  { lane := "PNP-EQUALITY-BRANCH"
    target := "CanonicalSATCompletenessTransfer"
    classification := .exactProducer
    inhabitant := .absent
    sourceRepo := "ShantiDraconis/m-core-p-vs-np"
    sourceRef := "atk/pnp-equality-branch-mincut-20261001"
    sourcePath := "lean/MCore/Real/PNPEqualityBranchMinCut.lean"
    residual := "formalize same-model NP-completeness transfer: InP(CanonicalSAT) -> forall L, InNP L -> InP L; then P=NP branch closes" }

def p01RecoveredCandidate : MaterializerMiningRecord :=
  { lane := "P01"
    target := "P01ConstructionGap / canonical SAT in NP"
    classification := .exactProducer
    inhabitant := .candidateUnverified
    sourceRepo := "ShantiDraconis/m-core-p-vs-np"
    sourceRef := "atk/p01-post-mincut-advance-20261001"
    sourcePath := "lean/MCore/Real/P01RawTotalizationProducer.lean"
    residual := "branch contains rawDecodeNoneFailClosedProducer and p01ConstructionGap_closed; full branch CI status not independently verified here" }

def materializerMiningLedger : List MaterializerMiningRecord :=
  [rhMaterializer, p01RecoveredCandidate, p02Materializer, nsMaterializer,
   hodgeMaterializer, bsdMaterializer, ymMaterializer, bealMaterializer]

def inhabitedCount : Nat :=
  materializerMiningLedger.foldl
    (fun n r => if r.inhabitant == .inhabited then n + 1 else n) 0

def candidateCount : Nat :=
  materializerMiningLedger.foldl
    (fun n r => if r.inhabitant == .candidateUnverified then n + 1 else n) 0

def absentCount : Nat :=
  materializerMiningLedger.foldl
    (fun n r => if r.inhabitant == .absent then n + 1 else n) 0

theorem mining_ledger_has_eight_records :
    materializerMiningLedger.length = 8 := by
  decide

theorem mining_ledger_verified_inhabited_zero :
    inhabitedCount = 0 := by
  decide

theorem mining_ledger_candidate_one :
    candidateCount = 1 := by
  decide

theorem mining_ledger_absent_seven :
    absentCount = 7 := by
  decide

end AxiomaticMillenium
