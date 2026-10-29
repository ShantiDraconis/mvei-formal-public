# harappan-00-universal — branch `copilot/create-harappan-symbols-repo`

Lean sources from the branch `copilot/create-harappan-symbols-repo` of the private repository `ShantiDraconis/harappan-00-universal`, commit `2c5177dd5e9fa413cbac5e68aad7fbb5f65e8b2e` (2025-11-30T11:35:56+00:00), that hold theorems found only on branches (no default branch of any repository has a theorem with the same name). Published here: the files with the theorems the kernel closed, the local files they import and the Lake files of their project.

* Branch state: parada (not in the default branch).
* Theorems only on branches, in this branch: 27 — closed 1, conditional 1, open 1, proof error 4, not reached 20, no result 0.
* History: 9 commit(s) of this branch that are not in the default branch, with date and subject, in `certificate.json`.
* `certificate.json` (SHA-256 of its content: `1f4654df33553aa3188271c9f6c6554616da2676b8d271717858d87220b8d0be`) lists every theorem with its state and the axioms beyond the standard three, and the SHA-256 of every published file. From the repository root: `sha256sum -c mvei/branches/harappan-00-universal/copilot_create-harappan-symbols-repo/SOURCES.sha256`.

Closed means the kernel accepted the proof and it depends only on `propext`, `Classical.choice` and `Quot.sound`; it proves the statement written in the file and is not a claim that an open problem is solved.

| Theorem | File | State |
|---|---|---|
| `Harappan.Collapse.annihilate_voids` | `src/lean/Harappan/CollapseAxioms.lean`:69 | nao_alcancado |
| `Harappan.Collapse.annihilate_zero_energy` | `src/lean/Harappan/CollapseAxioms.lean`:74 | nao_alcancado |
| `Harappan.Collapse.collapse_reduces_superposition` | `src/lean/Harappan/CollapseAxioms.lean`:142 | nao_alcancado |
| `Harappan.Collapse.dual_annihilation_void` | `src/lean/Harappan/CollapseAxioms.lean`:107 | nao_alcancado |
| `Harappan.Collapse.empty_sequence_identity` | `src/lean/Harappan/CollapseAxioms.lean`:118 | nao_alcancado |
| `Harappan.Collapse.energy_nonneg` | `src/lean/Harappan/CollapseAxioms.lean`:79 | nao_alcancado |
| `Harappan.Collapse.no_deadlock` | `src/lean/Harappan/CollapseAxioms.lean`:133 | nao_alcancado |
| `Harappan.Collapse.observe_collapses` | `src/lean/Harappan/CollapseAxioms.lean`:64 | nao_alcancado |
| `Harappan.Collapse.unify_idempotent` | `src/lean/Harappan/CollapseAxioms.lean`:57 | nao_alcancado |
| `Harappan.Consistency.add_consistent_preserves` | `src/lean/Harappan/ConsistencyTheorems.lean`:107 | nao_alcancado |
| `Harappan.Consistency.mapping_is_function` | `src/lean/Harappan/ConsistencyTheorems.lean`:66 | nao_alcancado |
| `Harappan.Consistency.phoneme_mapping_deterministic` | `src/lean/Harappan/ConsistencyTheorems.lean`:40 | nao_alcancado |
| `Harappan.Consistency.position_valid` | `src/lean/Harappan/ConsistencyTheorems.lean`:127 | nao_alcancado |
| `Harappan.Consistency.sign_identity_unique` | `src/lean/Harappan/ConsistencyTheorems.lean`:25 | nao_alcancado |
| `Harappan.Consistency.wellformed_no_selfloops` | `src/lean/Harappan/ConsistencyTheorems.lean`:86 | nao_alcancado |
| `Harappan.Phonology.PhonemeInventory.count_sum` | `src/lean/Harappan/Phonology.lean`:137 | aberto-sorry |
| `Harappan.Phonology.phonemeDistance_nonneg` | `src/lean/Harappan/Phonology.lean`:82 | erro |
| `Harappan.Phonology.phonemeDistance_self` | `src/lean/Harappan/Phonology.lean`:105 | erro |
| `Harappan.Phonology.phonemeDistance_symm` | `src/lean/Harappan/Phonology.lean`:91 | erro |
| `Harappan.Phonotactics.empty_violates_standard` | `src/lean/Harappan/Phonotactics.lean`:107 | nao_alcancado |
| `Harappan.Phonotactics.singleton_wellformed` | `src/lean/Harappan/Phonotactics.lean`:113 | nao_alcancado |
| `Harappan.Semantics.SemanticGraph.edge_nodes_exist` | `src/lean/Harappan/Semantics.lean`:117 | nao_alcancado |
| `Harappan.Semantics.SemanticSystem.category_partition` | `src/lean/Harappan/Semantics.lean`:134 | nao_alcancado |
| `Harappan.SignSet.lookup_deterministic` | `src/lean/Harappan/SignSet.lean`:38 | erro |
| `Harappan.UniversalGrammar.universal_vowels_consonants` | `src/lean/Harappan/UniversalGrammar.lean`:84 | nao_alcancado |
| `Harappan.standardCorpus_finite` | `src/lean/Harappan/SignSet.lean`:80 | fechado |
| `Harappan.standardSignIds_valid` | `src/lean/Harappan/SignSet.lean`:89 | condicional |
