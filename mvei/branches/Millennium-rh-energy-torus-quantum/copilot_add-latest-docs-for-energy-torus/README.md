# Millennium-rh-energy-torus-quantum — branch `copilot/add-latest-docs-for-energy-torus`

Lean sources from the branch `copilot/add-latest-docs-for-energy-torus` of the private repository `ShantiDraconis/Millennium-rh-energy-torus-quantum`, commit `4acc9a232abdbd0d4bf4d76ae6dbc038e772040d` (2025-12-02T16:38:14+00:00), that hold theorems found only on branches (no default branch of any repository has a theorem with the same name). Published here: the files with the theorems the kernel closed, the local files they import and the Lake files of their project.

* Branch state: parada (not in the default branch).
* Theorems only on branches, in this branch: 52 — closed 6, conditional 3, open 34, proof error 7, not reached 2, no result 0.
* History: 4 commit(s) of this branch that are not in the default branch, with date and subject, in `certificate.json`.
* `certificate.json` (SHA-256 of its content: `759063ed7898292b2f5c6adf475aa2b510800177741d3da2b69e45602f6733dd`) lists every theorem with its state and the axioms beyond the standard three, and the SHA-256 of every published file. From the repository root: `sha256sum -c mvei/branches/Millennium-rh-energy-torus-quantum/copilot_add-latest-docs-for-energy-torus/SOURCES.sha256`.

Closed means the kernel accepted the proof and it depends only on `propext`, `Classical.choice` and `Quot.sound`; it proves the statement written in the file and is not a claim that an open problem is solved.

