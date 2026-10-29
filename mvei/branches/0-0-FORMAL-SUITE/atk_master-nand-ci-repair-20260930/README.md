# 0-0-FORMAL-SUITE — branch `atk/master-nand-ci-repair-20260930`

Lean sources from the branch `atk/master-nand-ci-repair-20260930` of the private repository `ShantiDraconis/0-0-FORMAL-SUITE`, commit `6a1a449fa63fd619ffd6e1df80505b428e76e995` (2026-09-30T11:46:11+02:00), that hold theorems found only on branches (no default branch of any repository has a theorem with the same name). Published here: the files with the theorems the kernel closed, the local files they import and the Lake files of their project.

* Branch state: parada (not in the default branch).
* Theorems only on branches, in this branch: 51 — closed 50, conditional 0, open 0, proof error 1, not reached 0, no result 0.
* History: 13 commit(s) of this branch that are not in the default branch, with date and subject, in `certificate.json`.
* `certificate.json` (SHA-256 of its content: `171faf250640908d568969d301428e88f86f77a07b8313366850848ba7b32209`) lists every theorem with its state and the axioms beyond the standard three, and the SHA-256 of every published file. From the repository root: `sha256sum -c mvei/branches/0-0-FORMAL-SUITE/atk_master-nand-ci-repair-20260930/SOURCES.sha256`.

Closed means the kernel accepted the proof and it depends only on `propext`, `Classical.choice` and `Quot.sound`; it proves the statement written in the file and is not a claim that an open problem is solved.

