# Heu-7-universal-framework — branch `copilot/add-initial-repository-structure`

Lean sources from the branch `copilot/add-initial-repository-structure` of the private repository `ShantiDraconis/Heu-7-universal-framework`, commit `81b71df03c53f6a2b8bcfcb1a87330ac9f014e49` (2025-12-02T08:42:59+00:00), that hold theorems found only on branches (no default branch of any repository has a theorem with the same name). Published here: the files with the theorems the kernel closed, the local files they import and the Lake files of their project.

* Branch state: parada (not in the default branch).
* Theorems only on branches, in this branch: 75 — closed 31, conditional 0, open 16, proof error 0, not reached 28, no result 0.
* History: 6 commit(s) of this branch that are not in the default branch, with date and subject, in `certificate.json`.
* `certificate.json` (SHA-256 of its content: `44c64e453eec0048d8a1e7f280e3112587539176e723017af47f7382db9384ba`) lists every theorem with its state and the axioms beyond the standard three, and the SHA-256 of every published file. From the repository root: `sha256sum -c mvei/branches/Heu-7-universal-framework/copilot_add-initial-repository-structure/SOURCES.sha256`.

Closed means the kernel accepted the proof and it depends only on `propext`, `Classical.choice` and `Quot.sound`; it proves the statement written in the file and is not a claim that an open problem is solved.

