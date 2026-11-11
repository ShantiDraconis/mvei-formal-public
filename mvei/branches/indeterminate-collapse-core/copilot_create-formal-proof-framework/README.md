# indeterminate-collapse-core — branch `copilot/create-formal-proof-framework`

Lean sources from the branch `copilot/create-formal-proof-framework` of the private repository `ShantiDraconis/indeterminate-collapse-core`, commit `5f078034fe36baf16b70e0ac0ae06605383f4e4c` (2026-03-26T03:23:54+00:00), that hold theorems found only on branches (no default branch of any repository has a theorem with the same name). Published here: the files with the theorems the kernel closed, the local files they import and the Lake files of their project.

* Branch state: parada (not in the default branch).
* Theorems only on branches, in this branch: 69 — closed 55, conditional 3, open 2, proof error 0, not reached 9, no result 0.
* History: 2 commit(s) of this branch that are not in the default branch, with date and subject, in `certificate.json`.
* `certificate.json` (SHA-256 of its content: `822f5ab7f8195a063b87905ca766c8b1a979a347f9ed1e7a1a793b1b854f806f`) lists every theorem with its state and the axioms beyond the standard three, and the SHA-256 of every published file. From the repository root: `sha256sum -c mvei/branches/indeterminate-collapse-core/copilot_create-formal-proof-framework/SOURCES.sha256`.

Closed means the kernel accepted the proof and it depends only on `propext`, `Classical.choice` and `Quot.sound`; it proves the statement written in the file and is not a claim that an open problem is solved.

