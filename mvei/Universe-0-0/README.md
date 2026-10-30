# MVEI kernel check — Universe-0-0

This folder records what the Lean 4 kernel said about the Lean sources of the private repository `ShantiDraconis/Universe-0-0`. The sources are published in [`imports/Universe-0-0/`](../../imports/Universe-0-0/).

## What is published

* Source: `ShantiDraconis/Universe-0-0`, commit `ad86336840111095220c61c09ffe0dabeedb9447` (2026-09-18T09:52:41Z).
* 57 files: 57 `.lean` files and the Lake files (`lakefile.*`, `lean-toolchain`, `lake-manifest.json`). Paths are the same as in the source repository.
* Nothing else from the private repository is published (documents, commercial license, prompts, storefront material).
* `SOURCES.sha256` lists every published file with its SHA-256. From the repository root: `sha256sum -c mvei/Universe-0-0/SOURCES.sha256`.

## What the kernel said

MVEI verification of 2026-10-30T08:01:18+00:00, on commit `ad86336840111095220c61c09ffe0dabeedb9447`. Each theorem was read with `Lean.collectAxioms`, the function behind `#print axioms`.

| Lean project | Lean version | Build | Closed | Conditional | Open (`sorry`) | Checked file by file: closed / conditional / open / proof error / not reached |
|---|---|---|---:|---:|---:|---|
| `provers/lean` (no lakefile; project assembled by MVEI) | v4.19.0 | partial | 17 | 1 | 3 | 22 / 11 / 54 / 72 / 105 |
| `universe-00/applications/millennium/riemann` (no lakefile; project assembled by MVEI) | padrão do elan | failed | 0 | 0 | 0 | 0 / 0 / 4 / 0 / 8 |
| `universe-00/applications/unified-field-theory/proofs` (no lakefile; project assembled by MVEI) | padrão do elan | failed | 0 | 0 | 0 | 1 / 1 / 5 / 23 / 75 |
| `universe-00/core/lean` (no lakefile; project assembled by MVEI) | padrão do elan | failed | 0 | 0 | 0 | 0 / 0 / 2 / 0 / 7 |

| Closed theorems in this repository | |
|---|---:|
| Counting each project | 40 |
| Unique (name + statement) | 40 |
| Unique, without the lemmas Lean generates itself (`eq_1`, `mk.inj`, `sizeOf_spec`, `deriving`) | 30 |

*Closed* means the kernel accepted the proof and it depends only on `propext`, `Classical.choice` and `Quot.sound`. It says that the statement as written in the file is proved; it does not say that an open problem is solved. Every statement is in `VERIFICACAO.json`. *Conditional* means the proof also uses axioms declared in the repository; *open* means it uses `sorry`. *Checked file by file* covers the files that no build reached: each one went through Lean whole, with a `#print axioms` for each theorem.

