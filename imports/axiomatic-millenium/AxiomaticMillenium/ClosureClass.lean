namespace AxiomaticMillenium

/-- Closed cross-domain closure-class vocabulary.
Adding a constructor is a deliberate schema change. -/
inductive ClosureClass where
  | realization
  | uniformization
  | localToGlobal
  | canonicalIdentification
  | preservation
  | invariance
  | endpointBridge
  deriving Repr, DecidableEq, BEq

end AxiomaticMillenium
