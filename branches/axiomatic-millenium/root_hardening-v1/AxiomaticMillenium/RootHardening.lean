import AxiomaticMillenium.RootContract

namespace AxiomaticMillenium

/-- A frozen root must carry a nonzero declared hash and an explicit hash scheme.
This audits the metadata contract without pretending that Lean kernel reduction
itself computes an Expr hash in ordinary theorem code. -/
structure FrozenRootAudit (r : FrozenRoot) where
  statusFrozen : r.hashStatus = .frozen
  hashNonzero : r.statementHash ≠ 0
  schemeInstantiated : r.hashScheme ≠ "UNINSTANTIATED"

/-- Reduced frontier with deterministic ordering by AtomKey.
ReductionGraph.rank/decreases already gives well-founded acyclicity. -/
structure CanonicalReducedFrontier where
  frontier : CanonicalFrontier
  reductions : ReductionGraph
  terminal : ∀ a, a ∈ frontier.atoms → reductions.children a = []

theorem canonical_reduced_frontier_nodup
    (f : CanonicalReducedFrontier) :
    f.frontier.atoms.Nodup :=
  f.frontier.nodup

/-- A bounded-search certificate.
The executable search is represented by [candidates] and [closes].
Soundness is fail-closed: a Boolean rejection must carry a theorem that the
candidate cannot imply the root. [enumerationComplete] is what upgrades
"no candidate found" into "no smaller candidate exists within the bound". -/
structure BoundedMinimalitySearch
    (C : RootContract)
    (target : Frontier) where
  candidates : List (List AtomKey)
  searchBound : Nat
  closes : List AtomKey → Bool
  enumerationComplete :
    ∀ s : List AtomKey,
      s.Nodup →
      s.length < target.atoms.length →
      s.length ≤ searchBound →
      s ∈ candidates
  rejected :
    ∀ s,
      s ∈ candidates →
      closes s = false
  rejectionSound :
    ∀ s,
      closes s = false →
      s.Nodup →
      ¬ ((∀ a, a ∈ s → C.atomSpace.term a) → C.root.statement)

theorem bounded_search_no_smaller
    {C : RootContract}
    {target : Frontier}
    (S : BoundedMinimalitySearch C target) :
    ∀ s : List AtomKey,
      s.Nodup →
      s.length < target.atoms.length →
      s.length ≤ S.searchBound →
      ¬ ((∀ a, a ∈ s → C.atomSpace.term a) → C.root.statement) := by
  intro s hnodup hsmall hbound
  have hmem : s ∈ S.candidates :=
    S.enumerationComplete s hnodup hsmall hbound
  exact S.rejectionSound s (S.rejected s hmem) hnodup

/-- Direct axiom-dependency audit. Only direct dependencies are persisted.
Transitive closure is deliberately not a field of this structure. -/
structure DirectAxiomAudit where
  used : List Name
  declared : List Name
  subset : ∀ n, n ∈ used → n ∈ declared

/-- An EGC is accepted only together with:
1. a real proof term of the frozen root;
2. a frozen-root audit;
3. an axiom audit showing every directly observed axiom lies in the declared base.

Actual extraction of [used] from `#print axioms` is a CI/meta-level operation;
this structure is the kernel-checked acceptance contract for that extraction. -/
structure AuditedEGC (C : RootContract) extends ExternalGlobalCertificate C where
  rootAudit : FrozenRootAudit C.root
  axiomAudit : DirectAxiomAudit
  declaredBaseMatches : axiomAudit.declared = C.root.declaredBase

theorem audited_egc_proves_root
    {C : RootContract}
    (e : AuditedEGC C) :
    C.root.statement :=
  e.term

theorem audited_egc_used_axioms_declared
    {C : RootContract}
    (e : AuditedEGC C)
    (n : Name)
    (hn : n ∈ e.axiomAudit.used) :
    n ∈ C.root.declaredBase := by
  rw [← e.declaredBaseMatches]
  exact e.axiomAudit.subset n hn

end AxiomaticMillenium
