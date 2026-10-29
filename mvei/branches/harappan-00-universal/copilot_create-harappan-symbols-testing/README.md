# harappan-00-universal — branch `copilot/create-harappan-symbols-testing`

Lean sources from the branch `copilot/create-harappan-symbols-testing` of the private repository `ShantiDraconis/harappan-00-universal`, commit `02efd6f7318213fc2dd5c7f7f91ad7eb33b1d336` (2025-11-30T11:35:28+00:00), that hold theorems found only on branches (no default branch of any repository has a theorem with the same name). Published here: the files with the theorems the kernel closed, the local files they import and the Lake files of their project.

* Branch state: parada (not in the default branch).
* Theorems only on branches, in this branch: 19 — closed 3, conditional 0, open 0, proof error 4, not reached 12, no result 0.
* History: 4 commit(s) of this branch that are not in the default branch, with date and subject, in `certificate.json`.
* `certificate.json` (SHA-256 of its content: `6ee393a7942aec60e7f4db4275400a9d0de8e0bc3796e8f7ec10eae988ae54d2`) lists every theorem with its state and the axioms beyond the standard three, and the SHA-256 of every published file. From the repository root: `sha256sum -c mvei/branches/harappan-00-universal/copilot_create-harappan-symbols-testing/SOURCES.sha256`.

Closed means the kernel accepted the proof and it depends only on `propext`, `Classical.choice` and `Quot.sound`; it proves the statement written in the file and is not a claim that an open problem is solved.

| Theorem | File | State |
|---|---|---|
| `Harappan.CollapseAxioms.apply_collapse_preserves_id` | `src/lean/Harappan/CollapseAxioms.lean`:124 | nao_alcancado |
| `Harappan.CollapseAxioms.apply_collapse_to_collapsed` | `src/lean/Harappan/CollapseAxioms.lean`:130 | fechado |
| `Harappan.CollapseAxioms.reset_produces_zero_zero` | `src/lean/Harappan/CollapseAxioms.lean`:145 | fechado |
| `Harappan.ConsistencyTheorems.empty_hypotheses_consistent` | `src/lean/Harappan/ConsistencyTheorems.lean`:28 | nao_alcancado |
| `Harappan.ConsistencyTheorems.empty_states_consistent` | `src/lean/Harappan/ConsistencyTheorems.lean`:59 | nao_alcancado |
| `Harappan.ConsistencyTheorems.empty_system_consistent` | `src/lean/Harappan/ConsistencyTheorems.lean`:111 | nao_alcancado |
| `Harappan.ConsistencyTheorems.no_contradiction` | `src/lean/Harappan/ConsistencyTheorems.lean`:66 | nao_alcancado |
| `Harappan.ConsistencyTheorems.single_hypothesis_coherent` | `src/lean/Harappan/ConsistencyTheorems.lean`:88 | nao_alcancado |
| `Harappan.ConsistencyTheorems.single_mapping_consistent` | `src/lean/Harappan/ConsistencyTheorems.lean`:39 | nao_alcancado |
| `Harappan.Phonology.phoneme_distance_nonneg` | `src/lean/Harappan/Phonology.lean`:170 | erro |
| `Harappan.Phonology.phoneme_distance_symm` | `src/lean/Harappan/Phonology.lean`:179 | erro |
| `Harappan.Phonotactics.cv_valid` | `src/lean/Harappan/Phonotactics.lean`:124 | nao_alcancado |
| `Harappan.Phonotactics.empty_valid` | `src/lean/Harappan/Phonotactics.lean`:118 | nao_alcancado |
| `Harappan.Phonotactics.single_valid` | `src/lean/Harappan/Phonotactics.lean`:121 | nao_alcancado |
| `Harappan.Semantics.empty_graph_no_edges` | `src/lean/Harappan/Semantics.lean`:105 | erro |
| `Harappan.Semantics.node_membership_decidable` | `src/lean/Harappan/Semantics.lean`:112 | fechado |
| `Harappan.SignSet.unique_ids_preserved` | `src/lean/Harappan/SignSet.lean`:24 | erro |
| `Harappan.UniversalGrammar.grammar_has_base_rules` | `src/lean/Harappan/UniversalGrammar.lean`:119 | nao_alcancado |
| `Harappan.UniversalGrammar.word_is_well_formed` | `src/lean/Harappan/UniversalGrammar.lean`:125 | nao_alcancado |
