# MVEI kernel check — universal-emergent-logic-

This folder records what the Lean 4 kernel said about the Lean sources of the private repository `ShantiDraconis/universal-emergent-logic-`. The sources are published in [`imports/universal-emergent-logic-/`](../../imports/universal-emergent-logic-/).

## What is published

* Source: `ShantiDraconis/universal-emergent-logic-`, commit `041a2090e226310380ee3297d5abef5a51801265` (2026-09-20T08:28:25Z).
* 260 files: 256 `.lean` files and the Lake files (`lakefile.*`, `lean-toolchain`, `lake-manifest.json`), plus 1 license or origin file(s) that third-party code requires (`LICENSE`). Paths are the same as in the source repository.
* Nothing else from the private repository is published (documents, commercial license, prompts, storefront material).
* `SOURCES.sha256` lists every published file with its SHA-256. From the repository root: `sha256sum -c mvei/universal-emergent-logic-/SOURCES.sha256`.

## What the kernel said

MVEI verification of 2026-10-30T08:01:18+00:00, on commit `041a2090e226310380ee3297d5abef5a51801265`. Each theorem was read with `Lean.collectAxioms`, the function behind `#print axioms`.

| Lean project | Lean version | Build | Closed | Conditional | Open (`sorry`) | Checked file by file: closed / conditional / open / proof error / not reached |
|---|---|---|---:|---:|---:|---|
| `codigo` (no lakefile; project assembled by MVEI) | padrão do elan | failed | 0 | 0 | 0 | 0 / 0 / 0 / 3 / 0 |
| `formalization` (no lakefile; project assembled by MVEI) | padrão do elan | failed | 0 | 0 | 0 | 0 / 0 / 1 / 4 / 0 |
| `formalization/lean` | v4.19.0 | partial | 21 | 0 | 8 | 15 / 1 / 90 / 99 / 740 |
| `proofs/bsd_conjecture` (no lakefile; project assembled by MVEI) | padrão do elan | failed | 0 | 0 | 0 | 0 / 0 / 4 / 1 / 0 |
| `proofs/hodge_conjecture` (no lakefile; project assembled by MVEI) | padrão do elan | failed | 0 | 0 | 0 | 0 / 0 / 2 / 3 / 0 |
| `proofs/navier_stokes` (no lakefile; project assembled by MVEI) | padrão do elan | failed | 0 | 0 | 0 | 0 / 0 / 0 / 0 / 6 |
| `proofs/p_vs_np` (no lakefile; project assembled by MVEI) | padrão do elan | failed | 0 | 0 | 0 | 0 / 0 / 0 / 0 / 19 |
| `proofs/riemann_hypothesis` (no lakefile; project assembled by MVEI) | padrão do elan | failed | 0 | 0 | 0 | 0 / 0 / 0 / 0 / 69 |
| `proofs/yang_mills` (no lakefile; project assembled by MVEI) | padrão do elan | failed | 0 | 0 | 0 | 0 / 0 / 4 / 1 / 0 |
| `src/lean` | v4.8.0 | failed | 0 | 0 | 0 | 0 / 0 / 1 / 0 / 6 |
| `universe00` | v4.3.0 | failed | 0 | 0 | 0 | 21 / 0 / 12 / 2 / 257 |

| Closed theorems in this repository | |
|---|---:|
| Counting each project | 57 |
| Unique (name + statement) | 56 |
| Unique, without the lemmas Lean generates itself (`eq_1`, `mk.inj`, `sizeOf_spec`, `deriving`) | 41 |

*Closed* means the kernel accepted the proof and it depends only on `propext`, `Classical.choice` and `Quot.sound`. It says that the statement as written in the file is proved; it does not say that an open problem is solved. Every statement is in `VERIFICACAO.json`. *Conditional* means the proof also uses axioms declared in the repository; *open* means it uses `sorry`. *Checked file by file* covers the files that no build reached: each one went through Lean whole, with a `#print axioms` for each theorem.

