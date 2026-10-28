import FormalSuite.I.Universal.Laws

namespace FormalSuite.I.Universal

/-- Major application domains for possible Fundamental-I bridges.
Membership in this list does not assert that a bridge is true. -/
inductive ApplicationDomain where
  | mathematics
  | physics
  | chemistry
  | biology
  | neuroscience
  | medicine
  | engineering
  | computerScience
  | informationTheory
  | astronomy
  | cosmology
  | geology
  | materialsScience
  | economics
  | socialScience
  | psychology
  | history
  | linguistics
  | philosophy
  | religion
  | arts
  | law
  | education
deriving DecidableEq, Repr

inductive BridgeStatus where
  | open
  | structured
  | validated
  | falsified
deriving DecidableEq, Repr

/-- A bridge is an explicitly typed research obligation.
No proposition about the external domain is assumed merely by constructing one. -/
structure DomainBridge where
  domain : ApplicationDomain
  name : String
  status : BridgeStatus
  mathematicalSource : String
  targetSemantics : String
  requiredEvidence : List String
deriving Repr

def openBridge (d : ApplicationDomain) (name source target : String)
    (evidence : List String) : DomainBridge :=
  { domain := d
    name := name
    status := .open
    mathematicalSource := source
    targetSemantics := target
    requiredEvidence := evidence }

/-- Canonical fail-closed bridge registry. Every entry starts OPEN. -/
def fundamentalIBridges : List DomainBridge := [
  openBridge .mathematics "I-Mathematics" "FundamentalIClaim"
    "new mathematical structures beyond the certified core"
    ["explicit definitions", "kernel proof", "axiom audit"],
  openBridge .physics "I-Physics" "FundamentalIClaim"
    "physical observables and dynamics"
    ["action or equations of motion", "dimensional consistency", "measurable predictions"],
  openBridge .chemistry "I-Chemistry" "FundamentalIClaim"
    "chemical states, kinetics, or bonding"
    ["chemical model", "quantitative predictions", "comparison with established chemistry"],
  openBridge .biology "I-Biology" "FundamentalIClaim"
    "biological mechanisms"
    ["mechanistic mapping", "measurable phenotype", "experimental discrimination"],
  openBridge .neuroscience "I-Neuroscience" "FundamentalIClaim"
    "neural or cognitive observables"
    ["neural mapping", "measurement protocol", "falsifiable prediction"],
  openBridge .medicine "I-Medicine" "FundamentalIClaim"
    "clinical or biomedical effects"
    ["biological mechanism", "safety evidence", "clinical validation"],
  openBridge .engineering "I-Engineering" "FundamentalIClaim"
    "engineered systems and control"
    ["system model", "performance metric", "reproducible implementation"],
  openBridge .computerScience "I-ComputerScience" "FundamentalIClaim"
    "algorithms, computation, or formal systems"
    ["formal semantics", "algorithm", "complexity/correctness proof"],
  openBridge .informationTheory "I-InformationTheory" "informationNonCollapse"
    "coding, entropy, or information refinement"
    ["operational information measure", "coding theorem or bound", "comparison baseline"],
  openBridge .astronomy "I-Astronomy" "FundamentalIClaim"
    "astronomical observables"
    ["observable mapping", "dataset", "statistical test"],
  openBridge .cosmology "I-Cosmology" "FundamentalIClaim"
    "cosmological dynamics or dark sector"
    ["stress-energy or equivalent", "background dynamics", "perturbations/observables", "data comparison"],
  openBridge .geology "I-Geology" "FundamentalIClaim"
    "geophysical or geological processes"
    ["process model", "field/lab observables", "comparative prediction"],
  openBridge .materialsScience "I-Materials" "FundamentalIClaim"
    "material properties"
    ["constitutive model", "measured property", "reproducible experiment"],
  openBridge .economics "I-Economics" "FundamentalIClaim"
    "economic dynamics"
    ["economic variables", "identified model", "out-of-sample test"],
  openBridge .socialScience "I-SocialScience" "FundamentalIClaim"
    "social phenomena"
    ["operational variables", "causal/statistical design", "replication"],
  openBridge .psychology "I-Psychology" "FundamentalIClaim"
    "behavioral or cognitive phenomena"
    ["operationalization", "experimental design", "replication"],
  openBridge .history "I-History" "FundamentalIClaim"
    "historical interpretation"
    ["primary sources", "methodological rule", "comparison with alternative explanations"],
  openBridge .linguistics "I-Linguistics" "FundamentalIClaim"
    "language structure or change"
    ["formal linguistic mapping", "corpus evidence", "predictive distinction"],
  openBridge .philosophy "I-Philosophy" "FundamentalIClaim"
    "metaphysical or epistemic interpretation"
    ["explicit argument", "defined terms", "separation from empirical claims"],
  openBridge .religion "I-Religion" "FundamentalIClaim"
    "theological or comparative-religion interpretation"
    ["tradition-specific sources", "hermeneutic method", "no conversion of faith claim into mathematical theorem"],
  openBridge .arts "I-Arts" "FundamentalIClaim"
    "aesthetic or generative interpretation"
    ["declared interpretation", "artifact or method", "no empirical overclaim"],
  openBridge .law "I-Law" "FundamentalIClaim"
    "legal reasoning or doctrine"
    ["jurisdiction", "authoritative sources", "legal argument"],
  openBridge .education "I-Education" "FundamentalIClaim"
    "learning or pedagogy"
    ["learning objective", "assessment metric", "controlled evaluation"]
]

theorem all_registered_bridges_start_open :
    ∀ b ∈ fundamentalIBridges, b.status = .open := by
  intro b hb
  simp [fundamentalIBridges, openBridge] at hb ⊢
  rcases hb with rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl |
    rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl <;> rfl

end FormalSuite.I.Universal
