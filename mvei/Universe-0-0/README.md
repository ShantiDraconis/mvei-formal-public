# MVEI kernel check — Universe-0-0

This folder records what the Lean 4 kernel said about the Lean sources of the private repository `ShantiDraconis/Universe-0-0`. The sources are published in [`imports/Universe-0-0/`](../../imports/Universe-0-0/).

## What is published

* Source: `ShantiDraconis/Universe-0-0`, commit `ad86336840111095220c61c09ffe0dabeedb9447` (2026-09-18T09:52:41Z).
* 57 files: 57 `.lean` files and the Lake files (`lakefile.*`, `lean-toolchain`, `lake-manifest.json`). Paths are the same as in the source repository.
* Nothing else from the private repository is published (documents, commercial license, prompts, storefront material).
* `SOURCES.sha256` lists every published file with its SHA-256. From the repository root: `sha256sum -c mvei/Universe-0-0/SOURCES.sha256`.

## What the kernel said

MVEI verification of 2026-11-05T15:19:16+00:00, on commit `ad86336840111095220c61c09ffe0dabeedb9447`. Each theorem was read with `Lean.collectAxioms`, the function behind `#print axioms`.

| Lean project | Lean version | Build | Closed | Conditional | Open (`sorry`) | Checked file by file: closed / conditional / open / proof error / not reached |
|---|---|---|---:|---:|---:|---|
| `provers/lean` (no lakefile; project assembled by MVEI) | v4.19.0 | partial | 33 | 1 | 3 | 62 / 32 / 92 / 34 / 41 |
| `universe-00/applications/millennium/riemann` (no lakefile; project assembled by MVEI) | padrão do elan | failed | 0 | 0 | 0 | 0 / 0 / 4 / 0 / 8 |
| `universe-00/applications/unified-field-theory/proofs` (no lakefile; project assembled by MVEI) | padrão do elan | failed | 0 | 0 | 0 | 7 / 1 / 30 / 21 / 46 |
| `universe-00/core/lean` (no lakefile; project assembled by MVEI) | padrão do elan | failed | 0 | 0 | 0 | 0 / 0 / 2 / 0 / 7 |

| Closed theorems in this repository | |
|---|---:|
| Counting each project | 102 |
| Unique (name + statement) | 102 |
| Unique, without the lemmas Lean generates itself (`eq_1`, `mk.inj`, `sizeOf_spec`, `deriving`) | 83 |

*Closed* means the kernel accepted the proof and it depends only on `propext`, `Classical.choice` and `Quot.sound`. It says that the statement as written in the file is proved; it does not say that an open problem is solved. Every statement is in `VERIFICACAO.json`. *Conditional* means the proof also uses axioms declared in the repository; *open* means it uses `sorry`. *Checked file by file* covers the files that no build reached: each one went through Lean whole, with a `#print axioms` for each theorem.

