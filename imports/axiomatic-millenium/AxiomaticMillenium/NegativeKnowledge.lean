namespace AxiomaticMillenium

inductive ReplacementStatus where
  | none
  | candidate
  | proven
  deriving Repr, DecidableEq, BEq

structure Replacement where
  statement : Prop
  routeId : String

/-- Negative knowledge is a proof of negation plus a typed replacement state. -/
structure NegativeRecord where
  statement : Prop
  refutation : ¬ statement
  replacement : Option Replacement
  replacementStatus : ReplacementStatus

theorem negative_route_never_reopens (r : NegativeRecord) : ¬ r.statement :=
  r.refutation

end AxiomaticMillenium
