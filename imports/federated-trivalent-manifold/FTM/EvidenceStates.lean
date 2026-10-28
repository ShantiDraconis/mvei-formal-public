/-!
# Scientific evidence and epistemic states

Truth of a mathematical proposition is separated from the status of empirical
evidence and from the status of a bridge connecting the two.
-/

namespace FTM.Evidence

inductive Domain
  | mathematical | atomic | cosmological | biochemical | computational
deriving Repr, DecidableEq

/-- Logical/semantic status of a precisely stated claim. -/
inductive TruthStatus
  | proved
  | refuted
  | open
  | independentOfAxioms
  | inconsistentPremises
  | illPosed
  | outOfDomain
deriving Repr, DecidableEq

/-- Lifecycle status of a scientific datum or interpretation. -/
inductive EvidenceStatus
  | raw
  | calibrated
  | replicated
  | curated
  | inferred
  | predicted
  | disputed
  | retracted
  | superseded
  | censored
deriving Repr, DecidableEq

inductive EvidenceMode
  | deductiveProof
  | counterexample
  | controlledExperiment
  | observation
  | simulation
  | statisticalInference
  | databaseCuration
  | expertJudgment
deriving Repr, DecidableEq

inductive NumericClass
  | exactInteger
  | exactRational
  | algebraicNumber
  | floatingPoint
  | realInterval
  | complexInterval
  | measurementWithUncertainty
  | upperLimit
  | lowerLimit
  | censoredValue
  | probabilityDistribution
  | posteriorSamples
  | categorical
  | finiteSequence
  | graph
  | tensor
deriving Repr, DecidableEq

inductive OperatorKind
  | calibration
  | unitConversion
  | normalization
  | uncertaintyPropagation
  | covarianceAdjustment
  | filtering
  | FourierTransform
  | spectralDecomposition
  | coarseGraining
  | renormalization
  | BayesianUpdate
  | hypothesisTest
  | modelSelection
  | causalIntervention
  | sequenceAlignment
  | structureSuperposition
  | graphReduction
  | homology
  | cohomology
  | functorialMap
deriving Repr, DecidableEq

structure Provenance where
  source : String
  version : String
  retrievedAt : String
  method : String
  license : String
deriving Repr, DecidableEq

structure Quantity where
  name : String
  canonicalValue : String
  unit : String
  uncertainty : Option String
  numericClass : NumericClass
  provenance : Provenance
deriving Repr, DecidableEq

structure ScientificClaim where
  id : String
  domain : Domain
  statement : String
  truth : TruthStatus
  evidence : EvidenceStatus
  mode : EvidenceMode
deriving Repr, DecidableEq

/-- A bridge is the only sanctioned route from empirical data to a formal
    mathematical target.  A bridge proof must establish that the data/model
    semantics imply the target statement; analogy is not enough. -/
structure BridgeAudit where
  sourceValidated : Bool
  unitsChecked : Bool
  uncertaintyPropagated : Bool
  modelIdentifiable : Bool
  semanticsPreserved : Bool
  reductionProved : Bool
deriving Repr, DecidableEq

def BridgeAudit.establishesTarget (a : BridgeAudit) : Bool :=
  a.sourceValidated && (a.unitsChecked && (a.uncertaintyPropagated &&
  (a.modelIdentifiable && (a.semanticsPreserved && a.reductionProved))))

theorem no_reduction_no_mathematical_proof (a : BridgeAudit)
    (h : a.reductionProved = false) : a.establishesTarget = false := by
  simp [BridgeAudit.establishesTarget, h]

theorem analogy_alone_is_insufficient :
    (BridgeAudit.mk true true true true false false).establishesTarget = false := by
  decide

/-- Three headline states are not exhaustive. -/
def headlineStates : List TruthStatus :=
  [.proved, .refuted, .open]

def extendedStates : List TruthStatus :=
  [.proved, .refuted, .open, .independentOfAxioms,
   .inconsistentPremises, .illPosed, .outOfDomain]

end FTM.Evidence
