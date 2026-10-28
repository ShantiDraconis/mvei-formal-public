# 0-0-FORMAL-SUITE — branch `atk/fundamental-i-model`

Lean sources from the branch `atk/fundamental-i-model` of the private repository `ShantiDraconis/0-0-FORMAL-SUITE`, commit `669fca457dd15d4928080b4190c12ae8c71c59fb` (2026-09-26T21:20:45+01:00), that hold theorems found only on branches (no default branch of any repository has a theorem with the same name). Published here: the files with the theorems the kernel closed, the local files they import and the Lake files of their project.

* Branch state: parada (not in the default branch).
* Theorems only on branches, in this branch: 37 — closed 31, conditional 0, open 2, proof error 2, not reached 2, no result 0.
* History: 29 commit(s) of this branch that are not in the default branch, with date and subject, in `certificate.json`.
* `certificate.json` (SHA-256 of its content: `a8143ee2a88caf7b2e52885fe315a0a9a4ac7aa67def54ac6599670f08c4c078`) lists every theorem with its state and the axioms beyond the standard three, and the SHA-256 of every published file. From the repository root: `sha256sum -c mvei/branches/0-0-FORMAL-SUITE/atk_fundamental-i-model/SOURCES.sha256`.

Closed means the kernel accepted the proof and it depends only on `propext`, `Classical.choice` and `Quot.sound`; it proves the statement written in the file and is not a claim that an open problem is solved.

| Theorem | File | State |
|---|---|---|
| `FormalSuite.I.Universal.FUNDAMENTAL_I_EXTERNAL_BRIDGES_FAIL_CLOSED` | `src/FormalSuite/I/Universal/ExternalCertificate.lean`:31 | nao_alcancado |
| `FormalSuite.I.Universal.FUNDAMENTAL_I_EXTERNAL_CERTIFICATE` | `src/FormalSuite/I/Universal/ExternalCertificate.lean`:27 | nao_alcancado |
| `FormalSuite.I.Universal.FundamentalIClaim_proved` | `src/FormalSuite/I/Universal/Claim.lean`:12 | fechado |
| `FormalSuite.I.Universal.FundamentalIFinalProof_exists` | `src/FormalSuite/I/Universal/FinalProof.lean`:11 | fechado |
| `FormalSuite.I.Universal.FundamentalIModelExistenceCertificate` | `src/FormalSuite/I/Universal/FundamentalIModel.lean`:141 | fechado |
| `FormalSuite.I.Universal.FundamentalITheorem` | `src/FormalSuite/I/Universal/FundamentalIModel.lean`:147 | fechado |
| `FormalSuite.I.Universal.SN_eq_rose_sum` | `src/FormalSuite/I/Universal/SNMultistateGap.lean`:37 | erro |
| `FormalSuite.I.Universal.all_registered_bridges_start_open` | `src/FormalSuite/I/Universal/DomainBridges.lean`:132 | fechado |
| `FormalSuite.I.Universal.certificate_closes_terminal_gap` | `src/FormalSuite/I/Universal/SNMultistateGap.lean`:104 | aberto-sorry |
| `FormalSuite.I.Universal.closure_semantic_exhaustive` | `src/FormalSuite/I/Universal/Semantics.lean`:21 | fechado |
| `FormalSuite.I.Universal.concreteFundamentalILaws` | `src/FormalSuite/I/Universal/Laws.lean`:16 | fechado |
| `FormalSuite.I.Universal.concreteFundamentalIModel_properties` | `src/FormalSuite/I/Universal/FundamentalIModel.lean`:136 | fechado |
| `FormalSuite.I.Universal.embedReal_add` | `src/FormalSuite/I/Universal/Operations.lean`:25 | fechado |
| `FormalSuite.I.Universal.embedReal_injective` | `src/FormalSuite/I/Universal/FundamentalIModel.lean`:120 | fechado |
| `FormalSuite.I.Universal.embedReal_mul` | `src/FormalSuite/I/Universal/Operations.lean`:29 | fechado |
| `FormalSuite.I.Universal.embedReal_neg` | `src/FormalSuite/I/Universal/Operations.lean`:33 | fechado |
| `FormalSuite.I.Universal.informationNonCollapse` | `src/FormalSuite/I/Universal/FundamentalIModel.lean`:108 | fechado |
| `FormalSuite.I.Universal.information_refines_projection` | `src/FormalSuite/I/Universal/Semantics.lean`:29 | fechado |
| `FormalSuite.I.Universal.projection_embedReal` | `src/FormalSuite/I/Universal/FundamentalIModel.lean`:74 | fechado |
| `FormalSuite.I.Universal.projection_iAdd` | `src/FormalSuite/I/Universal/Operations.lean`:13 | fechado |
| `FormalSuite.I.Universal.projection_iMul` | `src/FormalSuite/I/Universal/Operations.lean`:17 | fechado |
| `FormalSuite.I.Universal.projection_iNeg` | `src/FormalSuite/I/Universal/Operations.lean`:21 | fechado |
| `FormalSuite.I.Universal.retraction_preserves_projection` | `src/FormalSuite/I/Universal/FundamentalIModel.lean`:82 | fechado |
| `FormalSuite.I.Universal.retraction_traction` | `src/FormalSuite/I/Universal/FundamentalIModel.lean`:90 | fechado |
| `FormalSuite.I.Universal.retraction_traction_transition` | `src/FormalSuite/I/Universal/Transitions.lean`:29 | fechado |
| `FormalSuite.I.Universal.roseFiber_eq_petal_sum` | `src/FormalSuite/I/Universal/SNMultistateGap.lean`:41 | erro |
| `FormalSuite.I.Universal.stabilize_idempotent` | `src/FormalSuite/I/Universal/FundamentalIModel.lean`:100 | fechado |
| `FormalSuite.I.Universal.stabilize_transition_idempotent` | `src/FormalSuite/I/Universal/Transitions.lean`:33 | fechado |
| `FormalSuite.I.Universal.state00_projects_to_zero` | `src/FormalSuite/I/Universal/FundamentalIModel.lean`:104 | fechado |
| `FormalSuite.I.Universal.state_nontrivial` | `src/FormalSuite/I/Universal/FundamentalIModel.lean`:115 | fechado |
| `FormalSuite.I.Universal.traction_preserves_projection` | `src/FormalSuite/I/Universal/FundamentalIModel.lean`:78 | fechado |
| `FormalSuite.I.Universal.traction_retraction` | `src/FormalSuite/I/Universal/FundamentalIModel.lean`:95 | fechado |
| `FormalSuite.I.Universal.traction_retraction_transition` | `src/FormalSuite/I/Universal/Transitions.lean`:25 | fechado |
| `FormalSuite.I.Universal.transition_preserves_projection` | `src/FormalSuite/I/Universal/Transitions.lean`:17 | fechado |
| `FormalSuite.I.Universal.twist_preserves_projection` | `src/FormalSuite/I/Universal/FundamentalIModel.lean`:86 | fechado |
| `FormalSuite.I.Universal.weighted_modular_bilinear_decay_implies_SN_vanishes` | `src/FormalSuite/I/Universal/SNMultistateGap.lean`:56 | aberto-sorry |
| `FormalSuite.I.Universal.zero_one_two_chain` | `src/FormalSuite/I/Universal/SNMultistateGap.lean`:94 | fechado |
