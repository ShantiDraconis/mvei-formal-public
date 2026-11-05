# MVEI kernel check — Millennium

This folder records what the Lean 4 kernel said about the Lean sources of the private repository `ShantiDraconis/Millennium`. The sources are published in [`imports/Millennium/`](../../imports/Millennium/).

## What is published

* Source: `ShantiDraconis/Millennium`, commit `5c5ec3d9597f5ffd00210793a63b1ebdeff08baa` (2026-10-21T23:18:45Z).
* 285 files: 275 `.lean` files and the Lake files (`lakefile.*`, `lean-toolchain`, `lake-manifest.json`), plus 3 license or origin file(s) that third-party code requires (`LICENSE`, `rh-ns-cascade/LICENSE`, `rh-umi-invariant/LICENSE`). Paths are the same as in the source repository.
* Nothing else from the private repository is published (documents, commercial license, prompts, storefront material). The `Contaminated/` folder, which the author quarantined and marked as never evidence, is left out too.
* `SOURCES.sha256` lists every published file with its SHA-256. From the repository root: `sha256sum -c mvei/Millennium/SOURCES.sha256`.

## What the kernel said

MVEI verification of 2026-11-05T15:19:16+00:00, on commit `5c5ec3d9597f5ffd00210793a63b1ebdeff08baa`. Each theorem was read with `Lean.collectAxioms`, the function behind `#print axioms`.

| Lean project | Lean version | Build | Closed | Conditional | Open (`sorry`) | Checked file by file: closed / conditional / open / proof error / not reached |
|---|---|---|---:|---:|---:|---|
| `.` (no lakefile; project assembled by MVEI) | v4.19.0 | partial | 244 | 28 | 11 | 15 / 6 / 14 / 10 / 5 |
| `formal/lean` | v4.19.0 | partial | 98 | 21 | 10 | 11 / 2 / 10 / 9 / 14 |
| `formal/theorems` | v4.12.0 | failed | 0 | 0 | 0 | 3 / 3 / 0 / 0 / 1 |
| `lean` | v4.19.0 | partial | 92 | 10 | 12 | 6 / 11 / 3 / 4 / 0 |
| `lean4` | v4.12.0 | partial | 492 | 9 | 14 | 82 / 19 / 107 / 61 / 37 |
| `rh-umi-invariant/formal/lean` | v4.12.0 | OK | 0 | 2 | 0 | — |
| `src/lean` | v4.19.0 | partial | 36 | 1 | 1 | 12 / 5 / 4 / 0 / 4 |
| `src/lean4` | v4.3.0 | partial | 3 | 0 | 0 | 5 / 0 / 4 / 1 / 33 |
| `universe00` | v4.19.0 | partial | 38 | 0 | 0 | 3 / 0 / 8 / 0 / 0 |

| Closed theorems in this repository | |
|---|---:|
| Counting each project | 1 140 |
| Unique (name + statement) | 1 140 |
| Unique, without the lemmas Lean generates itself (`eq_1`, `mk.inj`, `sizeOf_spec`, `deriving`) | 315 |

*Closed* means the kernel accepted the proof and it depends only on `propext`, `Classical.choice` and `Quot.sound`. It says that the statement as written in the file is proved; it does not say that an open problem is solved. Every statement is in `VERIFICACAO.json`. *Conditional* means the proof also uses axioms declared in the repository; *open* means it uses `sorry`. *Checked file by file* covers the files that no build reached: each one went through Lean whole, with a `#print axioms` for each theorem.

