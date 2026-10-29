# open-math-scoped-final — branch `attack/rh-g6g8-kfar-interface-20260926`

Lean sources from the branch `attack/rh-g6g8-kfar-interface-20260926` of the private repository `ShantiDraconis/open-math-scoped-final`, commit `f8c096776877ac99122a7eebfdb51cae45a22c49` (2026-09-27T20:49:10+01:00), that hold theorems found only on branches (no default branch of any repository has a theorem with the same name). Published here: the files with the theorems the kernel closed, the local files they import and the Lake files of their project.

* Branch state: parada (not in the default branch).
* Theorems only on branches, in this branch: 77 — closed 40, conditional 0, open 1, proof error 1, not reached 35, no result 0.
* History: 99 commit(s) of this branch that are not in the default branch, with date and subject, in `certificate.json`.
* `certificate.json` (SHA-256 of its content: `89fc3f8c7018e454638fab1bebd9fabea9c2d6d38bd90889f5a5782e547d2017`) lists every theorem with its state and the axioms beyond the standard three, and the SHA-256 of every published file. From the repository root: `sha256sum -c mvei/branches/open-math-scoped-final/attack_rh-g6g8-kfar-interface-20260926/SOURCES.sha256`.

Closed means the kernel accepted the proof and it depends only on `propext`, `Classical.choice` and `Quot.sound`; it proves the statement written in the file and is not a claim that an open problem is solved.

