# Eclectic_S — branch `copilot/add-internal-proof-structure`

Lean sources from the branch `copilot/add-internal-proof-structure` of the private repository `ShantiDraconis/Eclectic_S`, commit `3585ddb9ffb2faae2f74bd7c5c9211bfb8639ea6` (2025-12-29T02:13:58+00:00), that hold theorems found only on branches (no default branch of any repository has a theorem with the same name). Published here: the files with the theorems the kernel closed, the local files they import and the Lake files of their project.

* Branch state: parada (not in the default branch).
* Theorems only on branches, in this branch: 28 — closed 3, conditional 8, open 16, proof error 0, not reached 1, no result 0.
* History: 3 commit(s) of this branch that are not in the default branch, with date and subject, in `certificate.json`.
* `certificate.json` (SHA-256 of its content: `ecb8a0946dc4ebf76dd4c6be7e8d23651ec745978581a60a9ee46e74df4ec206`) lists every theorem with its state and the axioms beyond the standard three, and the SHA-256 of every published file. From the repository root: `sha256sum -c mvei/branches/Eclectic_S/copilot_add-internal-proof-structure/SOURCES.sha256`.

Closed means the kernel accepted the proof and it depends only on `propext`, `Classical.choice` and `Quot.sound`; it proves the statement written in the file and is not a claim that an open problem is solved.

| Theorem | File | State |
|---|---|---|
| `BirchSwinnertonDyer.ConsistencyChecks.mordell_weil_holds` | `ecletics/problems/birch_swinnerton_dyer/consistency_checks.lean`:16 | condicional |
| `BirchSwinnertonDyer.ConsistencyChecks.rank_0_consistent` | `ecletics/problems/birch_swinnerton_dyer/consistency_checks.lean`:39 | condicional |
| `BirchSwinnertonDyer.MainTheorem.bsd_strong_form` | `ecletics/problems/birch_swinnerton_dyer/main_theorem.lean`:26 | aberto-sorry |
| `BirchSwinnertonDyer.MainTheorem.bsd_weak_form` | `ecletics/problems/birch_swinnerton_dyer/main_theorem.lean`:17 | aberto-sorry |
| `HodgeConjecture.ConsistencyChecks.algebraic_is_hodge` | `ecletics/problems/hodge_conjecture/consistency_checks.lean`:16 | condicional |
| `HodgeConjecture.ConsistencyChecks.hodge_decomposition_well_defined` | `ecletics/problems/hodge_conjecture/consistency_checks.lean`:32 | condicional |
| `HodgeConjecture.MainTheorem.hodge_conjecture_statement` | `ecletics/problems/hodge_conjecture/main_theorem.lean`:17 | aberto-sorry |
| `NavierStokes.ConsistencyChecks.energy_finite_preserved` | `ecletics/problems/navier_stokes/consistency_checks.lean`:42 | condicional |
| `NavierStokes.ConsistencyChecks.weak_existence_is_known` | `ecletics/problems/navier_stokes/consistency_checks.lean`:16 | condicional |
| `NavierStokes.MainTheorem.navier_stokes_global_smooth` | `ecletics/problems/navier_stokes/main_theorem.lean`:17 | aberto-sorry |
| `PvsNP.ConsistencyChecks.NPC_implies_in_NP` | `ecletics/problems/p_vs_np/consistency_checks.lean`:40 | aberto-sorry |
| `PvsNP.ConsistencyChecks.NP_well_defined` | `ecletics/problems/p_vs_np/consistency_checks.lean`:64 | fechado |
| `PvsNP.ConsistencyChecks.P_subset_NP_is_trivial` | `ecletics/problems/p_vs_np/consistency_checks.lean`:16 | aberto-sorry |
| `PvsNP.ConsistencyChecks.P_well_defined` | `ecletics/problems/p_vs_np/consistency_checks.lean`:58 | fechado |
| `PvsNP.ConsistencyChecks.not_both` | `ecletics/problems/p_vs_np/consistency_checks.lean`:25 | aberto-sorry |
| `PvsNP.ConsistencyChecks.reduction_well_defined` | `ecletics/problems/p_vs_np/consistency_checks.lean`:65 | fechado |
| `PvsNP.MainTheorem.P_equals_NP_statement` | `ecletics/problems/p_vs_np/main_theorem.lean`:28 | aberto-sorry |
| `PvsNP.MainTheorem.P_neq_NP_via_SAT` | `ecletics/problems/p_vs_np/main_theorem.lean`:36 | aberto-sorry |
| `PvsNP.MainTheorem.P_not_equals_NP_statement` | `ecletics/problems/p_vs_np/main_theorem.lean`:17 | aberto-sorry |
| `RiemannHypothesis.ConsistencyChecks.critical_line_in_strip` | `ecletics/problems/riemann_hypothesis/consistency_checks.lean`:20 | aberto-sorry |
| `RiemannHypothesis.ConsistencyChecks.main_theorem_well_typed` | `ecletics/problems/riemann_hypothesis/consistency_checks.lean`:75 | aberto-sorry |
| `RiemannHypothesis.ConsistencyChecks.nontrivial_implies_zero` | `ecletics/problems/riemann_hypothesis/consistency_checks.lean`:30 | aberto-sorry |
| `RiemannHypothesis.ConsistencyChecks.rh_preserves_symmetry` | `ecletics/problems/riemann_hypothesis/consistency_checks.lean`:40 | nao_alcancado |
| `RiemannHypothesis.MainTheorem.riemann_hypothesis_statement` | `ecletics/problems/riemann_hypothesis/main_theorem.lean`:23 | aberto-sorry |
| `RiemannHypothesis.MainTheorem.riemann_hypothesis_via_reduction` | `ecletics/problems/riemann_hypothesis/main_theorem.lean`:31 | aberto-sorry |
| `YangMills.ConsistencyChecks.classical_is_well_defined` | `ecletics/problems/yang_mills/consistency_checks.lean`:16 | condicional |
| `YangMills.ConsistencyChecks.energy_nonnegative` | `ecletics/problems/yang_mills/consistency_checks.lean`:39 | condicional |
| `YangMills.MainTheorem.yang_mills_existence_and_mass_gap` | `ecletics/problems/yang_mills/main_theorem.lean`:17 | aberto-sorry |