| Theorem | Project | State | Axioms beyond the standard three |
|---|---|---|---|
| `ComplexityCurvature.rh_implies_phi_image_gaps` | `.` | open | `sorryAx`, `ComplexityCurvature.Φ`, `ComplexityCurvature.f`, `ComplexityCurvature.gap_control`, `ComplexityCurvature.f_zero` |
| `DeltaGapFramework.T1_conditional_equivalence` | `.` | conditional | `DeltaGapFramework.ZetaZeros`, `DeltaGapFramework.NPLanguage`, `DeltaGapFramework.C_det`, `DeltaGapFramework.C_ndet`, `DeltaGapFramework.Phi`, `DeltaGapFramework.f`, `DeltaGapFramework.f_zero` |
| `DeltaGapFramework.T4_transfer` | `.` | conditional | `DeltaGapFramework.ZetaZeros`, `DeltaGapFramework.NPLanguage`, `DeltaGapFramework.Phi`, `DeltaGapFramework.C_det`, `DeltaGapFramework.C_ndet`, `DeltaGapFramework.f`, `DeltaGapFramework.L2_approximate_transfer` |
| `LocalGlobal.Instances.Poincare.Poincare_solved` | `.` | conditional | `LocalGlobal.Instances.Poincare.Perelman` |
| `MillenniumGroups.Group1.BSD_Conjecture_Analytic` | `.` | open | `sorryAx` |
| `MillenniumGroups.Group1.Riemann_Hypothesis` | `.` | open | `sorryAx` |
| `MillenniumGroups.Group1.Spectral_LFunction_Theorem` | `.` | open | `sorryAx` |
| `MillenniumGroups.Group2.NavierStokes_Existence_Smoothness` | `.` | open | `sorryAx` |
| `SpectralLink.zero_deviation_implies_both` | `.` | open | `sorryAx` |
| `StructuralInsufficiency.reconciliation` | `.` | conditional | `StructuralInsufficiency.classical_system`, `StructuralInsufficiency.expanded_system`, `StructuralInsufficiency.WeakSol`, `StructuralInsufficiency.classical_obstruction`, `StructuralInsufficiency.expanded_no_obstruction` |
| `StructuralInsufficiency.theorem_A` | `.` | conditional | `StructuralInsufficiency.classical_system`, `StructuralInsufficiency.classical_obstruction` |
| `StructuralInsufficiency.theorem_B` | `.` | conditional | `StructuralInsufficiency.WeakSol` |
| `StructuralInsufficiency.theorem_C` | `.` | conditional | `StructuralInsufficiency.WeakSol`, `StructuralInsufficiency.classical_system`, `StructuralInsufficiency.classical_obstruction` |
| `StructuralInsufficiency.weak_implies_strong_in_expanded` | `.` | conditional | `StructuralInsufficiency.WeakSol`, `StructuralInsufficiency.expanded_system`, `StructuralInsufficiency.expanded_no_obstruction` |
| `TUSC.BlockA_Laws.energy_law` | `.` | conditional | `TUSC.BlockA` |
| `TUSC.BlockA_Laws.mk.inj` | `.` | conditional | `TUSC.BlockA` |
| `TUSC.BlockA_Laws.mk.injEq` | `.` | conditional | `TUSC.BlockA` |
| `TUSC.BlockA_Laws.mk.sizeOf_spec` | `.` | conditional | `TUSC.BlockA` |
| `TUSC.BlockA_Laws.spectral_law` | `.` | conditional | `TUSC.BlockA` |
| `TUSC.BlockElement.fromA.inj` | `.` | conditional | `TUSC.BlockA`, `TUSC.BlockB`, `TUSC.BlockC`, `TUSC.BlockD` |
| `TUSC.BlockElement.fromA.injEq` | `.` | conditional | `TUSC.BlockA`, `TUSC.BlockB`, `TUSC.BlockC`, `TUSC.BlockD` |
| `TUSC.BlockElement.fromA.sizeOf_spec` | `.` | conditional | `TUSC.BlockA`, `TUSC.BlockB`, `TUSC.BlockC`, `TUSC.BlockD` |
| `TUSC.BlockElement.fromB.inj` | `.` | conditional | `TUSC.BlockB`, `TUSC.BlockA`, `TUSC.BlockC`, `TUSC.BlockD` |
| `TUSC.BlockElement.fromB.injEq` | `.` | conditional | `TUSC.BlockB`, `TUSC.BlockA`, `TUSC.BlockC`, `TUSC.BlockD` |
| `TUSC.BlockElement.fromB.sizeOf_spec` | `.` | conditional | `TUSC.BlockB`, `TUSC.BlockA`, `TUSC.BlockC`, `TUSC.BlockD` |
| `TUSC.BlockElement.fromC.inj` | `.` | conditional | `TUSC.BlockC`, `TUSC.BlockA`, `TUSC.BlockB`, `TUSC.BlockD` |
| `TUSC.BlockElement.fromC.injEq` | `.` | conditional | `TUSC.BlockC`, `TUSC.BlockA`, `TUSC.BlockB`, `TUSC.BlockD` |
| `TUSC.BlockElement.fromC.sizeOf_spec` | `.` | conditional | `TUSC.BlockC`, `TUSC.BlockA`, `TUSC.BlockB`, `TUSC.BlockD` |
| `TUSC.BlockElement.fromD.inj` | `.` | conditional | `TUSC.BlockD`, `TUSC.BlockA`, `TUSC.BlockB`, `TUSC.BlockC` |
| `TUSC.BlockElement.fromD.injEq` | `.` | conditional | `TUSC.BlockD`, `TUSC.BlockA`, `TUSC.BlockB`, `TUSC.BlockC` |
| `TUSC.BlockElement.fromD.sizeOf_spec` | `.` | conditional | `TUSC.BlockD`, `TUSC.BlockA`, `TUSC.BlockB`, `TUSC.BlockC` |
| `TUSC.TUSC_existence` | `.` | open | `TUSC.BlockA`, `TUSC.BlockB`, `TUSC.BlockC`, `TUSC.BlockD`, `TUSC.F_AG`, `TUSC.F_AN`, `TUSC.F_AC`, `TUSC.F_GN`, `TUSC.F_CN`, `sorryAx` |
| `TUSC.local_to_global_correspondence` | `.` | conditional | `TUSC.BlockA`, `TUSC.BlockB`, `TUSC.BlockC`, `TUSC.F_AG`, `TUSC.F_AN` |
| `TUSC.transfer_theorem` | `.` | conditional | `TUSC.BlockA`, `TUSC.BlockB`, `TUSC.BlockC`, `TUSC.F_AG`, `TUSC.F_AN` |
| `energy_inequality_rh` | `.` | open | `sorryAx` |
| `oscillation_cancellation` | `.` | open | `ζ`, `sorryAx` |
| `rh_implies_global_regularity` | `.` | open | `ζ`, `sorryAx` |
| `rh_implies_stability` | `.` | conditional | `ζ` |
| `vorticity_bound_rh` | `.` | open | `ζ`, `sorryAx` |
| `BSD.Classical.bsd_gap_characterization` | `formal/lean` | conditional | `BSD.Classical.EllipticCurve`, `BSD.Classical.ord_s_1`, `BSD.Classical.rank` |
| `BSD.Classical.weak_bsd_gap` | `formal/lean` | open | `BSD.Classical.EllipticCurve`, `BSD.Classical.L`, `BSD.Classical.rank`, `BSD.Classical.ord_s_1`, `sorryAx` |
| `BSD.Classical.Δ_BSD.eq_1` | `formal/lean` | conditional | `BSD.Classical.EllipticCurve`, `BSD.Classical.ord_s_1`, `BSD.Classical.rank` |
| `LGMathOS.Hodge.AlgebraicCycle.mk.inj` | `formal/lean` | conditional | `LGMathOS.Hodge.ProjectiveVariety` |
| `LGMathOS.Hodge.AlgebraicCycle.mk.injEq` | `formal/lean` | conditional | `LGMathOS.Hodge.ProjectiveVariety` |
| `LGMathOS.Hodge.AlgebraicCycle.mk.sizeOf_spec` | `formal/lean` | conditional | `LGMathOS.Hodge.ProjectiveVariety` |
| `LGMathOS.Hodge.HodgeClass.mk.inj` | `formal/lean` | conditional | `LGMathOS.Hodge.ProjectiveVariety` |
| `LGMathOS.Hodge.HodgeClass.mk.injEq` | `formal/lean` | conditional | `LGMathOS.Hodge.ProjectiveVariety` |
| `LGMathOS.Hodge.HodgeClass.mk.sizeOf_spec` | `formal/lean` | conditional | `LGMathOS.Hodge.ProjectiveVariety` |
| `LGMathOS.Poincare.poincare_conjecture` | `formal/lean` | open | `LGMathOS.Poincare.Manifold3`, `LGMathOS.Poincare.simply_connected`, `LGMathOS.Poincare.is_closed`, `LGMathOS.Poincare.homeomorphic`, `LGMathOS.Poincare.S3`, `sorryAx` |
| `Millennium.ImpossibilityClassical` | `formal/lean` | conditional | `Millennium.StrongSolutionP`, `Millennium.AdequateP`, `Millennium.StrongSolutionImpliesAdequateP`, `Millennium.HasBridge`, `Millennium.AdequatePImpliesBridge`, `Millennium.NoBridgeInScl` |
| `Millennium.NavierStokes.LocalEnergyBound.decay` | `formal/lean` | conditional | `Millennium.NavierStokes.SobolevH1` |
| `Millennium.NavierStokes.LocalEnergyBound.initial` | `formal/lean` | conditional | `Millennium.NavierStokes.SobolevH1` |
| `Millennium.NavierStokes.LocalEnergyBound.nonneg` | `formal/lean` | conditional | `Millennium.NavierStokes.SobolevH1` |
| `Millennium.NavierStokes.PressureRegularity.gradient_bound` | `formal/lean` | conditional | `Millennium.NavierStokes.SobolevH1` |
| `Millennium.NavierStokes.VorticityControl.locally_bounded` | `formal/lean` | conditional | `Millennium.NavierStokes.SobolevH1` |
| `Millennium.NavierStokes.VorticityControl.no_concentration` | `formal/lean` | conditional | `Millennium.NavierStokes.SobolevH1` |
| `Millennium.NavierStokes.bridge_navier_stokes` | `formal/lean` | open | `Millennium.NavierStokes.SobolevH1`, `sorryAx` |
| `Millennium.NoGlobalAdequacy` | `formal/lean` | conditional | `Millennium.Adequate`, `Millennium.NotAdequateScl` |
| `Millennium.NoLocalAdequacy` | `formal/lean` | conditional | `Millennium.AdequateP`, `Millennium.HasBridge`, `Millennium.AdequatePImpliesBridge`, `Millennium.NoBridgeInScl` |
| `Millennium.poincare_no_strong` | `formal/lean` | conditional | `Millennium.StrongSolutionP`, `Millennium.AdequateP`, `Millennium.StrongSolutionImpliesAdequateP`, `Millennium.HasBridge`, `Millennium.AdequatePImpliesBridge`, `Millennium.NoBridgeInScl` |
| `Millennium.poincare_weak` | `formal/lean` | conditional | `Millennium.WeakSolutionP`, `Millennium.PoincareWeakSolution` |
| `Millennium.weak_without_strong_consistent` | `formal/lean` | conditional | `Millennium.WeakSolutionP`, `Millennium.StrongSolutionP`, `Millennium.PoincareWeakSolution`, `Millennium.AdequateP`, `Millennium.StrongSolutionImpliesAdequateP`, `Millennium.HasBridge`, `Millennium.AdequatePImpliesBridge`, `Millennium.NoBridgeInScl` |
| `PvsNP.Bridge.NP_subset_PSPACE` | `formal/lean` | open | `sorryAx` |
| `PvsNP.Bridge.PSPACE_subset_EXP` | `formal/lean` | open | `sorryAx` |
| `PvsNP.Bridge.P_subset_NP` | `formal/lean` | open | `sorryAx` |
| `PvsNP.Bridge.bridge_theorem_separation` | `formal/lean` | open | `sorryAx` |
| `PvsNP.Bridge.cook_levin` | `formal/lean` | open | `sorryAx` |
| `PvsNP.Bridge.pvsnp_dichotomy` | `formal/lean` | open | `sorryAx` |
| `PvsNP.Bridge.time_hierarchy` | `formal/lean` | open | `sorryAx` |
| `RH.Classical.rh_gap_characterization` | `formal/lean` | conditional | `RH.Classical.ζ` |
| `DeltaGap44.DeltaGap44Structure.law1` | `lean` | conditional | `DeltaGap44.C_det`, `DeltaGap44.C_ndet`, `DeltaGap44.Phi` |
| `DeltaGap44.DeltaGap44Structure.law2` | `lean` | conditional | `DeltaGap44.C_det`, `DeltaGap44.C_ndet`, `DeltaGap44.Phi` |
| `DeltaGap44.DeltaGap44Structure.law4` | `lean` | conditional | `DeltaGap44.C_det`, `DeltaGap44.C_ndet`, `DeltaGap44.Phi` |
| `DeltaGap44.DeltaGap44Structure.mk.inj` | `lean` | conditional | `DeltaGap44.C_det`, `DeltaGap44.C_ndet`, `DeltaGap44.Phi` |
| `DeltaGap44.DeltaGap44Structure.mk.injEq` | `lean` | conditional | `DeltaGap44.C_det`, `DeltaGap44.C_ndet`, `DeltaGap44.Phi` |
| `DeltaGap44.DeltaGap44Structure.mk.sizeOf_spec` | `lean` | conditional | `DeltaGap44.C_det`, `DeltaGap44.C_ndet`, `DeltaGap44.Phi` |
| `DeltaGap44.DeltaGap44Structure.phi_exists` | `lean` | conditional | `DeltaGap44.C_det`, `DeltaGap44.C_ndet`, `DeltaGap44.Phi` |
| `DeltaGap44.Theorem1` | `lean` | conditional | `DeltaGap44.C_det`, `DeltaGap44.C_ndet`, `DeltaGap44.Phi` |
| `DeltaGap44.Theorem2` | `lean` | conditional | `DeltaGap44.C_det`, `DeltaGap44.C_ndet`, `DeltaGap44.Phi` |
| `NavierStokes.LRE.navier_stokes_compression_barrier` | `lean` | conditional | `NavierStokes.LRE.EnergyDissipationPath`, `NavierStokes.LRE.LerayHopfSolution`, `NavierStokes.LRE.critical_residual`, `NavierStokes.LRE.energetic_projection`, `NavierStokes.LRE.projection_non_injective`, `NavierStokes.LRE.residual_discriminates` |
| `NavierStokes.converges_to_critical_point` | `lean` | open | `sorryAx` |
| `NavierStokes.energy_decay_exponential` | `lean` | open | `sorryAx` |
| `NavierStokes.lyapunov_decreases` | `lean` | open | `sorryAx` |
| `NavierStokes.rh_coupling_ensures_stability` | `lean` | open | `sorryAx` |
| `NavierStokes.rh_violation_allows_singularities` | `lean` | open | `sorryAx` |
| `RHPvsNP.off_line_dominates` | `lean` | open | `sorryAx` |
| `RHPvsNP.p_subset_np` | `lean` | open | `sorryAx` |
| `RHPvsNP.scenario_gap_connection` | `lean` | open | `sorryAx` |
| `RiemannHypothesis.off_line_contribution_dominates` | `lean` | open | `sorryAx` |
| `RiemannHypothesis.p_eq_np_implies_f_np_bounded` | `lean` | open | `sorryAx` |
| `RiemannHypothesis.primes_dont_let` | `lean` | open | `sorryAx` |
| `RiemannHypothesis.zero_contribution_magnitude` | `lean` | open | `sorryAx` |
| `GapUniversal.gap_implies_undeterminable` | `lean4` | open | `sorryAx` |
| `LocalGlobal.Instances.PvsNP.gap_nonneg` | `lean4` | conditional | `LocalGlobal.Instances.PvsNP.det_ge_ndet` |
| `Millennium.Delta.IClass.mk.inj` | `lean4` | conditional | `Millennium.Delta.I` |
| `Millennium.Delta.IClass.mk.injEq` | `lean4` | conditional | `Millennium.Delta.I` |
| `Millennium.Delta.IClass.mk.sizeOf_spec` | `lean4` | conditional | `Millennium.Delta.I` |
| `RH_NP.deltaSpectrum_under_RH` | `lean4` | open | `sorryAx` |
| `RiemannHypothesis.critical_line_is_stable` | `lean4` | open | `sorryAx` |
| `RiemannHypothesis.primes_block_zeros` | `lean4` | open | `sorryAx` |
| `RiemannHypothesis.primes_zeros_equivalence` | `lean4` | open | `sorryAx` |
| `RiemannHypothesis.zero_off_line_contradicts_prime_bound` | `lean4` | open | `sorryAx` |
| `StructuralCheckmate.ForcedBifurcation` | `lean4` | conditional | `StructuralCheckmate.NoUnifyingStructureInClassical` |
| `StructuralCheckmate.ParadigmMustBend` | `lean4` | conditional | `StructuralCheckmate.NoUnifyingStructureInClassical` |
| `StructuralCheckmate.StructuralCheckmate` | `lean4` | conditional | `StructuralCheckmate.NoUnifyingStructureInClassical` |
| `UnifiedSystem.classical_expanded_distinct` | `lean4` | open | `sorryAx` |
| `UnifiedSystem.classical_proper_subset` | `lean4` | open | `sorryAx` |
| `UnifiedSystem.expanded_proper_subset` | `lean4` | open | `sorryAx` |
| `UnifiedSystem.final_clay_compatible_statement` | `lean4` | open | `sorryAx` |
| `UnifiedSystem.millennium_unified` | `lean4` | open | `sorryAx` |
| `UnifiedSystem.obstruction_unified_zero` | `lean4` | open | `sorryAx` |
| `UnifiedSystem.unified_obstruction_vanishes` | `lean4` | open | `sorryAx`, `UnifiedSystem.obstruction_expanded_zero` |
| `UnifiedSystem.weak_strong_equivalence` | `lean4` | open | `sorryAx` |
| `allLawsHold` | `lean4` | conditional | `lawA1`, `lawL1_unified`, `lawC1`, `lawS1` |
| `masterTheorem` | `lean4` | conditional | `lawA1` |
| `UMI_RH.I_RH.eq_1` | `rh-umi-invariant/formal/lean` | conditional | `UMI_RH.d` |
| `UMI_RH.RH_equiv_I` | `rh-umi-invariant/formal/lean` | conditional | `UMI_RH.RH`, `UMI_RH.d`, `UMI_RH.NB_BD_anchor` |
| `Millennium.Logical.classical_invariance` | `src/lean` | conditional | `Millennium.Logical.provable_monotone` |
| `Millennium.Zeta.rh_equivalence` | `src/lean` | open | `sorryAx` |
| `LocalGlobalFramework.all_clay_iff_all_bridge` | `. (file by file)` | open | `sorryAx`, `LocalGlobalFramework.LFunction`, `LocalGlobalFramework.NS_InitialData`, `LocalGlobalFramework.clay_equiv_bridge_i`, `LocalGlobalFramework.ns_inv`, `LocalGlobalFramework.ns_loc`, `LocalGlobalFramework.rh_inv`, `LocalGlobalFramework.rh_loc` |
| `LocalGlobalFramework.millennium_solved_iff_bridges_constructed` | `. (file by file)` | open | `sorryAx`, `LocalGlobalFramework.LFunction`, `LocalGlobalFramework.NS_InitialData`, `LocalGlobalFramework.clay_equiv_bridge_i`, `LocalGlobalFramework.ns_inv`, `LocalGlobalFramework.ns_loc`, `LocalGlobalFramework.rh_inv`, `LocalGlobalFramework.rh_loc` |
| `LocalGlobalFramework.bridge_transfer` | `. (file by file)` | open | `sorryAx` |
| `quantum_performance_degradation` | `. (file by file)` | conditional | `MillenniumProblem`, `QuantumComputer`, `UniversalConstant` |
| `chain_of_command_established` | `. (file by file)` | conditional | `MillenniumProblem`, `UniversalConstant` |
| `final_sovereignty_theorem` | `. (file by file)` | conditional | `MillenniumProblem`, `UniversalConstant` |
| `Classical_System_Insufficient` | `. (file by file)` | open | `Axiom_A_Adequacy`, `Axiom_E_Evidence`, `sorryAx` |
| `Zero_Obstruction_Necessary` | `. (file by file)` | conditional | `Axiom_A_Adequacy` |
| `RH_No_Strong_Solution` | `. (file by file)` | open | `Axiom_A_Adequacy`, `Axiom_E_Evidence`, `sorryAx` |
| `PvsNP_No_Strong_Solution` | `. (file by file)` | open | `Axiom_A_Adequacy`, `Axiom_E_Evidence`, `sorryAx` |
| `NS_No_Strong_Solution` | `. (file by file)` | open | `Axiom_A_Adequacy`, `Axiom_E_Evidence`, `sorryAx` |
| `BSD_No_Strong_Solution` | `. (file by file)` | open | `Axiom_A_Adequacy`, `Axiom_E_Evidence`, `sorryAx` |
| `Hodge_No_Strong_Solution` | `. (file by file)` | open | `Axiom_A_Adequacy`, `Axiom_E_Evidence`, `sorryAx` |
| `YM_No_Strong_Solution` | `. (file by file)` | open | `Axiom_A_Adequacy`, `Axiom_E_Evidence`, `sorryAx` |
| `final_five_stability` | `. (file by file)` | conditional | `FinalState`, `ThermalTrigger` |
| `trigger_cascade` | `. (file by file)` | conditional | `FinalState`, `ThermalTrigger`, `thermal_trigger_activation` |
| `infinite_growth_convergence` | `. (file by file)` | open | `FinalState`, `ThermalTrigger`, `sorryAx` |
| `meta_unification` | `. (file by file)` | open | `FinalState`, `ThermalTrigger`, `barco_escola`, `solar_colonization`, `sorryAx` |
| `authority_loop_amplification` | `. (file by file)` | open | `sorryAx`, `truth_server`, `youtube_algorithm_recognition` |
| `rh_coupling_bound` | `. (file by file)` | open | `sorryAx`, `ζ` |
| `BSD.Bridge.height_bridge` | `formal/lean (file by file)` | open | `sorryAx`, `BSD.Classical.EllipticCurve`, `BSD.Classical.L`, `BSD.Classical.ord_s_1`, `BSD.Classical.rank`, `BSD.Classical.regulator` |
| `BSD.Bridge.bsd_via_bridges` | `formal/lean (file by file)` | open | `sorryAx`, `BSD.Bridge.is_modular`, `BSD.Classical.EllipticCurve`, `BSD.Classical.L`, `BSD.Classical.ord_s_1`, `BSD.Classical.rank` |
| `Millennium.adequate_implies_unifying` | `formal/lean (file by file)` | conditional | `Millennium.Adequate` |
| `Millennium.local_to_global_adequacy` | `formal/lean (file by file)` | conditional | `Millennium.Adequate`, `Millennium.AdequateGlobal_iff`, `Millennium.AdequateP` |
| `NavierStokes.Bridge.bkm_criterion` | `formal/lean (file by file)` | open | `sorryAx` |
| `NavierStokes.Bridge.ns_2d_global_existence` | `formal/lean (file by file)` | open | `sorryAx` |
| `NavierStokes.Bridge.ns_local_existence` | `formal/lean (file by file)` | open | `sorryAx` |
| `rh_iff_critical_line` | `formal/lean (file by file)` | open | `sorryAx` |
| `RH.Bridge.rh_iff_li_criterion` | `formal/lean (file by file)` | open | `sorryAx` |
| `Millennium.RH.bridge_rh` | `formal/lean (file by file)` | open | `sorryAx` |
| `Millennium.RH.classical_rh_from_bridge` | `formal/lean (file by file)` | open | `sorryAx` |
| … 165 more in `VERIFICACAO.json` and `TEOREMAS.csv` | | | |

