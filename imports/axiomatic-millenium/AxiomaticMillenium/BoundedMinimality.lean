import AxiomaticMillenium.PvsNPRootContract

namespace AxiomaticMillenium

/-- Bounded graph-search minimality is deliberately weaker than semantic
minimality.  It records what a finite dependency search checked; it does not
claim that no smaller set of propositions could imply the root in logic. -/
structure BoundedGraphMinimality where
  frontier : CanonicalFrontier
  searchBound : Nat
  checkedProperSubsets : Nat
  graphFingerprint : String
  noSmallerFound : Bool

/-- The current three P-vs-NP frontier atoms have a deterministic canonical
order by AtomKey. -/
def pvsnpCanonicalFrontier : CanonicalFrontier :=
  { atoms := pvsnpCandidateFrontier.atoms
    nodup := pvsnpCandidateFrontier.nodup
    ordered := by
      simp [pvsnpCandidateFrontier, pvsnpP01Key, pvsnpP02Key,
        pvsnpExternalModelKey] }

/-- At the current meta-level all three frontier atoms are terminal:
P01/P02 lack exact source statements and ExternalModelMatch is itself the
formal open obligation.  No recursive reduction is asserted here. -/
def pvsnpTerminalReductionGraph : ReductionGraph :=
  { children := fun _ => []
    childrenNodup := by
      intro a
      simp
    rank := fun _ => 0
    decreases := by
      intro parent child h
      simp at h }

/-- Canonical reduced frontier for the current source state. -/
def pvsnpReducedFrontier : ReducedFrontier :=
  { frontier := pvsnpCandidateFrontier
    reductions := pvsnpTerminalReductionGraph
    terminal := by
      intro a ha
      rfl }

/-- Machine-search metadata only.  The actual bounded-search result is
generated and checked by root_minimality_search.py. -/
def pvsnpBoundedMinimalityMetadata : BoundedGraphMinimality :=
  { frontier := pvsnpCanonicalFrontier
    searchBound := 2
    checkedProperSubsets := 7
    graphFingerprint := "PVSNP-FRONTIER-ALL-REQUIRED-v1"
    noSmallerFound := true }

end AxiomaticMillenium
