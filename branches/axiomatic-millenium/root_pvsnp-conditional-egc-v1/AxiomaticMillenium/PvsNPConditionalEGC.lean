import AxiomaticMillenium.PvsNPRootSchema

namespace AxiomaticMillenium

/-- Kernel-checked conditional root term. It proves the P-vs-NP separation
root shape only from the three explicit frontier atoms and the explicit
closure witness. No P-vs-NP solution is claimed unless these premises are
independently inhabited. -/
theorem pvsnpConditionalEGCTerm
    (M : PvsNPOfficialModel)
    (I : PvsNPFrontierInputs)
    (W : PvsNPClosureWitness M I)
    (hp01 : I.p01)
    (hp02 : I.p02)
    (hext : I.externalModelMatch) :
    pvsnpSeparationStatement M :=
  W.compose hp01 hp02 hext

end AxiomaticMillenium
