# Heu-7-universal-framework — branch `copilot/create-scientific-repository`

Lean sources from the branch `copilot/create-scientific-repository` of the private repository `ShantiDraconis/Heu-7-universal-framework`, commit `8a96b4515634986aa29448563e1f56d8dcacdacf` (2025-12-02T08:47:05+00:00), that hold theorems found only on branches (no default branch of any repository has a theorem with the same name). Published here: the files with the theorems the kernel closed, the local files they import and the Lake files of their project.

* Branch state: parada (not in the default branch).
* Theorems only on branches, in this branch: 48 — closed 1, conditional 0, open 0, proof error 4, not reached 43, no result 0.
* History: 6 commit(s) of this branch that are not in the default branch, with date and subject, in `certificate.json`.
* `certificate.json` (SHA-256 of its content: `e99187d9756c71a3c02f1c38f0ff2240d27afdda777b737e013d7f5aa6fc531f`) lists every theorem with its state and the axioms beyond the standard three, and the SHA-256 of every published file. From the repository root: `sha256sum -c mvei/branches/Heu-7-universal-framework/copilot_create-scientific-repository/SOURCES.sha256`.

Closed means the kernel accepted the proof and it depends only on `propext`, `Classical.choice` and `Quot.sound`; it proves the statement written in the file and is not a claim that an open problem is solved.

