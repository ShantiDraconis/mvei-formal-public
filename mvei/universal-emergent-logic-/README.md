# MVEI kernel check — universal-emergent-logic-

This folder records what the Lean 4 kernel said about the Lean sources of the private repository `ShantiDraconis/universal-emergent-logic-`. The sources are published in [`imports/universal-emergent-logic-/`](../../imports/universal-emergent-logic-/).

## What is published

* Source: `ShantiDraconis/universal-emergent-logic-`, commit `041a2090e226310380ee3297d5abef5a51801265` (2026-09-20T08:28:25Z).
* 260 files: 256 `.lean` files and the Lake files (`lakefile.*`, `lean-toolchain`, `lake-manifest.json`), plus 1 license or origin file(s) that third-party code requires (`LICENSE`). Paths are the same as in the source repository.
* Nothing else from the private repository is published (documents, commercial license, prompts, storefront material).
* `SOURCES.sha256` lists every published file with its SHA-256. From the repository root: `sha256sum -c mvei/universal-emergent-logic-/SOURCES.sha256`.

## What the kernel said

MVEI verification of 2026-11-03T08:19:01+00:00, on commit `041a2090e226310380ee3297d5abef5a51801265`. Each theorem was read with `Lean.collectAxioms`, the function behind `#print axioms`.

| Lean project | Lean version | Build | Closed | Conditional | Open (`sorry`) | Checked file by file: closed / conditional / open / proof error / not reached |
|---|---|---|---:|---:|---:|---|
| `codigo` (no lakefile; project assembled by MVEI) | padrão do elan | failed | 0 | 0 | 0 | 0 / 0 / 0 / 3 / 0 |
| `formalization` (no lakefile; project assembled by MVEI) | padrão do elan | failed | 0 | 0 | 0 | 0 / 0 / 1 / 4 / 0 |
| `formalization/lean` | v4.19.0 | partial | 25 | 0 | 14 | 36 / 3 / 302 / 94 / 504 |
| `proofs/bsd_conjecture` (no lakefile; project assembled by MVEI) | padrão do elan | failed | 0 | 0 | 0 | 0 / 0 / 4 / 1 / 0 |
| `proofs/hodge_conjecture` (no lakefile; project assembled by MVEI) | padrão do elan | failed | 0 | 0 | 0 | 0 / 0 / 2 / 3 / 0 |
| `proofs/navier_stokes` (no lakefile; project assembled by MVEI) | v4.19.0 | OK | 0 | 0 | 3 | 0 / 0 / 4 / 1 / 1 |
| `proofs/p_vs_np` (no lakefile; project assembled by MVEI) | padrão do elan | failed | 0 | 0 | 0 | 0 / 0 / 14 / 0 / 5 |
| `proofs/riemann_hypothesis` (no lakefile; project assembled by MVEI) | padrão do elan | failed | 0 | 0 | 0 | 1 / 1 / 45 / 0 / 22 |
| `proofs/yang_mills` (no lakefile; project assembled by MVEI) | padrão do elan | failed | 0 | 0 | 0 | 0 / 0 / 4 / 1 / 0 |
| `src/lean` | v4.8.0 | failed | 0 | 0 | 0 | 0 / 0 / 1 / 0 / 6 |
| `universe00` | v4.3.0 | partial | 19 | 0 | 0 | 12 / 0 / 15 / 2 / 252 |

| Closed theorems in this repository | |
|---|---:|
| Counting each project | 93 |
| Unique (name + statement) | 92 |
| Unique, without the lemmas Lean generates itself (`eq_1`, `mk.inj`, `sizeOf_spec`, `deriving`) | 66 |

*Closed* means the kernel accepted the proof and it depends only on `propext`, `Classical.choice` and `Quot.sound`. It says that the statement as written in the file is proved; it does not say that an open problem is solved. Every statement is in `VERIFICACAO.json`. *Conditional* means the proof also uses axioms declared in the repository; *open* means it uses `sorry`. *Checked file by file* covers the files that no build reached: each one went through Lean whole, with a `#print axioms` for each theorem.