| Theorem | File | State |
|---|---|---|
| `MCore.RH.NB.NBHilbertData.DNLimit_eq_zero_of_arbitrarily_small` | `RIEMANN/MCore/RH/NB/Limit.lean`:27 | fechado |
| `Riemann.audit.concrete_decay_to_DNLimit_zero` | `RIEMANN/Riemann/audit/DenseConversationCertification.lean`:25 | nao_alcancado |
| `Riemann.audit.concrete_decay_to_RH` | `RIEMANN/Riemann/audit/DenseConversationCertification.lean`:34 | nao_alcancado |
| `Riemann.claims.AnalyticTailSolution.DN_le_patchedEps` | `RIEMANN/Riemann/claims/Claim5_UnconditionalVUB.lean`:195 | fechado |
| `Riemann.claims.AnalyticTailSolution.DN_tail_le` | `RIEMANN/Riemann/claims/Claim5_UnconditionalVUB.lean`:174 | fechado |
| `Riemann.claims.AnalyticTailSolution.newApproximant_closes_material_open_math` | `RIEMANN/Riemann/claims/Claim5_UnconditionalVUB.lean`:230 | fechado |
| `Riemann.claims.AnalyticTailSolution.patchedEps_nonneg` | `RIEMANN/Riemann/claims/Claim5_UnconditionalVUB.lean`:187 | fechado |
| `Riemann.claims.AnalyticTailSolution.patchedEps_tendsto_zero` | `RIEMANN/Riemann/claims/Claim5_UnconditionalVUB.lean`:204 | fechado |
| `Riemann.claims.BalancedDyadicBlock.E_coeff_nonneg` | `RIEMANN/Riemann/claims/Claim5_BalancedMobiusEstermannHabitant.lean`:60 | nao_alcancado |
| `Riemann.claims.BalancedDyadicBlock.E_mod_nonneg` | `RIEMANN/Riemann/claims/Claim5_BalancedMobiusEstermannHabitant.lean`:66 | nao_alcancado |
| `Riemann.claims.BalancedDyadicBlock.contribution_sq_le_energy` | `RIEMANN/Riemann/claims/Claim5_BalancedMobiusEstermannHabitant.lean`:72 | nao_alcancado |
| `Riemann.claims.BalancedMobiusEstermannHabitant.closes_weighted_modular_decay` | `RIEMANN/Riemann/claims/Claim5_BalancedMobiusEstermannHabitant.lean`:258 | nao_alcancado |
| `Riemann.claims.BalancedMobiusEstermannHabitant.eps_nonneg` | `RIEMANN/Riemann/claims/Claim5_BalancedMobiusEstermannHabitant.lean`:236 | nao_alcancado |
| `Riemann.claims.CorrelatedBalancedHabitant.closes_weighted_modular_decay` | `RIEMANN/Riemann/claims/Claim5_CorrelatedBalancedDecay.lean`:43 | nao_alcancado |
| `Riemann.claims.DNBoundCertificate.dn_le_patchedEps` | `RIEMANN/Riemann/claims/Claim5_UnconditionalVUB.lean`:713 | fechado |
| `Riemann.claims.DNBoundCertificate.patchedEps_nonneg` | `RIEMANN/Riemann/claims/Claim5_UnconditionalVUB.lean`:703 | fechado |
| `Riemann.claims.DNBoundCertificate.patchedEps_tendsto_zero` | `RIEMANN/Riemann/claims/Claim5_UnconditionalVUB.lean`:724 | fechado |
| `Riemann.claims.DN_le_eps_frontier` | `RIEMANN/Riemann/claims/Claim5_UnconditionalVUB.lean`:58 | fechado |
| `Riemann.claims.DN_le_residualEnergy` | `RIEMANN/Riemann/claims/Claim5_UnconditionalVUB.lean`:136 | fechado |
| `Riemann.claims.KConcrete_partition` | `RIEMANN/Riemann/claims/Claim5_UnconditionalVUB.lean`:480 | fechado |
| `Riemann.claims.KFarCertificate.abs_bound` | `RIEMANN/Riemann/claims/Claim5_UnconditionalVUB.lean`:267 | fechado |
| `Riemann.claims.KFarCertificate.upper_bound` | `RIEMANN/Riemann/claims/Claim5_UnconditionalVUB.lean`:281 | fechado |
| `Riemann.claims.ModularBlockEnergyData.eps_nonneg` | `RIEMANN/Riemann/claims/Claim5_MultiStateWeightedModularDecay.lean`:190 | fechado |
| `Riemann.claims.ModularBlockEnergyData.global_abs_le_eps` | `RIEMANN/Riemann/claims/Claim5_MultiStateWeightedModularDecay.lean`:197 | erro |
| `Riemann.claims.MultiStateSNData.global_eq_bouquet` | `RIEMANN/Riemann/claims/Claim5_MultiStateWeightedModularDecay.lean`:59 | fechado |
| `Riemann.claims.PersistentBalancedBlockLowerBound.forbids_decay` | `RIEMANN/Riemann/claims/Claim5_CoarseEnergyNondecayCriterion.lean`:13 | nao_alcancado |
| `Riemann.claims.RiemannHabitant.kfar_vanishes` | `RIEMANN/Riemann/claims/Claim5_RiemannHabitant.lean`:29 | nao_alcancado |
| `Riemann.claims.RiemannUnconditionalClosureCertificate.enableTheorem` | `RIEMANN/Riemann/claims/Claim5_RiemannHabitant.lean`:69 | nao_alcancado |
| `Riemann.claims.StructuralNumber.structural_number_closure` | `RIEMANN/Riemann/claims/Claim9_StructuralMultiStateTheorem.lean`:72 | nao_alcancado |
| `Riemann.claims.WEIGHTED_MODULAR_BILINEAR_DECAY` | `RIEMANN/Riemann/claims/WeightedModularBilinearDecay.lean`:88 | fechado |
| `Riemann.claims.WeightedModularBilinearData.S_eq_weighted_roses` | `RIEMANN/Riemann/claims/WeightedModularBilinearDecay.lean`:47 | fechado |
| `Riemann.claims.WeightedModularBilinearData.rose_eq_sum_dyadicBlocks` | `RIEMANN/Riemann/claims/WeightedModularBilinearDecay.lean`:60 | fechado |
| `Riemann.claims.WeightedModularBilinearDecayCertificate.tendsto_zero` | `RIEMANN/Riemann/claims/Claim5_MultiStateWeightedModularDecay.lean`:84 | fechado |
| `Riemann.claims.ZeroResidueControlCertificate.residue_tendsto_zero` | `RIEMANN/Riemann/claims/Claim5_UnconditionalVUB.lean`:653 | fechado |
| `Riemann.claims.ZeroResidueProducer.closes_open_math_control` | `RIEMANN/Riemann/claims/Claim5_UnconditionalVUB.lean`:920 | fechado |
| `Riemann.claims.ZeroResidueProducer.residue_tendsto_zero` | `RIEMANN/Riemann/claims/Claim5_UnconditionalVUB.lean`:926 | fechado |
| `Riemann.claims.approxNormSq_eq_gramQuadratic` | `RIEMANN/Riemann/claims/Claim5_UnconditionalVUB.lean`:493 | fechado |
| `Riemann.claims.balancedBlockKey_mem` | `RIEMANN/Riemann/claims/Claim5_BalancedMobiusEstermannHabitant.lean`:115 | nao_alcancado |
| `Riemann.claims.balancedTriples_mapsTo_blocks` | `RIEMANN/Riemann/claims/Claim5_BalancedMobiusEstermannHabitant.lean`:130 | nao_alcancado |
| `Riemann.claims.block_contribution_abs_le_energy` | `RIEMANN/Riemann/claims/Claim5_BalancedMobiusEstermannHabitant.lean`:197 | nao_alcancado |
| `Riemann.claims.block_contribution_eq_fiber` | `RIEMANN/Riemann/claims/Claim5_BalancedMobiusEstermannHabitant.lean`:140 | nao_alcancado |
| `Riemann.claims.concreteCorrelatedDecay_closes_weighted_modular` | `RIEMANN/Riemann/claims/Claim5_CorrelatedBalancedDecay.lean`:66 | nao_alcancado |
| `Riemann.claims.concreteDecay_closes_weighted_modular` | `RIEMANN/Riemann/claims/Claim5_ConcreteMobiusVasyuninData.lean`:66 | nao_alcancado |
| `Riemann.claims.concreteKFar_of_parts` | `RIEMANN/Riemann/claims/Claim5_UnconditionalVUB.lean`:577 | fechado |
| `Riemann.claims.concrete_global_eq_explicit` | `RIEMANN/Riemann/claims/Claim5_ConcreteMobiusVasyuninData.lean`:77 | nao_alcancado |
| `Riemann.claims.correlatedBlockEps_nonneg` | `RIEMANN/Riemann/claims/Claim5_CorrelatedBalancedDecay.lean`:9 | nao_alcancado |
| `Riemann.claims.energyPairRegion_cases` | `RIEMANN/Riemann/claims/Claim5_UnconditionalVUB.lean`:391 | fechado |
| `Riemann.claims.explicitApprox_mem` | `RIEMANN/Riemann/claims/Claim5_UnconditionalVUB.lean`:119 | fechado |
| `Riemann.claims.global_abs_le_balancedBlockEps` | `RIEMANN/Riemann/claims/Claim5_BalancedMobiusEstermannHabitant.lean`:214 | nao_alcancado |
| `Riemann.claims.global_abs_le_correlatedBlockEps` | `RIEMANN/Riemann/claims/Claim5_CorrelatedBalancedDecay.lean`:16 | nao_alcancado |
| `Riemann.claims.global_eq_sum_block_contributions` | `RIEMANN/Riemann/claims/Claim5_BalancedMobiusEstermannHabitant.lean`:163 | nao_alcancado |
| `Riemann.claims.gramQuadratic_partition` | `RIEMANN/Riemann/claims/Claim5_UnconditionalVUB.lean`:458 | fechado |
| `Riemann.claims.mobiusLinearTaper_tendsto_one` | `RIEMANN/Riemann/claims/Claim5_MobiusTaperAsymptotics.lean`:9 | nao_alcancado |
| `Riemann.claims.mobiusTaperCoeff_three_tendsto_one` | `RIEMANN/Riemann/claims/Claim5_MobiusTaperAsymptotics.lean`:40 | nao_alcancado |
| `Riemann.claims.mobiusTaperCoeff_two_tendsto_one` | `RIEMANN/Riemann/claims/Claim5_MobiusTaperAsymptotics.lean`:33 | nao_alcancado |
| `Riemann.claims.modular_block_energy_vanishing_implies_weighted_decay` | `RIEMANN/Riemann/claims/Claim5_MultiStateWeightedModularDecay.lean`:245 | aberto-sorry |
| `Riemann.claims.residualEnergy_eq_regular_add_far` | `RIEMANN/Riemann/claims/Claim5_UnconditionalVUB.lean`:545 | fechado |
| `Riemann.claims.residualEnergy_expand` | `RIEMANN/Riemann/claims/Claim5_UnconditionalVUB.lean`:364 | fechado |
| `Riemann.claims.residualEnergy_region_split` | `RIEMANN/Riemann/claims/Claim5_UnconditionalVUB.lean`:520 | fechado |
| `Riemann.claims.riemann_unconditional_claim_ready_implies_RH` | `RIEMANN/Riemann/claims/Claim5_RiemannHabitant.lean`:88 | nao_alcancado |
| `Riemann.claims.structural_law_enables_riemann_decay` | `RIEMANN/Riemann/claims/Claim9_StructuralMultiStateTheorem.lean`:112 | nao_alcancado |
| `Riemann.claims.tendsto_log_nat_atTop` | `RIEMANN/Riemann/claims/Claim5_MobiusTaperAsymptotics.lean`:4 | nao_alcancado |
| `Riemann.claims.vasyuninSymmetricKernel_two_three` | `RIEMANN/Riemann/claims/Claim5_ConcreteMobiusVasyuninData.lean`:96 | nao_alcancado |
| `Riemann.claims.vasyuninSymmetricKernel_two_three_ne_zero` | `RIEMANN/Riemann/claims/Claim5_ConcreteMobiusVasyuninData.lean`:105 | nao_alcancado |
| `Riemann.claims.weightedModularBilinearOpenMath_closes` | `RIEMANN/Riemann/claims/WeightedModularBilinearDecay.lean`:108 | fechado |
| `Riemann.external.FINAL_EXTERNAL_ROOT` | `RIEMANN/Riemann/external/FinalExternalCertificate.lean`:51 | fechado |
| `Riemann.full.ALL_CLOSURES_TO_RH` | `RIEMANN/Riemann/full/AllClosuresToTheorem.lean`:8 | fechado |
| `Riemann.full.FINAL_ROOT` | `RIEMANN/Riemann/full/FinalRoot.lean`:4 | fechado |
| `Riemann.full.MinimalUnconditionalRHCertificate.enableTheorem` | `RIEMANN/Riemann/full/MinimalUnconditionalRHCertificate.lean`:17 | nao_alcancado |
| `Riemann.full.UnconditionalRHClaimCertificate.enableTheorem` | `RIEMANN/Riemann/full/UnconditionalClaimCertificate.lean`:16 | nao_alcancado |
| `Riemann.full.finalOpenMathClosureRequirement_to_RH` | `RIEMANN/Riemann/full/AllClosuresToTheorem.lean`:36 | fechado |
| `Riemann.full.minimal_unconditional_rh_ready_implies_RH` | `RIEMANN/Riemann/full/MinimalUnconditionalRHCertificate.lean`:50 | nao_alcancado |
| `Riemann.full.unconditional_claim_ready_implies_RH` | `RIEMANN/Riemann/full/UnconditionalClaimCertificate.lean`:32 | nao_alcancado |
| `Riemann.structural.FormulationProfile.framework_incomplete_of_missing` | `RIEMANN/Riemann/structural/ATKStructuralTheorem.lean`:166 | fechado |
| `Riemann.structural.FormulationProfile.missing_parameter_implies_incomplete` | `RIEMANN/Riemann/structural/ATKStructuralTheorem.lean`:151 | fechado |
| `Riemann.structural.StructuralLogicCertificate.closes_every_certified_manifestation` | `RIEMANN/Riemann/structural/ATKStructuralTheorem.lean`:195 | fechado |
| `Riemann.structural.StructuralNumber.structural_number_closure` | `RIEMANN/Riemann/structural/ATKStructuralTheorem.lean`:105 | fechado |
