# Riemann-energy-proofline — branch `copilot/add-final-tree-structure`

Lean sources from the branch `copilot/add-final-tree-structure` of the private repository `ShantiDraconis/Riemann-energy-proofline`, commit `c87b155bfae60825b920c1041f6d4fa649cc351e` (2025-12-02T14:05:51+00:00), that hold theorems found only on branches (no default branch of any repository has a theorem with the same name). Published here: the files with the theorems the kernel closed, the local files they import and the Lake files of their project.

* Branch state: parada (not in the default branch).
* Theorems only on branches, in this branch: 60 — closed 4, conditional 0, open 12, proof error 2, not reached 42, no result 0.
* History: 3 commit(s) of this branch that are not in the default branch, with date and subject, in `certificate.json`.
* `certificate.json` (SHA-256 of its content: `968869bc152acc98718b2b2cc37c0e908fda626b8eaa5f931a1cbfe05e4f9023`) lists every theorem with its state and the axioms beyond the standard three, and the SHA-256 of every published file. From the repository root: `sha256sum -c mvei/branches/Riemann-energy-proofline/copilot_add-final-tree-structure/SOURCES.sha256`.

Closed means the kernel accepted the proof and it depends only on `propext`, `Classical.choice` and `Quot.sound`; it proves the statement written in the file and is not a claim that an open problem is solved.