| Theorem | Project | State | Axioms beyond the standard three |
|---|---|---|---|
| `LRE.NavierStokes.coupling_dominates_dissipation_implies_cascade` | `formalization/lean` | open | `sorryAx` |
| `LRE.NavierStokes.coupling_from_spectrum` | `formalization/lean` | open | `sorryAx` |
| `LRE.NavierStokes.energyTransfer_bounded` | `formalization/lean` | open | `sorryAx` |
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
| `NavierStokes.InitialData.mk.inj` | `proofs/navier_stokes` | open | `sorryAx` |
| `NavierStokes.InitialData.mk.injEq` | `proofs/navier_stokes` | open | `sorryAx` |
| `NavierStokes.InitialData.mk.sizeOf_spec` | `proofs/navier_stokes` | open | `sorryAx` |
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
| `LRE.fiber_nonempty` | `formalization/lean (file by file)` | open | `sorryAx` |
| `LRE.fibers_partition` | `formalization/lean (file by file)` | open | `sorryAx` |
| `LRE.residual_feedback` | `formalization/lean (file by file)` | open | `sorryAx`, `LRE.lre_axiom_3` |
| `LREPropositions.fiber_noncompact` | `formalization/lean (file by file)` | open | `sorryAx` |
| `LREPropositions.residue_accumulation` | `formalization/lean (file by file)` | open | `sorryAx` |
| `LREPropositions.projection_unstable` | `formalization/lean (file by file)` | open | `sorryAx` |
| `LRE.QuantitativeObstruction.turbulence_closure_error` | `formalization/lean (file by file)` | open | `sorryAx` |
| `LRE.QuantitativeObstruction.explicit_counterexample` | `formalization/lean (file by file)` | open | `sorryAx` |
| `LRE.QuantitativeObstruction.closure_error_as_information_loss` | `formalization/lean (file by file)` | open | `sorryAx` |
| `LRE.QuantitativeObstruction.residue_as_hidden_information` | `formalization/lean (file by file)` | open | `sorryAx` |
| `LRE.Complexity.P_eq_NP_iff_flat_connection` | `formalization/lean (file by file)` | open | `sorryAx` |
| `LRE.Complexity.P_eq_NP_iff_flat_connection_theorem` | `formalization/lean (file by file)` | open | `sorryAx` |
| `LRE.Complexity.P_neq_NP_iff_exponential_holonomy` | `formalization/lean (file by file)` | open | `sorryAx` |
| `LRE.Complexity.holonomy_bounded_by_residue` | `formalization/lean (file by file)` | open | `sorryAx` |
| `LRE.Complexity.holonomy_implies_circuit_lower_bound` | `formalization/lean (file by file)` | open | `sorryAx` |
| `ProjectionSystem.sigma_pi_measurable_iff_factors` | `formalization/lean (file by file)` | open | `sorryAx` |
| `ProjectionSystem.residue_fibration` | `formalization/lean (file by file)` | open | `sorryAx` |
| `ProjectionSystem.threshold_set_not_sigma_pi` | `formalization/lean (file by file)` | open | `sorryAx` |
| `ProjectionSystem.no_closed_theory_approximates_residue` | `formalization/lean (file by file)` | open | `sorryAx` |
| `ProjectionSystem.residue_not_sigma_pi_measurable` | `formalization/lean (file by file)` | open | `sorryAx` |
| `ProjectionSystem.violation_measure_lower_bound` | `formalization/lean (file by file)` | open | `sorryAx` |
| `ProjectionSystem.noncontrol_positive_violation` | `formalization/lean (file by file)` | open | `sorryAx` |
| `ProjectionSystem.essentially_noninjective_implies_noncontrol` | `formalization/lean (file by file)` | open | `sorryAx` |
| `ProjectionSystem.closed_theory_cannot_predict_residue` | `formalization/lean (file by file)` | open | `sorryAx` |
| `ProjectionSystem.violation_set_positive_measure` | `formalization/lean (file by file)` | open | `sorryAx` |
| `ProjectionSystem.residue_arbitrarily_large` | `formalization/lean (file by file)` | open | `sorryAx` |
| `LRE.LRE.closure_error_linear_growth` | `formalization/lean (file by file)` | open | `sorryAx` |
| `LRE.LRE.coupling_makes_residue_observable` | `formalization/lean (file by file)` | open | `sorryAx` |
| `LRE.LRE.no_perfect_closure_with_varying_residue` | `formalization/lean (file by file)` | open | `sorryAx` |
| `LRE.LRE.error_lower_bound_independent_of_model` | `formalization/lean (file by file)` | open | `sorryAx` |
| `ResidualRegularity.ns_residual_bv` | `formalization/lean (file by file)` | open | `sorryAx` |
| `ResidualRegularity.shell_residual_smooth` | `formalization/lean (file by file)` | open | `sorryAx` |
| `ResidualRegularity.bv_decomposition` | `formalization/lean (file by file)` | open | `sorryAx` |
| `ResidualRegularity.blowup_criterion` | `formalization/lean (file by file)` | open | `sorryAx` |
| `ProjectionSystem.residue_unbounded_on_fibers` | `formalization/lean (file by file)` | open | `sorryAx` |
| `LRE.ERS.finite_time_blowup` | `formalization/lean (file by file)` | open | `sorryAx` |
| `LRE.ERS.exponential_growth_discrete` | `formalization/lean (file by file)` | open | `sorryAx` |
| `LRE.exponential_growth_from_discrete_ERS` | `formalization/lean (file by file)` | open | `sorryAx` |
| `ProjectionSystem.toyModel_flat_has_zero_curvature` | `formalization/lean (file by file)` | open | `sorryAx` |
| `LRE.Connection.tangent_decomposition` | `formalization/lean (file by file)` | open | `sorryAx` |
| `LRE.Connection.frobenius_theorem` | `formalization/lean (file by file)` | open | `sorryAx` |
| `LRE.Connection.nonzero_curvature_implies_holonomy` | `formalization/lean (file by file)` | open | `sorryAx` |
| `LRE.Connection.stokes_for_curvature` | `formalization/lean (file by file)` | open | `sorryAx` |
| `LRE.Connection.curvature_bound_gives_error_bound` | `formalization/lean (file by file)` | open | `sorryAx` |
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
| `LRE.HCS.PvsNP.NP_complete_exponential_curvature` | `formalization/lean (file by file)` | open | `sorryAx` |
| `LRE.HCS.PvsNP.P_neq_NP_iff_obstructive` | `formalization/lean (file by file)` | open | `sorryAx` |
| `LRE.HCS.PvsNP.NP_complete_no_poly_section` | `formalization/lean (file by file)` | open | `sorryAx` |
| `LRE.HCS.PvsNP.P_has_zero_exponent` | `formalization/lean (file by file)` | open | `sorryAx` |
| `LRE.HCS.PvsNP.NP_has_negative_exponent` | `formalization/lean (file by file)` | open | `sorryAx` |
| `LRE.HCS.RiemannHypothesis.RH_iff_admissible_closure` | `formalization/lean (file by file)` | open | `sorryAx` |
| `LRE.HCS.RiemannHypothesis.RH_via_HCS` | `formalization/lean (file by file)` | open | `sorryAx` |
| `LRE.HCS.RiemannHypothesis.not_RH_implies_obstruction` | `formalization/lean (file by file)` | open | `sorryAx` |
| `LRE.HCS.YangMills.confinement_curvature_lower_bound` | `formalization/lean (file by file)` | open | `sorryAx` |
| `LRE.HCS.YangMills.mass_gap_iff_obstructive` | `formalization/lean (file by file)` | open | `sorryAx` |
| `LRE.Millennium.mordell_weil_finitely_generated` | `formalization/lean (file by file)` | open | `sorryAx` |
| `LRE.Millennium.bsd_formula` | `formalization/lean (file by file)` | open | `sorryAx` |
| `LRE.Millennium.analytic_rank_is_vanishing_order` | `formalization/lean (file by file)` | open | `sorryAx` |
| `LRE.Millennium.bsd_iff_zero_residue` | `formalization/lean (file by file)` | open | `sorryAx` |
| `LRE.Millennium.sha_as_holonomy` | `formalization/lean (file by file)` | open | `sorryAx` |
| `LRE.Millennium.weak_bsd_lre` | `formalization/lean (file by file)` | open | `sorryAx` |
| `LRE.Millennium.full_bsd_formula` | `formalization/lean (file by file)` | open | `sorryAx` |
| `LRE.Millennium.arithmetic_analytic_correspondence` | `formalization/lean (file by file)` | open | `sorryAx` |
| `LRE.Millennium.arithmetic_rank_hard` | `formalization/lean (file by file)` | open | `sorryAx` |
| `LRE.Millennium.analytic_rank_computable` | `formalization/lean (file by file)` | open | `sorryAx` |
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
| `LRE.Millennium.lefschetz_one_one` | `formalization/lean (file by file)` | open | `sorryAx` |
| `LRE.Millennium.higher_codimension_open` | `formalization/lean (file by file)` | open | `sorryAx` |
| `LRE.Millennium.nonzero_curvature_implies_noalgebraic` | `formalization/lean (file by file)` | open | `sorryAx` |
| `LRE.Millennium.zero_residue_iff_all_algebraic` | `formalization/lean (file by file)` | open | `sorryAx` |
| `LRE.Millennium.curvature_obstruction` | `formalization/lean (file by file)` | open | `sorryAx` |
| `LRE.Millennium.griffiths_transversality` | `formalization/lean (file by file)` | open | `sorryAx` |
| `LRE.Millennium.algebraicity_undecidable` | `formalization/lean (file by file)` | open | `sorryAx` |
| `LRE.Millennium.specific_varieties_computable` | `formalization/lean (file by file)` | open | `sorryAx` |
| `NS_sufficient_viscosity` | `formalization/lean (file by file)` | open | `sorryAx` |
| `P_equals_NP_characterization` | `formalization/lean (file by file)` | open | `sorryAx` |
| `P_neq_NP_exponential_gap` | `formalization/lean (file by file)` | open | `sorryAx` |
| `NP_complete_residue_transfer` | `formalization/lean (file by file)` | open | `sorryAx` |
| `LRE.Millennium.unbounded_gap_implies_p_neq_np` | `formalization/lean (file by file)` | open | `sorryAx` |
| `LRE.Millennium.p_neq_np_iff_no_polynomial_section` | `formalization/lean (file by file)` | open | `sorryAx` |
| `LRE.Millennium.residue_exponential_growth_for_hard_instances` | `formalization/lean (file by file)` | open | `sorryAx` |
| `LRE.Millennium.complexity_gap_is_residue` | `formalization/lean (file by file)` | open | `sorryAx` |
| `LRE.Millennium.computational_curvature_nonzero` | `formalization/lean (file by file)` | open | `sorryAx` |
| `PvsNP.ers_hard_instances` | `formalization/lean (file by file)` | open | `sorryAx` |
| `Riemann.selfadjoint_implies_rh` | `formalization/lean (file by file)` | open | `sorryAx`, `Riemann.spectralOperator`, `Riemann.spectrum` |
| `Riemann_Hypothesis` | `formalization/lean (file by file)` | open | `sorryAx` |
| `RH_prime_counting` | `formalization/lean (file by file)` | open | `sorryAx` |
| `RiemannHypothesis.bootstrap_is_contraction` | `formalization/lean (file by file)` | open | `sorryAx` |
| `RiemannHypothesis.bootstrap_converges` | `formalization/lean (file by file)` | open | `sorryAx` |
| `RiemannHypothesis.exponential_convergence` | `formalization/lean (file by file)` | open | `sorryAx` |
| `RiemannHypothesis.frameworks_equivalent` | `formalization/lean (file by file)` | open | `sorryAx` |
| `LRE.Millennium.projection_loses_information` | `formalization/lean (file by file)` | open | `sorryAx` |
| `LRE.Millennium.von_koch_lre_form` | `formalization/lean (file by file)` | open | `sorryAx` |
| `LRE.Millennium.zeros_on_critical_line_minimize_residue` | `formalization/lean (file by file)` | open | `sorryAx` |
| `LRE.Millennium.curvature_measures_prime_correlations` | `formalization/lean (file by file)` | open | `sorryAx` |
| `LRE.Millennium.rh_iff_bounded_curvature` | `formalization/lean (file by file)` | open | `sorryAx` |
| `LRE.Millennium.grh_as_universal_residue_control` | `formalization/lean (file by file)` | open | `sorryAx` |
| `YangMills_mass_gap` | `formalization/lean (file by file)` | open | `sorryAx` |
| `mass_gap_positive` | `formalization/lean (file by file)` | open | `sorryAx` |
| `IR_slavery_implies_mass_gap` | `formalization/lean (file by file)` | open | `sorryAx` |
| … 263 more in `VERIFICACAO.json` and `TEOREMAS.csv` | | | |