| Theorem | File | State |
|---|---|---|
| `Riemann.C1_nonneg` | `src/lean/Riemann/SymmetryAndDerivative.lean`:59 | aberto-sorry |
| `Riemann.C1_symmetric` | `src/lean/Riemann/SymmetryAndDerivative.lean`:64 | aberto-sorry |
| `Riemann.C2_symmetric` | `src/lean/Riemann/SymmetryAndDerivative.lean`:69 | aberto-sorry |
| `Riemann.RF1_characterization` | `src/lean/Riemann/RefutationRF1.lean`:20 | aberto-sorry |
| `Riemann.RF1_creates_extra_critical_points` | `src/lean/Riemann/RefutationRF1.lean`:53 | aberto-sorry |
| `Riemann.RF1_numerical_criterion` | `src/lean/Riemann/RefutationRF1.lean`:59 | aberto-sorry |
| `Riemann.RF1_refutation` | `src/lean/Riemann/RefutationRF1.lean`:13 | aberto-sorry |
| `Riemann.RF2_numerical_criterion` | `src/lean/Riemann/RefutationRF2.lean`:73 | condicional |
| `Riemann.RF2_refutation` | `src/lean/Riemann/RefutationRF2.lean`:43 | condicional |
| `Riemann.RF3_numerical_criterion` | `src/lean/Riemann/RefutationRF3.lean`:98 | aberto-sorry |
| `Riemann.RF3_refutation` | `src/lean/Riemann/RefutationRF3.lean`:73 | aberto-sorry |
| `Riemann.RH_geometric_characterization` | `src/lean/Riemann/RHTruthFramework.lean`:68 | aberto-sorry |
| `Riemann.RH_implies_standard_morse` | `src/lean/Riemann/RefutationRF3.lean`:91 | aberto-sorry |
| `Riemann.RH_implies_unique_minimum` | `src/lean/Riemann/CurvatureDecomposition.lean`:63 | aberto-sorry |
| `Riemann.any_refutation_implies_not_RH` | `src/lean/Riemann/RHTruthFramework.lean`:29 | aberto-sorry |
| `Riemann.critical_line_angle` | `src/lean/Riemann/TorusCompactification.lean`:76 | fechado |
| `Riemann.critical_line_is_minimum` | `src/lean/Riemann/SymmetryAndDerivative.lean`:39 | aberto-sorry |
| `Riemann.curvatureC1_nonneg` | `src/lean/Riemann/CurvatureDecomposition.lean`:27 | aberto-sorry |
| `Riemann.curvatureC1_symmetric` | `src/lean/Riemann/CurvatureDecomposition.lean`:42 | aberto-sorry |
| `Riemann.curvatureC2_symmetric` | `src/lean/Riemann/CurvatureDecomposition.lean`:48 | aberto-sorry |
| `Riemann.energy_derivative_zero_at_half` | `src/lean/Riemann/SymmetryAndDerivative.lean`:23 | aberto-sorry |
| `Riemann.energy_nonneg` | `src/lean/Riemann/WeightAndEnergy.lean`:43 | aberto-sorry |
| `Riemann.energy_symmetric` | `src/lean/Riemann/WeightAndEnergy.lean`:63 | aberto-sorry |
| `Riemann.euler_violation_implies_inconsistency` | `src/lean/Riemann/RefutationRF3.lean`:55 | aberto-sorry |
| `Riemann.extra_valley_search_compact` | `src/lean/Riemann/ExtraValleyAxioms.lean`:72 | fechado |
| `Riemann.extra_valley_symmetry` | `src/lean/Riemann/ExtraValleyAxioms.lean`:35 | aberto-sorry |
| `Riemann.extra_valleys_paired` | `src/lean/Riemann/ExtraValleyAxioms.lean`:58 | aberto-sorry |
| `Riemann.gauss_bonnet` | `src/lean/Riemann/TorusCompactification.lean`:70 | aberto-sorry |
| `Riemann.geometric_equivalences` | `src/lean/Riemann/RHTruthFramework.lean`:60 | nao_alcancado |
| `Riemann.minimum_critical_points` | `src/lean/Riemann/MorseSetup.lean`:75 | aberto-sorry |
| `Riemann.morse_euler` | `src/lean/Riemann/MorseSetup.lean`:68 | aberto-sorry |
| `Riemann.no_extra_valleys_consistent_with_RH` | `src/lean/Riemann/ExtraValleyAxioms.lean`:65 | aberto-sorry |
| `Riemann.no_refutation_consistent_with_RH` | `src/lean/Riemann/RHTruthFramework.lean`:48 | aberto-sorry |
| `Riemann.nondegenerate_consistent_with_RH` | `src/lean/Riemann/RefutationRF2.lean`:54 | condicional |
| `Riemann.off_critical_minimum_implies_extra_valley` | `src/lean/Riemann/RefutationRF3.lean`:62 | aberto-sorry |
| `Riemann.positive_curvature_implies_minimum` | `src/lean/Riemann/CurvatureDecomposition.lean`:54 | aberto-sorry |
| `Riemann.positive_gap_implies_nondegenerate` | `src/lean/Riemann/RefutationRF2.lean`:67 | aberto-sorry |
| `Riemann.potential_symmetric` | `src/lean/Riemann/WeightAndEnergy.lean`:52 | nao_alcancado |
| `Riemann.strip_angles_inverse` | `src/lean/Riemann/TorusCompactification.lean`:40 | aberto-sorry |
| `Riemann.torus_euler_characteristic` | `src/lean/Riemann/TorusCompactification.lean`:67 | fechado |
| `Riemann.unique_minimum_implies_no_RF1` | `src/lean/Riemann/RefutationRF1.lean`:37 | aberto-sorry |
| `Riemann.zero_conjugate_symmetry` | `src/lean/Riemann/BasicZetaXi.lean`:70 | erro |
| `Riemann.zero_symmetry` | `src/lean/Riemann/BasicZetaXi.lean`:52 | aberto-sorry |
| `Util.ComplexAnalysis.complex_cauchy_schwarz` | `src/lean/Util/ComplexAnalysisTools.lean`:28 | erro |
| `Util.ComplexAnalysis.normSq_conj` | `src/lean/Util/ComplexAnalysisTools.lean`:20 | erro |
| `Util.ComplexAnalysis.normSq_eq_re_sq_add_im_sq` | `src/lean/Util/ComplexAnalysisTools.lean`:11 | fechado |
| `Util.ComplexAnalysis.normSq_mul` | `src/lean/Util/ComplexAnalysisTools.lean`:16 | erro |
| `Util.ComplexAnalysis.re_mul_conj` | `src/lean/Util/ComplexAnalysisTools.lean`:24 | erro |
| `Util.MeasureTheory.integral_nonneg_of_nonneg` | `src/lean/Util/MeasureTheoryTools.lean`:11 | erro |
| `Util.MeasureTheory.integral_rectangle` | `src/lean/Util/MeasureTheoryTools.lean`:25 | erro |
| `Util.TopologyTorus.euler_char_torus` | `src/lean/Util/TopologyTorusTools.lean`:20 | fechado |
| `Util.TopologyTorus.euler_from_betti` | `src/lean/Util/TopologyTorusTools.lean`:29 | fechado |
