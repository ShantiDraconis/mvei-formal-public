# Universe-0-0 — branch `copilot/implement-certificacao-protocolo-unico`

Lean sources from the branch `copilot/implement-certificacao-protocolo-unico` of the private repository `ShantiDraconis/Universe-0-0`, commit `e8743b337d9ece01ac193ca7eb9cc26b0a03b3cb` (2025-12-27T15:53:24+00:00), that hold theorems found only on branches (no default branch of any repository has a theorem with the same name). Published here: the files with the theorems the kernel closed, the local files they import and the Lake files of their project.

* Branch state: parada (not in the default branch).
* Theorems only on branches, in this branch: 37 — closed 13, conditional 0, open 11, proof error 13, not reached 0, no result 0.
* History: 5 commit(s) of this branch that are not in the default branch, with date and subject, in `certificate.json`.
* `certificate.json` (SHA-256 of its content: `048717d92480fa9ffd1932a6bb29569789e7c116b97c4c96cbf60e5ccbe1026e`) lists every theorem with its state and the axioms beyond the standard three, and the SHA-256 of every published file. From the repository root: `sha256sum -c mvei/branches/Universe-0-0/copilot_implement-certificacao-protocolo-unico/SOURCES.sha256`.

Closed means the kernel accepted the proof and it depends only on `propext`, `Classical.choice` and `Quot.sound`; it proves the statement written in the file and is not a claim that an open problem is solved.

| Theorem | File | State |
|---|---|---|
| `CalabiYau41D.calabi_yau_is_ricci_flat` | `provers/lean/CalabiYau/Manifold41D.lean`:107 | erro |
| `CalabiYau41D.compactification_preserves_susy` | `provers/lean/CalabiYau/Manifold41D.lean`:139 | erro |
| `CalabiYau41D.dimension_is_prime` | `provers/lean/CalabiYau/Manifold41D.lean`:42 | fechado |
| `CalabiYau41D.holomorphic_volume_form_exists` | `provers/lean/CalabiYau/Manifold41D.lean`:205 | erro |
| `CalabiYau41D.mass_gap_from_geometry` | `provers/lean/CalabiYau/Manifold41D.lean`:157 | erro |
| `CalabiYau41D.moduli_real_dimension` | `provers/lean/CalabiYau/Manifold41D.lean`:190 | fechado |
| `CalabiYau41D.respects_I_axioms` | `provers/lean/CalabiYau/Manifold41D.lean`:221 | fechado |
| `GodelDecidability.PvsNP_decidable` | `provers/lean/LogicFoundations/GodelDecidability.lean`:171 | fechado |
| `GodelDecidability.RH_decidable` | `provers/lean/LogicFoundations/GodelDecidability.lean`:158 | aberto-sorry |
| `GodelDecidability.decidability_respects_I` | `provers/lean/LogicFoundations/GodelDecidability.lean`:242 | erro |
| `GodelDecidability.eigenvalue_decidable` | `provers/lean/LogicFoundations/GodelDecidability.lean`:91 | aberto-sorry |
| `GodelDecidability.finite_dimensional_decidable` | `provers/lean/LogicFoundations/GodelDecidability.lean`:76 | aberto-sorry |
| `GodelDecidability.godel_ensures_consistency` | `provers/lean/LogicFoundations/GodelDecidability.lean`:113 | fechado |
| `GodelDecidability.godel_positive` | `provers/lean/LogicFoundations/GodelDecidability.lean`:106 | fechado |
| `GodelDecidability.ground_state_decidable` | `provers/lean/LogicFoundations/GodelDecidability.lean`:129 | aberto-sorry |
| `GodelDecidability.physics_realizable` | `provers/lean/LogicFoundations/GodelDecidability.lean`:207 | fechado |
| `GodelDecidability.spectral_gap_decidable` | `provers/lean/LogicFoundations/GodelDecidability.lean`:141 | aberto-sorry |
| `GodelDecidability.toe_avoids_halting` | `provers/lean/LogicFoundations/GodelDecidability.lean`:218 | erro |
| `GodelDecidability.toe_completely_decidable` | `provers/lean/LogicFoundations/GodelDecidability.lean`:264 | fechado |
| `NonCommutativeGeometry.atiyah_singer_index` | `provers/lean/SpectralGeometry/DiracOperator.lean`:219 | aberto-sorry |
| `NonCommutativeGeometry.beta_zero_conformal` | `provers/lean/SpectralGeometry/DiracOperator.lean`:132 | aberto-sorry |
| `NonCommutativeGeometry.compact_resolvent_prevents_singularities` | `provers/lean/SpectralGeometry/DiracOperator.lean`:178 | erro |
| `NonCommutativeGeometry.dimensional_regularization_finite` | `provers/lean/SpectralGeometry/DiracOperator.lean`:201 | erro |
| `NonCommutativeGeometry.k_theory_prevents_singularities` | `provers/lean/SpectralGeometry/DiracOperator.lean`:83 | erro |
| `NonCommutativeGeometry.spectral_action_gives_einstein` | `provers/lean/SpectralGeometry/DiracOperator.lean`:103 | aberto-sorry |
| `NonCommutativeGeometry.spectral_respects_I_axioms` | `provers/lean/SpectralGeometry/DiracOperator.lean`:240 | aberto-sorry |
| `NonCommutativeGeometry.spectral_zeta_connects_riemann` | `provers/lean/SpectralGeometry/DiracOperator.lean`:233 | aberto-sorry |
| `NonCommutativeGeometry.universal_has_spectral_decomposition` | `provers/lean/SpectralGeometry/DiracOperator.lean`:160 | erro |
| `TOEAudit.audit_implies_soundness` | `provers/lean/TOEAudit/AuditScript.lean`:160 | fechado |
| `TOEAudit.axioms_independent` | `provers/lean/TOEAudit/AuditScript.lean`:60 | aberto-sorry |
| `TOEAudit.dimension_must_be_41` | `provers/lean/TOEAudit/AuditScript.lean`:127 | erro |
| `TOEAudit.parameter_stress_test` | `provers/lean/TOEAudit/AuditScript.lean`:113 | erro |
| `TOEAudit.proof_search_terminates` | `provers/lean/TOEAudit/AuditScript.lean`:210 | fechado |
| `TOEAudit.regression_test_1` | `provers/lean/TOEAudit/AuditScript.lean`:191 | fechado |
| `TOEAudit.regression_test_2` | `provers/lean/TOEAudit/AuditScript.lean`:199 | erro |
| `TOEAudit.toe_certified` | `provers/lean/TOEAudit/AuditScript.lean`:219 | fechado |
| `TOEAudit.toe_well_founded` | `provers/lean/TOEAudit/AuditScript.lean`:87 | fechado |
