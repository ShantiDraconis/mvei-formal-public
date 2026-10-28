namespace AxiomaticMillenium

/-- Provenance for an exact external Lean statement.
This is metadata only: it does not inhabit the referenced proposition locally. -/
structure FrozenSourceBinding where
  id : String
  repository : String
  commit : String
  path : String
  declaration : String
  canonicalText : String
  statementHash : String
  buildRun : Nat
  buildTarget : String
  deriving Repr, DecidableEq

end AxiomaticMillenium
