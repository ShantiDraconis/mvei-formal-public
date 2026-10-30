# MVEI kernel check — Millennium

This folder records what the Lean 4 kernel said about the Lean sources of the private repository `ShantiDraconis/Millennium`. The sources are published in [`imports/Millennium/`](../../imports/Millennium/).

## What is published

* Source: `ShantiDraconis/Millennium`, commit `5c5ec3d9597f5ffd00210793a63b1ebdeff08baa` (2026-10-21T23:18:45Z).
* 285 files: 275 `.lean` files and the Lake files (`lakefile.*`, `lean-toolchain`, `lake-manifest.json`), plus 3 license or origin file(s) that third-party code requires (`LICENSE`, `rh-ns-cascade/LICENSE`, `rh-umi-invariant/LICENSE`). Paths are the same as in the source repository.
* Nothing else from the private repository is published (documents, commercial license, prompts, storefront material). The `Contaminated/` folder, which the author quarantined and marked as never evidence, is left out too.
* `SOURCES.sha256` lists every published file with its SHA-256. From the repository root: `sha256sum -c mvei/Millennium/SOURCES.sha256`.

## What the kernel said

MVEI verification of 2026-10-30T08:01:18+00:00, on commit `5c5ec3d9597f5ffd00210793a63b1ebdeff08baa`. Each theorem was read with `Lean.collectAxioms`, the function behind `#print axioms`.

| Lean project | Lean version | Build | Closed | Conditional | Open (`sorry`) | Checked file by file: closed / conditional / open / proof error / not reached |
|---|---|---|---:|---:|---:|---|
| `.` (no lakefile; project assembled by MVEI) | v4.19.0 | partial | 128 | 2 | 5 | 18 / 6 / 18 / 19 / 10 |
| `formal/lean` | v4.19.0 | partial | 62 | 18 | 2 | 6 / 2 / 23 / 10 / 30 |
| `formal/theorems` | v4.12.0 | failed | 0 | 0 | 0 | 3 / 3 / 0 / 0 / 1 |
| `lean` | v4.19.0 | partial | 80 | 9 | 4 | 6 / 9 / 11 / 6 / 5 |
| `lean4` | v4.12.0 | partial | 386 | 6 | 6 | 75 / 20 / 112 / 75 / 48 |
| `rh-umi-invariant/formal/lean` | v4.12.0 | OK | 0 | 2 | 0 | — |
| `src/lean` | v4.19.0 | partial | 13 | 0 | 1 | 5 / 4 / 0 / 6 / 21 |
| `src/lean4` | v4.3.0 | partial | 3 | 0 | 0 | 5 / 0 / 4 / 1 / 33 |
| `universe00` | v4.19.0 | partial | 31 | 0 | 0 | 3 / 0 / 0 / 1 / 11 |

| Closed theorems in this repository | |
|---|---:|
| Counting each project | 824 |
| Unique (name + statement) | 822 |
| Unique, without the lemmas Lean generates itself (`eq_1`, `mk.inj`, `sizeOf_spec`, `deriving`) | 218 |

*Closed* means the kernel accepted the proof and it depends only on `propext`, `Classical.choice` and `Quot.sound`. It says that the statement as written in the file is proved; it does not say that an open problem is solved. Every statement is in `VERIFICACAO.json`. *Conditional* means the proof also uses axioms declared in the repository; *open* means it uses `sorry`. *Checked file by file* covers the files that no build reached: each one went through Lean whole, with a `#print axioms` for each theorem.