| Theorem | Project | State | Axioms beyond the standard three |
|---|---|---|---|
| `Millennium.RiemannHypothesis.RiemannHypothesis_CriticalStrip` | `provers/lean` | open | `sorryAx` |
| `SorrySingularity.prova_do_comportamento_real` | `provers/lean` | open | `SorrySingularity.Architecture`, `SorrySingularity.Architecture.is_expanding`, `sorryAx` |
| `SorrySingularity.sorry_external` | `provers/lean` | open | `SorrySingularity.I`, `sorryAx` |
| `SorrySingularity.twelve_tribes_preservation` | `provers/lean` | conditional | `SorrySingularity.I`, `SorrySingularity.sorry_is_singularity` |
| `Universe00.Complexity.SAT_is_NPC` | `provers/lean (file by file)` | open | `sorryAx` |
| `Universe00.Complexity.ThreeSAT_is_NPC` | `provers/lean (file by file)` | open | `sorryAx` |
| `Universe00.Complexity.P_neq_NP_means_hard_problems` | `provers/lean (file by file)` | open | `sorryAx` |
| `Universe00.Complexity.P_eq_NP_means_all_efficient` | `provers/lean (file by file)` | open | `sorryAx` |
| `Universe00.Complexity.P_eq_NP_implies_NP_eq_coNP` | `provers/lean (file by file)` | open | `sorryAx` |
| `Universe00.Complexity.verification_easier_than_search` | `provers/lean (file by file)` | open | `sorryAx` |
| `Universe00.Complexity.Clique_is_NPC` | `provers/lean (file by file)` | open | `sorryAx` |
| `Universe00.Core.infinite_authority` | `provers/lean (file by file)` | conditional | `Universe00.Core.primary_orcid` |
| `Universe00.Core.orcid_identifies_author` | `provers/lean (file by file)` | open | `sorryAx`, `Universe00.Core.primary_orcid` |
| `Universe00.FluidDynamics.BKM_criterion` | `provers/lean (file by file)` | open | `sorryAx` |
| `Universe00.FluidDynamics.prodi_serrin_conditions` | `provers/lean (file by file)` | open | `sorryAx` |
| `Universe00.FluidDynamics.weak_implies_smooth_question` | `provers/lean (file by file)` | open | `sorryAx` |
| `ImpossibilityTheorem.Universe00.Impossibility.field_collapses_with_strong_cancellation` | `provers/lean (file by file)` | open | `sorryAx` |
| `ImpossibilityTheorem.field_collapses_with_strong_cancellation` | `provers/lean (file by file)` | conditional | `ImpossibilityTheorem.div_zero_const` |
| `ImpossibilityTheorem.nontrivial_field_no_strong_cancellation` | `provers/lean (file by file)` | conditional | `ImpossibilityTheorem.div_zero_const` |
| `Universe00.Foundations.Impossibility.ExtendedNumber.i_equals_zero_div_zero` | `provers/lean (file by file)` | open | `sorryAx` |
| `Universe00.Foundations.complex_embedding` | `provers/lean (file by file)` | conditional | `Universe00.Foundations.IConst` |
| `Universe00.Foundations.complex_is_critical` | `provers/lean (file by file)` | conditional | `Universe00.Foundations.IConst` |
| `Universe00.StructuralResidue.problem_I_correspondence` | `provers/lean (file by file)` | open | `sorryAx`, `Universe00.StructuralResidue.I` |
| `LA2028.LA2028_scheduling_complexity` | `provers/lean (file by file)` | open | `sorryAx` |
| `LA2028.Security.RH_implies_factoring_lower_bound` | `provers/lean (file by file)` | open | `sorryAx`, `LA2028.Security.RiemannHypothesis` |
| `LA2028.Security.LA2028_key_size_adequate` | `provers/lean (file by file)` | open | `sorryAx`, `LA2028.Security.RiemannHypothesis` |
| `LA2028.Security.hybrid_system_secure` | `provers/lean (file by file)` | open | `sorryAx`, `LA2028.Security.RiemannHypothesis` |
| `LA2028.Security.LA2028_scalability` | `provers/lean (file by file)` | open | `sorryAx` |
| `LA2028.Security.LA2028_security_validated` | `provers/lean (file by file)` | open | `sorryAx`, `LA2028.Security.RiemannHypothesis` |
| `LRE.ProjectionSystem.residueFree_eq_image` | `provers/lean (file by file)` | open | `sorryAx` |
| `residue_in_kernel` | `provers/lean (file by file)` | open | `sorryAx` |
| `non_trivial_kernel_implies_residue` | `provers/lean (file by file)` | open | `sorryAx` |
| `universal_zero_residue_implies_injective` | `provers/lean (file by file)` | open | `sorryAx` |
| `LA2028.Linker.LA2028_traffic_feasible` | `provers/lean (file by file)` | open | `sorryAx`, `LA2028.Linker.NavierStokes_Solution`, `LA2028.Linker.TransportPlan`, `LA2028.Linker.efficient_plan`, `LA2028.Linker.is_smooth` |
| `Millennium.Complexity.P_neq_NP_implies_NPComplete_not_in_P` | `provers/lean (file by file)` | open | `sorryAx` |
| `Universe00.RHGeometry.TransitionOperator.distance_metric_nonneg` | `provers/lean (file by file)` | open | `sorryAx` |
| `Universe00.RHGeometry.TransitionOperator.distance_metric_pos` | `provers/lean (file by file)` | open | `sorryAx` |
| `Universe00.RHGeometry.TransitionOperator.apply_toward_critical_line` | `provers/lean (file by file)` | open | `sorryAx` |
| `Universe00.RHGeometry.DualZeroStates.inverse_magnitude_grows` | `provers/lean (file by file)` | open | `sorryAx` |
| `Universe00.RHGeometry.triangle_inequality` | `provers/lean (file by file)` | open | `sorryAx` |
| `Universe00.RHGeometry.dual_zeros_same_singularity` | `provers/lean (file by file)` | open | `sorryAx` |
| `Universe00.RHGeometry.FlowTensor.row_sum_preserved_under_permute` | `provers/lean (file by file)` | open | `sorryAx` |
| `Universe00.RHGeometry.FlowTensor.col_sum_preserved_under_permute` | `provers/lean (file by file)` | open | `sorryAx` |
| `Universe00.RHGeometry.FlowTensor.conservation_preserved` | `provers/lean (file by file)` | open | `sorryAx` |
| `Universe00.RHGeometry.FlowTensor.perfect_conservation_score_one` | `provers/lean (file by file)` | open | `sorryAx` |
| `Universe00.RHGeometry.FlowTensor.permute_trans` | `provers/lean (file by file)` | open | `sorryAx` |
| `Universe00.RHGeometry.FlowTensor.completely_invariant_uniform_diagonal` | `provers/lean (file by file)` | open | `sorryAx` |
| `Universe00.RHGeometry.NetworkTopology.fully_connected_max_score` | `provers/lean (file by file)` | open | `sorryAx` |
| `Universe00.RHGeometry.NetworkStability.stability_bounded` | `provers/lean (file by file)` | open | `sorryAx` |
| `Riemann.zero_classification` | `provers/lean (file by file)` | conditional | `Riemann.ζ` |
| `Riemann.critical_anomalous_exclusive` | `provers/lean (file by file)` | conditional | `Riemann.ζ` |
| `Riemann.RH_from_I_axiom` | `provers/lean (file by file)` | conditional | `Riemann.I`, `Riemann.I_ne_one`, `Riemann.collapse_axiom`, `Riemann.ζ` |
| `S5.Kernel.i_idempotent` | `provers/lean (file by file)` | conditional | `S5.Kernel.IConstant`, `S5.Kernel.i_squared_eq_i` |
| `S5.Kernel.i_distinct` | `provers/lean (file by file)` | conditional | `S5.Kernel.IConstant`, `S5.Kernel.i_nonone`, `S5.Kernel.i_nonzero` |
| `S5.Kernel.frequency_alignment_symmetric` | `provers/lean (file by file)` | open | `sorryAx` |
| `S5.Kernel.div_zero_eq_i` | `provers/lean (file by file)` | conditional | `S5.Kernel.IConstant` |
| `UncertaintyProtection.system_inviability` | `provers/lean (file by file)` | open | `sorryAx` |
| `UncertaintyProtection.positive_entropy` | `provers/lean (file by file)` | open | `sorryAx` |
| `UncertaintyProtection.protection_bounded` | `provers/lean (file by file)` | open | `sorryAx` |
| `spectrum_is_real` | `provers/lean (file by file)` | open | `sorryAx` |
| `fredholm_essential_spectrum` | `provers/lean (file by file)` | open | `sorryAx` |
| `Universe00.ZetaFunction.zeta_convergence` | `provers/lean (file by file)` | open | `sorryAx` |
| `Universe00.ZetaFunction.zeta_pole_at_one` | `provers/lean (file by file)` | open | `sorryAx` |
| `Universe00.ZetaFunction.functional_equation_zeros` | `provers/lean (file by file)` | open | `sorryAx` |
| `Universe00.ZetaFunction.critical_line_symmetry` | `provers/lean (file by file)` | open | `sorryAx` |
| `Universe00.ZetaFunction.zero_symmetry` | `provers/lean (file by file)` | open | `sorryAx` |
| `Universe00.ZetaFunction.zeta_analytic_critical_strip` | `provers/lean (file by file)` | open | `sorryAx` |
| `Universe00.ZetaFunction.zeros_isolated` | `provers/lean (file by file)` | open | `sorryAx` |
| `Universe00.ZetaFunction.vertical_strip_bound` | `provers/lean (file by file)` | open | `sorryAx` |
| `Millennium.Riemann.IdentityEmergence.finite_approximation_not_exact` | `universe-00/applications/millennium/riemann (file by file)` | open | `sorryAx`, `Millennium.Riemann.IdentityEmergence.π` |
| `Millennium.Riemann.IdentityEmergence.limit_is_exact_one` | `universe-00/applications/millennium/riemann (file by file)` | open | `sorryAx`, `Millennium.Riemann.IdentityEmergence.π` |
| `Millennium.Riemann.riemann_via_rh_collapse` | `universe-00/applications/millennium/riemann (file by file)` | open | `sorryAx`, `Universe00.collapse_law_C1`, `Universe00.delta_collapse` |
| `Millennium.Riemann.critical_line_is_C_crit` | `universe-00/applications/millennium/riemann (file by file)` | open | `sorryAx` |
| `AxiomaticFoundations.no_block_decomposition` | `universe-00/applications/unified-field-theory/proofs (file by file)` | open | `sorryAx`, `AxiomaticFoundations.prime_coupling_dimension` |
| `AxiomaticFoundations.finite_approximation` | `universe-00/applications/unified-field-theory/proofs (file by file)` | open | `sorryAx`, `AxiomaticFoundations.H_adelic` |
| `UFTAxioms.ground_state_energy_zero` | `universe-00/applications/unified-field-theory/proofs (file by file)` | open | `sorryAx` |
| `UFTAxioms.spectral_gap_exists` | `universe-00/applications/unified-field-theory/proofs (file by file)` | conditional | `UFTAxioms.axiom_A7` |
| `UniversalUnificationOperator.spectral_decomposition` | `universe-00/applications/unified-field-theory/proofs (file by file)` | open | `sorryAx` |
| `UniversalUnificationOperator.ground_state_exists` | `universe-00/applications/unified-field-theory/proofs (file by file)` | open | `sorryAx` |
| `Universe00.zero_div_zero_is_I` | `universe-00/core/lean (file by file)` | open | `sorryAx`, `Universe00.div_I` |
| `Universe00.collapse_irreversible` | `universe-00/core/lean (file by file)` | open | `sorryAx`, `Universe00.delta_collapse` |