### Declared theorems

The `.lean` files of the verified commit declare 1 369 `theorem`/`lemma` (counting copies). The kernel checked 470 of them (60 closed, 4 conditional, 406 open). The closed count in the table above is larger: it also counts the theorems Lean generates by itself (equation lemmas, structure fields, `deriving`), which are not written in the text. For 899 the kernel has no result:

| Reason | Theorems |
|---|---:|
| checked file by file: Lean did not reach the theorem (missing import, syntax error or timeout) | 790 |
| checked file by file: the written proof does not pass the kernel | 109 |

### MVEI corrections

* `correcoes/a-arquivos-corrompidos.patch` (arquivo corrompido no repositório (merge add/add resolvido aceitando os dois lados: linhas das duas versões intercaladas), 32 file(s)): applies to the published sources: `git apply -p1 --directory=imports/universal-emergent-logic- mvei/universal-emergent-logic-/correcoes/a-arquivos-corrompidos.patch` (in order, after the ones above)
* `correcoes/imports-no-topo.patch` (import fora do início do arquivo, 33 file(s)): applies to the published sources: `git apply -p1 --directory=imports/universal-emergent-logic- mvei/universal-emergent-logic-/correcoes/imports-no-topo.patch` (in order, after the ones above)
* `correcoes/renomear-imports-mathlib.patch` (import de módulo que não existe na versão do Mathlib do projeto (renomeado ou dividido), 61 file(s)): applies to the published sources: `git apply -p1 --directory=imports/universal-emergent-logic- mvei/universal-emergent-logic-/correcoes/renomear-imports-mathlib.patch` (in order, after the ones above)
* `correcoes/tatica-encontrada.patch` (prova que não passava (ou axioma) que uma tática padrão fecha no kernel, 5 file(s)): applies to the published sources: `git apply -p1 --directory=imports/universal-emergent-logic- mvei/universal-emergent-logic-/correcoes/tatica-encontrada.patch` (in order, after the ones above)
* `correcoes/vocabulario-lean4.patch` (grafia que o Lean 4 não lê (nome acentuado, λ/Σ/Π como nome, ∀ x y ∈ s, docstring solta, constant, tática do Mathlib sem import), 215 file(s)): applies to the published sources: `git apply -p1 --directory=imports/universal-emergent-logic- mvei/universal-emergent-logic-/correcoes/vocabulario-lean4.patch` (in order, after the ones above)
* `correcoes/z-provas-reparadas.patch` (prova que não passava no kernel (o enunciado fica igual), 6 file(s)): applies to the published sources: `git apply -p1 --directory=imports/universal-emergent-logic- mvei/universal-emergent-logic-/correcoes/z-provas-reparadas.patch` (in order, after the ones above)
* `correcoes/zz-refutacoes.patch` (teorema com enunciado falso como o Lean o lê (o original fica como está), 1 file(s)): applies to the published sources: `git apply -p1 --directory=imports/universal-emergent-logic- mvei/universal-emergent-logic-/correcoes/zz-refutacoes.patch` (in order, after the ones above)

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