| Theorem | Project | State | Axioms beyond the standard three |
|---|---|---|---|
| `Millennium.RiemannHypothesis.RiemannHypothesis_CriticalStrip` | `provers/lean` | open | `sorryAx` |
| `SorrySingularity.prova_do_comportamento_real` | `provers/lean` | open | `SorrySingularity.Architecture`, `SorrySingularity.Architecture.is_expanding`, `sorryAx` |
| `SorrySingularity.sorry_external` | `provers/lean` | open | `SorrySingularity.I`, `sorryAx` |
| `SorrySingularity.twelve_tribes_preservation` | `provers/lean` | conditional | `SorrySingularity.I`, `SorrySingularity.sorry_is_singularity` |
| `Universe00.Complexity.P_subset_NP` | `provers/lean (file by file)` | open | `sorryAx` |
| `Universe00.Complexity.SAT_is_NPC` | `provers/lean (file by file)` | open | `sorryAx` |
| `Universe00.Complexity.ThreeSAT_is_NPC` | `provers/lean (file by file)` | open | `sorryAx` |
| `Universe00.Complexity.P_neq_NP_means_hard_problems` | `provers/lean (file by file)` | open | `sorryAx` |
| `Universe00.Complexity.P_eq_NP_means_all_efficient` | `provers/lean (file by file)` | open | `sorryAx` |
| `Universe00.Complexity.P_eq_NP_implies_NP_eq_coNP` | `provers/lean (file by file)` | open | `sorryAx` |
| `Universe00.Complexity.verification_easier_than_search` | `provers/lean (file by file)` | open | `sorryAx` |
| `Universe00.Complexity.Clique_is_NPC` | `provers/lean (file by file)` | open | `sorryAx` |
| `Universe00.Core.infinite_authority` | `provers/lean (file by file)` | conditional | `Universe00.Core.primary_orcid` |
| `Universe00.Core.all_blocks_verified` | `provers/lean (file by file)` | conditional | `Universe00.Core.primary_orcid` |
| `Universe00.Core.orcid_identifies_author` | `provers/lean (file by file)` | open | `sorryAx`, `Universe00.Core.primary_orcid` |
| `Universe00.FluidDynamics.local_existence` | `provers/lean (file by file)` | open | `sorryAx`, `Universe00.FluidDynamics.ν` |
| `Universe00.FluidDynamics.global_regularity_consequence` | `provers/lean (file by file)` | open | `sorryAx`, `Universe00.FluidDynamics.ν` |
| `Universe00.FluidDynamics.energy_estimate` | `provers/lean (file by file)` | open | `sorryAx`, `Universe00.FluidDynamics.ν` |
| `Universe00.FluidDynamics.BKM_criterion` | `provers/lean (file by file)` | open | `sorryAx` |
| `Universe00.FluidDynamics.prodi_serrin_conditions` | `provers/lean (file by file)` | open | `sorryAx` |
| `Universe00.FluidDynamics.weak_solution_exists` | `provers/lean (file by file)` | open | `sorryAx` |
| `Universe00.FluidDynamics.weak_implies_smooth_question` | `provers/lean (file by file)` | open | `sorryAx` |
| `Universe00.Foundations.Distinction.i_ne_one` | `provers/lean (file by file)` | conditional | `Universe00.Foundations.IConst`, `Universe00.Foundations.Distinction.i_ne_complex` |
| `Universe00.Foundations.Distinction.absolute_distinction_immutable` | `provers/lean (file by file)` | conditional | `Universe00.Foundations.IConst`, `Universe00.Foundations.Distinction.i_ne_complex` |
| `Universe00.Foundations.Distinction.reflexive_identity` | `provers/lean (file by file)` | conditional | `Universe00.Foundations.IConst` |
| `Universe00.Foundations.Distinction.one_equals_one` | `provers/lean (file by file)` | conditional | `Universe00.Foundations.IConst` |
| `Universe00.Foundations.Distinction.i_equals_i` | `provers/lean (file by file)` | conditional | `Universe00.Foundations.IConst` |
| `Universe00.Foundations.Distinction.identity_exact` | `provers/lean (file by file)` | conditional | `Universe00.Foundations.IConst` |
| `Universe00.Foundations.Distinction.i_not_ne_itself` | `provers/lean (file by file)` | conditional | `Universe00.Foundations.IConst` |
| `Universe00.Foundations.Distinction.one_not_ne_itself` | `provers/lean (file by file)` | conditional | `Universe00.Foundations.IConst` |
| `Universe00.Foundations.Distinction.self_distinction_contradicts_reflexivity` | `provers/lean (file by file)` | conditional | `Universe00.Foundations.IConst` |
| `Universe00.Foundations.Distinction.master_reconciliation` | `provers/lean (file by file)` | conditional | `Universe00.Foundations.IConst`, `Universe00.Foundations.Distinction.i_ne_complex` |
| `Universe00.Foundations.Distinction.i_ne_i_implies_inconsistency` | `provers/lean (file by file)` | conditional | `Universe00.Foundations.IConst` |
| `Universe00.Foundations.Distinction.one_ne_one_implies_inconsistency` | `provers/lean (file by file)` | conditional | `Universe00.Foundations.IConst` |
| `Universe00.Foundations.Distinction.interpret_one_ne_one` | `provers/lean (file by file)` | conditional | `Universe00.Foundations.IConst` |
| `Universe00.Foundations.Distinction.interpret_i_ne_i` | `provers/lean (file by file)` | conditional | `Universe00.Foundations.IConst` |
| `Universe00.Foundations.Distinction.interpret_i_ne_one` | `provers/lean (file by file)` | conditional | `Universe00.Foundations.IConst`, `Universe00.Foundations.Distinction.i_ne_complex` |
| `Universe00.Foundations.Distinction.statement_interpretation` | `provers/lean (file by file)` | conditional | `Universe00.Foundations.IConst` |
| `Universe00.Foundations.Distinction.correct_fundamental_axiom` | `provers/lean (file by file)` | conditional | `Universe00.Foundations.IConst`, `Universe00.Foundations.Distinction.i_ne_complex` |
| `Universe00.Foundations.Distinction.framework_consistency` | `provers/lean (file by file)` | conditional | `Universe00.Foundations.IConst`, `Universe00.Foundations.Distinction.i_ne_complex` |
| `Universe00.Foundations.Impossibility.ExtendedNumber.i_equals_zero_div_zero` | `provers/lean (file by file)` | open | `sorryAx` |
| `Universe00.Foundations.complex_embedding` | `provers/lean (file by file)` | conditional | `Universe00.Foundations.IConst` |
| `Universe00.Foundations.complex_is_critical` | `provers/lean (file by file)` | conditional | `Universe00.Foundations.IConst` |
| `Universe00.Foundations.numeric_classes_partition` | `provers/lean (file by file)` | conditional | `Universe00.Foundations.IConst` |
| `Universe00.Foundations.classes_mutually_exclusive` | `provers/lean (file by file)` | conditional | `Universe00.Foundations.IConst` |
| `Universe00.Foundations.complex_critical` | `provers/lean (file by file)` | conditional | `Universe00.Foundations.IConst` |
| `Universe00.Foundations.i_collapsed` | `provers/lean (file by file)` | conditional | `Universe00.Foundations.IConst` |
| `Universe00.Foundations.delta_i` | `provers/lean (file by file)` | open | `sorryAx`, `Universe00.Foundations.IConst`, `Universe00.Foundations.delta_idempotent`, `Universe00.Foundations.delta_operator_exists` |
| `Universe00.Foundations.RiemannHypothesis.phase_interference_lemma` | `provers/lean (file by file)` | open | `sorryAx`, `Universe00.Foundations.IConst` |
| `Universe00.Foundations.RiemannHypothesis.delta_collapse` | `provers/lean (file by file)` | open | `sorryAx`, `Universe00.Foundations.IConst` |
| `Universe00.Foundations.RiemannHypothesis.riemann_hypothesis_collapse` | `provers/lean (file by file)` | open | `sorryAx`, `Universe00.Foundations.IConst`, `Universe00.Foundations.RiemannHypothesis.I_ne_1` |
| `Universe00.Foundations.RiemannHypothesis.rh_equivalence` | `provers/lean (file by file)` | open | `sorryAx`, `Universe00.Foundations.IConst` |
| `Universe00.Foundations.RiemannHypothesis.prime_number_theorem_error` | `provers/lean (file by file)` | open | `sorryAx` |
| `Universe00.Foundations.RiemannHypothesis.rh_quantum_interpretation` | `provers/lean (file by file)` | open | `sorryAx` |
| `Universe00.Foundations.RiemannHypothesis.consistency_with_computation` | `provers/lean (file by file)` | open | `sorryAx`, `Universe00.Foundations.IConst`, `Universe00.Foundations.RiemannHypothesis.I_ne_1` |
| `Universe00.Foundations.RiemannHypothesis.strengthens_hardy` | `provers/lean (file by file)` | open | `sorryAx`, `Universe00.Foundations.IConst`, `Universe00.Foundations.RiemannHypothesis.I_ne_1` |
| `Universe00.StructuralResidue.problem_I_correspondence` | `provers/lean (file by file)` | open | `sorryAx`, `Universe00.StructuralResidue.I` |
| `LA2028.LA2028_scheduling_complexity` | `provers/lean (file by file)` | open | `sorryAx` |
| `LA2028.Security.RH_implies_factoring_lower_bound` | `provers/lean (file by file)` | open | `sorryAx`, `LA2028.Security.RiemannHypothesis` |
| `LA2028.Security.LA2028_key_size_adequate` | `provers/lean (file by file)` | open | `sorryAx`, `LA2028.Security.RiemannHypothesis` |
| `LA2028.Security.hybrid_system_secure` | `provers/lean (file by file)` | open | `sorryAx`, `LA2028.Security.RiemannHypothesis` |
| `LA2028.Security.LA2028_scalability` | `provers/lean (file by file)` | open | `sorryAx` |
| `LA2028.Security.LA2028_security_validated` | `provers/lean (file by file)` | open | `sorryAx`, `LA2028.Security.RiemannHypothesis` |
| `non_trivial_kernel_implies_residue` | `provers/lean (file by file)` | open | `sorryAx` |
| `i_phase_properties` | `provers/lean (file by file)` | open | `sorryAx` |
| `LA2028.Linker.LA2028_traffic_feasible` | `provers/lean (file by file)` | open | `sorryAx`, `LA2028.Linker.NavierStokes_Solution`, `LA2028.Linker.TransportPlan`, `LA2028.Linker.efficient_plan`, `LA2028.Linker.is_smooth` |
| `Millennium.Complexity.P_neq_NP_implies_NPComplete_not_in_P` | `provers/lean (file by file)` | open | `sorryAx` |
| `Universe00.RHGeometry.TransitionOperator.distance_metric_nonneg` | `provers/lean (file by file)` | open | `sorryAx` |
| `Universe00.RHGeometry.TransitionOperator.distance_metric_pos` | `provers/lean (file by file)` | open | `sorryAx` |
| `Universe00.RHGeometry.TransitionOperator.apply_toward_critical_line` | `provers/lean (file by file)` | open | `sorryAx` |
| `Universe00.RHGeometry.DualZeroStates.inverse_magnitude_grows` | `provers/lean (file by file)` | open | `sorryAx` |
| `Universe00.RHGeometry.DualZeroStates.inverse_phase_preserved` | `provers/lean (file by file)` | open | `sorryAx` |
| `Universe00.RHGeometry.triangle_inequality` | `provers/lean (file by file)` | open | `sorryAx` |
| `Universe00.RHGeometry.dual_zeros_same_singularity` | `provers/lean (file by file)` | open | `sorryAx` |
| `Universe00.RHGeometry.FlowTensor.row_sum_preserved_under_permute` | `provers/lean (file by file)` | open | `sorryAx` |
| `Universe00.RHGeometry.FlowTensor.col_sum_preserved_under_permute` | `provers/lean (file by file)` | open | `sorryAx` |
| `Universe00.RHGeometry.FlowTensor.conservation_preserved` | `provers/lean (file by file)` | open | `sorryAx` |
| `Universe00.RHGeometry.FlowTensor.completely_invariant_uniform_diagonal` | `provers/lean (file by file)` | open | `sorryAx` |
| `Universe00.RHGeometry.NetworkTopology.fully_connected_max_score` | `provers/lean (file by file)` | open | `sorryAx` |
| `Universe00.RHGeometry.NetworkStability.stability_bounded` | `provers/lean (file by file)` | open | `sorryAx` |
| `Riemann.zero_classification` | `provers/lean (file by file)` | conditional | `Riemann.ζ` |
| `Riemann.critical_anomalous_exclusive` | `provers/lean (file by file)` | conditional | `Riemann.ζ` |
| `Riemann.RH_from_I_axiom` | `provers/lean (file by file)` | conditional | `Riemann.I`, `Riemann.I_ne_one`, `Riemann.collapse_axiom`, `Riemann.ζ` |
| `RiemannHypothesis.riemann_hypothesis` | `provers/lean (file by file)` | open | `sorryAx`, `RiemannHypothesis.collapse_trigger`, `RiemannHypothesis.i_neq_one`, `Universe00.Foundations.IConst`, `Universe00.Foundations.delta_operator_exists` |
| `RiemannHypothesis.no_anomalous_zeros` | `provers/lean (file by file)` | open | `sorryAx`, `RiemannHypothesis.collapse_trigger`, `RiemannHypothesis.i_neq_one`, `Universe00.Foundations.IConst`, `Universe00.Foundations.delta_operator_exists` |
| `RiemannHypothesis.i_in_unit_interval` | `provers/lean (file by file)` | open | `sorryAx` |
| `RiemannHypothesis.i_nonneg` | `provers/lean (file by file)` | open | `sorryAx` |
| `RiemannHypothesis.i_le_one` | `provers/lean (file by file)` | open | `sorryAx` |
| `RiemannHypothesis.phase_trichotomy` | `provers/lean (file by file)` | open | `sorryAx` |
| `RiemannHypothesis.coherent_not_anomalous` | `provers/lean (file by file)` | open | `sorryAx` |
| `RiemannHypothesis.anomalous_not_collapsed` | `provers/lean (file by file)` | open | `sorryAx` |
| `RiemannHypothesis.coherent_not_collapsed` | `provers/lean (file by file)` | open | `sorryAx` |
| `RiemannHypothesis.not_collapsed` | `provers/lean (file by file)` | open | `sorryAx`, `RiemannHypothesis.i_neq_one` |
| `RiemannHypothesis.coherent_or_anomalous` | `provers/lean (file by file)` | open | `sorryAx`, `RiemannHypothesis.i_neq_one` |
| `RiemannHypothesis.dampingFactor_ne_zero` | `provers/lean (file by file)` | open | `sorryAx` |
| `RiemannHypothesis.dampingFactor_bounded` | `provers/lean (file by file)` | open | `sorryAx` |
| `RiemannHypothesis.InfiniteFrequency.zero_duality_refutation` | `provers/lean (file by file)` | open | `sorryAx` |
| `RiemannHypothesis.InfiniteFrequency.rh_as_circular_circuit` | `provers/lean (file by file)` | open | `sorryAx` |
| `RiemannHypothesis.InfiniteFrequency.load_distribution_optimal` | `provers/lean (file by file)` | open | `sorryAx` |
| `RiemannHypothesis.zeta_I_classical_limit` | `provers/lean (file by file)` | open | `sorryAx` |
| `RiemannHypothesis.zeta_I_nonzero_of_zeta_nonzero` | `provers/lean (file by file)` | open | `sorryAx` |
| `RiemannHypothesis.damping_preserves_symmetry` | `provers/lean (file by file)` | open | `sorryAx` |
| `RiemannHypothesis.RH_critical_line_version` | `provers/lean (file by file)` | open | `sorryAx` |
| `RiemannHypothesis.RH_no_zeros_off_line` | `provers/lean (file by file)` | open | `sorryAx` |
| `RiemannHypothesis.RH_no_anomalous_zeros` | `provers/lean (file by file)` | open | `sorryAx` |
| `RiemannHypothesis.critical_strip_equals_critical_line` | `provers/lean (file by file)` | open | `sorryAx` |
| `S5.Kernel.i_idempotent` | `provers/lean (file by file)` | conditional | `S5.Kernel.IConstant`, `S5.Kernel.i_squared_eq_i` |
| `S5.Kernel.i_distinct` | `provers/lean (file by file)` | conditional | `S5.Kernel.IConstant`, `S5.Kernel.i_nonone`, `S5.Kernel.i_nonzero` |
| `S5.Kernel.frequency_alignment_symmetric` | `provers/lean (file by file)` | open | `sorryAx` |
| `S5.Kernel.div_zero_eq_i` | `provers/lean (file by file)` | conditional | `S5.Kernel.IConstant` |
| `UncertaintyProtection.system_inviability` | `provers/lean (file by file)` | open | `sorryAx` |
| `UncertaintyProtection.positive_entropy` | `provers/lean (file by file)` | open | `sorryAx` |
| `UncertaintyProtection.protection_bounded` | `provers/lean (file by file)` | open | `sorryAx` |
| `spectrum_is_real` | `provers/lean (file by file)` | open | `sorryAx` |
| `fredholm_essential_spectrum` | `provers/lean (file by file)` | open | `sorryAx` |
| `riemann_hypothesis` | `provers/lean (file by file)` | open | `sorryAx`, `LogicCorrelationOperator.riemannZeta` |
| `spectral_entropy_circuit_complexity` | `provers/lean (file by file)` | open | `sorryAx` |
| `riemann_resonances` | `provers/lean (file by file)` | open | `sorryAx`, `LogicCorrelationOperator.riemannZeta` |
| `yang_mills_gap_evolution` | `provers/lean (file by file)` | open | `sorryAx` |
| `bsd_correlation` | `provers/lean (file by file)` | open | `sorryAx` |
| `hodge_monodromy` | `provers/lean (file by file)` | open | `sorryAx` |
| `Universe00.ZetaFunction.zeta_convergence` | `provers/lean (file by file)` | open | `sorryAx` |
| `Universe00.ZetaFunction.zeta_pole_at_one` | `provers/lean (file by file)` | open | `sorryAx` |
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
| `UFTHamiltonian.kinetic_energy_nonneg` | `universe-00/applications/unified-field-theory/proofs (file by file)` | open | `sorryAx` |
| `UFTHamiltonian.potential_convex_at_minimum` | `universe-00/applications/unified-field-theory/proofs (file by file)` | open | `sorryAx` |
| `UFTHamiltonian.hamiltonian_self_adjoint` | `universe-00/applications/unified-field-theory/proofs (file by file)` | open | `sorryAx` |
| `UFTHamiltonian.hamiltonian_bounded_below` | `universe-00/applications/unified-field-theory/proofs (file by file)` | open | `sorryAx` |
| `UFTHamiltonian.ground_state_exists` | `universe-00/applications/unified-field-theory/proofs (file by file)` | open | `sorryAx` |
| `UFTHamiltonian.ground_state_unique` | `universe-00/applications/unified-field-theory/proofs (file by file)` | open | `sorryAx` |
| `UFTHamiltonian.first_excited_energy` | `universe-00/applications/unified-field-theory/proofs (file by file)` | open | `sorryAx` |
| `UFTHamiltonian.time_evolution_unitary` | `universe-00/applications/unified-field-theory/proofs (file by file)` | open | `sorryAx` |
| `UFTHamiltonian.ground_state_stationary` | `universe-00/applications/unified-field-theory/proofs (file by file)` | open | `sorryAx` |
| `UFTHamiltonian.ground_state_solves_all` | `universe-00/applications/unified-field-theory/proofs (file by file)` | open | `sorryAx` |
| `UFTOperators.ns_operator_bounds_energy` | `universe-00/applications/unified-field-theory/proofs (file by file)` | open | `sorryAx` |
| `UFTOperators.ym_mass_gap_numerical` | `universe-00/applications/unified-field-theory/proofs (file by file)` | open | `sorryAx` |
| `UFTOperators.operators_are_coupled` | `universe-00/applications/unified-field-theory/proofs (file by file)` | open | `sorryAx` |
| `UFTOperators.coupling_antisymmetric` | `universe-00/applications/unified-field-theory/proofs (file by file)` | open | `sorryAx` |
| … 15 more in `VERIFICACAO.json` and `TEOREMAS.csv` | | | |

