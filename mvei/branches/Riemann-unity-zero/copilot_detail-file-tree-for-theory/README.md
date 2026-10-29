# Riemann-unity-zero — branch `copilot/detail-file-tree-for-theory`

Lean sources from the branch `copilot/detail-file-tree-for-theory` of the private repository `ShantiDraconis/Riemann-unity-zero`, commit `b030c53f3f18df3ff48675f0300a74057565fa21` (2026-01-17T05:00:29+00:00), that hold theorems found only on branches (no default branch of any repository has a theorem with the same name). Published here: the files with the theorems the kernel closed, the local files they import and the Lake files of their project.

* Branch state: parada (not in the default branch).
* Theorems only on branches, in this branch: 44 — closed 5, conditional 0, open 0, proof error 1, not reached 38, no result 0.
* History: 4 commit(s) of this branch that are not in the default branch, with date and subject, in `certificate.json`.
* `certificate.json` (SHA-256 of its content: `eb85f3612a373deb80bf1bff29755603d561829958197d582d987285906122a3`) lists every theorem with its state and the axioms beyond the standard three, and the SHA-256 of every published file. From the repository root: `sha256sum -c mvei/branches/Riemann-unity-zero/copilot_detail-file-tree-for-theory/SOURCES.sha256`.

Closed means the kernel accepted the proof and it depends only on `propext`, `Classical.choice` and `Quot.sound`; it proves the statement written in the file and is not a claim that an open problem is solved.