### Declared theorems

The `.lean` files of the verified commit declare 396 `theorem`/`lemma` (counting copies). The kernel checked 106 of them (25 closed, 13 conditional, 68 open). The closed count in the table above is larger: it also counts the theorems Lean generates by itself (equation lemmas, structure fields, `deriving`), which are not written in the text. For 290 the kernel has no result:

| Reason | Theorems |
|---|---:|
| checked file by file: Lean did not reach the theorem (missing import, syntax error or timeout) | 195 |
| checked file by file: the written proof does not pass the kernel | 95 |

### MVEI corrections

* `correcoes/imports-no-topo.patch` (import fora do início do arquivo, 6 file(s)): applies to the published sources: `git apply -p1 --directory=imports/Universe-0-0 mvei/Universe-0-0/correcoes/imports-no-topo.patch` (in order, after the ones above)
* `correcoes/renomear-imports-mathlib.patch` (import de módulo que não existe na versão do Mathlib do projeto (renomeado ou dividido), 10 file(s)): applies to the published sources: `git apply -p1 --directory=imports/Universe-0-0 mvei/Universe-0-0/correcoes/renomear-imports-mathlib.patch` (in order, after the ones above)
* `correcoes/tatica-encontrada.patch` (prova que não passava (ou axioma) que uma tática padrão fecha no kernel, 4 file(s)): applies to the published sources: `git apply -p1 --directory=imports/Universe-0-0 mvei/Universe-0-0/correcoes/tatica-encontrada.patch` (in order, after the ones above)
* `correcoes/vocabulario-lean4.patch` (grafia que o Lean 4 não lê (nome acentuado, λ/Σ/Π como nome, ∀ x y ∈ s, docstring solta, constant, tática do Mathlib sem import), 55 file(s)): applies to the published sources: `git apply -p1 --directory=imports/Universe-0-0 mvei/Universe-0-0/correcoes/vocabulario-lean4.patch` (in order, after the ones above)
* `correcoes/z-provas-reparadas.patch` (prova que não passava no kernel (o enunciado fica igual), 1 file(s)): applies to the published sources: `git apply -p1 --directory=imports/Universe-0-0 mvei/Universe-0-0/correcoes/z-provas-reparadas.patch` (in order, after the ones above)

## Files in this folder

* `VERIFICACAO.json` — each Lean project of this repository, each theorem the kernel read, its statement, its axioms and its state (`fechado` closed, `condicional` conditional, `aberto-sorry` open)
* `TEOREMAS.csv` — each declared `theorem`/`lemma`: file, line, state in the kernel (`nao_checado` = not checked) and, if not checked, why (in Portuguese)
* `BUILD_LOG.txt` — one block per project: Lean version, result, errors
* `SOURCE.json` — source commit, verified commit and dates, machine-readable
* `SOURCES.sha256` — SHA-256 of every published file

## Reproduce

```
cd imports/Universe-0-0/<project>   # a project folder from the table above ('.' is imports/Universe-0-0)
lake exe cache get           # only for projects that require Mathlib
lake build
```

Each project uses the Lean version in its own `lean-toolchain`, which elan installs. The MVEI pipeline that produced these results is in the author's repository and is not public.
