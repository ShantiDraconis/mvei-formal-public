# MVEI kernel check — universal-emergent-logic-

This folder records what the Lean 4 kernel said about the Lean sources of the private repository `ShantiDraconis/universal-emergent-logic-`. The sources are published in [`imports/universal-emergent-logic-/`](../../imports/universal-emergent-logic-/).

## What is published

* Source: `ShantiDraconis/universal-emergent-logic-`, commit `041a2090e226310380ee3297d5abef5a51801265` (2026-09-20T08:28:25Z).
* 260 files: 256 `.lean` files and the Lake files (`lakefile.*`, `lean-toolchain`, `lake-manifest.json`), plus 1 license or origin file(s) that third-party code requires (`LICENSE`). Paths are the same as in the source repository.
* Nothing else from the private repository is published (documents, commercial license, prompts, storefront material).
* `SOURCES.sha256` lists every published file with its SHA-256. From the repository root: `sha256sum -c mvei/universal-emergent-logic-/SOURCES.sha256`.

## What the kernel said

MVEI verification of 2026-11-06T00:22:08+00:00, on commit `041a2090e226310380ee3297d5abef5a51801265`. Each theorem was read with `Lean.collectAxioms`, the function behind `#print axioms`.

| Lean project | Lean version | Build | Closed | Conditional | Open (`sorry`) | Checked file by file: closed / conditional / open / proof error / not reached |
|---|---|---|---:|---:|---:|---|
| `codigo` (no lakefile; project assembled by MVEI) | padrão do elan | failed | 0 | 0 | 0 | 0 / 0 / 0 / 3 / 0 |
| `formalization` (no lakefile; project assembled by MVEI) | padrão do elan | failed | 0 | 0 | 0 | 0 / 0 / 1 / 4 / 0 |
| `formalization/lean` | v4.19.0 | partial | 210 | 0 | 42 | 97 / 3 / 340 / 103 / 319 |
| `proofs/bsd_conjecture` (no lakefile; project assembled by MVEI) | padrão do elan | failed | 0 | 0 | 0 | 0 / 0 / 4 / 1 / 0 |
| `proofs/hodge_conjecture` (no lakefile; project assembled by MVEI) | padrão do elan | failed | 0 | 0 | 0 | 0 / 0 / 2 / 3 / 0 |
| `proofs/navier_stokes` (no lakefile; project assembled by MVEI) | v4.19.0 | OK | 0 | 0 | 3 | 0 / 0 / 4 / 1 / 1 |
| `proofs/p_vs_np` (no lakefile; project assembled by MVEI) | padrão do elan | failed | 0 | 0 | 0 | 0 / 0 / 14 / 0 / 5 |
| `proofs/riemann_hypothesis` (no lakefile; project assembled by MVEI) | padrão do elan | failed | 0 | 0 | 0 | 1 / 1 / 45 / 0 / 22 |
| `proofs/yang_mills` (no lakefile; project assembled by MVEI) | padrão do elan | failed | 0 | 0 | 0 | 0 / 0 / 4 / 1 / 0 |
| `src/lean` | v4.8.0 | failed | 0 | 0 | 0 | 0 / 0 / 0 / 0 / 6 |
| `universe00` | v4.19.0 | partial | 233 | 0 | 3 | 200 / 0 / 23 / 28 / 2 |

| Closed theorems in this repository | |
|---|---:|
| Counting each project | 741 |
| Unique (name + statement) | 740 |
| Unique, without the lemmas Lean generates itself (`eq_1`, `mk.inj`, `sizeOf_spec`, `deriving`) | 436 |

*Closed* means the kernel accepted the proof and it depends only on `propext`, `Classical.choice` and `Quot.sound`. It says that the statement as written in the file is proved; it does not say that an open problem is solved. Every statement is in `VERIFICACAO.json`. *Conditional* means the proof also uses axioms declared in the repository; *open* means it uses `sorry`. *Checked file by file* covers the files that no build reached: each one went through Lean whole, with a `#print axioms` for each theorem.

