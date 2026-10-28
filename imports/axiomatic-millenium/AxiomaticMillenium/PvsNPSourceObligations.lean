import AxiomaticMillenium.SourceBinding
import AxiomaticMillenium.OpenObligation

namespace AxiomaticMillenium

/-- Exact P01 source statement recovered from the EGC-hardening lane.
This binds provenance/hash only; it does not import or prove the proposition. -/
def pvsnpP01FrozenSourceBinding : FrozenSourceBinding :=
  { id := "P01ConstructionGap"
    repository := "ShantiDraconis/m-core-p-vs-np"
    commit := "7744deb4dbdf03073441beabc6e3027825d7b3ef"
    path := "lean/MCore/Hardening/P01StatementFrozen.lean"
    declaration := "MCore.Hardening.P01StatementFrozen.Statement"
    canonicalText := "Nonempty MCore.Real.P01FinalCertificate.P01MachineConstruction"
    statementHash := "sha256:da4ad11e047a06464bdfb4add0697fa5dd98e3c7e0432d75d821c4fafbe98b20"
    buildRun := 36233335511
    buildTarget := "MCore.Hardening.P01StatementFrozen" }


/-- P01 is referenced upstream but currently has no Lean declaration.
This object is intentionally not an OpenObligation because there is no exact
Prop to search for yet. -/
def pvsnpP01SourceStatementObligation : SourceStatementObligation :=
  { id := "P01ConstructionGap"
    source := "ShantiDraconis/millennium-p-vs-np-I@0dd4e68213b62c24a57b794265b8cf6a9702ff2b:evidence/endpoint_states.json"
    requiredStatement := "Exact Lean Prop/type for P01ConstructionGap and primitive P01MachineConstruction"
    provenance := "endpoint_states.json reports declarations=[]; final-proof/endpoints.json references the names only" }

/-- P02 is likewise only a commented scaffold signature upstream; the named
types are not declared in the current source tree. -/
def pvsnpP02SourceStatementObligation : SourceStatementObligation :=
  { id := "P02Target"
    source := "ShantiDraconis/millennium-p-vs-np-I@0dd4e68213b62c24a57b794265b8cf6a9702ff2b:FinalProof/OpenMathScaffold.lean"
    requiredStatement := "Exact Lean declarations for TotalVariableCoverageObligationNorm and P02Target_G21"
    provenance := "OpenMathScaffold.lean states these signatures only inside a FAIL-CLOSED comment; endpoint_states.json reports declarations=[]" }

/-- The endpoint shape exists upstream, but remains abstract until a concrete
official-model match fixes the language and official P/NP predicates. -/
def pvsnpConcreteRootInstantiationObligation : SourceStatementObligation :=
  { id := "ConcreteOfficialModel"
    source := "ShantiDraconis/m-core-p-vs-np@0c423c3062d2bce8278c313a0dcf820a7084bb2d:audit/FinalEndpoint.lean"
    requiredStatement := "Concrete official Turing-machine Language, P and NP predicates plus a proved OfficialModelMatch to ClassicalComplexityInterface"
    provenance := "FINAL_STATEMENT_for_interface is explicitly abstract; audit/repro_PNP.lean keeps OfficialModelMatch as a premise" }

end AxiomaticMillenium