| Theorem | File | State |
|---|---|---|
| `Riemann.Asymptotics.energy_asymptotic_at_one` | `src/lean/Riemann/Asymptotics/Edges.lean`:28 | nao_alcancado |
| `Riemann.Asymptotics.energy_asymptotic_at_zero` | `src/lean/Riemann/Asymptotics/Edges.lean`:23 | nao_alcancado |
| `Riemann.Asymptotics.energy_taylor_at_half` | `src/lean/Riemann/Asymptotics/Edges.lean`:46 | nao_alcancado |
| `Riemann.Asymptotics.xi_large_t_decay` | `src/lean/Riemann/Asymptotics/Edges.lean`:35 | nao_alcancado |
| `Riemann.Asymptotics.zero_free_near_one` | `src/lean/Riemann/Asymptotics/Edges.lean`:41 | nao_alcancado |
| `Riemann.Energy.energyFunctional''_symmetric` | `src/lean/Riemann/Energy/SymmetryStationary.lean`:43 | nao_alcancado |
| `Riemann.Energy.energyFunctional'_antisymmetric` | `src/lean/Riemann/Energy/SymmetryStationary.lean`:36 | nao_alcancado |
| `Riemann.Energy.energyFunctional_continuous` | `src/lean/Riemann/Energy/Edef.lean`:52 | aberto-sorry |
| `Riemann.Energy.energyFunctional_odd_derivatives_zero` | `src/lean/Riemann/Energy/SymmetryStationary.lean`:50 | nao_alcancado |
| `Riemann.Energy.energyFunctional_pos` | `src/lean/Riemann/Energy/Edef.lean`:47 | aberto-sorry |
| `Riemann.Energy.energyFunctional_smooth` | `src/lean/Riemann/Energy/Edef.lean`:56 | aberto-sorry |
| `Riemann.Energy.energyFunctional_stationary_half` | `src/lean/Riemann/Energy/SymmetryStationary.lean`:29 | nao_alcancado |
| `Riemann.Energy.energyFunctional_symmetric` | `src/lean/Riemann/Energy/SymmetryStationary.lean`:20 | nao_alcancado |
| `Riemann.Gaps.RH_from_gaps` | `src/lean/Riemann/Gaps/G3_ZeroMinimumPrinciple.lean`:53 | nao_alcancado |
| `Riemann.Gaps.energy_boundary_behavior` | `src/lean/Riemann/Gaps/G2_UniqueGlobalMin.lean`:36 | nao_alcancado |
| `Riemann.Gaps.energy_strictly_convex` | `src/lean/Riemann/Gaps/G1_CurvaturePos.lean`:38 | nao_alcancado |
| `Riemann.Gaps.energy_tends_to_infinity_at_one` | `src/lean/Riemann/Gaps/G2_UniqueGlobalMin.lean`:30 | nao_alcancado |
| `Riemann.Gaps.energy_tends_to_infinity_at_zero` | `src/lean/Riemann/Gaps/G2_UniqueGlobalMin.lean`:26 | nao_alcancado |
| `Riemann.Gaps.gap_G1` | `src/lean/Riemann/Gaps/G1_CurvaturePos.lean`:25 | nao_alcancado |
| `Riemann.Gaps.gap_G1_at_half` | `src/lean/Riemann/Gaps/G1_CurvaturePos.lean`:44 | nao_alcancado |
| `Riemann.Gaps.gap_G1_numerical_evidence` | `src/lean/Riemann/Gaps/G1_CurvaturePos.lean`:50 | nao_alcancado |
| `Riemann.Gaps.gap_G2` | `src/lean/Riemann/Gaps/G2_UniqueGlobalMin.lean`:41 | nao_alcancado |
| `Riemann.Gaps.gap_G2_location` | `src/lean/Riemann/Gaps/G2_UniqueGlobalMin.lean`:54 | nao_alcancado |
| `Riemann.Gaps.gap_G3` | `src/lean/Riemann/Gaps/G3_ZeroMinimumPrinciple.lean`:34 | nao_alcancado |
| `Riemann.Gaps.gap_G3_contrapositive` | `src/lean/Riemann/Gaps/G3_ZeroMinimumPrinciple.lean`:47 | nao_alcancado |
| `Riemann.Gaps.off_critical_zero_contribution` | `src/lean/Riemann/Gaps/G3_ZeroMinimumPrinciple.lean`:27 | nao_alcancado |
| `Riemann.Geometry.level_sets_connected` | `src/lean/Riemann/Geometry/PotentialValley.lean`:51 | nao_alcancado |
| `Riemann.Geometry.valley_implies_G2` | `src/lean/Riemann/Geometry/PotentialValley.lean`:34 | nao_alcancado |
| `Riemann.Operators.energy_as_trace` | `src/lean/Riemann/Operators/KernelIntegral.lean`:44 | nao_alcancado |
| `Riemann.Operators.gue_statistics_evidence` | `src/lean/Riemann/Operators/ORH_Criterion.lean`:40 | nao_alcancado |
| `Riemann.Operators.operator_positivity_implies_curvature` | `src/lean/Riemann/Operators/ORH_Criterion.lean`:29 | nao_alcancado |
| `Riemann.Operators.spectral_determinant_relation` | `src/lean/Riemann/Operators/ORH_Criterion.lean`:36 | nao_alcancado |
| `Riemann.RMT.keating_snaith_moments` | `src/lean/Riemann/RMT/Statistics.lean`:36 | aberto-sorry |
| `Riemann.RMT.level_repulsion` | `src/lean/Riemann/RMT/Statistics.lean`:32 | aberto-sorry |
| `Riemann.RMT.montgomery_pair_correlation` | `src/lean/Riemann/RMT/Statistics.lean`:24 | aberto-sorry |
| `Riemann.RMT.statistical_tests_pass` | `src/lean/Riemann/RMT/Statistics.lean`:40 | fechado |
| `Riemann.Scenarios.arithmetical_consequences` | `src/lean/Riemann/Scenarios/Independent.lean`:34 | nao_alcancado |
| `Riemann.Scenarios.counterexample_detectable` | `src/lean/Riemann/Scenarios/False.lean`:44 | nao_alcancado |
| `Riemann.Scenarios.expert_consensus` | `src/lean/Riemann/Scenarios/Independent.lean`:48 | nao_alcancado |
| `Riemann.Scenarios.gap_failure_under_rh_false` | `src/lean/Riemann/Scenarios/False.lean`:33 | nao_alcancado |
| `Riemann.Scenarios.gaps_hold_under_rh` | `src/lean/Riemann/Scenarios/True.lean`:44 | nao_alcancado |
| `Riemann.Scenarios.gaps_might_be_independent` | `src/lean/Riemann/Scenarios/Independent.lean`:43 | nao_alcancado |
| `Riemann.Scenarios.independence_heuristic` | `src/lean/Riemann/Scenarios/Independent.lean`:40 | nao_alcancado |
| `Riemann.Scenarios.independence_implications` | `src/lean/Riemann/Scenarios/Independent.lean`:28 | nao_alcancado |
| `Riemann.Scenarios.off_critical_zeros_paired` | `src/lean/Riemann/Scenarios/False.lean`:49 | nao_alcancado |
| `Riemann.Scenarios.prime_counting_error` | `src/lean/Riemann/Scenarios/True.lean`:27 | nao_alcancado |
| `Riemann.Scenarios.prime_gap_bound` | `src/lean/Riemann/Scenarios/True.lean`:36 | nao_alcancado |
| `Riemann.Scenarios.rh_false_implies_energy_anomaly` | `src/lean/Riemann/Scenarios/False.lean`:26 | nao_alcancado |
| `Riemann.Scenarios.rh_implies_energy_minimum` | `src/lean/Riemann/Scenarios/True.lean`:22 | nao_alcancado |
| `Riemann.criticalLine_subset_criticalStrip` | `src/lean/Riemann/Classical/CriticalStrip.lean`:28 | fechado |
| `Riemann.criticalStrip_ne_zero` | `src/lean/Riemann/Classical/CriticalStrip.lean`:37 | fechado |
| `Riemann.criticalStrip_symmetric` | `src/lean/Riemann/Classical/CriticalStrip.lean`:44 | fechado |
| `Riemann.riemannXi_entire` | `src/lean/Riemann/Classical/ZetaXi.lean`:34 | aberto-sorry |
| `Riemann.riemannXi_functional_equation` | `src/lean/Riemann/Classical/ZetaXi.lean`:37 | aberto-sorry |
| `Riemann.riemannXi_real_on_critical_line` | `src/lean/Riemann/Classical/ZetaXi.lean`:41 | aberto-sorry |
| `Riemann.zero_counting_asymptotic` | `src/lean/Riemann/Classical/Zeros.lean`:50 | aberto-sorry |
| `Riemann.zeros_conjugate` | `src/lean/Riemann/Classical/Zeros.lean`:43 | erro |
| `Riemann.zeros_correspondence` | `src/lean/Riemann/Classical/ZetaXi.lean`:45 | aberto-sorry |
| `Riemann.zeros_in_critical_strip` | `src/lean/Riemann/Classical/Zeros.lean`:29 | aberto-sorry |
| `Riemann.zeros_symmetric` | `src/lean/Riemann/Classical/Zeros.lean`:36 | erro |
