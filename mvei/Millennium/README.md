# MVEI kernel check — Millennium

This folder records what the Lean 4 kernel said about the Lean sources of the private repository `ShantiDraconis/Millennium`. The sources are published in [`imports/Millennium/`](../../imports/Millennium/).

## What is published

* Source: `ShantiDraconis/Millennium`, commit `5c5ec3d9597f5ffd00210793a63b1ebdeff08baa` (2026-10-21T23:18:45Z).
* 285 files: 275 `.lean` files and the Lake files (`lakefile.*`, `lean-toolchain`, `lake-manifest.json`), plus 3 license or origin file(s) that third-party code requires (`LICENSE`, `rh-ns-cascade/LICENSE`, `rh-umi-invariant/LICENSE`). Paths are the same as in the source repository.
* Nothing else from the private repository is published (documents, commercial license, prompts, storefront material).
* `SOURCES.sha256` lists every published file with its SHA-256. From the repository root: `sha256sum -c mvei/Millennium/SOURCES.sha256`.

## What the kernel said

MVEI verification of 2026-10-29T01:06:09+00:00, on commit `5c5ec3d9597f5ffd00210793a63b1ebdeff08baa`. Each theorem was read with `Lean.collectAxioms`, the function behind `#print axioms`.

| Lean project | Lean version | Build | Closed | Conditional | Open (`sorry`) | Checked file by file: closed / conditional / open / proof error / not reached |
|---|---|---|---:|---:|---:|---|
| `.` (no lakefile; project assembled by MVEI) | v4.19.0 | partial | 94 | 0 | 8 | 17 / 5 / 16 / 25 / 10 |
| `formal/lean` | v4.19.0 | partial | 54 | 12 | 2 | 0 / 0 / 3 / 9 / 64 |
| `formal/theorems` | v4.12.0 | failed | 0 | 0 | 0 | 0 / 0 / 0 / 0 / 7 |
| `lean` | padrão do elan | failed | 0 | 0 | 0 | 6 / 3 / 10 / 19 / 14 |
| `lean4` | v4.19.0 | partial | 145 | 0 | 10 | 34 / 10 / 66 / 91 / 138 |
| `rh-umi-invariant/formal/lean` | v4.12.0 | failed | 0 | 0 | 0 | 0 / 0 / 0 / 0 / 1 |
| `src/lean` | v4.19.0 | partial | 13 | 0 | 1 | 5 / 3 / 0 / 7 / 21 |
| `src/lean4` | v4.19.0 | partial | 3 | 0 | 0 | 3 / 0 / 4 / 3 / 33 |
| `universe00` | padrão do elan | failed | 0 | 0 | 0 | 0 / 0 / 2 / 1 / 24 |

| Closed theorems in this repository | |
|---|---:|
| Counting each project | 374 |
| Unique (name + statement) | 373 |
| Unique, without the lemmas Lean generates itself (`eq_1`, `mk.inj`, `sizeOf_spec`, `deriving`) | 125 |

*Closed* means the kernel accepted the proof and it depends only on `propext`, `Classical.choice` and `Quot.sound`. It says that the statement as written in the file is proved; it does not say that an open problem is solved. Every statement is in `VERIFICACAO.json`. *Conditional* means the proof also uses axioms declared in the repository; *open* means it uses `sorry`. *Checked file by file* covers the files that no build reached: each one went through Lean whole, with a `#print axioms` for each theorem.

