# Riemann-energy-proofline — branch `copilot/add-energy-torus-model`

Lean sources from the branch `copilot/add-energy-torus-model` of the private repository `ShantiDraconis/Riemann-energy-proofline`, commit `4308ee22acad3bbdf05459b43de89847e52d2714` (2025-12-02T14:49:31+00:00), that hold theorems found only on branches (no default branch of any repository has a theorem with the same name). Published here: the files with the theorems the kernel closed, the local files they import and the Lake files of their project.

* Branch state: parada (not in the default branch).
* Theorems only on branches, in this branch: 25 — closed 3, conditional 1, open 16, proof error 0, not reached 5, no result 0.
* History: 3 commit(s) of this branch that are not in the default branch, with date and subject, in `certificate.json`.
* `certificate.json` (SHA-256 of its content: `0ae279fbbd5f9aeda3bd86471ce486bc0cafbac63d8d2dcbb5acc28b23d1b86c`) lists every theorem with its state and the axioms beyond the standard three, and the SHA-256 of every published file. From the repository root: `sha256sum -c mvei/branches/Riemann-energy-proofline/copilot_add-energy-torus-model/SOURCES.sha256`.

Closed means the kernel accepted the proof and it depends only on `propext`, `Classical.choice` and `Quot.sound`; it proves the statement written in the file and is not a claim that an open problem is solved.

| Theorem | File | State |
|---|---|---|
| `Riemann.E''_symmetric` | `src/lean/Riemann/CurvatureDecomposition.lean`:33 | aberto-sorry |
| `Riemann.E'_antisymmetric` | `src/lean/Riemann/SymmetryAndDerivative.lean`:30 | aberto-sorry |
| `Riemann.E'_half_zero` | `src/lean/Riemann/SymmetryAndDerivative.lean`:37 | aberto-sorry |
| `Riemann.E_symmetric` | `src/lean/Riemann/SymmetryAndDerivative.lean`:21 | nao_alcancado |
| `Riemann.RF1_iff_not_RH_partial` | `src/lean/Riemann/RefutationRF1.lean`:30 | aberto-sorry |
| `Riemann.RF1_implies_not_RH` | `src/lean/Riemann/RefutationRF1.lean`:15 | aberto-sorry |
| `Riemann.RF2_cases` | `src/lean/Riemann/RefutationRF2.lean`:22 | aberto-sorry |
| `Riemann.RF2_implies_not_RH` | `src/lean/Riemann/RefutationRF2.lean`:40 | aberto-sorry |
| `Riemann.RF3_indicates_limitation` | `src/lean/Riemann/RefutationRF3.lean`:27 | fechado |
| `Riemann.RH_implies_not_RF1` | `src/lean/Riemann/RefutationRF1.lean`:24 | aberto-sorry |
| `Riemann.RH_implies_positive_curvature` | `src/lean/Riemann/RefutationRF2.lean`:48 | nao_alcancado |
| `Riemann.RH_implies_strict_min` | `src/lean/Riemann/RefutationRF2.lean`:58 | aberto-sorry |
| `Riemann.Util.integrable_on_Icc` | `src/lean/Util/MeasureTheoryTools.lean`:13 | aberto-sorry |
| `Riemann.critical_line_is_critical_point` | `src/lean/Riemann/SymmetryAndDerivative.lean`:44 | aberto-sorry |
| `Riemann.extra_valley_at_same_level_implies_RF1` | `src/lean/Riemann/ExtraValleyAxioms.lean`:33 | aberto-sorry |
| `Riemann.framework_conclusions` | `src/lean/Riemann/RefutationRF3.lean`:41 | nao_alcancado |
| `Riemann.no_refutation_iff` | `src/lean/Riemann/RHTruthFramework.lean`:20 | aberto-sorry |
| `Riemann.not_rh_iff_exists_off_line` | `src/lean/Riemann/BasicZetaXi.lean`:60 | aberto-sorry |
| `Riemann.potential_symmetric` | `src/lean/Riemann/SymmetryAndDerivative.lean`:12 | nao_alcancado |
| `Riemann.rh_framework_summary` | `src/lean/Riemann/RHTruthFramework.lean`:48 | aberto-sorry |
| `Riemann.strong_consistency_implies_no_refutation` | `src/lean/Riemann/RHTruthFramework.lean`:32 | nao_alcancado |
| `Riemann.torus_euler_characteristic` | `src/lean/Riemann/TorusCompactification.lean`:31 | fechado |
| `Riemann.torus_genus` | `src/lean/Riemann/TorusCompactification.lean`:34 | fechado |
| `Riemann.unique_extrema_implies_two_saddles` | `src/lean/Riemann/MorseSetup.lean`:37 | condicional |
| `Riemann.unique_min_implies_not_RF1` | `src/lean/Riemann/ExtraValleyAxioms.lean`:44 | aberto-sorry |
