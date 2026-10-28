namespace AxiomaticMillenium

/-- Generated proof skeleton: exact target type only, never a fabricated body. -/
structure OpenObligation where
  id : String
  target : Prop
  source : String

/-- Source-level blocker: the intended mathematical object is named upstream,
but no exact Lean Prop has been supplied yet.  This cannot enter proof search. -/
structure SourceStatementObligation where
  id : String
  source : String
  requiredStatement : String
  provenance : String

/-- A proof candidate exists only when a real term inhabits the exact target. -/
structure ProofCandidate (o : OpenObligation) where
  term : o.target
  theoremName : Name

end AxiomaticMillenium