| Theorem | File | State |
|---|---|---|
| `BSDCore_I_bridge` | `BSDCore/MainBridge.lean`:12 | fechado |
| `BSDCore_collapse_idempotent` | `BSDCore/IntermediateLemmas.lean`:20 | fechado |
| `BSDCore_decomposition_nontrivial` | `BSDCore/IntermediateLemmas.lean`:16 | fechado |
| `BSDCore_known_consistent` | `BSDCore/IntermediateLemmas.lean`:12 | fechado |
| `BSDCore_unknown_collapses_to_I` | `BSDCore/IReformulation.lean`:21 | fechado |
| `BSDCore_unknown_is_indet` | `BSDCore/IReformulation.lean`:24 | fechado |
| `ComplexityCore_I_bridge` | `ComplexityCore/MainBridge.lean`:12 | fechado |
| `ComplexityCore_collapse_idempotent` | `ComplexityCore/IntermediateLemmas.lean`:20 | fechado |
| `ComplexityCore_decomposition_nontrivial` | `ComplexityCore/IntermediateLemmas.lean`:16 | fechado |
| `ComplexityCore_known_consistent` | `ComplexityCore/IntermediateLemmas.lean`:12 | fechado |
| `ComplexityCore_unknown_collapses_to_I` | `ComplexityCore/IReformulation.lean`:21 | fechado |
| `ComplexityCore_unknown_is_indet` | `ComplexityCore/IReformulation.lean`:24 | fechado |
| `HodgeCore_I_bridge` | `HodgeCore/MainBridge.lean`:12 | fechado |
| `HodgeCore_collapse_idempotent` | `HodgeCore/IntermediateLemmas.lean`:20 | fechado |
| `HodgeCore_decomposition_nontrivial` | `HodgeCore/IntermediateLemmas.lean`:16 | fechado |
| `HodgeCore_known_consistent` | `HodgeCore/IntermediateLemmas.lean`:12 | fechado |
| `HodgeCore_unknown_collapses_to_I` | `HodgeCore/IReformulation.lean`:21 | fechado |
| `HodgeCore_unknown_is_indet` | `HodgeCore/IReformulation.lean`:24 | fechado |
| `NavierStokesCore_I_bridge` | `NavierStokesCore/MainBridge.lean`:12 | fechado |
| `NavierStokesCore_collapse_idempotent` | `NavierStokesCore/IntermediateLemmas.lean`:20 | fechado |
| `NavierStokesCore_decomposition_nontrivial` | `NavierStokesCore/IntermediateLemmas.lean`:16 | fechado |
| `NavierStokesCore_known_consistent` | `NavierStokesCore/IntermediateLemmas.lean`:12 | fechado |
| `NavierStokesCore_unknown_collapses_to_I` | `NavierStokesCore/IReformulation.lean`:21 | fechado |
| `NavierStokesCore_unknown_is_indet` | `NavierStokesCore/IReformulation.lean`:24 | fechado |
| `RH_I_bridge` | `RiemannCore/MainBridge.lean`:20 | fechado |
| `RH_collapse_idempotent` | `RiemannCore/IntermediateLemmas.lean`:42 | aberto-sorry |
| `RH_collapse_structural_coherence` | `RiemannCore/MainBridge.lean`:39 | nao_alcancado |
| `RH_decomposition_nontrivial` | `RiemannCore/IntermediateLemmas.lean`:33 | fechado |
| `RH_indet_stable_under_idT` | `RiemannCore/IntermediateLemmas.lean`:25 | fechado |
| `RH_known_consistent_with_I` | `RiemannCore/IntermediateLemmas.lean`:16 | fechado |
| `RH_unknown_collapses_to_I` | `RiemannCore/IReformulation.lean`:34 | aberto-sorry |
| `RH_unknown_is_indet` | `RiemannCore/IReformulation.lean`:46 | fechado |
| `YangMillsCore_I_bridge` | `YangMillsCore/MainBridge.lean`:12 | fechado |
| `YangMillsCore_collapse_idempotent` | `YangMillsCore/IntermediateLemmas.lean`:20 | fechado |
| `YangMillsCore_decomposition_nontrivial` | `YangMillsCore/IntermediateLemmas.lean`:16 | fechado |
| `YangMillsCore_known_consistent` | `YangMillsCore/IntermediateLemmas.lean`:12 | fechado |
| `YangMillsCore_unknown_collapses_to_I` | `YangMillsCore/IReformulation.lean`:21 | fechado |
| `YangMillsCore_unknown_is_indet` | `YangMillsCore/IReformulation.lean`:24 | fechado |
| `closure_under_transformation` | `I_foundations/Propagation.lean`:34 | fechado |
| `collapse_invariant` | `I_foundations/Operators.lean`:87 | fechado |
| `collapse_is_consistent` | `I_foundations/Consistency.lean`:58 | nao_alcancado |
| `compT_preserves_indet` | `I_foundations/Operators.lean`:45 | fechado |
| `comp_preserves_identity` | `I_foundations/Transformations.lean`:36 | nao_alcancado |
| `comp_wellBehaved` | `I_foundations/Transformations.lean`:86 | nao_alcancado |
| `consistency_of_I_system` | `I_foundations/Consistency.lean`:20 | condicional |
| `constIndet_propagates` | `I_foundations/Operators.lean`:62 | fechado |
| `det_indet_disjoint` | `I_foundations/Consistency.lean`:47 | condicional |
| `det_initial_is_consistent` | `I_foundations/Consistency.lean`:52 | fechado |
| `idT_preserves_identity` | `I_foundations/Transformations.lean`:30 | nao_alcancado |
| `idT_propagates` | `I_foundations/Operators.lean`:57 | fechado |
| `idT_wellBehaved` | `I_foundations/Transformations.lean`:82 | nao_alcancado |
| `identity_preserved_under_valid_transition` | `I_foundations/Stability.lean`:21 | fechado |
| `indet_is_fixed_point` | `I_foundations/Stability.lean`:77 | fechado |
| `indet_stable_under_iter` | `I_foundations/Stability.lean`:85 | fechado |
| `indet_unique` | `I_foundations/States.lean`:33 | fechado |
| `isIndet_invariant_of_propagating` | `I_foundations/Operators.lean`:75 | fechado |
| `iterT_propagates` | `I_foundations/States.lean`:82 | fechado |
| `iter_closure` | `I_foundations/Propagation.lean`:62 | fechado |
| `no_immediate_contradiction` | `I_foundations/Consistency.lean`:33 | condicional |
| `opAdd_propagates_left` | `I_foundations/Propagation.lean`:68 | fechado |
| `opAdd_propagates_right` | `I_foundations/Propagation.lean`:76 | fechado |
| `opMul_propagates_left` | `I_foundations/Propagation.lean`:82 | fechado |
| `propagation_no_collapse` | `I_foundations/Propagation.lean`:88 | nao_alcancado |
| `propagation_preserves_structure` | `I_foundations/Propagation.lean`:21 | fechado |
| `seq_closure` | `I_foundations/Propagation.lean`:53 | fechado |
| `stability_under_iter` | `I_foundations/Stability.lean`:61 | nao_alcancado |
| `stable_transition_exists` | `I_foundations/Stability.lean`:37 | nao_alcancado |
| `transformedIndet` | `I_foundations/States.lean`:58 | fechado |
| `valid_preserves_consistency` | `I_foundations/Transformations.lean`:53 | fechado |