| Theorem | File | State |
|---|---|---|
| `FormalSuite.IMultiState.certificate_nonempty_iff_exists` | `src/FormalSuite/I/MultiStateEncodings.lean`:197 | fechado |
| `FormalSuite.IMultiState.certificate_roundtrip` | `src/FormalSuite/I/MultiStateEncodings.lean`:185 | fechado |
| `FormalSuite.IMultiState.decodeBits_encodeBits` | `src/FormalSuite/I/MultiStateEncodings.lean`:129 | fechado |
| `FormalSuite.IMultiState.decodeBits_invalid` | `src/FormalSuite/I/MultiStateEncodings.lean`:133 | fechado |
| `FormalSuite.IMultiState.edge_complete` | `src/FormalSuite/I/MultiStateEncodings.lean`:107 | fechado |
| `FormalSuite.IMultiState.edge_rotate` | `src/FormalSuite/I/MultiStateEncodings.lean`:97 | fechado |
| `FormalSuite.IMultiState.edge_sound` | `src/FormalSuite/I/MultiStateEncodings.lean`:101 | fechado |
| `FormalSuite.IMultiState.encodeBits_valid` | `src/FormalSuite/I/MultiStateEncodings.lean`:140 | fechado |
| `FormalSuite.IMultiState.findFirst_exists_iff` | `src/FormalSuite/I/MultiStateEncodings.lean`:244 | erro |
| `FormalSuite.IMultiState.findFirst_mem` | `src/FormalSuite/I/MultiStateEncodings.lean`:207 | fechado |
| `FormalSuite.IMultiState.findFirst_none_iff` | `src/FormalSuite/I/MultiStateEncodings.lean`:229 | fechado |
| `FormalSuite.IMultiState.findFirst_sound` | `src/FormalSuite/I/MultiStateKernel.lean`:75 | fechado |
| `FormalSuite.IMultiState.nand_as_not` | `src/FormalSuite/I/MultiStateEncodings.lean`:301 | fechado |
| `FormalSuite.IMultiState.nand_builds_and` | `src/FormalSuite/I/MultiStateEncodings.lean`:305 | fechado |
| `FormalSuite.IMultiState.nand_builds_or` | `src/FormalSuite/I/MultiStateEncodings.lean`:309 | fechado |
| `FormalSuite.IMultiState.ofOptionBool_toOptionBool` | `src/FormalSuite/I/MultiStateEncodings.lean`:32 | fechado |
| `FormalSuite.IMultiState.oneHot_valid` | `src/FormalSuite/I/MultiStateEncodings.lean`:162 | fechado |
| `FormalSuite.IMultiState.rotate_manifest` | `src/FormalSuite/I/MultiStateKernel.lean`:37 | fechado |
| `FormalSuite.IMultiState.rotate_ne_self` | `src/FormalSuite/I/MultiStateKernel.lean`:43 | fechado |
| `FormalSuite.IMultiState.rotate_seed` | `src/FormalSuite/I/MultiStateKernel.lean`:34 | fechado |
| `FormalSuite.IMultiState.rotate_three` | `src/FormalSuite/I/MultiStateKernel.lean`:38 | fechado |
| `FormalSuite.IMultiState.rotate_transit` | `src/FormalSuite/I/MultiStateKernel.lean`:36 | fechado |
| `FormalSuite.IMultiState.rotation_invariant_bool_constant` | `src/FormalSuite/I/MultiStateKernel.lean`:48 | fechado |
| `FormalSuite.IMultiState.runTwo_phase` | `src/FormalSuite/I/MultiStateKernel.lean`:134 | fechado |
| `FormalSuite.IMultiState.runTwo_result` | `src/FormalSuite/I/MultiStateKernel.lean`:140 | fechado |
| `FormalSuite.IMultiState.runTwo_sound` | `src/FormalSuite/I/MultiStateKernel.lean`:146 | fechado |
| `FormalSuite.IMultiState.semanticProduce_sound` | `src/FormalSuite/I/MultiStateEncodings.lean`:287 | fechado |
| `FormalSuite.IMultiState.step_deterministic` | `src/FormalSuite/I/MultiStateEncodings.lean`:79 | fechado |
| `FormalSuite.IMultiState.step_iff_eq_rotate` | `src/FormalSuite/I/MultiStateEncodings.lean`:58 | fechado |
| `FormalSuite.IMultiState.step_total` | `src/FormalSuite/I/MultiStateEncodings.lean`:87 | fechado |
| `FormalSuite.IMultiState.subtype_roundtrip` | `src/FormalSuite/I/MultiStateEncodings.lean`:191 | fechado |
| `FormalSuite.IMultiState.toOptionBool_ofOptionBool` | `src/FormalSuite/I/MultiStateEncodings.lean`:36 | fechado |
| `FormalSuite.INand.NandExpr.eval_nandAnd` | `src/FormalSuite/I/NandCompleteBasis.lean`:128 | fechado |
| `FormalSuite.INand.NandExpr.eval_nandImp` | `src/FormalSuite/I/NandCompleteBasis.lean`:158 | fechado |
| `FormalSuite.INand.NandExpr.eval_nandNor` | `src/FormalSuite/I/NandCompleteBasis.lean`:140 | fechado |
| `FormalSuite.INand.NandExpr.eval_nandOr` | `src/FormalSuite/I/NandCompleteBasis.lean`:134 | fechado |
| `FormalSuite.INand.NandExpr.eval_nandXnor` | `src/FormalSuite/I/NandCompleteBasis.lean`:152 | fechado |
| `FormalSuite.INand.NandExpr.eval_nandXor` | `src/FormalSuite/I/NandCompleteBasis.lean`:146 | fechado |
| `FormalSuite.INand.NandExpr.eval_nnot` | `src/FormalSuite/I/NandCompleteBasis.lean`:124 | fechado |
| `FormalSuite.INand.bandN_eq` | `src/FormalSuite/I/NandCompleteBasis.lean`:51 | fechado |
| `FormalSuite.INand.bimpN_eq` | `src/FormalSuite/I/NandCompleteBasis.lean`:71 | fechado |
| `FormalSuite.INand.bnorN_eq` | `src/FormalSuite/I/NandCompleteBasis.lean`:59 | fechado |
| `FormalSuite.INand.bnotN_eq` | `src/FormalSuite/I/NandCompleteBasis.lean`:47 | fechado |
| `FormalSuite.INand.borN_eq` | `src/FormalSuite/I/NandCompleteBasis.lean`:55 | fechado |
| `FormalSuite.INand.bxnorN_eq` | `src/FormalSuite/I/NandCompleteBasis.lean`:67 | fechado |
| `FormalSuite.INand.bxorN_eq` | `src/FormalSuite/I/NandCompleteBasis.lean`:63 | fechado |
| `FormalSuite.INand.compileNand_sound` | `src/FormalSuite/I/NandCompleteBasis.lean`:208 | fechado |
| `FormalSuite.INand.exists_nand_realization` | `src/FormalSuite/I/NandCompleteBasis.lean`:230 | fechado |
| `FormalSuite.INand.nand_is_not_and` | `src/FormalSuite/I/NandCompleteBasis.lean`:75 | fechado |
| `FormalSuite.INand.nor_is_not_or` | `src/FormalSuite/I/NandCompleteBasis.lean`:78 | fechado |
| `FormalSuite.INand.xnor_is_not_xor` | `src/FormalSuite/I/NandCompleteBasis.lean`:82 | fechado |