### Declared theorems

The `.lean` files of the verified commit declare 687 `theorem`/`lemma` (counting copies). The kernel checked 476 of them (208 closed, 75 conditional, 193 open). The closed count in the table above is larger: it also counts the theorems Lean generates by itself (equation lemmas, structure fields, `deriving`), which are not written in the text. For 211 the kernel has no result:

| Reason | Theorems |
|---|---:|
| checked file by file: Lean did not reach the theorem (missing import, syntax error or timeout) | 92 |
| checked file by file: the written proof does not pass the kernel | 81 |
| the file compiled, but the name did not appear in the kernel (private, mutual or macro-generated) | 22 |
| the file did not compile (an error in it or in a file it imports) | 16 |

### MVEI corrections

* `correcoes/a-arquivos-corrompidos.patch` (arquivo corrompido no repositório (merge add/add resolvido aceitando os dois lados: linhas das duas versões intercaladas), 23 file(s)): applies to the published sources: `git apply -p1 --directory=imports/Millennium mvei/Millennium/correcoes/a-arquivos-corrompidos.patch` (in order, after the ones above)
* `correcoes/imports-no-topo.patch` (import fora do início do arquivo, 16 file(s)): made for the verified commit; it does not apply to the published commit as is
* `correcoes/renomear-imports-mathlib.patch` (import de módulo que não existe na versão do Mathlib do projeto (renomeado ou dividido), 24 file(s)): made for the verified commit; it does not apply to the published commit as is
* `correcoes/tatica-encontrada.patch` (prova que não passava (ou axioma) que uma tática padrão fecha no kernel, 24 file(s)): made for the verified commit; it does not apply to the published commit as is
* `correcoes/vocabulario-lean4.patch` (grafia que o Lean 4 não lê (nome acentuado, λ/Σ/Π como nome, ∀ x y ∈ s, docstring solta, constant, tática do Mathlib sem import), 223 file(s)): made for the verified commit; it does not apply to the published commit as is
* `correcoes/z-provas-reparadas.patch` (prova que não passava no kernel (o enunciado fica igual), 43 file(s)): made for the verified commit; it does not apply to the published commit as is
* `correcoes/zy-enunciados-do-autor.patch` (enunciado reescrito a pedido do autor (o original, como escrito, fica registrado), 21 file(s)): made for the verified commit; it does not apply to the published commit as is
* `correcoes/zz-refutacoes.patch` (teorema com enunciado falso como o Lean o lê (o original fica como está), 6 file(s)): applies to the published sources: `git apply -p1 --directory=imports/Millennium mvei/Millennium/correcoes/zz-refutacoes.patch` (in order, after the ones above)

## Files in this folder

* `VERIFICACAO.json` — each Lean project of this repository, each theorem the kernel read, its statement, its axioms and its state (`fechado` closed, `condicional` conditional, `aberto-sorry` open)
* `TEOREMAS.csv` — each declared `theorem`/`lemma`: file, line, state in the kernel (`nao_checado` = not checked) and, if not checked, why (in Portuguese)
* `BUILD_LOG.txt` — one block per project: Lean version, result, errors
* `SOURCE.json` — source commit, verified commit and dates, machine-readable
* `SOURCES.sha256` — SHA-256 of every published file

## Reproduce

```
cd imports/Millennium/<project>   # a project folder from the table above ('.' is imports/Millennium)
lake exe cache get           # only for projects that require Mathlib
lake build
```

Each project uses the Lean version in its own `lean-toolchain`, which elan installs. The MVEI pipeline that produced these results is in the author's repository and is not public.