| Theorem | Project | State | Axioms beyond the standard three |
|---|---|---|---|
| `LRE.Millennium.curvature_measures_prime_correlations` | `formalization/lean` | open | `sorryAx` |
| `LRE.Millennium.projection_loses_information` | `formalization/lean` | open | `sorryAx` |
| `LRE.Millennium.rh_iff_bounded_curvature` | `formalization/lean` | open | `sorryAx` |
| `LRE.Millennium.von_koch_lre_form` | `formalization/lean` | open | `sorryAx` |
| `LRE.Millennium.zeros_on_critical_line_minimize_residue` | `formalization/lean` | open | `sorryAx` |
| `LRE.NavierStokes.coupling_dominates_dissipation_implies_cascade` | `formalization/lean` | open | `sorryAx` |
| `LRE.NavierStokes.coupling_from_spectrum` | `formalization/lean` | open | `sorryAx` |
| `LRE.NavierStokes.energyTransfer_bounded` | `formalization/lean` | open | `sorryAx` |
| `LRE.Projection.closure_obstruction_quantitative` | `formalization/lean` | open | `sorryAx` |
| `LRE.Unified.controllable_residue_implies_tractable` | `formalization/lean` | open | `sorryAx` |
| `LRE.Unified.nonzero_curvature_prevents_closure` | `formalization/lean` | open | `sorryAx` |
| `ProjectionSystem.essentially_noninjective_implies_noncontrol` | `formalization/lean` | open | `sorryAx` |
| `ProjectionSystem.residue_unbounded_on_fibers` | `formalization/lean` | open | `sorryAx` |
| `ResidualRegularity.AdmissibleResidual.growth` | `formalization/lean` | open | `sorryAx` |
| `ResidualRegularity.AdmissibleResidual.mk.inj` | `formalization/lean` | open | `sorryAx` |
| `ResidualRegularity.AdmissibleResidual.mk.injEq` | `formalization/lean` | open | `sorryAx` |
| `ResidualRegularity.AdmissibleResidual.mk.sizeOf_spec` | `formalization/lean` | open | `sorryAx` |
| `ResidualRegularity.AdmissibleResidual.nonneg` | `formalization/lean` | open | `sorryAx` |
| `ResidualRegularity.BVFunction.bv_bound` | `formalization/lean` | open | `sorryAx` |
| `ResidualRegularity.BVFunction.mk.inj` | `formalization/lean` | open | `sorryAx` |
| `ResidualRegularity.BVFunction.mk.injEq` | `formalization/lean` | open | `sorryAx` |
| `ResidualRegularity.BVFunction.mk.sizeOf_spec` | `formalization/lean` | open | `sorryAx` |
| `ResidualRegularity.absolutely_continuous_lre` | `formalization/lean` | open | `sorryAx` |
| `ResidualRegularity.blowup_criterion` | `formalization/lean` | open | `sorryAx` |
| `ResidualRegularity.bv_decomposition` | `formalization/lean` | open | `sorryAx` |
| `ResidualRegularity.gronwall_lre` | `formalization/lean` | open | `sorryAx` |
| `ResidualRegularity.integration_by_parts_bv` | `formalization/lean` | open | `sorryAx` |
| `ResidualRegularity.ns_residual_bv` | `formalization/lean` | open | `sorryAx` |
| `ResidualRegularity.shell_residual_smooth` | `formalization/lean` | open | `sorryAx` |
| `ResidualRegularity.weak_lre_to_measure` | `formalization/lean` | open | `sorryAx` |
| `Residual_Blowup_Criterion` | `formalization/lean` | open | `sorryAx` |
| `UnifiedTheory.canonical_is_minimum` | `formalization/lean` | open | `sorryAx` |
| `UnifiedTheory.canonical_strict_local_min` | `formalization/lean` | open | `sorryAx` |
| `UnifiedTheory.coupling_pos_def` | `formalization/lean` | open | `sorryAx` |
| `UnifiedTheory.coupling_symmetric` | `formalization/lean` | open | `sorryAx` |
| `UnifiedTheory.potential_nonneg` | `formalization/lean` | open | `sorryAx` |
| `blowup_time_sharp` | `formalization/lean` | open | `sorryAx` |
| `critical_threshold_characterization` | `formalization/lean` | open | `sorryAx` |
| `integrate_Z_bound` | `formalization/lean` | open | `sorryAx` |
| `subcritical_stability` | `formalization/lean` | open | `sorryAx` |
| `substitution_transform` | `formalization/lean` | open | `sorryAx` |
| `toyModel_NC` | `formalization/lean` | open | `sorryAx` |
| `NavierStokes.InitialData.mk.inj` | `proofs/navier_stokes` | open | `sorryAx` |
| `NavierStokes.InitialData.mk.injEq` | `proofs/navier_stokes` | open | `sorryAx` |
| `NavierStokes.InitialData.mk.sizeOf_spec` | `proofs/navier_stokes` | open | `sorryAx` |
| `Monotonicity.validation_implies_progress` | `universe00` | open | `sorryAx` |
| `Universe00.Core.ErrorVector.maxError_bounds` | `universe00` | open | `sorryAx` |
| `Universe00.Core.ErrorVector.minError_bounds` | `universe00` | open | `sorryAx` |
| `HCS_RBC.rbc_stabilization_pure` | `formalization (file by file)` | open | `sorryAx` |
| `LRE.NavierStokes.projection_loses_topology` | `formalization/lean (file by file)` | open | `sorryAx` |
| `YourProblem_equivalence` | `formalization/lean (file by file)` | open | `sorryAx` |
| `YourProblem_has_counterexample` | `formalization/lean (file by file)` | open | `sorryAx` |
| `YourProblem_classification` | `formalization/lean (file by file)` | open | `sorryAx` |
| `LRE.PvsNP.continuous_hierarchy` | `formalization/lean (file by file)` | open | `sorryAx` |
| `LRE.PvsNP.continuous_family_exists` | `formalization/lean (file by file)` | open | `sorryAx` |
| `LRE.PvsNP.p_vs_np_is_spectrum` | `formalization/lean (file by file)` | open | `sorryAx` |
| `LRE.RiemannHypothesis.rh_unprovable_without_residue` | `formalization/lean (file by file)` | open | `sorryAx` |
| `LRE.RiemannHypothesis.positive_residue_exists` | `formalization/lean (file by file)` | open | `sorryAx` |
| `LRE.residual_feedback` | `formalization/lean (file by file)` | conditional | `LRE.lre_axiom_3` |
| `LREPropositions.fiber_noncompact` | `formalization/lean (file by file)` | open | `sorryAx` |
| `LREPropositions.residue_accumulation` | `formalization/lean (file by file)` | open | `sorryAx` |
| `LREPropositions.projection_unstable` | `formalization/lean (file by file)` | open | `sorryAx` |
| `LRE.QuantitativeObstruction.turbulence_closure_error` | `formalization/lean (file by file)` | open | `sorryAx` |
| `LRE.QuantitativeObstruction.explicit_counterexample` | `formalization/lean (file by file)` | open | `sorryAx` |
| `LRE.QuantitativeObstruction.closure_error_as_information_loss` | `formalization/lean (file by file)` | open | `sorryAx` |
| `LRE.QuantitativeObstruction.residue_as_hidden_information` | `formalization/lean (file by file)` | open | `sorryAx` |
| `LRE.Complexity.P_eq_NP_iff_flat_connection_theorem` | `formalization/lean (file by file)` | open | `sorryAx` |
| `LRE.Complexity.P_neq_NP_iff_exponential_holonomy` | `formalization/lean (file by file)` | open | `sorryAx` |
| `LRE.Complexity.holonomy_bounded_by_residue` | `formalization/lean (file by file)` | open | `sorryAx` |
| `LRE.Complexity.holonomy_implies_circuit_lower_bound` | `formalization/lean (file by file)` | open | `sorryAx` |
| `LRE.ProjectiveSystem.residue_fibration` | `formalization/lean (file by file)` | open | `sorryAx` |
| `LRE.coupling_makes_residue_observable` | `formalization/lean (file by file)` | open | `sorryAx` |
| `LRE.LRE.no_invariant_section` | `formalization/lean (file by file)` | open | `sorryAx` |
| `LRE.LRE.ns_regularity_obstruction` | `formalization/lean (file by file)` | open | `sorryAx`, `LRE.LRE.SobolevSpace`, `LRE.LRE.lerayProjection`, `LRE.LRE.nsConnection` |
| `LRE.ERS.finite_time_blowup` | `formalization/lean (file by file)` | open | `sorryAx` |
| `LRE.ERS.exponential_growth_discrete` | `formalization/lean (file by file)` | open | `sorryAx` |
| `LRE.exponential_growth_from_discrete_ERS` | `formalization/lean (file by file)` | open | `sorryAx` |
| `LRE.Examples.turbulence_prevents_closure` | `formalization/lean (file by file)` | open | `sorryAx`, `LRE.Examples.HSobolevHalf`, `LRE.Examples.HSobolevHalf_normed`, `LRE.Examples.LTwoSpace`, `LRE.Examples.lerayProjection` |
| `LRE.Examples.LRE.Examples.helicity_bounds_residue` | `formalization/lean (file by file)` | open | `sorryAx` |
| `LRE.Examples.coupling_simplifies` | `formalization/lean (file by file)` | open | `sorryAx` |
| `LRE.Examples.toy_curvature_nonzero` | `formalization/lean (file by file)` | open | `sorryAx` |
| `LRE.Examples.prediction_error_vs_residue` | `formalization/lean (file by file)` | open | `sorryAx` |
| `LRE.Examples.coupling_depends_on_phase` | `formalization/lean (file by file)` | open | `sorryAx` |
| `ProjectionSystem.closure_error_bounded_by_residue` | `formalization/lean (file by file)` | open | `sorryAx` |
| `ProjectionSystem.projection_prediction_error` | `formalization/lean (file by file)` | open | `sorryAx` |
| `ProjectionSystem.large_coupling_implies_large_error` | `formalization/lean (file by file)` | open | `sorryAx` |
| `LRE.Connection.tangent_decomposition` | `formalization/lean (file by file)` | open | `sorryAx` |
| `LRE.Connection.frobenius_theorem` | `formalization/lean (file by file)` | open | `sorryAx` |
| `LRE.Connection.nonzero_curvature_implies_holonomy` | `formalization/lean (file by file)` | open | `sorryAx` |
| `LRE.Connection.stokes_for_curvature` | `formalization/lean (file by file)` | open | `sorryAx` |
| `LRE.Connection.curvature_bound_gives_error_bound` | `formalization/lean (file by file)` | open | `sorryAx` |
| `LRE.holonomy_contractible` | `formalization/lean (file by file)` | open | `sorryAx` |
| `LRE.nonzero_curvature_implies_holonomy` | `formalization/lean (file by file)` | open | `sorryAx` |
| `LRE.rectangle_holonomy_equals_flux` | `formalization/lean (file by file)` | open | `sorryAx` |
| `LRE.holonomy_bounds_residue_change` | `formalization/lean (file by file)` | open | `sorryAx` |
| `LRE.holonomy_obstruction` | `formalization/lean (file by file)` | open | `sorryAx` |
| `LRE.residue_fibration` | `formalization/lean (file by file)` | open | `sorryAx` |
| `LRE.closure_obstruction_quantitative` | `formalization/lean (file by file)` | open | `sorryAx` |
| `LRE.feedback_residual_bound` | `formalization/lean (file by file)` | open | `sorryAx` |
| `LRE.holonomy_small_loop_approximation` | `formalization/lean (file by file)` | open | `sorryAx` |
| `LRE.curvature_bounds_obstruction` | `formalization/lean (file by file)` | open | `sorryAx` |
| `LRE.feedback_proportional_to_curvature` | `formalization/lean (file by file)` | open | `sorryAx` |
| `toyModel_fiber_is_vertical_line` | `formalization/lean (file by file)` | open | `sorryAx` |
| `prediction_error_proportional_to_residue` | `formalization/lean (file by file)` | open | `sorryAx` |
| `closed_prediction_error` | `formalization/lean (file by file)` | open | `sorryAx` |
| `LRE.ToyModel.projected_eq_x_dot` | `formalization/lean (file by file)` | open | `sorryAx` |
| `LRE.ToyModel.linearConnection_curvature` | `formalization/lean (file by file)` | open | `sorryAx` |
| `LRE.ToyModel.flatConnection_curvature` | `formalization/lean (file by file)` | open | `sorryAx` |
| `LRE.ToyModel.closure_error_bounded_by_residue` | `formalization/lean (file by file)` | open | `sorryAx` |
| `LRE.ToyModel.closure_error_equals_coupling` | `formalization/lean (file by file)` | open | `sorryAx` |
| `LRE.ToyModel.nonzero_curvature_implies_coupling` | `formalization/lean (file by file)` | open | `sorryAx` |
| `LRE.HCS.BirchSwinnertonDyer.weak_BSD_is_half_exponent` | `formalization/lean (file by file)` | open | `sorryAx` |
| `LRE.HCS.BirchSwinnertonDyer.strong_BSD_is_zero_exponent` | `formalization/lean (file by file)` | open | `sorryAx` |
| `LRE.HCS.regime_dichotomy` | `formalization/lean (file by file)` | open | `sorryAx` |
| `LRE.HCS.rbc_implies_obstruction` | `formalization/lean (file by file)` | open | `sorryAx` |
| `LRE.HCS.critical_point_determines_regime` | `formalization/lean (file by file)` | open | `sorryAx` |
| `LRE.HCS.section_collapse_hypothesis` | `formalization/lean (file by file)` | open | `sorryAx` |
| `LRE.HCS.HodgeConjecture.Hodge_is_rigid` | `formalization/lean (file by file)` | open | `sorryAx` |
| `LRE.HCS.NavierStokes.regularity_iff_bounded_curvature` | `formalization/lean (file by file)` | open | `sorryAx` |
| `LRE.HCS.NavierStokes.unbounded_LP_allows_blowup` | `formalization/lean (file by file)` | open | `sorryAx` |
| `LRE.HCS.PvsNP.NP_complete_exponential_curvature` | `formalization/lean (file by file)` | open | `sorryAx` |
| `LRE.HCS.PvsNP.P_neq_NP_iff_obstructive` | `formalization/lean (file by file)` | open | `sorryAx` |
| `LRE.HCS.PvsNP.NP_complete_no_poly_section` | `formalization/lean (file by file)` | open | `sorryAx` |
| `LRE.HCS.PvsNP.P_has_zero_exponent` | `formalization/lean (file by file)` | open | `sorryAx` |
| `LRE.HCS.PvsNP.NP_has_negative_exponent` | `formalization/lean (file by file)` | open | `sorryAx` |
| `LRE.HCS.PvsNP.PNP_via_HCS` | `formalization/lean (file by file)` | open | `sorryAx` |
| `LRE.HCS.RiemannHypothesis.RH_iff_admissible_closure` | `formalization/lean (file by file)` | open | `sorryAx` |
| `LRE.HCS.RiemannHypothesis.RH_via_HCS` | `formalization/lean (file by file)` | open | `sorryAx` |
| `LRE.HCS.RiemannHypothesis.not_RH_implies_obstruction` | `formalization/lean (file by file)` | open | `sorryAx` |
| `LRE.HCS.YangMills.confinement_curvature_lower_bound` | `formalization/lean (file by file)` | open | `sorryAx` |
| `LRE.HCS.YangMills.mass_gap_iff_obstructive` | `formalization/lean (file by file)` | open | `sorryAx` |
| `LRE.Millennium.bsd_formula` | `formalization/lean (file by file)` | open | `sorryAx` |
| `LRE.Millennium.analytic_rank_is_vanishing_order` | `formalization/lean (file by file)` | open | `sorryAx` |
| `LRE.Millennium.bsd_iff_zero_residue` | `formalization/lean (file by file)` | open | `sorryAx` |
| `LRE.Millennium.sha_as_holonomy` | `formalization/lean (file by file)` | open | `sorryAx` |
| `LRE.Millennium.full_bsd_formula` | `formalization/lean (file by file)` | open | `sorryAx` |
| `LRE.Millennium.arithmetic_analytic_correspondence` | `formalization/lean (file by file)` | open | `sorryAx` |
| `BSD.residue_from_modular_form` | `formalization/lean (file by file)` | open | `sorryAx`, `BSD.analyticRank`, `BSD.arithmeticRank` |
| `BSD.iwasawa_implies_bsd` | `formalization/lean (file by file)` | open | `sorryAx`, `BSD.analyticRank`, `BSD.arithmeticRank`, `BSD.iwasawaMainConjecture` |
| `BSD_conjecture` | `formalization/lean (file by file)` | open | `sorryAx` |
| `ranks_match_no_holonomy` | `formalization/lean (file by file)` | open | `sorryAx` |
| `BSD_formula_iff_zero_residue` | `formalization/lean (file by file)` | open | `sorryAx` |
| `zero_holonomy_perfect_duality` | `formalization/lean (file by file)` | open | `sorryAx` |
| `residue_conductor_evolution` | `formalization/lean (file by file)` | open | `sorryAx` |
| `sha_finite_iff_bounded_residue` | `formalization/lean (file by file)` | open | `sorryAx` |
| `BSD_true_implies_rank_match` | `formalization/lean (file by file)` | open | `sorryAx` |
| `BSD_true_implies_sha_control` | `formalization/lean (file by file)` | open | `sorryAx` |
| `LRE.Millennium.hodge_all_algebraic` | `formalization/lean (file by file)` | open | `sorryAx` |
| `LRE.Millennium.hodge_decomposition` | `formalization/lean (file by file)` | open | `sorryAx` |
| `LRE.Millennium.hodge_symmetry` | `formalization/lean (file by file)` | open | `sorryAx` |
| … 339 more in `VERIFICACAO.json` and `TEOREMAS.csv` | | | |

