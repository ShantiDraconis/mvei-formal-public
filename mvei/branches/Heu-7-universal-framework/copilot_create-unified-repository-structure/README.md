# Heu-7-universal-framework — branch `copilot/create-unified-repository-structure`

Lean sources from the branch `copilot/create-unified-repository-structure` of the private repository `ShantiDraconis/Heu-7-universal-framework`, commit `65779fb9e6e1becf8fb44930dbaa825673c919eb` (2025-12-02T08:34:42+00:00), that hold theorems found only on branches (no default branch of any repository has a theorem with the same name). Published here: the files with the theorems the kernel closed, the local files they import and the Lake files of their project.

* Branch state: parada (not in the default branch).
* Theorems only on branches, in this branch: 33 — closed 1, conditional 0, open 0, proof error 2, not reached 30, no result 0.
* History: 4 commit(s) of this branch that are not in the default branch, with date and subject, in `certificate.json`.
* `certificate.json` (SHA-256 of its content: `e786270ae59e58066ed4c8fb6828f7b430e46ef3d7211b63fa8fae4fbdcd000c`) lists every theorem with its state and the axioms beyond the standard three, and the SHA-256 of every published file. From the repository root: `sha256sum -c mvei/branches/Heu-7-universal-framework/copilot_create-unified-repository-structure/SOURCES.sha256`.

Closed means the kernel accepted the proof and it depends only on `propext`, `Classical.choice` and `Quot.sound`; it proves the statement written in the file and is not a claim that an open problem is solved.

| Theorem | File | State |
|---|---|---|
| `HEU.BSD.BSD_HEU_equivalence` | `src/lean/HEU/BSD/Equivalence_BSD.lean`:23 | nao_alcancado |
| `HEU.BSD.BSD_equivalence_statement` | `src/lean/HEU/BSD/Equivalence_BSD.lean`:34 | nao_alcancado |
| `HEU.BSD.BSD_uses_equality` | `src/lean/HEU/BSD/Critical_BSD.lean`:18 | nao_alcancado |
| `HEU.BSD.F_BSD_zero_iff_ranks_equal` | `src/lean/HEU/BSD/F_BSD.lean`:22 | nao_alcancado |
| `HEU.BSD.critical_BSD_eq_zero` | `src/lean/HEU/BSD/Critical_BSD.lean`:15 | nao_alcancado |
| `HEU.Core.nat_encodes_to_finite` | `src/lean/HEU/Core/Encoding.lean`:34 | nao_alcancado |
| `HEU.Core.omega_below_omega_omega` | `src/lean/HEU/Core/Ordinals.lean`:38 | erro |
| `HEU.Core.zero_below_omega` | `src/lean/HEU/Core/Ordinals.lean`:34 | erro |
| `HEU.Core.zfc_axioms_satisfied` | `src/lean/HEU/Core/ZFC.lean`:35 | fechado |
| `HEU.Hodge.F_Hodge_finite_iff_algebraic` | `src/lean/HEU/Hodge/F_Hodge.lean`:19 | nao_alcancado |
| `HEU.Hodge.Hodge_HEU_equivalence` | `src/lean/HEU/Hodge/Equivalence_Hodge.lean`:18 | nao_alcancado |
| `HEU.Hodge.Hodge_equivalence_statement` | `src/lean/HEU/Hodge/Equivalence_Hodge.lean`:29 | nao_alcancado |
| `HEU.Hodge.critical_Hodge_eq_omega` | `src/lean/HEU/Hodge/Critical_Hodge.lean`:15 | nao_alcancado |
| `HEU.Hodge.omega_represents_finite` | `src/lean/HEU/Hodge/Critical_Hodge.lean`:18 | nao_alcancado |
| `HEU.NS.F_NS_is_omega_one_iff_no_blowup` | `src/lean/HEU/NS/F_NS.lean`:22 | nao_alcancado |
| `HEU.NS.NS_HEU_equivalence` | `src/lean/HEU/NS/Equivalence_NS.lean`:28 | nao_alcancado |
| `HEU.NS.critical_NS_eq_omega_one` | `src/lean/HEU/NS/Critical_NS.lean`:15 | nao_alcancado |
| `HEU.NS.omega_one_is_uncountable` | `src/lean/HEU/NS/Critical_NS.lean`:18 | nao_alcancado |
| `HEU.PvsNP.F_PNP_below_threshold_iff_in_P` | `src/lean/HEU/PvsNP/F_PNP.lean`:22 | nao_alcancado |
| `HEU.PvsNP.PNP_HEU_equivalence` | `src/lean/HEU/PvsNP/Equivalence_PNP.lean`:24 | nao_alcancado |
| `HEU.PvsNP.PNP_equivalence_statement` | `src/lean/HEU/PvsNP/Equivalence_PNP.lean`:36 | nao_alcancado |
| `HEU.PvsNP.critical_PNP_eq_omega_omega` | `src/lean/HEU/PvsNP/Critical_PNP.lean`:15 | nao_alcancado |
| `HEU.PvsNP.omega_omega_is_polynomial_boundary` | `src/lean/HEU/PvsNP/Critical_PNP.lean`:18 | nao_alcancado |
| `HEU.RH.F_RH_zero_iff_on_critical_line` | `src/lean/HEU/RH/F_RH.lean`:22 | nao_alcancado |
| `HEU.RH.RH_HEU_equivalence` | `src/lean/HEU/RH/Equivalence_RH.lean`:24 | nao_alcancado |
| `HEU.RH.RH_equivalence_statement` | `src/lean/HEU/RH/Equivalence_RH.lean`:36 | nao_alcancado |
| `HEU.RH.RH_threshold_condition` | `src/lean/HEU/RH/Critical_RH.lean`:18 | nao_alcancado |
| `HEU.RH.RH_uses_equality` | `src/lean/HEU/RH/Critical_RH.lean`:24 | nao_alcancado |
| `HEU.RH.critical_RH_eq_zero` | `src/lean/HEU/RH/Critical_RH.lean`:15 | nao_alcancado |
| `HEU.YM.F_YM_positive_iff_mass_gap` | `src/lean/HEU/YM/F_YM.lean`:16 | nao_alcancado |
| `HEU.YM.YM_HEU_equivalence` | `src/lean/HEU/YM/Equivalence_YM.lean`:16 | nao_alcancado |
| `HEU.YM.YM_equivalence_statement` | `src/lean/HEU/YM/Equivalence_YM.lean`:27 | nao_alcancado |
| `HEU.YM.YM_uses_positivity` | `src/lean/HEU/YM/Critical_YM.lean`:16 | nao_alcancado |