### Declared theorems

The `.lean` files of the verified commit declare 396 `theorem`/`lemma` (counting copies). The kernel checked 234 of them (69 closed, 34 conditional, 131 open). The closed count in the table above is larger: it also counts the theorems Lean generates by itself (equation lemmas, structure fields, `deriving`), which are not written in the text. For 162 the kernel has no result:

| Reason | Theorems |
|---|---:|
| checked file by file: Lean did not reach the theorem (missing import, syntax error or timeout) | 102 |
| checked file by file: the written proof does not pass the kernel | 54 |
| the file did not compile (an error in it or in a file it imports) | 6 |

### MVEI corrections

* `correcoes/a-arquivos-corrompidos.patch` (arquivo corrompido no repositório (merge add/add resolvido aceitando os dois lados: linhas das duas versões intercaladas), 2 file(s)): applies to the published sources: `git apply -p1 --directory=imports/Universe-0-0 mvei/Universe-0-0/correcoes/a-arquivos-corrompidos.patch` (in order, after the ones above)
* `correcoes/imports-no-topo.patch` (import fora do início do arquivo, 6 file(s)): applies to the published sources: `git apply -p1 --directory=imports/Universe-0-0 mvei/Universe-0-0/correcoes/imports-no-topo.patch` (in order, after the ones above)
* `correcoes/renomear-imports-mathlib.patch` (import de módulo que não existe na versão do Mathlib do projeto (renomeado ou dividido), 10 file(s)): applies to the published sources: `git apply -p1 --directory=imports/Universe-0-0 mvei/Universe-0-0/correcoes/renomear-imports-mathlib.patch` (in order, after the ones above)
* `correcoes/tatica-encontrada.patch` (prova que não passava (ou axioma) que uma tática padrão fecha no kernel, 7 file(s)): applies to the published sources: `git apply -p1 --directory=imports/Universe-0-0 mvei/Universe-0-0/correcoes/tatica-encontrada.patch` (in order, after the ones above)
* `correcoes/vocabulario-lean4.patch` (grafia que o Lean 4 não lê (nome acentuado, λ/Σ/Π como nome, ∀ x y ∈ s, docstring solta, constant, tática do Mathlib sem import), 55 file(s)): applies to the published sources: `git apply -p1 --directory=imports/Universe-0-0 mvei/Universe-0-0/correcoes/vocabulario-lean4.patch` (in order, after the ones above)
* `correcoes/z-provas-reparadas.patch` (prova que não passava no kernel (o enunciado fica igual), 21 file(s)): applies to the published sources: `git apply -p1 --directory=imports/Universe-0-0 mvei/Universe-0-0/correcoes/z-provas-reparadas.patch` (in order, after the ones above)
* `correcoes/zy-enunciados-do-autor.patch` (enunciado reescrito a pedido do autor (o original, como escrito, fica registrado), 15 file(s)): applies to the published sources: `git apply -p1 --directory=imports/Universe-0-0 mvei/Universe-0-0/correcoes/zy-enunciados-do-autor.patch` (in order, after the ones above)
* `correcoes/zz-refutacoes.patch` (teorema com enunciado falso como o Lean o lê (o original fica como está), 12 file(s)): applies to the published sources: `git apply -p1 --directory=imports/Universe-0-0 mvei/Universe-0-0/correcoes/zz-refutacoes.patch` (in order, after the ones above)
* `correcoes/zzz-nomes-ligados.patch` (nome usado no arquivo e declarado em outro arquivo do mesmo repositório, sem o import, 1 file(s)): applies to the published sources: `git apply -p1 --directory=imports/Universe-0-0 mvei/Universe-0-0/correcoes/zzz-nomes-ligados.patch` (in order, after the ones above)

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