| Theorem | Project | State | Axioms beyond the standard three |
|---|---|---|---|
| `LRE.NavierStokes.coupling_dominates_dissipation_implies_cascade` | `formalization/lean` | open | `sorryAx` |
| `LRE.NavierStokes.coupling_from_spectrum` | `formalization/lean` | open | `sorryAx` |
| `LRE.NavierStokes.energyTransfer_bounded` | `formalization/lean` | open | `sorryAx` |
| `UnifiedTheory.canonical_is_minimum` | `formalization/lean` | open | `sorryAx` |
| `UnifiedTheory.canonical_strict_local_min` | `formalization/lean` | open | `sorryAx` |
| `UnifiedTheory.coupling_pos_def` | `formalization/lean` | open | `sorryAx` |
| `UnifiedTheory.coupling_symmetric` | `formalization/lean` | open | `sorryAx` |
| `UnifiedTheory.potential_nonneg` | `formalization/lean` | open | `sorryAx` |
| `HCS_RBC.rbc_stabilization_pure` | `formalization (file by file)` | open | `sorryAx` |
| `YourProblem_equivalence` | `formalization/lean (file by file)` | open | `sorryAx` |
| `YourProblem_has_counterexample` | `formalization/lean (file by file)` | open | `sorryAx` |
| `YourProblem_classification` | `formalization/lean (file by file)` | open | `sorryAx` |
| `LREPropositions.fiber_noncompact` | `formalization/lean (file by file)` | open | `sorryAx` |
| `LREPropositions.residue_accumulation` | `formalization/lean (file by file)` | open | `sorryAx` |
| `LREPropositions.projection_unstable` | `formalization/lean (file by file)` | open | `sorryAx` |
| `LRE.Complexity.P_eq_NP_iff_flat_connection` | `formalization/lean (file by file)` | open | `sorryAx` |
| `ResidualRegularity.ns_residual_bv` | `formalization/lean (file by file)` | open | `sorryAx` |
| `ResidualRegularity.shell_residual_smooth` | `formalization/lean (file by file)` | open | `sorryAx` |
| `ResidualRegularity.bv_decomposition` | `formalization/lean (file by file)` | open | `sorryAx` |
| `ResidualRegularity.blowup_criterion` | `formalization/lean (file by file)` | open | `sorryAx` |
| `Residual_Blowup_Criterion` | `formalization/lean (file by file)` | open | `sorryAx` |
| `substitution_transform` | `formalization/lean (file by file)` | open | `sorryAx` |
| `integrate_Z_bound` | `formalization/lean (file by file)` | open | `sorryAx` |
| `critical_threshold_characterization` | `formalization/lean (file by file)` | open | `sorryAx` |
| `subcritical_stability` | `formalization/lean (file by file)` | open | `sorryAx` |
| `blowup_time_sharp` | `formalization/lean (file by file)` | open | `sorryAx` |
| `BSD_conjecture` | `formalization/lean (file by file)` | open | `sorryAx` |
| `ranks_match_no_holonomy` | `formalization/lean (file by file)` | open | `sorryAx` |
| `BSD_formula_iff_zero_residue` | `formalization/lean (file by file)` | open | `sorryAx` |
| `zero_holonomy_perfect_duality` | `formalization/lean (file by file)` | open | `sorryAx` |
| `residue_conductor_evolution` | `formalization/lean (file by file)` | open | `sorryAx` |
| `sha_finite_iff_bounded_residue` | `formalization/lean (file by file)` | open | `sorryAx` |
| `BSD_true_implies_rank_match` | `formalization/lean (file by file)` | open | `sorryAx` |
| `BSD_true_implies_sha_control` | `formalization/lean (file by file)` | open | `sorryAx` |
| `NS_sufficient_viscosity` | `formalization/lean (file by file)` | open | `sorryAx` |
| `P_equals_NP_characterization` | `formalization/lean (file by file)` | open | `sorryAx` |
| `P_neq_NP_exponential_gap` | `formalization/lean (file by file)` | open | `sorryAx` |
| `NP_complete_residue_transfer` | `formalization/lean (file by file)` | open | `sorryAx` |
| `Riemann_Hypothesis` | `formalization/lean (file by file)` | open | `sorryAx` |
| `RH_prime_counting` | `formalization/lean (file by file)` | open | `sorryAx` |
| `RiemannHypothesis.bootstrap_is_contraction` | `formalization/lean (file by file)` | open | `sorryAx` |
| `RiemannHypothesis.bootstrap_converges` | `formalization/lean (file by file)` | open | `sorryAx` |
| `RiemannHypothesis.exponential_convergence` | `formalization/lean (file by file)` | open | `sorryAx` |
| `RiemannHypothesis.frameworks_equivalent` | `formalization/lean (file by file)` | open | `sorryAx` |
| `YangMills_mass_gap` | `formalization/lean (file by file)` | open | `sorryAx` |
| `mass_gap_positive` | `formalization/lean (file by file)` | open | `sorryAx` |
| `IR_slavery_implies_mass_gap` | `formalization/lean (file by file)` | open | `sorryAx` |
| `mass_gap_iff_confinement` | `formalization/lean (file by file)` | open | `sorryAx` |
| `vacuum_stability` | `formalization/lean (file by file)` | open | `sorryAx` |
| `mass_gap_implies_no_massless_states` | `formalization/lean (file by file)` | open | `sorryAx` |
| `mass_gap_determines_hadron_masses` | `formalization/lean (file by file)` | open | `sorryAx` |
| `LRE.NS.spectralProjection_idempotent` | `formalization/lean (file by file)` | open | `sorryAx` |
| `LRE.NS.spectralProjection_selfAdjoint` | `formalization/lean (file by file)` | open | `sorryAx` |
| `LRE.NS.lerayProjection_orthogonal` | `formalization/lean (file by file)` | open | `sorryAx` |
| `LRE.NS.frequency_decomposition_energy` | `formalization/lean (file by file)` | open | `sorryAx` |
| `LRE.ODE.continuous_ERS_stability` | `formalization/lean (file by file)` | open | `sorryAx` |
| `LRE.ODE.discrete_ERS_stability` | `formalization/lean (file by file)` | open | `sorryAx` |
| `LRE.ODE.discrete_ERS_growth` | `formalization/lean (file by file)` | open | `sorryAx` |
| `collatz_is_resolvable` | `formalization/lean (file by file)` | open | `sorryAx` |
| `LRE_RBC_Corrected.supercritical_blowup_exists` | `formalization/lean (file by file)` | open | `sorryAx` |
| `LRE_RBC_Corrected.NavierStokes.NS_blowup_via_supercritical_RBC` | `formalization/lean (file by file)` | open | `sorryAx`, `LRE_RBC_Corrected.NavierStokes.H1_norm`, `LRE_RBC_Corrected.NavierStokes.NS_Solution`, `LRE_RBC_Corrected.NavierStokes.residual_NS` |
| `Millennium.Stability.riemann_as_fixed_point` | `formalization/lean (file by file)` | open | `sorryAx` |
| `Millennium.Stability.navier_stokes_collapse` | `formalization/lean (file by file)` | open | `sorryAx` |
| `Millennium.Stability.coupling_matrix_feigenbaum` | `formalization/lean (file by file)` | open | `sorryAx` |
| `Millennium.Stability.coupling_matrix_golden_ratio` | `formalization/lean (file by file)` | open | `sorryAx` |
| `MillenniumCascade.check_regularity` | `formalization/lean (file by file)` | open | `sorryAx` |
| `MillenniumCascade.pos_def_implies_eigenvalue_bound` | `formalization/lean (file by file)` | open | `sorryAx` |
| `MillenniumCascade.intermittency_from_coupling` | `formalization/lean (file by file)` | open | `sorryAx` |
| `MillenniumCascade.numerical_verification` | `formalization/lean (file by file)` | open | `sorryAx` |
| `MillenniumCascade.realistic_dimension_reduction` | `formalization/lean (file by file)` | open | `sorryAx` |
| `Millennium.Lemmas.ODE_comparison` | `formalization/lean (file by file)` | open | `sorryAx` |
| `Millennium.Lemmas.gronwall_decay` | `formalization/lean (file by file)` | open | `sorryAx` |
| `Millennium.Lemmas.super_poly_dominates` | `formalization/lean (file by file)` | open | `sorryAx` |
| `Millennium.Lemmas.golden_ratio_approx` | `formalization/lean (file by file)` | open | `sorryAx` |
| `BSD.tamagawa_distribution` | `formalization/lean (file by file)` | open | `sorryAx`, `BSD.EllipticCurve`, `BSD.analytic_rank` |
| `BSD.bsd_numerical_verification` | `formalization/lean (file by file)` | open | `sorryAx`, `BSD.EllipticCurve`, `BSD.analytic_rank` |
| `BSD.local_factors_average` | `formalization/lean (file by file)` | open | `sorryAx`, `BSD.EllipticCurve`, `BSD.tamagawa_number` |
| `OperatorCore.operator_self_adjoint` | `formalization/lean (file by file)` | open | `sorryAx` |
| `OperatorCore.eigenvalues_real` | `formalization/lean (file by file)` | open | `sorryAx` |
| `OperatorCore.spectrum_discrete` | `formalization/lean (file by file)` | open | `sorryAx` |
| `OperatorCore.mass_gap_from_spectrum` | `formalization/lean (file by file)` | open | `sorryAx` |
| `OperatorCore.contains_berry_keating` | `formalization/lean (file by file)` | open | `sorryAx` |
| `RiemannHypothesis.K_RH_bounded` | `formalization/lean (file by file)` | open | `sorryAx` |
| `RiemannHypothesis.riemann_hypothesis` | `formalization/lean (file by file)` | open | `sorryAx` |
| `YangMills.mass_gap_golden_ratio` | `formalization/lean (file by file)` | open | `sorryAx` |
| `YangMills.yang_mills_coupling_block` | `formalization/lean (file by file)` | open | `sorryAx` |
| `UniversalConstants.YangMills.golden_ratio_relation` | `formalization/lean (file by file)` | open | `sorryAx` |
| `Unified.Coupling.C_identity_posdef` | `formalization/lean (file by file)` | open | `sorryAx` |
| `Unified.Coupling.C_standard_symmetric` | `formalization/lean (file by file)` | open | `sorryAx` |
| `Unified.Coupling.Certificate.posdef_from_cholesky` | `formalization/lean (file by file)` | open | `sorryAx` |
| `Unified.Coupling.Certificate.symmetric_from_cholesky` | `formalization/lean (file by file)` | open | `sorryAx` |
| `Unified.unification` | `formalization/lean (file by file)` | conditional | `Unified.bridge_BSD`, `Unified.bridge_Hodge`, `Unified.bridge_NS`, `Unified.bridge_PNP`, `Unified.bridge_RH`, `Unified.bridge_YM` |
| `Unified.Problems.BSD.refined_implies_classical` | `formalization/lean (file by file)` | open | `sorryAx` |
| `Unified.Problems.Hodge.refined_implies_classical` | `formalization/lean (file by file)` | open | `sorryAx` |
| `Unified.Problems.NS.refined_implies_classical` | `formalization/lean (file by file)` | open | `sorryAx` |
| `Unified.Problems.PNP.refined_implies_classical` | `formalization/lean (file by file)` | open | `sorryAx` |
| `Unified.Problems.RH.RH_at_canonical` | `formalization/lean (file by file)` | open | `sorryAx` |
| `Unified.Problems.RH.refined_implies_classical` | `formalization/lean (file by file)` | open | `sorryAx` |
| `Unified.Problems.YM.refined_implies_classical` | `formalization/lean (file by file)` | open | `sorryAx` |
| `UniversalisStructuralis.MillenniumProblems.NavierStokes_LRE_equivalence` | `formalization/lean (file by file)` | open | `sorryAx` |
| `BSD.LocalLemmas.κ_BSD_positive` | `proofs/bsd_conjecture (file by file)` | open | `sorryAx` |
| `BSD.LocalLemmas.rank_equals_analytic_rank` | `proofs/bsd_conjecture (file by file)` | open | `sorryAx`, `BSD.Foundations.EllipticCurve`, `BSD.Foundations.Rank` |
| `BSD.StructuralBridge.bridge_ranks_to_curvature` | `proofs/bsd_conjecture (file by file)` | open | `sorryAx`, `BSD.Foundations.EllipticCurve`, `BSD.Foundations.Rank` |
| `BSD.Reduction.main_reduction` | `proofs/bsd_conjecture (file by file)` | open | `sorryAx`, `BSD.Foundations.EllipticCurve`, `BSD.Foundations.Rank` |
| `Hodge.LocalLemmas.κ_Hodge_positive` | `proofs/hodge_conjecture (file by file)` | open | `sorryAx` |
| `Hodge.StructuralBridge.bridge_hodge_to_curvature` | `proofs/hodge_conjecture (file by file)` | open | `sorryAx`, `Hodge.Foundations.AlgebraicVariety` |
| `YangMills.LocalLemmas.κ_YM_positive` | `proofs/yang_mills (file by file)` | open | `sorryAx` |
| `YangMills.LocalLemmas.mass_gap_positive` | `proofs/yang_mills (file by file)` | open | `sorryAx` |
| `YangMills.StructuralBridge.bridge_mass_gap_to_curvature` | `proofs/yang_mills (file by file)` | open | `sorryAx` |
| `YangMills.Reduction.main_reduction` | `proofs/yang_mills (file by file)` | open | `sorryAx` |
| `EmergentTheta.RH_from_universal_theta` | `src/lean (file by file)` | open | `EmergentTheta.zeta`, `sorryAx` |
| `ErrorAggregation.aggregate_nonneg` | `universe00 (file by file)` | open | `sorryAx` |
| `ErrorAggregation.aggregate_le_hundred` | `universe00 (file by file)` | open | `sorryAx` |
| `ErrorAggregation.aggregate_zero_of_proven` | `universe00 (file by file)` | open | `sorryAx` |
| `ErrorAggregation.proven_of_aggregate_zero` | `universe00 (file by file)` | open | `sorryAx` |
| `ErrorAggregation.aggregate_monotone` | `universe00 (file by file)` | open | `sorryAx` |
| `Universe00.Core.Aggregation.weightedSum_bounds` | `universe00 (file by file)` | open | `sorryAx` |
| `Universe00.Core.Aggregation.uniform_weights_valid` | `universe00 (file by file)` | open | `sorryAx` |
| `Universe00.Core.ErrorVector.maxError_bounds` | `universe00 (file by file)` | open | `sorryAx` |
| `Universe00.Core.ErrorVector.minError_bounds` | `universe00 (file by file)` | open | `sorryAx` |
| `ErrorVector.proven_iff_norm_zero` | `universe00 (file by file)` | open | `sorryAx` |
| `ErrorVector.refines_refl` | `universe00 (file by file)` | open | `sorryAx` |
| `ErrorVector.refines_trans` | `universe00 (file by file)` | open | `sorryAx` |