| Theorem | Project | State | Axioms beyond the standard three |
|---|---|---|---|
| `ComplexityCurvature.rh_implies_phi_image_gaps` | `.` | open | `sorryAx`, `ComplexityCurvature.Φ`, `ComplexityCurvature.f`, `ComplexityCurvature.gap_control`, `ComplexityCurvature.f_zero` |
| `DeltaGapFramework.T1_conditional_equivalence` | `.` | conditional | `DeltaGapFramework.ZetaZeros`, `DeltaGapFramework.NPLanguage`, `DeltaGapFramework.C_det`, `DeltaGapFramework.C_ndet`, `DeltaGapFramework.Phi`, `DeltaGapFramework.f`, `DeltaGapFramework.f_zero` |
| `DeltaGapFramework.T4_transfer` | `.` | conditional | `DeltaGapFramework.ZetaZeros`, `DeltaGapFramework.NPLanguage`, `DeltaGapFramework.Phi`, `DeltaGapFramework.C_det`, `DeltaGapFramework.C_ndet`, `DeltaGapFramework.f`, `DeltaGapFramework.L2_approximate_transfer` |
| `MillenniumGroups.Group1.BSD_Conjecture_Analytic` | `.` | open | `sorryAx` |
| `MillenniumGroups.Group1.Riemann_Hypothesis` | `.` | open | `sorryAx` |
| `MillenniumGroups.Group1.Spectral_LFunction_Theorem` | `.` | open | `sorryAx` |
| `SpectralLink.zero_deviation_implies_both` | `.` | open | `sorryAx` |
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
| `DeltaGap44.DeltaGap44Structure.law1` | `lean` | conditional | `DeltaGap44.C_det`, `DeltaGap44.C_ndet`, `DeltaGap44.Phi` |
| `DeltaGap44.DeltaGap44Structure.law2` | `lean` | conditional | `DeltaGap44.C_det`, `DeltaGap44.C_ndet`, `DeltaGap44.Phi` |
| `DeltaGap44.DeltaGap44Structure.law4` | `lean` | conditional | `DeltaGap44.C_det`, `DeltaGap44.C_ndet`, `DeltaGap44.Phi` |
| `DeltaGap44.DeltaGap44Structure.mk.inj` | `lean` | conditional | `DeltaGap44.C_det`, `DeltaGap44.C_ndet`, `DeltaGap44.Phi` |
| `DeltaGap44.DeltaGap44Structure.mk.injEq` | `lean` | conditional | `DeltaGap44.C_det`, `DeltaGap44.C_ndet`, `DeltaGap44.Phi` |
| `DeltaGap44.DeltaGap44Structure.mk.sizeOf_spec` | `lean` | conditional | `DeltaGap44.C_det`, `DeltaGap44.C_ndet`, `DeltaGap44.Phi` |
| `DeltaGap44.DeltaGap44Structure.phi_exists` | `lean` | conditional | `DeltaGap44.C_det`, `DeltaGap44.C_ndet`, `DeltaGap44.Phi` |
| `DeltaGap44.Theorem1` | `lean` | conditional | `DeltaGap44.C_det`, `DeltaGap44.C_ndet`, `DeltaGap44.Phi` |
| `DeltaGap44.Theorem2` | `lean` | conditional | `DeltaGap44.C_det`, `DeltaGap44.C_ndet`, `DeltaGap44.Phi` |
| `RHPvsNP.off_line_dominates` | `lean` | open | `sorryAx` |
| `RHPvsNP.p_subset_np` | `lean` | open | `sorryAx` |
| `RHPvsNP.scenario_gap_connection` | `lean` | open | `sorryAx` |
| `RiemannHypothesis.p_eq_np_implies_f_np_bounded` | `lean` | open | `sorryAx` |
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
| `allLawsHold` | `lean4` | conditional | `lawA1`, `lawL1_unified`, `lawC1`, `lawS1` |
| `masterTheorem` | `lean4` | conditional | `lawA1` |
| `UMI_RH.I_RH.eq_1` | `rh-umi-invariant/formal/lean` | conditional | `UMI_RH.d` |
| `UMI_RH.RH_equiv_I` | `rh-umi-invariant/formal/lean` | conditional | `UMI_RH.RH`, `UMI_RH.d`, `UMI_RH.NB_BD_anchor` |
| `Millennium.Zeta.rh_equivalence` | `src/lean` | open | `sorryAx` |
| `LocalGlobal.Instances.Poincare.Poincare_solved` | `. (file by file)` | conditional | `LocalGlobal.Instances.Poincare.Perelman` |
| `LocalGlobalFramework.all_clay_iff_all_bridge` | `. (file by file)` | open | `sorryAx`, `LocalGlobalFramework.LFunction`, `LocalGlobalFramework.NS_InitialData`, `LocalGlobalFramework.clay_equiv_bridge_i`, `LocalGlobalFramework.ns_inv`, `LocalGlobalFramework.ns_loc`, `LocalGlobalFramework.rh_inv`, `LocalGlobalFramework.rh_loc` |
| `LocalGlobalFramework.millennium_solved_iff_bridges_constructed` | `. (file by file)` | open | `sorryAx`, `LocalGlobalFramework.LFunction`, `LocalGlobalFramework.NS_InitialData`, `LocalGlobalFramework.clay_equiv_bridge_i`, `LocalGlobalFramework.ns_inv`, `LocalGlobalFramework.ns_loc`, `LocalGlobalFramework.rh_inv`, `LocalGlobalFramework.rh_loc` |
| `quantum_performance_degradation` | `. (file by file)` | conditional | `MillenniumProblem`, `QuantumComputer`, `UniversalConstant` |
| `chain_of_command_established` | `. (file by file)` | conditional | `MillenniumProblem`, `UniversalConstant` |
| `Classical_System_Insufficient` | `. (file by file)` | open | `Axiom_A_Adequacy`, `Axiom_E_Evidence`, `sorryAx` |
| `Zero_Obstruction_Necessary` | `. (file by file)` | conditional | `Axiom_A_Adequacy` |
| `RH_No_Strong_Solution` | `. (file by file)` | open | `Axiom_A_Adequacy`, `Axiom_E_Evidence`, `sorryAx` |
| `PvsNP_No_Strong_Solution` | `. (file by file)` | open | `Axiom_A_Adequacy`, `Axiom_E_Evidence`, `sorryAx` |
| `NS_No_Strong_Solution` | `. (file by file)` | open | `Axiom_A_Adequacy`, `Axiom_E_Evidence`, `sorryAx` |
| `BSD_No_Strong_Solution` | `. (file by file)` | open | `Axiom_A_Adequacy`, `Axiom_E_Evidence`, `sorryAx` |
| `Hodge_No_Strong_Solution` | `. (file by file)` | open | `Axiom_A_Adequacy`, `Axiom_E_Evidence`, `sorryAx` |
| `YM_No_Strong_Solution` | `. (file by file)` | open | `Axiom_A_Adequacy`, `Axiom_E_Evidence`, `sorryAx` |
| `StructuralInsufficiency.theorem_B` | `. (file by file)` | open | `sorryAx`, `StructuralInsufficiency.WeakSol` |
| `TUSC.TUSC_existence` | `. (file by file)` | open | `sorryAx`, `TUSC.BlockA`, `TUSC.BlockB`, `TUSC.BlockC`, `TUSC.BlockD`, `TUSC.F_AC`, `TUSC.F_AG`, `TUSC.F_AN`, `TUSC.F_CN`, `TUSC.F_GN` |
| `final_five_stability` | `. (file by file)` | conditional | `FinalState`, `ThermalTrigger` |
| `trigger_cascade` | `. (file by file)` | conditional | `FinalState`, `ThermalTrigger`, `thermal_trigger_activation` |
| `infinite_growth_convergence` | `. (file by file)` | open | `FinalState`, `ThermalTrigger`, `sorryAx` |
| `meta_unification` | `. (file by file)` | open | `FinalState`, `ThermalTrigger`, `barco_escola`, `solar_colonization`, `sorryAx` |
| `authority_loop_amplification` | `. (file by file)` | open | `sorryAx`, `truth_server`, `youtube_algorithm_recognition` |
| `MillenniumGroups.Group2.NavierStokes_Existence_Smoothness` | `. (file by file)` | open | `sorryAx` |
| `energy_inequality_rh` | `. (file by file)` | open | `sorryAx` |
| `oscillation_cancellation` | `. (file by file)` | open | `sorryAx`, `ζ` |
| `gaussian_tail_bound` | `. (file by file)` | open | `sorryAx` |
| `BSD.Bridge.bridge_theorem_bsd` | `formal/lean (file by file)` | open | `sorryAx` |
| `BSD.Bridge.weak_bsd_l_nonzero` | `formal/lean (file by file)` | open | `sorryAx` |
| `BSD.Bridge.kolyvagin_bsd` | `formal/lean (file by file)` | open | `sorryAx` |
| `BSD.Bridge.BSD.Bridge.height_bridge` | `formal/lean (file by file)` | open | `sorryAx`, `BSD.Classical.EllipticCurve`, `BSD.Classical.L`, `BSD.Classical.ord_s_1`, `BSD.Classical.rank`, `BSD.Classical.regulator` |
| `BSD.Bridge.BSD.Bridge.bsd_via_bridges` | `formal/lean (file by file)` | open | `sorryAx`, `BSD.Classical.EllipticCurve`, `BSD.Classical.L`, `BSD.Classical.ord_s_1`, `BSD.Classical.rank`, `BSD.Bridge.BSD.Bridge.is_modular` |
| `BSD.Classical.weak_bsd_gap` | `formal/lean (file by file)` | open | `sorryAx`, `BSD.Classical.EllipticCurve`, `BSD.Classical.L`, `BSD.Classical.ord_s_1`, `BSD.Classical.rank` |
| `Millennium.adequate_implies_unifying` | `formal/lean (file by file)` | conditional | `Millennium.Adequate` |
| `Millennium.local_to_global_adequacy` | `formal/lean (file by file)` | conditional | `Millennium.Adequate`, `Millennium.AdequateGlobal_iff`, `Millennium.AdequateP` |
| `PvsNP.Bridge.cook_levin` | `formal/lean (file by file)` | open | `sorryAx` |
| `PvsNP.Bridge.bridge_theorem_separation` | `formal/lean (file by file)` | open | `sorryAx` |
| `PvsNP.Bridge.relativization_barrier` | `formal/lean (file by file)` | open | `sorryAx` |
| `PvsNP.Bridge.P_subset_NP` | `formal/lean (file by file)` | open | `sorryAx` |
| `PvsNP.Bridge.time_hierarchy` | `formal/lean (file by file)` | open | `sorryAx` |
| `PvsNP.Bridge.NP_subset_PSPACE` | `formal/lean (file by file)` | open | `sorryAx` |
| `PvsNP.Bridge.PSPACE_subset_EXP` | `formal/lean (file by file)` | open | `sorryAx` |
| `PvsNP.Bridge.pvsnp_dichotomy` | `formal/lean (file by file)` | open | `sorryAx` |
| `PvsNP.Bridge.natural_proof_bridge` | `formal/lean (file by file)` | open | `sorryAx`, `PvsNP.Bridge.is_natural_proof`, `PvsNP.Classical.NondeterministicTM`, `PvsNP.Classical.TuringMachine`, `PvsNP.Classical.accepts`, `PvsNP.Classical.ntime_complexity`, `PvsNP.Classical.time_complexity` |
| `PvsNP.Bridge.non_relativizing_bridge` | `formal/lean (file by file)` | open | `sorryAx`, `PvsNP.Bridge.NP_relative`, `PvsNP.Bridge.Oracle`, `PvsNP.Bridge.P_relative`, `PvsNP.Classical.NondeterministicTM`, `PvsNP.Classical.TuringMachine`, `PvsNP.Classical.accepts`, `PvsNP.Classical.ntime_complexity`, `PvsNP.Classical.time_complexity` |
| `PvsNP.Bridge.tuns_bridge` | `formal/lean (file by file)` | open | `sorryAx`, `PvsNP.Bridge.UniversalSpectrum`, `PvsNP.Bridge.complexity_spectrum`, `PvsNP.Classical.NondeterministicTM`, `PvsNP.Classical.TuringMachine`, `PvsNP.Classical.accepts`, `PvsNP.Classical.ntime_complexity`, `PvsNP.Classical.time_complexity` |
| `PvsNP.Bridge.arithmetic_bridge` | `formal/lean (file by file)` | open | `sorryAx`, `PvsNP.Classical.NondeterministicTM`, `PvsNP.Classical.ntime_complexity` |
| `RH.Bridge.rh_implies_prime_bound` | `formal/lean (file by file)` | open | `sorryAx` |
| `RH.Bridge.rh_iff_li_criterion` | `formal/lean (file by file)` | open | `sorryAx` |
| `RH.Bridge.RH.Bridge.rh_bridge_existence` | `formal/lean (file by file)` | open | `sorryAx`, `RH.Classical.ζ` |
| `Millennium.RH.bridge_rh` | `formal/lean (file by file)` | open | `sorryAx` |
| `Millennium.RH.classical_rh_from_bridge` | `formal/lean (file by file)` | open | `sorryAx` |
| `DeltaCollapse.extended_completeness` | `formal/theorems (file by file)` | conditional | `DeltaCollapse.Delta`, `DeltaCollapse.I`, `DeltaCollapse.extended_solutions` |
| `DeltaCollapse.main_delta_collapse_theorem` | `formal/theorems (file by file)` | conditional | `DeltaCollapse.Delta`, `DeltaCollapse.I`, `DeltaCollapse.extended_solutions` |
| `DeltaCollapse.strict_extension` | `formal/theorems (file by file)` | conditional | `DeltaCollapse.Delta`, `DeltaCollapse.I`, `DeltaCollapse.extended_solutions` |
| `NavierStokes.lyapunov_decreases` | `lean (file by file)` | open | `sorryAx` |
| `NavierStokes.energy_decay_exponential` | `lean (file by file)` | open | `sorryAx` |
| `NavierStokes.converges_to_critical_point` | `lean (file by file)` | open | `sorryAx` |
| `NavierStokes.rh_coupling_ensures_stability` | `lean (file by file)` | open | `sorryAx` |
| `NavierStokes.rh_violation_allows_singularities` | `lean (file by file)` | open | `sorryAx` |
| `vertical_transfer` | `lean (file by file)` | conditional | `Phi`, `balance_zero`, `delta_NP` |
| `horizontal_transfer` | `lean (file by file)` | conditional | `Phi`, `balance_zero`, `delta_NP` |
| `all_in_variety` | `lean (file by file)` | conditional | `Phi`, `balance_zero`, `delta_NP` |
| `image_in_fiber` | `lean (file by file)` | conditional | `Phi`, `balance_zero`, `delta_NP` |
| `RH_implies_all_poly` | `lean (file by file)` | conditional | `Phi`, `balance_zero`, `delta_NP` |
| `balance_well_defined` | `lean (file by file)` | conditional | `Phi`, `delta_NP` |
| `RiemannHypothesis.zero_contribution_magnitude` | `lean (file by file)` | open | `sorryAx` |
| `RiemannHypothesis.off_line_contribution_dominates` | `lean (file by file)` | open | `sorryAx` |
| `RiemannHypothesis.primes_dont_let` | `lean (file by file)` | open | `sorryAx` |
| `RiemannHypothesis.definitional_results_invariant` | `lean (file by file)` | open | `sorryAx`, `RiemannHypothesis.Ax_B` |
| `RiemannHypothesis.t2_has_rh` | `lean (file by file)` | conditional | `RiemannHypothesis.Ax_B` |
| `RiemannHypothesis.t2_has_p_neq_np` | `lean (file by file)` | conditional | `RiemannHypothesis.Ax_B` |
| `RiemannHypothesis.t9_minimal` | `lean (file by file)` | conditional | `RiemannHypothesis.Ax_B` |
| `YangMills.mass_gap_from_spectral` | `lean (file by file)` | open | `sorryAx` |
| `YangMills.mass_gap_equals_golden_ratio` | `lean (file by file)` | open | `sorryAx` |
| `ClassicalExpandedFramework.no_StrongSol_Classical` | `lean4 (file by file)` | open | `sorryAx` |
| `ClassicalExpandedFramework.LogicalSpace_equal` | `lean4 (file by file)` | conditional | `ClassicalExpandedFramework.conservative_extension` |
| `ClassicalExpandedFramework.structural_gap_theorem` | `lean4 (file by file)` | open | `sorryAx` |
| `Classical_System_Insufficient` | `lean4 (file by file)` | open | `Axiom_A_Adequacy`, `Axiom_E_Evidence`, `sorryAx` |
| `Zero_Obstruction_Necessary` | `lean4 (file by file)` | conditional | `Axiom_A_Adequacy` |
| `RH_No_Strong_Solution` | `lean4 (file by file)` | open | `Axiom_A_Adequacy`, `Axiom_E_Evidence`, `sorryAx` |
| `PvsNP_No_Strong_Solution` | `lean4 (file by file)` | open | `Axiom_A_Adequacy`, `Axiom_E_Evidence`, `sorryAx` |
| `NS_No_Strong_Solution` | `lean4 (file by file)` | open | `Axiom_A_Adequacy`, `Axiom_E_Evidence`, `sorryAx` |
| `BSD_No_Strong_Solution` | `lean4 (file by file)` | open | `Axiom_A_Adequacy`, `Axiom_E_Evidence`, `sorryAx` |
| `Hodge_No_Strong_Solution` | `lean4 (file by file)` | open | `Axiom_A_Adequacy`, `Axiom_E_Evidence`, `sorryAx` |
| `YM_No_Strong_Solution` | `lean4 (file by file)` | open | `Axiom_A_Adequacy`, `Axiom_E_Evidence`, `sorryAx` |
| `ClassicalObstruction.P_card` | `lean4 (file by file)` | conditional | `Lean.ofReduceBool` |
| `ClassicalObstruction.no_strong_solution_in_classical` | `lean4 (file by file)` | open | `sorryAx`, `ClassicalObstruction.E1_unification_bound`, `ClassicalObstruction.E2_bridge_bound`, `ClassicalObstruction.E3_singularity_bound`, `ClassicalObstruction.E4_expressivity_bound`, `ClassicalObstruction.Law_7_1`, `ClassicalObstruction.S_cl`, `ClassicalObstruction.StrongSolution_p`, `ClassicalObstruction.op_B`, `ClassicalObstruction.op_Exp`, `ClassicalObstruction.op_Sing_unif`, `ClassicalObstruction.op_U` |
| `ClassicalObstruction.no_strong_solution_RH` | `lean4 (file by file)` | open | `sorryAx`, `ClassicalObstruction.E1_unification_bound`, `ClassicalObstruction.E2_bridge_bound`, `ClassicalObstruction.E3_singularity_bound`, `ClassicalObstruction.E4_expressivity_bound`, `ClassicalObstruction.Law_7_1`, `ClassicalObstruction.S_cl`, `ClassicalObstruction.StrongSolution_p`, `ClassicalObstruction.op_B`, `ClassicalObstruction.op_Exp`, `ClassicalObstruction.op_Sing_unif`, `ClassicalObstruction.op_U` |
| `ClassicalObstruction.no_strong_solution_BSD` | `lean4 (file by file)` | open | `sorryAx`, `ClassicalObstruction.E1_unification_bound`, `ClassicalObstruction.E2_bridge_bound`, `ClassicalObstruction.E3_singularity_bound`, `ClassicalObstruction.E4_expressivity_bound`, `ClassicalObstruction.Law_7_1`, `ClassicalObstruction.S_cl`, `ClassicalObstruction.StrongSolution_p`, `ClassicalObstruction.op_B`, `ClassicalObstruction.op_Exp`, `ClassicalObstruction.op_Sing_unif`, `ClassicalObstruction.op_U` |
| `ClassicalObstruction.no_strong_solution_Hodge` | `lean4 (file by file)` | open | `sorryAx`, `ClassicalObstruction.E1_unification_bound`, `ClassicalObstruction.E2_bridge_bound`, `ClassicalObstruction.E3_singularity_bound`, `ClassicalObstruction.E4_expressivity_bound`, `ClassicalObstruction.Law_7_1`, `ClassicalObstruction.S_cl`, `ClassicalObstruction.StrongSolution_p`, `ClassicalObstruction.op_B`, `ClassicalObstruction.op_Exp`, `ClassicalObstruction.op_Sing_unif`, `ClassicalObstruction.op_U` |
| `ClassicalObstruction.no_strong_solution_NS` | `lean4 (file by file)` | open | `sorryAx`, `ClassicalObstruction.E1_unification_bound`, `ClassicalObstruction.E2_bridge_bound`, `ClassicalObstruction.E3_singularity_bound`, `ClassicalObstruction.E4_expressivity_bound`, `ClassicalObstruction.Law_7_1`, `ClassicalObstruction.S_cl`, `ClassicalObstruction.StrongSolution_p`, `ClassicalObstruction.op_B`, `ClassicalObstruction.op_Exp`, `ClassicalObstruction.op_Sing_unif`, `ClassicalObstruction.op_U` |
| `ClassicalObstruction.no_strong_solution_YM` | `lean4 (file by file)` | open | `sorryAx`, `ClassicalObstruction.E1_unification_bound`, `ClassicalObstruction.E2_bridge_bound`, `ClassicalObstruction.E3_singularity_bound`, `ClassicalObstruction.E4_expressivity_bound`, `ClassicalObstruction.Law_7_1`, `ClassicalObstruction.S_cl`, `ClassicalObstruction.StrongSolution_p`, `ClassicalObstruction.op_B`, `ClassicalObstruction.op_Exp`, `ClassicalObstruction.op_Sing_unif`, `ClassicalObstruction.op_U` |
| `ClassicalObstruction.no_strong_solution_PvsNP` | `lean4 (file by file)` | open | `sorryAx`, `ClassicalObstruction.E1_unification_bound`, `ClassicalObstruction.E2_bridge_bound`, `ClassicalObstruction.E3_singularity_bound`, `ClassicalObstruction.E4_expressivity_bound`, `ClassicalObstruction.Law_7_1`, `ClassicalObstruction.S_cl`, `ClassicalObstruction.StrongSolution_p`, `ClassicalObstruction.op_B`, `ClassicalObstruction.op_Exp`, `ClassicalObstruction.op_Sing_unif`, `ClassicalObstruction.op_U` |
| `ClassicalObstruction.no_strong_solution_Poincare` | `lean4 (file by file)` | open | `sorryAx`, `ClassicalObstruction.E1_unification_bound`, `ClassicalObstruction.E2_bridge_bound`, `ClassicalObstruction.E3_singularity_bound`, `ClassicalObstruction.E4_expressivity_bound`, `ClassicalObstruction.Law_7_1`, `ClassicalObstruction.S_cl`, `ClassicalObstruction.StrongSolution_p`, `ClassicalObstruction.op_B`, `ClassicalObstruction.op_Exp`, `ClassicalObstruction.op_Sing_unif`, `ClassicalObstruction.op_U` |
| `DeltaGap44.severe_obstruction_threshold` | `lean4 (file by file)` | open | `sorryAx` |
| `DeltaGap44.no_strong_solution_classical` | `lean4 (file by file)` | open | `sorryAx` |
| `DeltaGap44.structural_impossibility` | `lean4 (file by file)` | open | `sorryAx` |
| … 117 more in `VERIFICACAO.json` and `TEOREMAS.csv` | | | |