| Theorem | Project | State | Axioms beyond the standard three |
|---|---|---|---|
| `ComplexityCurvature.rh_implies_phi_image_gaps` | `.` | open | `sorryAx`, `ComplexityCurvature.Φ`, `ComplexityCurvature.f`, `ComplexityCurvature.gap_control`, `ComplexityCurvature.f_zero` |
| `MillenniumGroups.Group1.BSD_Conjecture_Analytic` | `.` | open | `sorryAx` |
| `MillenniumGroups.Group1.Riemann_Hypothesis` | `.` | open | `sorryAx` |
| `MillenniumGroups.Group1.Spectral_LFunction_Theorem` | `.` | open | `sorryAx` |
| `MillenniumGroups.Group3.GCT_implies_P_ne_NP` | `.` | open | `sorryAx` |
| `MillenniumGroups.Group3.P_not_EQ_NP` | `.` | open | `sorryAx` |
| `MillenniumGroups.Group3.P_not_EQ_NP_from_Orbit_Separation` | `.` | open | `sorryAx` |
| `SpectralLink.zero_deviation_implies_both` | `.` | open | `sorryAx` |
| `LGMathOS.Hodge.AlgebraicCycle.mk.inj` | `formal/lean` | conditional | `LGMathOS.Hodge.ProjectiveVariety` |
| `LGMathOS.Hodge.AlgebraicCycle.mk.injEq` | `formal/lean` | conditional | `LGMathOS.Hodge.ProjectiveVariety` |
| `LGMathOS.Hodge.AlgebraicCycle.mk.sizeOf_spec` | `formal/lean` | conditional | `LGMathOS.Hodge.ProjectiveVariety` |
| `LGMathOS.Hodge.HodgeClass.mk.inj` | `formal/lean` | conditional | `LGMathOS.Hodge.ProjectiveVariety` |
| `LGMathOS.Hodge.HodgeClass.mk.injEq` | `formal/lean` | conditional | `LGMathOS.Hodge.ProjectiveVariety` |
| `LGMathOS.Hodge.HodgeClass.mk.sizeOf_spec` | `formal/lean` | conditional | `LGMathOS.Hodge.ProjectiveVariety` |
| `LGMathOS.Poincare.poincare_conjecture` | `formal/lean` | open | `LGMathOS.Poincare.Manifold3`, `LGMathOS.Poincare.simply_connected`, `LGMathOS.Poincare.is_closed`, `LGMathOS.Poincare.homeomorphic`, `LGMathOS.Poincare.S3`, `sorryAx` |
| `Millennium.NavierStokes.LocalEnergyBound.decay` | `formal/lean` | conditional | `Millennium.NavierStokes.SobolevH1` |
| `Millennium.NavierStokes.LocalEnergyBound.initial` | `formal/lean` | conditional | `Millennium.NavierStokes.SobolevH1` |
| `Millennium.NavierStokes.LocalEnergyBound.nonneg` | `formal/lean` | conditional | `Millennium.NavierStokes.SobolevH1` |
| `Millennium.NavierStokes.PressureRegularity.gradient_bound` | `formal/lean` | conditional | `Millennium.NavierStokes.SobolevH1` |
| `Millennium.NavierStokes.VorticityControl.locally_bounded` | `formal/lean` | conditional | `Millennium.NavierStokes.SobolevH1` |
| `Millennium.NavierStokes.VorticityControl.no_concentration` | `formal/lean` | conditional | `Millennium.NavierStokes.SobolevH1` |
| `Millennium.NavierStokes.bridge_navier_stokes` | `formal/lean` | open | `Millennium.NavierStokes.SobolevH1`, `sorryAx` |
| `GapUniversal.gap_implies_undeterminable` | `lean4` | open | `sorryAx` |
| `GlobalMillenniumTheorem.global_millennium_group_theorem` | `lean4` | open | `sorryAx` |
| `GlobalMillenniumTheorem.group1_implies_BSD` | `lean4` | open | `sorryAx` |
| `GlobalMillenniumTheorem.group1_implies_RH` | `lean4` | open | `sorryAx` |
| `GlobalMillenniumTheorem.group2_implies_Hodge` | `lean4` | open | `sorryAx` |
| `GlobalMillenniumTheorem.group2_implies_NS` | `lean4` | open | `sorryAx` |
| `GlobalMillenniumTheorem.group2_implies_Poincare` | `lean4` | open | `sorryAx` |
| `GlobalMillenniumTheorem.group2_implies_YM` | `lean4` | open | `sorryAx` |
| `GlobalMillenniumTheorem.group3_implies_PNeqNP` | `lean4` | open | `sorryAx` |
| `RH_NP.deltaSpectrum_under_RH` | `lean4` | open | `sorryAx` |
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
| `DeltaGapFramework.T1_conditional_equivalence` | `. (file by file)` | conditional | `DeltaGapFramework.C_det`, `DeltaGapFramework.C_ndet`, `DeltaGapFramework.NPLanguage`, `DeltaGapFramework.Phi`, `DeltaGapFramework.ZetaZeros`, `DeltaGapFramework.f`, `DeltaGapFramework.f_zero` |
| `StructuralInsufficiency.theorem_B` | `. (file by file)` | open | `sorryAx`, `StructuralInsufficiency.WeakSol` |
| `TUSC.TUSC_existence` | `. (file by file)` | open | `sorryAx`, `TUSC.BlockA`, `TUSC.BlockB`, `TUSC.BlockC`, `TUSC.BlockD`, `TUSC.F_AC`, `TUSC.F_AG`, `TUSC.F_AN`, `TUSC.F_CN`, `TUSC.F_GN` |
| `meta_unification` | `. (file by file)` | open | `FinalState`, `ThermalTrigger`, `barco_escola`, `solar_colonization`, `sorryAx` |
| `authority_loop_amplification` | `. (file by file)` | open | `sorryAx`, `truth_server`, `youtube_algorithm_recognition` |
| `MillenniumGroups.Group2.NavierStokes_Existence_Smoothness` | `. (file by file)` | open | `sorryAx` |
| `energy_inequality_rh` | `. (file by file)` | open | `sorryAx` |
| `gaussian_tail_bound` | `. (file by file)` | open | `sorryAx` |
| `BSD.Classical.weak_bsd_gap` | `formal/lean (file by file)` | open | `sorryAx`, `BSD.Classical.EllipticCurve`, `BSD.Classical.L`, `BSD.Classical.ord_s_1`, `BSD.Classical.rank` |
| `Millennium.RH.bridge_rh` | `formal/lean (file by file)` | open | `sorryAx` |
| `Millennium.RH.classical_rh_from_bridge` | `formal/lean (file by file)` | open | `sorryAx` |
| `DeltaGap44.Theorem1` | `lean (file by file)` | conditional | `DeltaGap44.C_det`, `DeltaGap44.C_ndet`, `DeltaGap44.Phi` |
| `DeltaGap44.Theorem2` | `lean (file by file)` | conditional | `DeltaGap44.C_det`, `DeltaGap44.C_ndet`, `DeltaGap44.Phi` |
| `NavierStokes.lyapunov_decreases` | `lean (file by file)` | open | `sorryAx` |
| `NavierStokes.converges_to_critical_point` | `lean (file by file)` | open | `sorryAx` |
| `NavierStokes.rh_coupling_ensures_stability` | `lean (file by file)` | open | `sorryAx` |
| `NavierStokes.rh_violation_allows_singularities` | `lean (file by file)` | open | `sorryAx` |
| `RH_implies_all_poly` | `lean (file by file)` | open | `Phi`, `balance_zero`, `delta_NP`, `sorryAx` |
| `balance_well_defined` | `lean (file by file)` | conditional | `Phi`, `delta_NP` |
| `RiemannHypothesis.zero_contribution_magnitude` | `lean (file by file)` | open | `sorryAx` |
| `RiemannHypothesis.off_line_contribution_dominates` | `lean (file by file)` | open | `sorryAx` |
| `RiemannHypothesis.primes_dont_let` | `lean (file by file)` | open | `sorryAx` |
| `RiemannHypothesis.definitional_results_invariant` | `lean (file by file)` | open | `sorryAx`, `RiemannHypothesis.Ax_B` |
| `RiemannHypothesis.p_eq_np_implies_f_np_bounded` | `lean (file by file)` | open | `sorryAx` |
| `ClassicalExpandedFramework.WeakSol_implies_StrongSol_Expanded` | `lean4 (file by file)` | open | `sorryAx` |
| `ClassicalExpandedFramework.WeakSol_iff_StrongSol_Expanded` | `lean4 (file by file)` | open | `sorryAx` |
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
| `ClassicalObstruction.no_strong_solution_in_classical` | `lean4 (file by file)` | open | `sorryAx`, `ClassicalObstruction.Law_7_1`, `ClassicalObstruction.S_cl`, `ClassicalObstruction.StrongSolution_p`, `ClassicalObstruction.op_B`, `ClassicalObstruction.op_Exp`, `ClassicalObstruction.op_Sing_unif`, `ClassicalObstruction.op_U` |
| `ClassicalObstruction.no_strong_solution_RH` | `lean4 (file by file)` | open | `sorryAx`, `ClassicalObstruction.Law_7_1`, `ClassicalObstruction.S_cl`, `ClassicalObstruction.StrongSolution_p`, `ClassicalObstruction.op_B`, `ClassicalObstruction.op_Exp`, `ClassicalObstruction.op_Sing_unif`, `ClassicalObstruction.op_U` |
| `ClassicalObstruction.no_strong_solution_BSD` | `lean4 (file by file)` | open | `sorryAx`, `ClassicalObstruction.Law_7_1`, `ClassicalObstruction.S_cl`, `ClassicalObstruction.StrongSolution_p`, `ClassicalObstruction.op_B`, `ClassicalObstruction.op_Exp`, `ClassicalObstruction.op_Sing_unif`, `ClassicalObstruction.op_U` |
| `ClassicalObstruction.no_strong_solution_Hodge` | `lean4 (file by file)` | open | `sorryAx`, `ClassicalObstruction.Law_7_1`, `ClassicalObstruction.S_cl`, `ClassicalObstruction.StrongSolution_p`, `ClassicalObstruction.op_B`, `ClassicalObstruction.op_Exp`, `ClassicalObstruction.op_Sing_unif`, `ClassicalObstruction.op_U` |
| `ClassicalObstruction.no_strong_solution_NS` | `lean4 (file by file)` | open | `sorryAx`, `ClassicalObstruction.Law_7_1`, `ClassicalObstruction.S_cl`, `ClassicalObstruction.StrongSolution_p`, `ClassicalObstruction.op_B`, `ClassicalObstruction.op_Exp`, `ClassicalObstruction.op_Sing_unif`, `ClassicalObstruction.op_U` |
| `ClassicalObstruction.no_strong_solution_YM` | `lean4 (file by file)` | open | `sorryAx`, `ClassicalObstruction.Law_7_1`, `ClassicalObstruction.S_cl`, `ClassicalObstruction.StrongSolution_p`, `ClassicalObstruction.op_B`, `ClassicalObstruction.op_Exp`, `ClassicalObstruction.op_Sing_unif`, `ClassicalObstruction.op_U` |
| `ClassicalObstruction.no_strong_solution_PvsNP` | `lean4 (file by file)` | open | `sorryAx`, `ClassicalObstruction.Law_7_1`, `ClassicalObstruction.S_cl`, `ClassicalObstruction.StrongSolution_p`, `ClassicalObstruction.op_B`, `ClassicalObstruction.op_Exp`, `ClassicalObstruction.op_Sing_unif`, `ClassicalObstruction.op_U` |
| `ClassicalObstruction.no_strong_solution_Poincare` | `lean4 (file by file)` | open | `sorryAx`, `ClassicalObstruction.Law_7_1`, `ClassicalObstruction.S_cl`, `ClassicalObstruction.StrongSolution_p`, `ClassicalObstruction.op_B`, `ClassicalObstruction.op_Exp`, `ClassicalObstruction.op_Sing_unif`, `ClassicalObstruction.op_U` |
| `MillenniumFramework.BSD_bridge_characterization` | `lean4 (file by file)` | open | `sorryAx` |
| `GridEquation.productAnchor_vanishes_at_anchor` | `lean4 (file by file)` | open | `sorryAx` |
| `GridEquation.gridPotential_nonneg` | `lean4 (file by file)` | open | `sorryAx` |
| `total_energy_minimum` | `lean4 (file by file)` | open | `sorryAx` |
| `torsion_tension_equivalence` | `lean4 (file by file)` | open | `grid_induces_metric`, `grid_potential_minimum`, `phase_oscillator_isomorphism`, `riemannZeta`, `sorryAx` |
| `hadamard_anchoring` | `lean4 (file by file)` | open | `riemannZeta`, `sorryAx` |
| `rh_from_grid_hypothesis` | `lean4 (file by file)` | open | `grid_induces_metric`, `grid_potential_minimum`, `phase_oscillator_isomorphism`, `riemannZeta`, `sorryAx` |
| `MillenniumGroups.Group1.Spectral_LFunction_Theorem` | `lean4 (file by file)` | open | `sorryAx`, `MillenniumGroups.Group1.algebraicRank`, `MillenniumGroups.Group1.orderOfZero` |
| `MillenniumGroups.Group1.Riemann_Hypothesis` | `lean4 (file by file)` | open | `sorryAx`, `MillenniumGroups.Group1.RiemannZeta`, `MillenniumGroups.Group1.algebraicRank`, `MillenniumGroups.Group1.orderOfZero` |
| `MillenniumGroups.Group2.Global_Regularity_of_Geometric_Flows` | `lean4 (file by file)` | open | `sorryAx`, `MillenniumGroups.Group2.SmoothManifold`, `MillenniumGroups.Group2.Tensor` |
| `MillenniumGroups.Group2.NavierStokes_Existence_Smoothness` | `lean4 (file by file)` | open | `sorryAx`, `MillenniumGroups.Group2.NSFlow`, `MillenniumGroups.Group2.SmoothManifold`, `MillenniumGroups.Group2.Tensor` |
| `MillenniumGroups.Group3.P_eq_NP_iff_gap_zero` | `lean4 (file by file)` | open | `sorryAx`, `MillenniumGroups.Group3.C_det`, `MillenniumGroups.Group3.C_ndet` |
| `MillenniumGroups.Group3.P_ne_NP_iff_gap_positive` | `lean4 (file by file)` | open | `sorryAx`, `MillenniumGroups.Group3.C_det`, `MillenniumGroups.Group3.C_ndet` |
| `HLG.MetaTheorem_Unified` | `lean4 (file by file)` | conditional | `HLG.MillenniumConjecture`, `HLG.MillenniumFramework`, `HLG.millennium_bridge_equiv` |
| `LocalGlobal.MetaTheorem.at_least_one_solved` | `lean4 (file by file)` | conditional | `LocalGlobal.MetaTheorem.poincare_solved` |
| `MMEU.MMEU.emergence_theorem` | `lean4 (file by file)` | open | `sorryAx` |
| `MMEU.new_structures_emerge` | `lean4 (file by file)` | open | `sorryAx` |
| `NavierStokes.pi_not_injective` | `lean4 (file by file)` | open | `sorryAx` |
| `NavierStokes.clay_problem_precise` | `lean4 (file by file)` | open | `sorryAx` |
| `NavierStokes.LRE.ns_compression_barrier` | `lean4 (file by file)` | open | `sorryAx`, `NavierStokes.LRE.LerayHopfSolution`, `NavierStokes.LRE.R_critical`, `NavierStokes.LRE.dissipation`, `NavierStokes.LRE.energy`, `NavierStokes.LRE.ns_residual_variation` |
| `NavierStokes.energy_projection_not_injective` | `lean4 (file by file)` | open | `sorryAx` |
| `NavierStokes.fiber_diameter_unbounded` | `lean4 (file by file)` | open | `sorryAx` |
| `RiemannHypothesis.displacement_vanishes` | `lean4 (file by file)` | open | `sorryAx` |
| `RiemannHypothesis.real_part_half` | `lean4 (file by file)` | open | `sorryAx` |
| `RHSpectral.primeSpectralControl` | `lean4 (file by file)` | open | `sorryAx` |
| `RHSpectral.rh_iff_maxGapZero` | `lean4 (file by file)` | open | `sorryAx` |
| `RiemannHypothesis.zero_off_line_contradicts_prime_bound` | `lean4 (file by file)` | open | `sorryAx` |
| `RiemannHypothesis.primes_zeros_equivalence` | `lean4 (file by file)` | open | `sorryAx` |
| `RiemannHypothesis.primes_block_zeros` | `lean4 (file by file)` | open | `sorryAx` |
| `RiemannHypothesis.critical_line_is_stable` | `lean4 (file by file)` | open | `sorryAx` |
| `StructuralCheckmate.StructuralCheckmate` | `lean4 (file by file)` | conditional | `StructuralCheckmate.AdequacyImpliesUnification`, `StructuralCheckmate.NoUnifyingStructureInClassical` |
| `StructuralCheckmate.ForcedBifurcation` | `lean4 (file by file)` | conditional | `StructuralCheckmate.AdequacyImpliesUnification`, `StructuralCheckmate.NoUnifyingStructureInClassical` |
| `StructuralCheckmate.Checkmate` | `lean4 (file by file)` | open | `sorryAx`, `StructuralCheckmate.AdequacyImpliesUnif`, `StructuralCheckmate.NoUnifClassical` |
| `StructuralCheckmate.strategic_checkmate` | `lean4 (file by file)` | open | `sorryAx`, `StructuralCheckmate.AdequacyImpliesUnif`, `StructuralCheckmate.NoUnifClassical` |
| `masterTheorem` | `lean4 (file by file)` | conditional | `lawA1` |
| `allLawsHold` | `lean4 (file by file)` | conditional | `lawA1`, `lawC1`, `lawL1_unified`, `lawS1` |
| `StructuralObstruction.NoStrongSolutionForAnyProblem` | `lean4 (file by file)` | open | `sorryAx`, `StructuralObstruction.AxiomA`, `StructuralObstruction.AxiomE`, `StructuralObstruction.ClassicalSystem`, `StructuralObstruction.bridgeDegree`, `StructuralObstruction.expressiveness`, `StructuralObstruction.singularityDegree`, `StructuralObstruction.unificationDegree` |
| `Clay.no_strong_sol_in_S_cl` | `lean4 (file by file)` | open | `sorryAx`, `Clay.E_cl`, `Clay.axiom_A` |
| `UnifiedFieldTheory.millennium_unification` | `lean4 (file by file)` | open | `sorryAx` |
| `UnifiedFieldTheory.connectivity_blocks_exist` | `lean4 (file by file)` | open | `sorryAx` |
| `UnifiedFieldTheory.universal_energy_finite` | `lean4 (file by file)` | open | `sorryAx` |
| `UnifiedFieldTheory.main_unification_theorem` | `lean4 (file by file)` | open | `sorryAx` |
| `UnifiedSystem.obstruction_unified_zero` | `lean4 (file by file)` | open | `sorryAx` |
| `UnifiedSystem.unified_obstruction_vanishes` | `lean4 (file by file)` | open | `sorryAx`, `UnifiedSystem.obstruction_expanded_zero` |
| `UnifiedSystem.weak_strong_equivalence` | `lean4 (file by file)` | open | `sorryAx` |
| `UnifiedSystem.classical_proper_subset` | `lean4 (file by file)` | open | `sorryAx` |
| `UnifiedSystem.expanded_proper_subset` | `lean4 (file by file)` | open | `sorryAx` |
| `UnifiedSystem.classical_expanded_distinct` | `lean4 (file by file)` | open | `sorryAx` |
| `UnifiedSystem.millennium_unified` | `lean4 (file by file)` | open | `sorryAx` |
| `UnifiedSystem.UnifiedSystem.unified_zero_obstruction` | `lean4 (file by file)` | conditional | `UnifiedSystem.UnifiedSystem.obstruction_nonneg` |
| `UnifiedSystem.UnifiedSystem.unified_weak_strong_equiv` | `lean4 (file by file)` | open | `sorryAx`, `UnifiedSystem.UnifiedSystem.obstruction_nonneg`, `UnifiedSystem.UnifiedSystem.zero_obstruction_promotes` |
| `UnifiedSystem.UnifiedSystem.unified_conservative` | `lean4 (file by file)` | open | `sorryAx` |
| `UnifiedSystem.UnifiedSystem.problems_unified_theory` | `lean4 (file by file)` | open | `sorryAx`, `UnifiedSystem.UnifiedSystem.obstruction_nonneg`, `UnifiedSystem.UnifiedSystem.zero_obstruction_promotes` |
| `UnifiedTheory.canonical_is_minimum` | `lean4 (file by file)` | open | `sorryAx` |
| `UniversalCriticalFunctional.finiteness_criterion_alpha_positive` | `lean4 (file by file)` | open | `sorryAx` |
| `Millennium.Logical.StructuralCheckmate.Checkmate` | `src/lean (file by file)` | conditional | `Millennium.Logical.StructuralCheckmate.AdequacyImpliesUnif`, `Millennium.Logical.StructuralCheckmate.NoUnifClassical` |
| `Millennium.Logical.StructuralCheckmate.classical_inadequacy` | `src/lean (file by file)` | conditional | `Millennium.Logical.StructuralCheckmate.NoUnifClassical` |
| `Millennium.Logical.StructuralCheckmate.strategic_checkmate` | `src/lean (file by file)` | conditional | `Millennium.Logical.StructuralCheckmate.AdequacyImpliesUnif`, `Millennium.Logical.StructuralCheckmate.NoUnifClassical` |
| `Millennium.all_solved_iff_norm_zero` | `src/lean4 (file by file)` | open | `sorryAx` |
| … 5 more in `VERIFICACAO.json` and `TEOREMAS.csv` | | | |

