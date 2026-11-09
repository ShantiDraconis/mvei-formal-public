# Heu-7-universal-framework — branch `copilot/create-scientific-repository`

Lean sources from the branch `copilot/create-scientific-repository` of the private repository `ShantiDraconis/Heu-7-universal-framework`, commit `8a96b4515634986aa29448563e1f56d8dcacdacf` (2025-12-02T08:47:05+00:00), that hold theorems found only on branches (no default branch of any repository has a theorem with the same name). Published here: the files with the theorems the kernel closed, the local files they import and the Lake files of their project.

* Branch state: parada (not in the default branch).
* Theorems only on branches, in this branch: 48 — closed 20, conditional 1, open 15, proof error 4, not reached 8, no result 0.
* History: 6 commit(s) of this branch that are not in the default branch, with date and subject, in `certificate.json`.
* `certificate.json` (SHA-256 of its content: `2d0d4cb641368ff4fb29e004a97bc44fb94edadd2ad05b6e523e9074a99fa56b`) lists every theorem with its state and the axioms beyond the standard three, and the SHA-256 of every published file. From the repository root: `sha256sum -c mvei/branches/Heu-7-universal-framework/copilot_create-scientific-repository/SOURCES.sha256`.

Closed means the kernel accepted the proof and it depends only on `propext`, `Classical.choice` and `Quot.sound`; it proves the statement written in the file and is not a claim that an open problem is solved.

