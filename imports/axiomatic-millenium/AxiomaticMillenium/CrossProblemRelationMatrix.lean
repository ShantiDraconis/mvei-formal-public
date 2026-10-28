import AxiomaticMillenium.RefinedAttackFrontier

namespace AxiomaticMillenium

inductive RelationKind where
  | endpointOnly
  | producerEndpoint
  | realizationCore
  | globalizationCore
  | falsificationCore
  | normalizationEndpoint
  deriving Repr, DecidableEq, BEq

structure PairRelation where
  left : String
  right : String
  sharedPatterns : List Pattern
  weightedSimilarityPermille : Nat
  kind : RelationKind
  transferOperatorVerified : Bool
  note : String
  deriving Repr, DecidableEq

/--
Seven-problem matrix.  P vs NP is aggregated from its P01 and P02/G21 lanes.
Scores are weighted Jaccard values x10, so 737 means 73.7%.
They measure verified obstruction-shape overlap only.
-/
def crossProblemRelations : List PairRelation :=
  [
    { left := "RH", right := "BEAL", sharedPatterns := [.B],
      weightedSimilarityPermille := 750, kind := .endpointOnly,
      transferOperatorVerified := false,
      note := "high score is caused by sparse signatures; no mathematical transfer is certified" },
    { left := "RH", right := "HODGE", sharedPatterns := [.B],
      weightedSimilarityPermille := 214, kind := .endpointOnly,
      transferOperatorVerified := false, note := "shared terminal bridge only" },
    { left := "RH", right := "YM", sharedPatterns := [.B],
      weightedSimilarityPermille := 125, kind := .endpointOnly,
      transferOperatorVerified := false, note := "shared terminal bridge only" },
    { left := "RH", right := "PVSNP", sharedPatterns := [.B],
      weightedSimilarityPermille := 158, kind := .endpointOnly,
      transferOperatorVerified := false, note := "shared terminal bridge only" },
    { left := "RH", right := "BSD", sharedPatterns := [.B],
      weightedSimilarityPermille := 375, kind := .endpointOnly,
      transferOperatorVerified := false,
      note := "analytic/arithmetic analogy is not yet a verified operator" },
    { left := "RH", right := "NS", sharedPatterns := [.B],
      weightedSimilarityPermille := 167, kind := .endpointOnly,
      transferOperatorVerified := false, note := "shared terminal bridge only" },

    { left := "BEAL", right := "HODGE", sharedPatterns := [.U, .B],
      weightedSimilarityPermille := 286, kind := .producerEndpoint,
      transferOperatorVerified := false, note := "both require a genuine material witness plus endpoint bridge" },
    { left := "BEAL", right := "YM", sharedPatterns := [.U, .B],
      weightedSimilarityPermille := 167, kind := .producerEndpoint,
      transferOperatorVerified := false, note := "producer shape only" },
    { left := "BEAL", right := "PVSNP", sharedPatterns := [.U, .B],
      weightedSimilarityPermille := 211, kind := .producerEndpoint,
      transferOperatorVerified := false, note := "producer shape only" },
    { left := "BEAL", right := "BSD", sharedPatterns := [.B],
      weightedSimilarityPermille := 333, kind := .endpointOnly,
      transferOperatorVerified := false, note := "arithmetic subject matter does not instantiate a transfer operator" },
    { left := "BEAL", right := "NS", sharedPatterns := [.B],
      weightedSimilarityPermille := 158, kind := .endpointOnly,
      transferOperatorVerified := false, note := "shared terminal bridge only" },

    { left := "HODGE", right := "YM", sharedPatterns := [.U, .B, .R],
      weightedSimilarityPermille := 583, kind := .realizationCore,
      transferOperatorVerified := false,
      note := "shared producer-realization-endpoint spine; YM additionally requires globalization" },
    { left := "HODGE", right := "PVSNP", sharedPatterns := [.U, .B, .R],
      weightedSimilarityPermille := 737, kind := .realizationCore,
      transferOperatorVerified := false,
      note := "strongest nontrivial verified common core; objects and semantics remain different" },
    { left := "HODGE", right := "BSD", sharedPatterns := [.B],
      weightedSimilarityPermille := 158, kind := .endpointOnly,
      transferOperatorVerified := false, note := "geometric relations are domain analogies, not verified transfer" },
    { left := "HODGE", right := "NS", sharedPatterns := [.B],
      weightedSimilarityPermille := 103, kind := .endpointOnly,
      transferOperatorVerified := false, note := "shared terminal bridge only" },

    { left := "YM", right := "PVSNP", sharedPatterns := [.U, .B, .R],
      weightedSimilarityPermille := 483, kind := .realizationCore,
      transferOperatorVerified := false,
      note := "both require concrete realization; YM additionally requires continuum/global control" },
    { left := "YM", right := "BSD", sharedPatterns := [.B],
      weightedSimilarityPermille := 103, kind := .endpointOnly,
      transferOperatorVerified := false, note := "shared terminal bridge only" },
    { left := "YM", right := "NS", sharedPatterns := [.B, .C],
      weightedSimilarityPermille := 448, kind := .globalizationCore,
      transferOperatorVerified := false,
      note := "strong shared local/regulator-to-global mechanism; concrete operator still missing" },

    { left := "PVSNP", right := "BSD", sharedPatterns := [.B],
      weightedSimilarityPermille := 125, kind := .endpointOnly,
      transferOperatorVerified := false, note := "shared terminal bridge only" },
    { left := "PVSNP", right := "NS", sharedPatterns := [.B, .F],
      weightedSimilarityPermille := 276, kind := .falsificationCore,
      transferOperatorVerified := false,
      note := "both preserve negative route knowledge via firewalls; positive producers are unrelated" },

    { left := "BSD", right := "NS", sharedPatterns := [.B],
      weightedSimilarityPermille := 130, kind := .endpointOnly,
      transferOperatorVerified := false, note := "shared terminal bridge only" }
  ]

def strongStructuralRelations : List PairRelation :=
  crossProblemRelations.filter
    (fun r => r.weightedSimilarityPermille >= 400)

def verifiedTransferRelationCount : Nat :=
  crossProblemRelations.foldl
    (fun n r => if r.transferOperatorVerified then n + 1 else n) 0

theorem relation_matrix_pair_count :
    crossProblemRelations.length = 21 := by
  decide

theorem strong_relation_count :
    strongStructuralRelations.length = 5 := by
  decide

theorem no_verified_cross_problem_transfer_operator :
    verifiedTransferRelationCount = 0 := by
  decide

end AxiomaticMillenium