### Declared theorems

The `.lean` files of the verified commit declare 687 `theorem`/`lemma` (counting copies). The kernel checked 409 of them (168 closed, 57 conditional, 184 open). The closed count in the table above is larger: it also counts the theorems Lean generates by itself (equation lemmas, structure fields, `deriving`), which are not written in the text. For 278 the kernel has no result:

| Reason | Theorems |
|---|---:|
| checked file by file: Lean did not reach the theorem (missing import, syntax error or timeout) | 158 |
| checked file by file: the written proof does not pass the kernel | 110 |
| the file did not compile (an error in it or in a file it imports) | 5 |
| the file compiled, but the name did not appear in the kernel (private, mutual or macro-generated) | 5 |

### MVEI corrections

* `correcoes/imports-no-topo.patch` (import fora do início do arquivo, 20 file(s)): made for the verified commit; it does not apply to the published commit as is
* `correcoes/renomear-imports-mathlib.patch` (import de módulo que não existe na versão do Mathlib do projeto (renomeado ou dividido), 23 file(s)): made for the verified commit; it does not apply to the published commit as is
* `correcoes/tatica-encontrada.patch` (prova que não passava (ou axioma) que uma tática padrão fecha no kernel, 11 file(s)): made for the verified commit; it does not apply to the published commit as is
* `correcoes/vocabulario-lean4.patch` (grafia que o Lean 4 não lê (nome acentuado, λ/Σ/Π como nome, ∀ x y ∈ s, docstring solta, constant, tática do Mathlib sem import), 222 file(s)): made for the verified commit; it does not apply to the published commit as is
* `correcoes/z-provas-reparadas.patch` (prova que não passava no kernel (o enunciado fica igual), 27 file(s)): made for the verified commit; it does not apply to the published commit as is
* `correcoes/zz-refutacoes.patch` (teorema com enunciado falso como o Lean o lê (o original fica como está), 2 file(s)): applies to the published sources: `git apply -p1 --directory=imports/Millennium mvei/Millennium/correcoes/zz-refutacoes.patch` (in order, after the ones above)

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