### Declared theorems

The `.lean` files of the verified commit declare 1 369 `theorem`/`lemma` (counting copies). The kernel checked 817 of them (348 closed, 4 conditional, 465 open). The closed count in the table above is larger: it also counts the theorems Lean generates by itself (equation lemmas, structure fields, `deriving`), which are not written in the text. For 552 the kernel has no result:

| Reason | Theorems |
|---|---:|
| checked file by file: Lean did not reach the theorem (missing import, syntax error or timeout) | 355 |
| checked file by file: the written proof does not pass the kernel | 133 |
| the file did not compile (an error in it or in a file it imports) | 43 |
| the file compiled, but the name did not appear in the kernel (private, mutual or macro-generated) | 21 |

### MVEI corrections

* `correcoes/a-arquivos-corrompidos.patch` (arquivo corrompido no repositório (merge add/add resolvido aceitando os dois lados: linhas das duas versões intercaladas), 32 file(s)): applies to the published sources: `git apply -p1 --directory=imports/universal-emergent-logic- mvei/universal-emergent-logic-/correcoes/a-arquivos-corrompidos.patch` (in order, after the ones above)
* `correcoes/imports-no-topo.patch` (import fora do início do arquivo, 33 file(s)): applies to the published sources: `git apply -p1 --directory=imports/universal-emergent-logic- mvei/universal-emergent-logic-/correcoes/imports-no-topo.patch` (in order, after the ones above)
* `correcoes/renomear-imports-mathlib.patch` (import de módulo que não existe na versão do Mathlib do projeto (renomeado ou dividido), 61 file(s)): applies to the published sources: `git apply -p1 --directory=imports/universal-emergent-logic- mvei/universal-emergent-logic-/correcoes/renomear-imports-mathlib.patch` (in order, after the ones above)
* `correcoes/tatica-encontrada.patch` (prova que não passava (ou axioma) que uma tática padrão fecha no kernel, 17 file(s)): applies to the published sources: `git apply -p1 --directory=imports/universal-emergent-logic- mvei/universal-emergent-logic-/correcoes/tatica-encontrada.patch` (in order, after the ones above)
* `correcoes/vocabulario-lean4.patch` (grafia que o Lean 4 não lê (nome acentuado, λ/Σ/Π como nome, ∀ x y ∈ s, docstring solta, constant, tática do Mathlib sem import), 215 file(s)): applies to the published sources: `git apply -p1 --directory=imports/universal-emergent-logic- mvei/universal-emergent-logic-/correcoes/vocabulario-lean4.patch` (in order, after the ones above)
* `correcoes/z-provas-reparadas.patch` (prova que não passava no kernel (o enunciado fica igual), 30 file(s)): applies to the published sources: `git apply -p1 --directory=imports/universal-emergent-logic- mvei/universal-emergent-logic-/correcoes/z-provas-reparadas.patch` (in order, after the ones above)
* `correcoes/zy-enunciados-do-autor.patch` (enunciado reescrito a pedido do autor (o original, como escrito, fica registrado), 51 file(s)): applies to the published sources: `git apply -p1 --directory=imports/universal-emergent-logic- mvei/universal-emergent-logic-/correcoes/zy-enunciados-do-autor.patch` (in order, after the ones above)
* `correcoes/zz-refutacoes.patch` (teorema com enunciado falso como o Lean o lê (o original fica como está), 14 file(s)): applies to the published sources: `git apply -p1 --directory=imports/universal-emergent-logic- mvei/universal-emergent-logic-/correcoes/zz-refutacoes.patch` (in order, after the ones above)

## Files in this folder

* `VERIFICACAO.json` — each Lean project of this repository, each theorem the kernel read, its statement, its axioms and its state (`fechado` closed, `condicional` conditional, `aberto-sorry` open)
* `TEOREMAS.csv` — each declared `theorem`/`lemma`: file, line, state in the kernel (`nao_checado` = not checked) and, if not checked, why (in Portuguese)
* `BUILD_LOG.txt` — one block per project: Lean version, result, errors
* `SOURCE.json` — source commit, verified commit and dates, machine-readable
* `SOURCES.sha256` — SHA-256 of every published file

## Reproduce

```
cd imports/universal-emergent-logic-/<project>   # a project folder from the table above ('.' is imports/universal-emergent-logic-)
lake exe cache get           # only for projects that require Mathlib
lake build
```

Each project uses the Lean version in its own `lean-toolchain`, which elan installs. The MVEI pipeline that produced these results is in the author's repository and is not public.
