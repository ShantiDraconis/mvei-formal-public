# axiomatic-millenium — branch `root/hardening-v1`

Lean sources from the branch `root/hardening-v1` of the private repository `ShantiDraconis/axiomatic-millenium`, commit `2fe5c125a538ef456e9b448d7eefff2c74b0eac2` (2026-09-26T09:23:48+01:00), that hold theorems found only on branches (no default branch of any repository has a theorem with the same name). Published here: the files with the theorems the kernel closed, the local files they import and the Lake files of their project.

* Branch state: parada (not in the default branch).
* Theorems only on branches, in this branch: 4 — closed 1, conditional 0, open 0, proof error 3, not reached 0, no result 0.
* History: 2 commit(s) of this branch that are not in the default branch, with date and subject, in `certificate.json`.
* `certificate.json` (SHA-256 of its content: `f6e40e4be3d1435d3415a77b8eea6f4a2c5ad3d2a6161a65f4a14e31b9d438f7`) lists every theorem with its state and the axioms beyond the standard three, and the SHA-256 of every published file. From the repository root: `sha256sum -c mvei/branches/axiomatic-millenium/root_hardening-v1/SOURCES.sha256`.

Closed means the kernel accepted the proof and it depends only on `propext`, `Classical.choice` and `Quot.sound`; it proves the statement written in the file and is not a claim that an open problem is solved.

| Theorem | File | State |
|---|---|---|
| `AxiomaticMillenium.audited_egc_proves_root` | `AxiomaticMillenium/RootHardening.lean`:84 | erro |
| `AxiomaticMillenium.audited_egc_used_axioms_declared` | `AxiomaticMillenium/RootHardening.lean`:90 | erro |
| `AxiomaticMillenium.bounded_search_no_smaller` | `AxiomaticMillenium/RootHardening.lean`:51 | erro |
| `AxiomaticMillenium.canonical_reduced_frontier_nodup` | `AxiomaticMillenium/RootHardening.lean`:19 | fechado |
