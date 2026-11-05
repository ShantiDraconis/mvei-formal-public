# Millenium--core — branch `copilot/add-blueprint-tif-document`

Lean sources from the branch `copilot/add-blueprint-tif-document` of the private repository `ShantiDraconis/Millenium--core`, commit `cf31e48f5faecca39827bbc87a867bf5930c03ad` (2026-04-07T11:14:08-03:00), that hold theorems found only on branches (no default branch of any repository has a theorem with the same name). Published here: the files with the theorems the kernel closed, the local files they import and the Lake files of their project.

* Branch state: incorporada (already in the default branch).
* Theorems only on branches, in this branch: 18 — closed 11, conditional 2, open 1, proof error 0, not reached 4, no result 0.
* History: 0 commit(s) of this branch that are not in the default branch, with date and subject, in `certificate.json`.
* `certificate.json` (SHA-256 of its content: `f0efa3fe5771fd1e809a5b81f0f9ae1ae6f87076db465550d131acc24725c341`) lists every theorem with its state and the axioms beyond the standard three, and the SHA-256 of every published file. From the repository root: `sha256sum -c mvei/branches/Millenium--core/copilot_add-blueprint-tif-document/SOURCES.sha256`.

Closed means the kernel accepted the proof and it depends only on `propext`, `Classical.choice` and `Quot.sound`; it proves the statement written in the file and is not a claim that an open problem is solved.

| Theorem | File | State |
|---|---|---|
| `TIF.classical_preserves_semantics` | `Core/Semantics.lean`:138 | nao_alcancado |
| `TIF.classical_stability` | `Core/Rewrite.lean`:131 | nao_alcancado |
| `TIF.collapse_completeness` | `Core/Semantics.lean`:118 | fechado |
| `TIF.collapse_correctness` | `Core/Rewrite.lean`:145 | fechado |
| `TIF.collapse_soundness` | `Core/Semantics.lean`:109 | fechado |
| `TIF.conservativity` | `Core/Conservativity.lean`:37 | condicional |
| `TIF.local_completeness` | `Core/Conservativity.lean`:99 | fechado |
| `TIF.local_completeness_exact` | `Core/Conservativity.lean`:106 | fechado |
| `TIF.no_forced_classical_identity` | `Core/States.lean`:129 | fechado |
| `TIF.no_spurious_classical` | `Core/Conservativity.lean`:55 | condicional |
| `TIF.nonderivability_of_contradiction` | `Core/Conservativity.lean`:84 | fechado |
| `TIF.ontological_separation` | `Core/States.lean`:135 | fechado |
| `TIF.operator_conservativity` | `Core/Conservativity.lean`:48 | fechado |
| `TIF.restricted_confluence` | `Core/Rewrite.lean`:161 | aberto-sorry |
| `TIF.soundness_of_collapse` | `Core/Semantics.lean`:125 | nao_alcancado |
| `TIF.typed_object_interpretation` | `Core/States.lean`:115 | fechado |
| `TIF.uniqueness_implies_recovery` | `Core/Semantics.lean`:128 | fechado |
| `TIF.wellformedness_preservation` | `Core/Rewrite.lean`:119 | nao_alcancado |
