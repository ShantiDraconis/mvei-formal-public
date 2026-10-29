# i-constant-core — branch `work/t-state-calculus-v0`

Lean sources from the branch `work/t-state-calculus-v0` of the private repository `ShantiDraconis/i-constant-core`, commit `52c2fc60985d796934eecb823ac31535322c9b7b` (2026-09-20T13:50:59+01:00), that hold theorems found only on branches (no default branch of any repository has a theorem with the same name). Published here: the files with the theorems the kernel closed, the local files they import and the Lake files of their project.

* Branch state: parada (not in the default branch).
* Theorems only on branches, in this branch: 54 — closed 54, conditional 0, open 0, proof error 0, not reached 0, no result 0.
* History: 47 commit(s) of this branch that are not in the default branch, with date and subject, in `certificate.json`.
* `certificate.json` (SHA-256 of its content: `897ba4f5ee408021e377c1591762e76ecfe783aa51028215c24f1a67a88f91b5`) lists every theorem with its state and the axioms beyond the standard three, and the SHA-256 of every published file. From the repository root: `sha256sum -c mvei/branches/i-constant-core/work_t-state-calculus-v0/SOURCES.sha256`.

Closed means the kernel accepted the proof and it depends only on `propext`, `Classical.choice` and `Quot.sound`; it proves the statement written in the file and is not a claim that an open problem is solved.