### Declared theorems

The `.lean` files of the verified commit declare 1 369 `theorem`/`lemma` (counting copies). The kernel checked 159 of them (36 closed, 1 conditional, 122 open). The closed count in the table above is larger: it also counts the theorems Lean generates by itself (equation lemmas, structure fields, `deriving`), which are not written in the text. For 1 210 the kernel has no result:

| Reason | Theorems |
|---|---:|
| checked file by file: Lean did not reach the theorem (missing import, syntax error or timeout) | 1 097 |
| checked file by file: the written proof does not pass the kernel | 113 |

### MVEI corrections

* `correcoes/imports-no-topo.patch` (import fora do início do arquivo, 37 file(s)): applies to the published sources: `git apply -p1 --directory=imports/universal-emergent-logic- mvei/universal-emergent-logic-/correcoes/imports-no-topo.patch` (in order, after the ones above)
* `correcoes/renomear-imports-mathlib.patch` (import de módulo que não existe na versão do Mathlib do projeto (renomeado ou dividido), 61 file(s)): applies to the published sources: `git apply -p1 --directory=imports/universal-emergent-logic- mvei/universal-emergent-logic-/correcoes/renomear-imports-mathlib.patch` (in order, after the ones above)
* `correcoes/tatica-encontrada.patch` (prova que não passava (ou axioma) que uma tática padrão fecha no kernel, 1 file(s)): applies to the published sources: `git apply -p1 --directory=imports/universal-emergent-logic- mvei/universal-emergent-logic-/correcoes/tatica-encontrada.patch` (in order, after the ones above)
* `correcoes/vocabulario-lean4.patch` (grafia que o Lean 4 não lê (nome acentuado, λ/Σ/Π como nome, ∀ x y ∈ s, docstring solta, constant, tática do Mathlib sem import), 216 file(s)): applies to the published sources: `git apply -p1 --directory=imports/universal-emergent-logic- mvei/universal-emergent-logic-/correcoes/vocabulario-lean4.patch` (in order, after the ones above)

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