| Theorem | File | State |
|---|---|---|
| `HEU.BSD.BSD_structural_equivalence` | `src/lean/HEU/BSD/Equivalence_BSD.lean`:22 | fechado |
| `HEU.BSD.F_BSD_finite` | `src/lean/HEU/BSD/F_BSD.lean`:23 | aberto-sorry |
| `HEU.BSD.α_BSD_type` | `src/lean/HEU/BSD/Critical_BSD.lean`:17 | fechado |
| `HEU.Core.Advanced.OrdinalNotation.wf` | `src/lean/HEU/Core/AdvancedOrdinals.lean`:87 | aberto-sorry |
| `HEU.Core.Advanced.epsilon0_fixed_point` | `src/lean/HEU/Core/AdvancedOrdinals.lean`:31 | nao_alcancado |
| `HEU.Core.Advanced.fastGrowing_omega_superpolynomial` | `src/lean/HEU/Core/AdvancedOrdinals.lean`:71 | aberto-sorry |
| `HEU.Core.Advanced.fundamentalSequence_strictMono` | `src/lean/HEU/Core/AdvancedOrdinals.lean`:48 | aberto-sorry |
| `HEU.Core.Advanced.has_cnf_below_epsilon0` | `src/lean/HEU/Core/AdvancedOrdinals.lean`:35 | aberto-sorry |
| `HEU.Core.Advanced.omega_exp_add` | `src/lean/HEU/Core/AdvancedOrdinals.lean`:103 | aberto-sorry |
| `HEU.Core.Advanced.ordinal_add_assoc` | `src/lean/HEU/Core/AdvancedOrdinals.lean`:91 | nao_alcancado |
| `HEU.Core.Advanced.ordinal_add_left_cancel` | `src/lean/HEU/Core/AdvancedOrdinals.lean`:95 | fechado |
| `HEU.Core.Advanced.ordinal_mul_add` | `src/lean/HEU/Core/AdvancedOrdinals.lean`:99 | fechado |
| `HEU.Core.bound_or_exceed` | `src/lean/HEU/Core/Functional.lean`:42 | fechado |
| `HEU.Core.encodeNat_lt_omega` | `src/lean/HEU/Core/Encoding.lean`:34 | aberto-sorry |
| `HEU.Core.extensionality` | `src/lean/HEU/Core/ZFC.lean`:35 | fechado |
| `HEU.Core.finite_lt_omega` | `src/lean/HEU/Core/Ordinals.lean`:49 | erro |
| `HEU.Core.foundation` | `src/lean/HEU/Core/ZFC.lean`:41 | erro |
| `HEU.Core.omega_isLimitOrd` | `src/lean/HEU/Core/Ordinals.lean`:42 | erro |
| `HEU.Core.omega_ne_zero` | `src/lean/HEU/Core/Ordinals.lean`:40 | erro |
| `HEU.Hodge.Hodge_structural_equivalence` | `src/lean/HEU/Hodge/Equivalence_Hodge.lean`:20 | aberto-sorry |
| `HEU.Hodge.α_Hodge_eq_omega` | `src/lean/HEU/Hodge/Critical_Hodge.lean`:15 | aberto-sorry |
| `HEU.Hodge.α_Hodge_type` | `src/lean/HEU/Hodge/Critical_Hodge.lean`:17 | fechado |
| `HEU.LFunctions.GRH_RankinSelberg` | `src/lean/HEU/Core/LFunctions.lean`:73 | fechado |
| `HEU.LFunctions.GRH_structural_equivalence` | `src/lean/HEU/Core/LFunctions.lean`:53 | fechado |
| `HEU.LFunctions.L_function_unity` | `src/lean/HEU/Core/LFunctions.lean`:124 | nao_alcancado |
| `HEU.NS.NS_structural_equivalence` | `src/lean/HEU/NS/Equivalence_NS.lean`:20 | aberto-sorry |
| `HEU.NS.α_NS_eq_omega` | `src/lean/HEU/NS/Critical_NS.lean`:15 | aberto-sorry |
| `HEU.NS.α_NS_type` | `src/lean/HEU/NS/Critical_NS.lean`:17 | fechado |
| `HEU.PvsNP.PNP_structural_equivalence_negative` | `src/lean/HEU/PvsNP/Equivalence_PNP.lean`:33 | aberto-sorry |
| `HEU.PvsNP.PNP_structural_equivalence_positive` | `src/lean/HEU/PvsNP/Equivalence_PNP.lean`:20 | aberto-sorry |
| `HEU.PvsNP.α_PNP_eq_omega` | `src/lean/HEU/PvsNP/Critical_PNP.lean`:15 | aberto-sorry |
| `HEU.PvsNP.α_PNP_type` | `src/lean/HEU/PvsNP/Critical_PNP.lean`:17 | fechado |
| `HEU.RH.F_RH_eq_one` | `src/lean/HEU/RH/F_RH.lean`:25 | fechado |
| `HEU.RH.F_RH_finite` | `src/lean/HEU/RH/F_RH.lean`:29 | nao_alcancado |
| `HEU.RH.RH_bound_holds` | `src/lean/HEU/RH/Equivalence_RH.lean`:44 | fechado |
| `HEU.RH.RH_structural_equivalence` | `src/lean/HEU/RH/Equivalence_RH.lean`:28 | fechado |
| `HEU.RH.α_RH_eq_one` | `src/lean/HEU/RH/Critical_RH.lean`:15 | fechado |
| `HEU.RH.α_RH_finite` | `src/lean/HEU/RH/Critical_RH.lean`:17 | nao_alcancado |
| `HEU.RH.α_RH_type` | `src/lean/HEU/RH/Critical_RH.lean`:22 | fechado |
| `HEU.Unified.HEU_implication_preservation` | `src/lean/HEU/Core/UnifiedTheory.lean`:89 | nao_alcancado |
| `HEU.Unified.PNP_NS_Hodge_similar` | `src/lean/HEU/Core/UnifiedTheory.lean`:49 | fechado |
| `HEU.Unified.RH_YM_similar` | `src/lean/HEU/Core/UnifiedTheory.lean`:45 | fechado |
| `HEU.Unified.polynomial_barrier` | `src/lean/HEU/Core/UnifiedTheory.lean`:105 | nao_alcancado |
| `HEU.Unified.universal_HEU_property` | `src/lean/HEU/Core/UnifiedTheory.lean`:115 | aberto-sorry |
| `HEU.YM.YM_structural_equivalence` | `src/lean/HEU/YM/Equivalence_YM.lean`:20 | condicional |
| `HEU.YM.α_YM_eq_one` | `src/lean/HEU/YM/Critical_YM.lean`:15 | fechado |
| `HEU.YM.α_YM_finite` | `src/lean/HEU/YM/Critical_YM.lean`:17 | nao_alcancado |
| `HEU.YM.α_YM_type` | `src/lean/HEU/YM/Critical_YM.lean`:22 | fechado |