| Theorem | File | State |
|---|---|---|
| `RiemannUnityZero.complete_transubstantiation` | `lean/RiemannUnityZero/MainTheorem.lean`:129 | nao_alcancado |
| `RiemannUnityZero.critical_base_height_ratio_limit` | `lean/RiemannUnityZero/TriangleGeometry.lean`:50 | nao_alcancado |
| `RiemannUnityZero.critical_height_unity_exact` | `lean/RiemannUnityZero/MainTheorem.lean`:52 | nao_alcancado |
| `RiemannUnityZero.critical_hypotenuse_at_zero` | `lean/RiemannUnityZero/TriangleGeometry.lean`:105 | nao_alcancado |
| `RiemannUnityZero.critical_hypotenuse_gt_height` | `lean/RiemannUnityZero/TriangleGeometry.lean`:118 | nao_alcancado |
| `RiemannUnityZero.critical_hypotenuse_minimum` | `lean/RiemannUnityZero/TriangleGeometry.lean`:95 | nao_alcancado |
| `RiemannUnityZero.critical_line_boundary` | `lean/RiemannUnityZero/Symmetry.lean`:132 | nao_alcancado |
| `RiemannUnityZero.critical_line_conj_symmetric` | `lean/RiemannUnityZero/Symmetry.lean`:66 | nao_alcancado |
| `RiemannUnityZero.critical_line_conjugate` | `lean/RiemannUnityZero/Symmetry.lean`:59 | nao_alcancado |
| `RiemannUnityZero.critical_line_exhibits_unity` | `lean/RiemannUnityZero/MainTheorem.lean`:93 | nao_alcancado |
| `RiemannUnityZero.critical_line_functional_partner` | `lean/RiemannUnityZero/Symmetry.lean`:103 | nao_alcancado |
| `RiemannUnityZero.critical_line_modulus_formula` | `lean/RiemannUnityZero/BasicDefinitions.lean`:137 | fechado |
| `RiemannUnityZero.critical_line_natural_center` | `lean/RiemannUnityZero/Symmetry.lean`:147 | nao_alcancado |
| `RiemannUnityZero.critical_line_self_symmetric` | `lean/RiemannUnityZero/Symmetry.lean`:26 | nao_alcancado |
| `RiemannUnityZero.critical_line_unique` | `lean/RiemannUnityZero/MainTheorem.lean`:177 | nao_alcancado |
| `RiemannUnityZero.critical_line_uniqueness` | `lean/RiemannUnityZero/MainTheorem.lean`:81 | nao_alcancado |
| `RiemannUnityZero.critical_line_zero_distance` | `lean/RiemannUnityZero/Symmetry.lean`:47 | nao_alcancado |
| `RiemannUnityZero.critical_sequence_hypotenuse_limit` | `lean/RiemannUnityZero/TriangleGeometry.lean`:131 | nao_alcancado |
| `RiemannUnityZero.critical_triangle_height` | `lean/RiemannUnityZero/BasicDefinitions.lean`:113 | fechado |
| `RiemannUnityZero.critical_triangle_pythagorean` | `lean/RiemannUnityZero/TriangleGeometry.lean`:82 | nao_alcancado |
| `RiemannUnityZero.critical_triangle_small_base_limit` | `lean/RiemannUnityZero/BasicDefinitions.lean`:119 | nao_alcancado |
| `RiemannUnityZero.critical_value_special` | `lean/RiemannUnityZero/Symmetry.lean`:95 | nao_alcancado |
| `RiemannUnityZero.difference_quadratic_order` | `lean/RiemannUnityZero/MainTheorem.lean`:31 | nao_alcancado |
| `RiemannUnityZero.functional_equation_critical_line` | `lean/RiemannUnityZero/Symmetry.lean`:118 | nao_alcancado |
| `RiemannUnityZero.hypotenuse_approaches_height` | `lean/RiemannUnityZero/TriangleGeometry.lean`:35 | nao_alcancado |
| `RiemannUnityZero.hypotenuse_base_ratio_diverges_at_zero` | `lean/RiemannUnityZero/TriangleGeometry.lean`:17 | nao_alcancado |
| `RiemannUnityZero.hypotenuse_base_ratio_ge_one` | `lean/RiemannUnityZero/TriangleGeometry.lean`:110 | nao_alcancado |
| `RiemannUnityZero.hypotenuse_ge_base` | `lean/RiemannUnityZero/BasicDefinitions.lean`:93 | fechado |
| `RiemannUnityZero.hypotenuse_ge_height` | `lean/RiemannUnityZero/BasicDefinitions.lean`:80 | fechado |
| `RiemannUnityZero.hypotenuse_height_difference_quadratic` | `lean/RiemannUnityZero/TriangleGeometry.lean`:72 | nao_alcancado |
| `RiemannUnityZero.hypotenuse_taylor_approximation` | `lean/RiemannUnityZero/TriangleGeometry.lean`:64 | nao_alcancado |
| `RiemannUnityZero.imaginary_becomes_substance` | `lean/RiemannUnityZero/MainTheorem.lean`:60 | nao_alcancado |
| `RiemannUnityZero.imaginary_not_abstract` | `lean/RiemannUnityZero/MainTheorem.lean`:154 | nao_alcancado |
| `RiemannUnityZero.modulus_symmetric_about_critical` | `lean/RiemannUnityZero/Symmetry.lean`:73 | nao_alcancado |
| `RiemannUnityZero.pythagorean` | `lean/RiemannUnityZero/BasicDefinitions.lean`:104 | fechado |
| `RiemannUnityZero.ratio_approaches_unity` | `lean/RiemannUnityZero/MainTheorem.lean`:42 | nao_alcancado |
| `RiemannUnityZero.reflection_equidistant` | `lean/RiemannUnityZero/Symmetry.lean`:37 | nao_alcancado |
| `RiemannUnityZero.reflection_preserves_distance` | `lean/RiemannUnityZero/BasicDefinitions.lean`:147 | erro |
| `RiemannUnityZero.step1_base_to_zero` | `lean/RiemannUnityZero/MainTheorem.lean`:98 | nao_alcancado |
| `RiemannUnityZero.step2_hypotenuse_to_height` | `lean/RiemannUnityZero/MainTheorem.lean`:114 | nao_alcancado |
| `RiemannUnityZero.step3_ratio_to_unity` | `lean/RiemannUnityZero/MainTheorem.lean`:123 | nao_alcancado |
| `RiemannUnityZero.transubstantiation_of_unity` | `lean/RiemannUnityZero/MainTheorem.lean`:20 | nao_alcancado |
| `RiemannUnityZero.unity_from_geometry` | `lean/RiemannUnityZero/MainTheorem.lean`:68 | nao_alcancado |
| `RiemannUnityZero.unity_natural_limit` | `lean/RiemannUnityZero/MainTheorem.lean`:165 | nao_alcancado |
