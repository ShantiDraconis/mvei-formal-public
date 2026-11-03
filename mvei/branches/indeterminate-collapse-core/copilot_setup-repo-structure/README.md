# indeterminate-collapse-core — branch `copilot/setup-repo-structure`

Lean sources from the branch `copilot/setup-repo-structure` of the private repository `ShantiDraconis/indeterminate-collapse-core`, commit `35799ec4a7af1a7951b3c82f89399832b3beb9bf` (2026-03-26T03:34:31+00:00), that hold theorems found only on branches (no default branch of any repository has a theorem with the same name). Published here: the files with the theorems the kernel closed, the local files they import and the Lake files of their project.

* Branch state: parada (not in the default branch).
* Theorems only on branches, in this branch: 62 — closed 38, conditional 9, open 5, proof error 0, not reached 10, no result 0.
* History: 2 commit(s) of this branch that are not in the default branch, with date and subject, in `certificate.json`.
* `certificate.json` (SHA-256 of its content: `20e9242e646964480d7b050e4aed6ca64b6a9491ed7ec3cd2409c6c91ae1d92c`) lists every theorem with its state and the axioms beyond the standard three, and the SHA-256 of every published file. From the repository root: `sha256sum -c mvei/branches/indeterminate-collapse-core/copilot_setup-repo-structure/SOURCES.sha256`.

Closed means the kernel accepted the proof and it depends only on `propext`, `Classical.choice` and `Quot.sound`; it proves the statement written in the file and is not a claim that an open problem is solved.

| Theorem | File | State |
|---|---|---|
| `FiniteStateSpace_length` | `lean/States.lean`:65 | fechado |
| `IState_has_two_distinct_elements` | `lean/Consistency.lean`:22 | condicional |
| `I_absorbing` | `lean/Propagation.lean`:109 | aberto-sorry |
| `I_in_FiniteStateSpace` | `lean/States.lean`:60 | fechado |
| `I_is_fixpoint_of_ipropagating` | `lean/Propagation.lean`:104 | fechado |
| `I_ne_known` | `lean/Axioms.lean`:101 | condicional |
| `apply_I_propagating` | `lean/Transformations.lean`:65 | fechado |
| `axioms_consistent` | `lean/Consistency.lean`:95 | fechado |
| `chain_nil` | `lean/Transformations.lean`:77 | fechado |
| `chain_propagates` | `lean/Propagation.lean`:48 | aberto-sorry |
| `chain_singleton` | `lean/Transformations.lean`:81 | fechado |
| `collapse_known_ne_unknown` | `lean/Consistency.lean`:42 | aberto-sorry |
| `collapse_known_not_I` | `lean/Consistency.lean`:27 | nao_alcancado |
| `collapse_op_preserves_I` | `lean/Operators.lean`:99 | fechado |
| `collapse_unknown_is_I` | `lean/Consistency.lean`:37 | nao_alcancado |
| `compose_id_right` | `lean/Transformations.lean`:119 | fechado |
| `compose_propagates` | `lean/Propagation.lean`:35 | fechado |
| `consistent_compose` | `lean/Consistency.lean`:57 | fechado |
| `consistent_preserves_known` | `lean/Consistency.lean`:49 | fechado |
| `evenFilter_propagates_I` | `lean/Transformations.lean`:104 | fechado |
| `extract_I_default` | `lean/States.lean`:104 | fechado |
| `extract_known` | `lean/States.lean`:108 | fechado |
| `global_propagation_theorem` | `lean/Propagation.lean`:91 | fechado |
| `global_stability` | `lean/Stability.lean`:110 | fechado |
| `id_compose_left` | `lean/Transformations.lean`:114 | fechado |
| `identity_witnesses_non_triviality` | `lean/Consistency.lean`:86 | condicional |
| `ipropagating_propagates` | `lean/Propagation.lean`:14 | fechado |
| `isIndeterminate_I` | `lean/States.lean`:80 | fechado |
| `isIndeterminate_known` | `lean/States.lean`:84 | fechado |
| `isKnown_I` | `lean/States.lean`:88 | fechado |
| `isKnown_known` | `lean/States.lean`:92 | fechado |
| `known_ne_I` | `lean/Axioms.lean`:108 | condicional |
| `known_ne_indeterminate` | `lean/Consistency.lean`:14 | condicional |
| `liftTransformation_identityPreserving` | `lean/Definitions.lean`:82 | fechado |
| `liftTransformation_is_stable` | `lean/Stability.lean`:51 | fechado |
| `liftTransformation_propagates` | `lean/Definitions.lean`:76 | fechado |
| `liftTransformation_propagatesI` | `lean/Definitions.lean`:92 | nao_alcancado |
| `liftTransformation_stable` | `lean/Definitions.lean`:87 | fechado |
| `lift_preserves_I` | `lean/Axioms.lean`:113 | condicional |
| `lift_propagates_I` | `lean/Propagation.lean`:25 | fechado |
| `meta_add_I_left` | `lean/Operators.lean`:70 | nao_alcancado |
| `meta_add_I_right` | `lean/Operators.lean`:77 | nao_alcancado |
| `meta_compose_preserves_I` | `lean/Operators.lean`:92 | nao_alcancado |
| `meta_lift1_I` | `lean/Operators.lean`:108 | fechado |
| `meta_lift2_I_left` | `lean/Operators.lean`:103 | nao_alcancado |
| `meta_mul_I_left` | `lean/Operators.lean`:82 | nao_alcancado |
| `meta_mul_I_right` | `lean/Operators.lean`:87 | nao_alcancado |
| `propagation_chain_stays_indeterminate` | `lean/Propagation.lean`:68 | aberto-sorry |
| `propagation_does_not_create_known` | `lean/Propagation.lean`:59 | fechado |
| `propagation_not_determinising` | `lean/Propagation.lean`:77 | nao_alcancado |
| `stable_known_not_I` | `lean/Stability.lean`:29 | condicional |
| `stable_maps_I_to_I` | `lean/Stability.lean`:23 | fechado |
| `stable_maps_known_to_known` | `lean/Stability.lean`:14 | fechado |
| `stable_preserves_determinate` | `lean/Stability.lean`:56 | fechado |
| `stable_preserves_indeterminate` | `lean/Stability.lean`:66 | fechado |
| `system_not_trivially_inconsistent` | `lean/Consistency.lean`:70 | condicional |
| `system_stability_theorem` | `lean/Stability.lean`:75 | fechado |
| `valid_compose_stable` | `lean/Stability.lean`:37 | aberto-sorry |
| `valid_does_not_indeterminate` | `lean/Stability.lean`:92 | condicional |
| `valid_does_not_resolve` | `lean/Stability.lean`:101 | fechado |
| `valid_propagates` | `lean/Propagation.lean`:30 | fechado |
| `zeroCollapse_propagates_I` | `lean/Transformations.lean`:97 | fechado |
