# harappan-00-universal — branch `copilot/create-harappan-symbols-repo`

Lean sources from the branch `copilot/create-harappan-symbols-repo` of the private repository `ShantiDraconis/harappan-00-universal`, commit `2c5177dd5e9fa413cbac5e68aad7fbb5f65e8b2e` (2025-11-30T11:35:56+00:00), that hold theorems found only on branches (no default branch of any repository has a theorem with the same name). Published here: the files with the theorems the kernel closed, the local files they import and the Lake files of their project.

* Branch state: parada (not in the default branch).
* Theorems only on branches, in this branch: 27 — closed 13, conditional 1, open 9, proof error 3, not reached 1, no result 0.
* History: 9 commit(s) of this branch that are not in the default branch, with date and subject, in `certificate.json`.
* `certificate.json` (SHA-256 of its content: `848008774cbce74281427c6aa4e1b67e196c4b6d0e46148b79f7d9fa4ad6c19e`) lists every theorem with its state and the axioms beyond the standard three, and the SHA-256 of every published file. From the repository root: `sha256sum -c mvei/branches/harappan-00-universal/copilot_create-harappan-symbols-repo/SOURCES.sha256`.

Closed means the kernel accepted the proof and it depends only on `propext`, `Classical.choice` and `Quot.sound`; it proves the statement written in the file and is not a claim that an open problem is solved.

| Theorem | File | State |
|---|---|---|
| `Harappan.Collapse.annihilate_voids` | `src/lean/Harappan/CollapseAxioms.lean`:69 | fechado |
| `Harappan.Collapse.annihilate_zero_energy` | `src/lean/Harappan/CollapseAxioms.lean`:74 | fechado |
| `Harappan.Collapse.collapse_reduces_superposition` | `src/lean/Harappan/CollapseAxioms.lean`:142 | aberto-sorry |
| `Harappan.Collapse.dual_annihilation_void` | `src/lean/Harappan/CollapseAxioms.lean`:107 | fechado |
| `Harappan.Collapse.empty_sequence_identity` | `src/lean/Harappan/CollapseAxioms.lean`:118 | fechado |
| `Harappan.Collapse.energy_nonneg` | `src/lean/Harappan/CollapseAxioms.lean`:79 | aberto-sorry |
| `Harappan.Collapse.no_deadlock` | `src/lean/Harappan/CollapseAxioms.lean`:133 | fechado |
| `Harappan.Collapse.observe_collapses` | `src/lean/Harappan/CollapseAxioms.lean`:64 | fechado |
| `Harappan.Collapse.unify_idempotent` | `src/lean/Harappan/CollapseAxioms.lean`:57 | fechado |
| `Harappan.Consistency.add_consistent_preserves` | `src/lean/Harappan/ConsistencyTheorems.lean`:107 | aberto-sorry |
| `Harappan.Consistency.mapping_is_function` | `src/lean/Harappan/ConsistencyTheorems.lean`:66 | nao_alcancado |
| `Harappan.Consistency.phoneme_mapping_deterministic` | `src/lean/Harappan/ConsistencyTheorems.lean`:40 | fechado |
| `Harappan.Consistency.position_valid` | `src/lean/Harappan/ConsistencyTheorems.lean`:127 | fechado |
| `Harappan.Consistency.sign_identity_unique` | `src/lean/Harappan/ConsistencyTheorems.lean`:25 | fechado |
| `Harappan.Consistency.wellformed_no_selfloops` | `src/lean/Harappan/ConsistencyTheorems.lean`:86 | fechado |
| `Harappan.Phonology.PhonemeInventory.count_sum` | `src/lean/Harappan/Phonology.lean`:137 | aberto-sorry |
| `Harappan.Phonology.phonemeDistance_nonneg` | `src/lean/Harappan/Phonology.lean`:82 | erro |
| `Harappan.Phonology.phonemeDistance_self` | `src/lean/Harappan/Phonology.lean`:105 | erro |
| `Harappan.Phonology.phonemeDistance_symm` | `src/lean/Harappan/Phonology.lean`:91 | erro |
| `Harappan.Phonotactics.empty_violates_standard` | `src/lean/Harappan/Phonotactics.lean`:107 | aberto-sorry |
| `Harappan.Phonotactics.singleton_wellformed` | `src/lean/Harappan/Phonotactics.lean`:113 | fechado |
| `Harappan.Semantics.SemanticGraph.edge_nodes_exist` | `src/lean/Harappan/Semantics.lean`:117 | aberto-sorry |
| `Harappan.Semantics.SemanticSystem.category_partition` | `src/lean/Harappan/Semantics.lean`:134 | aberto-sorry |
| `Harappan.SignSet.lookup_deterministic` | `src/lean/Harappan/SignSet.lean`:38 | aberto-sorry |
| `Harappan.UniversalGrammar.universal_vowels_consonants` | `src/lean/Harappan/UniversalGrammar.lean`:84 | aberto-sorry |
| `Harappan.standardCorpus_finite` | `src/lean/Harappan/SignSet.lean`:80 | fechado |
| `Harappan.standardSignIds_valid` | `src/lean/Harappan/SignSet.lean`:89 | condicional |