| Theorem | File | State |
|---|---|---|
| `TState.BridgeCertificate.valid` | `t-state/lean/TState/Bridge.lean`:16 | fechado |
| `TState.CollapseEvent.conservative_covers` | `t-state/lean/TState/Collapse.lean`:38 | fechado |
| `TState.CollapseEvent.conservative_separates` | `t-state/lean/TState/Collapse.lean`:41 | fechado |
| `TState.DomainMorphism.comp_map` | `t-state/lean/TState/DomainMorphisms.lean`:35 | fechado |
| `TState.DomainMorphism.id_map` | `t-state/lean/TState/DomainMorphisms.lean`:32 | fechado |
| `TState.Horizon.neg_neg` | `t-state/lean/TState/Core.lean`:37 | fechado |
| `TState.LimitArithmetic.add_opposite_infinities` | `t-state/lean/TState/LimitArithmetic.lean`:68 | fechado |
| `TState.LimitArithmetic.div_posInfinity_posInfinity` | `t-state/lean/TState/LimitArithmetic.lean`:77 | fechado |
| `TState.LimitArithmetic.mul_zero_posInfinity` | `t-state/lean/TState/LimitArithmetic.lean`:72 | fechado |
| `TState.Outcome.map_exact` | `t-state/lean/TState/Outcome.lean`:21 | fechado |
| `TState.Outcome.map_undefined` | `t-state/lean/TState/Outcome.lean`:24 | fechado |
| `TState.Phase.flip_flip` | `t-state/lean/TState/Core.lean`:19 | fechado |
| `TState.ProjectiveReal.reciprocal_infinity` | `t-state/lean/TState/Projective.lean`:16 | fechado |
| `TState.ProjectiveReal.reciprocal_involutive` | `t-state/lean/TState/Projective.lean`:27 | fechado |
| `TState.ProjectiveReal.reciprocal_nonzero` | `t-state/lean/TState/Projective.lean`:23 | fechado |
| `TState.ProjectiveReal.reciprocal_zero` | `t-state/lean/TState/Projective.lean`:19 | fechado |
| `TState.State.negate_involutive` | `t-state/lean/TState/Core.lean`:84 | fechado |
| `TState.State.next_posInfinity_at` | `t-state/lean/TState/Boundary.lean`:34 | fechado |
| `TState.State.next_posInfinity_before` | `t-state/lean/TState/Boundary.lean`:31 | fechado |
| `TState.State.next_zero_at` | `t-state/lean/TState/Boundary.lean`:28 | fechado |
| `TState.State.next_zero_before` | `t-state/lean/TState/Boundary.lean`:25 | fechado |
| `TState.State.prev_zero_after` | `t-state/lean/TState/Boundary.lean`:37 | fechado |
| `TState.StateArithmetic.add_finite` | `t-state/lean/TState/Arithmetic.lean`:50 | fechado |
| `TState.StateArithmetic.div_finite_nonzero` | `t-state/lean/TState/Arithmetic.lean`:65 | fechado |
| `TState.StateArithmetic.div_nonzero_zero` | `t-state/lean/TState/Arithmetic.lean`:61 | fechado |
| `TState.StateArithmetic.div_zero_zero` | `t-state/lean/TState/Arithmetic.lean`:56 | fechado |
| `TState.StateArithmetic.inv_negInfinity_after` | `t-state/lean/TState/Arithmetic.lean`:78 | fechado |
| `TState.StateArithmetic.inv_posInfinity_before` | `t-state/lean/TState/Arithmetic.lean`:75 | fechado |
| `TState.StateArithmetic.inv_zero_after` | `t-state/lean/TState/Arithmetic.lean`:72 | fechado |
| `TState.StateArithmetic.inv_zero_before` | `t-state/lean/TState/Arithmetic.lean`:69 | fechado |
| `TState.StateArithmetic.mul_finite` | `t-state/lean/TState/Arithmetic.lean`:53 | fechado |
| `TState.StateSystem.firstHit_unique` | `t-state/lean/TState/Dynamics.lean`:38 | fechado |
| `TState.boundary_after_to_at` | `t-state/lean/TState/Laws.lean`:19 | fechado |
| `TState.boundary_at_to_after` | `t-state/lean/TState/Laws.lean`:15 | fechado |
| `TState.boundary_before_to_at` | `t-state/lean/TState/Laws.lean`:10 | fechado |
| `TState.bridge_allNegative_refutes_existential` | `t-state/lean/TState/Claims.lean`:67 | fechado |
| `TState.bridge_allPositive_proves_universal` | `t-state/lean/TState/Claims.lean`:37 | fechado |
| `TState.bridge_certificate_closes_model` | `t-state/lean/TState/Laws.lean`:34 | fechado |
| `TState.bridge_negativeWitness_refutes_universal` | `t-state/lean/TState/Claims.lean`:55 | fechado |
| `TState.bridge_positiveWitness_proves_existential` | `t-state/lean/TState/Claims.lean`:46 | fechado |
| `TState.exclusive_iff_no_overlap` | `t-state/lean/TState/Characterization.lean`:25 | fechado |
| `TState.exhaustive_iff_no_gap` | `t-state/lean/TState/Characterization.lean`:4 | fechado |
| `TState.gapWitness_refutes_exhaustive` | `t-state/lean/TState/Endpoint.lean`:42 | fechado |
| `TState.one_over_zero_classification` | `t-state/lean/TState/Laws.lean`:29 | fechado |
| `TState.overlapWitness_refutes_exclusive` | `t-state/lean/TState/Endpoint.lean`:50 | fechado |
| `TState.sigma_assoc` | `t-state/lean/TState/Operators.lean`:32 | fechado |
| `TState.sigma_comm` | `t-state/lean/TState/Operators.lean`:26 | fechado |
| `TState.sigma_omega` | `t-state/lean/TState/Operators.lean`:38 | fechado |
| `TState.validEndpoint_iff_witness_free_adequate` | `t-state/lean/TState/Characterization.lean`:41 | fechado |
| `TState.validEndpoint_no_gap` | `t-state/lean/TState/Laws.lean`:40 | fechado |
| `TState.validEndpoint_no_overlap` | `t-state/lean/TState/Laws.lean`:48 | fechado |
| `TState.wrapped_after_posInfinity` | `t-state/lean/TState/WrappedHorizon.lean`:13 | fechado |
| `TState.wrapped_contains_structural` | `t-state/lean/TState/WrappedHorizon.lean`:17 | fechado |
| `TState.zero_over_zero_classification` | `t-state/lean/TState/Laws.lean`:23 | fechado |