### Declared theorems

The `.lean` files of the verified commit declare 687 `theorem`/`lemma` (counting copies). The kernel checked 218 of them (78 closed, 20 conditional, 120 open). The closed count in the table above is larger: it also counts the theorems Lean generates by itself (equation lemmas, structure fields, `deriving`), which are not written in the text. For 469 the kernel has no result:

| Reason | Theorems |
|---|---:|
| checked file by file: Lean did not reach the theorem (missing import, syntax error or timeout) | 312 |
| checked file by file: the written proof does not pass the kernel | 152 |
| the file did not compile (an error in it or in a file it imports) | 5 |

### MVEI corrections

* `correcoes/imports-no-topo.patch` (import fora do início do arquivo, 20 file(s)): made for the verified commit; it does not apply to the published commit as is
* `correcoes/renomear-imports-mathlib.patch` (import de módulo que não existe na versão do Mathlib do projeto (renomeado ou dividido), 18 file(s)): made for the verified commit; it does not apply to the published commit as is
* `correcoes/tatica-encontrada.patch` (prova que não passava (ou axioma) que uma tática padrão fecha no kernel, 7 file(s)): applies to the published sources: `git apply -p1 --directory=imports/Millennium mvei/Millennium/correcoes/tatica-encontrada.patch` (in order, after the ones above)

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