| Theorem | File | State |
|---|---|---|
| `HEU.BSD.BSD_HEU_Equivalence` | `src/lean/HEU/BSD/Equivalence_BSD.lean`:24 | aberto-sorry |
| `HEU.BSD.DeepAnalysis.BSD_iff_HEU` | `src/lean/HEU/BSD/DeepAnalysis.lean`:141 | aberto-sorry |
| `HEU.BSD.DeepAnalysis.BSD_implies_sha_finite` | `src/lean/HEU/BSD/DeepAnalysis.lean`:160 | aberto-sorry |
| `HEU.BSD.DeepAnalysis.gross_zagier` | `src/lean/HEU/BSD/DeepAnalysis.lean`:110 | fechado |
| `HEU.BSD.DeepAnalysis.kolyvagin` | `src/lean/HEU/BSD/DeepAnalysis.lean`:118 | fechado |
| `HEU.BSD.HEU_BSD_holds` | `src/lean/HEU/BSD/Equivalence_BSD.lean`:19 | nao_alcancado |
| `HEU.BSD.ranks_agree_implies_BSD` | `src/lean/HEU/BSD/Equivalence_BSD.lean`:30 | aberto-sorry |
| `HEU.Core.CrossDomain.chain_resolution` | `src/lean/HEU/Core/CrossDomain.lean`:133 | nao_alcancado |
| `HEU.Core.CrossDomain.countable_enumeration` | `src/lean/HEU/Core/CrossDomain.lean`:81 | aberto-sorry |
| `HEU.Core.CrossDomain.minimum_implies_heu` | `src/lean/HEU/Core/CrossDomain.lean`:97 | fechado |
| `HEU.Core.CrossDomain.reduction_preserves_solution` | `src/lean/HEU/Core/CrossDomain.lean`:34 | fechado |
| `HEU.Core.CrossDomain.structurally_equivalent_symm` | `src/lean/HEU/Core/CrossDomain.lean`:47 | fechado |
| `HEU.Core.ProofTechniques.approximation_limit` | `src/lean/HEU/Core/ProofTechniques.lean`:133 | fechado |
| `HEU.Core.ProofTechniques.case_analysis` | `src/lean/HEU/Core/ProofTechniques.lean`:24 | fechado |
| `HEU.Core.ProofTechniques.composite_proof` | `src/lean/HEU/Core/ProofTechniques.lean`:160 | nao_alcancado |
| `HEU.Core.ProofTechniques.direct_verification` | `src/lean/HEU/Core/ProofTechniques.lean`:18 | fechado |
| `HEU.Core.ProofTechniques.domain_induction` | `src/lean/HEU/Core/ProofTechniques.lean`:86 | fechado |
| `HEU.Core.ProofTechniques.functional_reduction` | `src/lean/HEU/Core/ProofTechniques.lean`:147 | fechado |
| `HEU.Core.ProofTechniques.lower_bound_transfer` | `src/lean/HEU/Core/ProofTechniques.lean`:34 | fechado |
| `HEU.Core.ProofTechniques.minimum_element_bound` | `src/lean/HEU/Core/ProofTechniques.lean`:44 | fechado |
| `HEU.Core.ProofTechniques.monotonic_minimum` | `src/lean/HEU/Core/ProofTechniques.lean`:91 | fechado |
| `HEU.Core.ProofTechniques.no_valid_counterexample` | `src/lean/HEU/Core/ProofTechniques.lean`:62 | nao_alcancado |
| `HEU.Core.ProofTechniques.positive_threshold` | `src/lean/HEU/Core/ProofTechniques.lean`:112 | nao_alcancado |
| `HEU.Core.ProofTechniques.proof_by_contradiction` | `src/lean/HEU/Core/ProofTechniques.lean`:52 | nao_alcancado |
| `HEU.Core.ProofTechniques.strong_induction_on_functional` | `src/lean/HEU/Core/ProofTechniques.lean`:70 | nao_alcancado |
| `HEU.Core.ProofTechniques.symmetry_reduction` | `src/lean/HEU/Core/ProofTechniques.lean`:118 | fechado |
| `HEU.Core.ProofTechniques.zero_threshold_trivial` | `src/lean/HEU/Core/ProofTechniques.lean`:104 | nao_alcancado |
| `HEU.Core.Unified.counterexample_refutes` | `src/lean/HEU/Core/UnifiedFramework.lean`:132 | fechado |
| `HEU.Core.Unified.critical_ordinal_total_order` | `src/lean/HEU/Core/UnifiedFramework.lean`:73 | fechado |
| `HEU.Core.Unified.heu_completeness` | `src/lean/HEU/Core/UnifiedFramework.lean`:105 | fechado |
| `HEU.Core.Unified.heu_is_universal` | `src/lean/HEU/Core/UnifiedFramework.lean`:52 | fechado |
| `HEU.Core.Unified.heu_soundness` | `src/lean/HEU/Core/UnifiedFramework.lean`:97 | fechado |
| `HEU.Core.Unified.morphism_preserves_truth` | `src/lean/HEU/Core/UnifiedFramework.lean`:91 | fechado |
| `HEU.Core.Unified.neg_heu_implies_counterexample` | `src/lean/HEU/Core/UnifiedFramework.lean`:56 | nao_alcancado |
| `HEU.Core.Unified.no_counterexample_consistent` | `src/lean/HEU/Core/UnifiedFramework.lean`:139 | fechado |
| `HEU.Core.Unified.structural_uniformity` | `src/lean/HEU/Core/UnifiedFramework.lean`:44 | fechado |
| `HEU.Core.Unified.unified_proof_strategy` | `src/lean/HEU/Core/UnifiedFramework.lean`:111 | fechado |
| `HEU.Core.critical_iff_heu` | `src/lean/HEU/Core/CriticalLevel.lean`:16 | fechado |
| `HEU.Core.critical_no_counterexample` | `src/lean/HEU/Core/CriticalLevel.lean`:25 | fechado |
| `HEU.Core.heu_equiv_no_deficit` | `src/lean/HEU/Core/Functional.lean`:34 | nao_alcancado |
| `HEU.Core.strictly_critical_imp_critical` | `src/lean/HEU/Core/CriticalLevel.lean`:35 | fechado |
| `HEU.Hodge.DeepAnalysis.Hodge_iff_HEU` | `src/lean/HEU/Hodge/DeepAnalysis.lean`:111 | aberto-sorry |
| `HEU.Hodge.DeepAnalysis.hodge_decomposition` | `src/lean/HEU/Hodge/DeepAnalysis.lean`:40 | fechado |
| `HEU.Hodge.DeepAnalysis.hodge_symmetry` | `src/lean/HEU/Hodge/DeepAnalysis.lean`:45 | nao_alcancado |
| `HEU.Hodge.DeepAnalysis.lefschetz_1_1` | `src/lean/HEU/Hodge/DeepAnalysis.lean`:116 | fechado |
| `HEU.Hodge.HEU_Hodge_holds` | `src/lean/HEU/Hodge/Equivalence_Hodge.lean`:19 | nao_alcancado |
| `HEU.Hodge.Hodge_HEU_Equivalence` | `src/lean/HEU/Hodge/Equivalence_Hodge.lean`:24 | aberto-sorry |
| `HEU.Hodge.algebraic_implies_bound` | `src/lean/HEU/Hodge/Equivalence_Hodge.lean`:30 | nao_alcancado |
| `HEU.NS.DeepAnalysis.global_regularity_iff_omega` | `src/lean/HEU/NS/DeepAnalysis.lean`:117 | aberto-sorry |
| `HEU.NS.DeepAnalysis.small_data_global` | `src/lean/HEU/NS/DeepAnalysis.lean`:129 | aberto-sorry |
| `HEU.NS.HEU_NS_holds` | `src/lean/HEU/NS/Equivalence_NS.lean`:19 | nao_alcancado |
| `HEU.NS.NS_HEU_Equivalence` | `src/lean/HEU/NS/Equivalence_NS.lean`:25 | aberto-sorry |
| `HEU.NS.no_blowup_implies_global` | `src/lean/HEU/NS/Equivalence_NS.lean`:31 | aberto-sorry |
| `HEU.PvsNP.DeepAnalysis.P_eq_NP_collapses_PH` | `src/lean/HEU/PvsNP/DeepAnalysis.lean`:201 | fechado |
| `HEU.PvsNP.DeepAnalysis.PneNP_iff_omega_complexity` | `src/lean/HEU/PvsNP/DeepAnalysis.lean`:145 | nao_alcancado |
| `HEU.PvsNP.DeepAnalysis.PneNP_implies_separation` | `src/lean/HEU/PvsNP/DeepAnalysis.lean`:209 | aberto-sorry |
| `HEU.PvsNP.DeepAnalysis.natural_proofs_barrier` | `src/lean/HEU/PvsNP/DeepAnalysis.lean`:192 | aberto-sorry |
| `HEU.PvsNP.HEU_PvsNP_holds` | `src/lean/HEU/PvsNP/Equivalence_PvsNP.lean`:19 | nao_alcancado |
| `HEU.PvsNP.P_eq_NP_polynomial_circuits` | `src/lean/HEU/PvsNP/Equivalence_PvsNP.lean`:31 | aberto-sorry |
| `HEU.PvsNP.PvsNP_HEU_Equivalence` | `src/lean/HEU/PvsNP/Equivalence_PvsNP.lean`:24 | nao_alcancado |
| `HEU.RH.DeepAnalysis.HEU_captures_RH` | `src/lean/HEU/RH/DeepAnalysis.lean`:130 | nao_alcancado |
| `HEU.RH.DeepAnalysis.RH_iff_all_deviation_zero` | `src/lean/HEU/RH/DeepAnalysis.lean`:116 | nao_alcancado |
| `HEU.RH.DeepAnalysis.deviation_nonneg` | `src/lean/HEU/RH/DeepAnalysis.lean`:95 | nao_alcancado |
| `HEU.RH.DeepAnalysis.deviation_pos_off_line` | `src/lean/HEU/RH/DeepAnalysis.lean`:107 | nao_alcancado |
| `HEU.RH.DeepAnalysis.deviation_zero_on_line` | `src/lean/HEU/RH/DeepAnalysis.lean`:102 | nao_alcancado |
| `HEU.RH.DeepAnalysis.verified_support_RH` | `src/lean/HEU/RH/DeepAnalysis.lean`:153 | nao_alcancado |
| `HEU.RH.DeepAnalysis.zero_count_bound` | `src/lean/HEU/RH/DeepAnalysis.lean`:172 | fechado |
| `HEU.RH.HEU_RH_holds` | `src/lean/HEU/RH/Equivalence_RH.lean`:20 | nao_alcancado |
| `HEU.RH.HEU_RH_iff_Critical` | `src/lean/HEU/RH/Equivalence_RH.lean`:42 | nao_alcancado |
| `HEU.RH.RH_HEU_Equivalence` | `src/lean/HEU/RH/Equivalence_RH.lean`:25 | nao_alcancado |
| `HEU.YM.DeepAnalysis.YM_iff_HEU` | `src/lean/HEU/YM/DeepAnalysis.lean`:133 | aberto-sorry |
| `HEU.YM.DeepAnalysis.mass_gap_implies_glueballs` | `src/lean/HEU/YM/DeepAnalysis.lean`:148 | fechado |
| `HEU.YM.HEU_YM_holds` | `src/lean/HEU/YM/Equivalence_YM.lean`:19 | nao_alcancado |
| `HEU.YM.YM_HEU_Equivalence` | `src/lean/HEU/YM/Equivalence_YM.lean`:24 | aberto-sorry |
| `HEU.YM.spectral_gap_implies_mass_gap` | `src/lean/HEU/YM/Equivalence_YM.lean`:30 | nao_alcancado |