| Theorem | File | State |
|---|---|---|
| `HEU.BSD.BSD_structural_equivalence` | `src/lean/HEU/BSD/Equivalence_BSD.lean`:22 | nao_alcancado |
| `HEU.BSD.F_BSD_finite` | `src/lean/HEU/BSD/F_BSD.lean`:23 | nao_alcancado |
| `HEU.BSD.α_BSD_type` | `src/lean/HEU/BSD/Critical_BSD.lean`:17 | nao_alcancado |
| `HEU.Core.Advanced.OrdinalNotation.wf` | `src/lean/HEU/Core/AdvancedOrdinals.lean`:87 | nao_alcancado |
| `HEU.Core.Advanced.epsilon0_fixed_point` | `src/lean/HEU/Core/AdvancedOrdinals.lean`:31 | nao_alcancado |
| `HEU.Core.Advanced.fastGrowing_omega_superpolynomial` | `src/lean/HEU/Core/AdvancedOrdinals.lean`:71 | nao_alcancado |
| `HEU.Core.Advanced.fundamentalSequence_strictMono` | `src/lean/HEU/Core/AdvancedOrdinals.lean`:48 | nao_alcancado |
| `HEU.Core.Advanced.has_cnf_below_epsilon0` | `src/lean/HEU/Core/AdvancedOrdinals.lean`:35 | nao_alcancado |
| `HEU.Core.Advanced.omega_exp_add` | `src/lean/HEU/Core/AdvancedOrdinals.lean`:103 | nao_alcancado |
| `HEU.Core.Advanced.ordinal_add_assoc` | `src/lean/HEU/Core/AdvancedOrdinals.lean`:91 | nao_alcancado |
| `HEU.Core.Advanced.ordinal_add_left_cancel` | `src/lean/HEU/Core/AdvancedOrdinals.lean`:95 | nao_alcancado |
| `HEU.Core.Advanced.ordinal_mul_add` | `src/lean/HEU/Core/AdvancedOrdinals.lean`:99 | nao_alcancado |
| `HEU.Core.bound_or_exceed` | `src/lean/HEU/Core/Functional.lean`:42 | nao_alcancado |
| `HEU.Core.encodeNat_lt_omega` | `src/lean/HEU/Core/Encoding.lean`:34 | nao_alcancado |
| `HEU.Core.extensionality` | `src/lean/HEU/Core/ZFC.lean`:35 | fechado |
| `HEU.Core.finite_lt_omega` | `src/lean/HEU/Core/Ordinals.lean`:49 | erro |
| `HEU.Core.foundation` | `src/lean/HEU/Core/ZFC.lean`:41 | erro |
| `HEU.Core.omega_isLimitOrd` | `src/lean/HEU/Core/Ordinals.lean`:42 | erro |
| `HEU.Core.omega_ne_zero` | `src/lean/HEU/Core/Ordinals.lean`:40 | erro |
| `HEU.Hodge.Hodge_structural_equivalence` | `src/lean/HEU/Hodge/Equivalence_Hodge.lean`:20 | nao_alcancado |
| `HEU.Hodge.α_Hodge_eq_omega` | `src/lean/HEU/Hodge/Critical_Hodge.lean`:15 | nao_alcancado |
| `HEU.Hodge.α_Hodge_type` | `src/lean/HEU/Hodge/Critical_Hodge.lean`:17 | nao_alcancado |
| `HEU.LFunctions.GRH_RankinSelberg` | `src/lean/HEU/Core/LFunctions.lean`:73 | nao_alcancado |
| `HEU.LFunctions.GRH_structural_equivalence` | `src/lean/HEU/Core/LFunctions.lean`:53 | nao_alcancado |
| `HEU.LFunctions.L_function_unity` | `src/lean/HEU/Core/LFunctions.lean`:124 | nao_alcancado |
| `HEU.NS.NS_structural_equivalence` | `src/lean/HEU/NS/Equivalence_NS.lean`:20 | nao_alcancado |
| `HEU.NS.α_NS_eq_omega` | `src/lean/HEU/NS/Critical_NS.lean`:15 | nao_alcancado |
| `HEU.NS.α_NS_type` | `src/lean/HEU/NS/Critical_NS.lean`:17 | nao_alcancado |
| `HEU.PvsNP.PNP_structural_equivalence_negative` | `src/lean/HEU/PvsNP/Equivalence_PNP.lean`:33 | nao_alcancado |
| `HEU.PvsNP.PNP_structural_equivalence_positive` | `src/lean/HEU/PvsNP/Equivalence_PNP.lean`:20 | nao_alcancado |
| `HEU.PvsNP.α_PNP_eq_omega` | `src/lean/HEU/PvsNP/Critical_PNP.lean`:15 | nao_alcancado |
| `HEU.PvsNP.α_PNP_type` | `src/lean/HEU/PvsNP/Critical_PNP.lean`:17 | nao_alcancado |
| `HEU.RH.F_RH_eq_one` | `src/lean/HEU/RH/F_RH.lean`:25 | nao_alcancado |
| `HEU.RH.F_RH_finite` | `src/lean/HEU/RH/F_RH.lean`:29 | nao_alcancado |
| `HEU.RH.RH_bound_holds` | `src/lean/HEU/RH/Equivalence_RH.lean`:44 | nao_alcancado |
| `HEU.RH.RH_structural_equivalence` | `src/lean/HEU/RH/Equivalence_RH.lean`:28 | nao_alcancado |
| `HEU.RH.α_RH_eq_one` | `src/lean/HEU/RH/Critical_RH.lean`:15 | nao_alcancado |
| `HEU.RH.α_RH_finite` | `src/lean/HEU/RH/Critical_RH.lean`:17 | nao_alcancado |
| `HEU.RH.α_RH_type` | `src/lean/HEU/RH/Critical_RH.lean`:22 | nao_alcancado |
| `HEU.Unified.HEU_implication_preservation` | `src/lean/HEU/Core/UnifiedTheory.lean`:89 | nao_alcancado |
| `HEU.Unified.PNP_NS_Hodge_similar` | `src/lean/HEU/Core/UnifiedTheory.lean`:49 | nao_alcancado |
| `HEU.Unified.RH_YM_similar` | `src/lean/HEU/Core/UnifiedTheory.lean`:45 | nao_alcancado |
| `HEU.Unified.polynomial_barrier` | `src/lean/HEU/Core/UnifiedTheory.lean`:105 | nao_alcancado |
| `HEU.Unified.universal_HEU_property` | `src/lean/HEU/Core/UnifiedTheory.lean`:115 | nao_alcancado |
| `HEU.YM.YM_structural_equivalence` | `src/lean/HEU/YM/Equivalence_YM.lean`:20 | nao_alcancado |
| `HEU.YM.α_YM_eq_one` | `src/lean/HEU/YM/Critical_YM.lean`:15 | nao_alcancado |
| `HEU.YM.α_YM_finite` | `src/lean/HEU/YM/Critical_YM.lean`:17 | nao_alcancado |
| `HEU.YM.α_YM_type` | `src/lean/HEU/YM/Critical_YM.lean`:22 | nao_alcancado |
