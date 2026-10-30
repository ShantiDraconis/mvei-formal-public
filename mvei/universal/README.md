# MVEI kernel check — universal

This folder records what the Lean 4 kernel said about the Lean sources of the private repository `ShantiDraconis/universal`. The sources are published in [`imports/universal/`](../../imports/universal/).

## What is published

* Source: `ShantiDraconis/universal`, commit `459428bdf95732b15340106312929cb6c0f4ba23` (2025-12-20T19:51:02Z).
* 157 files: 156 `.lean` files and the Lake files (`lakefile.*`, `lean-toolchain`, `lake-manifest.json`). Paths are the same as in the source repository.
* Nothing else from the private repository is published (documents, commercial license, prompts, storefront material).
* `SOURCES.sha256` lists every published file with its SHA-256. From the repository root: `sha256sum -c mvei/universal/SOURCES.sha256`.

## What the kernel said

MVEI verification of 2026-10-30T08:01:18+00:00, on commit `459428bdf95732b15340106312929cb6c0f4ba23`. Each theorem was read with `Lean.collectAxioms`, the function behind `#print axioms`.

| Lean project | Lean version | Build | Closed | Conditional | Open (`sorry`) | Checked file by file: closed / conditional / open / proof error / not reached |
|---|---|---|---:|---:|---:|---|
| `.` | v4.19.0 | failed | 0 | 0 | 0 | 99 / 0 / 116 / 144 / 12 |

| Closed theorems in this repository | |
|---|---:|
| Counting each project | 99 |
| Unique (name + statement) | 99 |
| Unique, without the lemmas Lean generates itself (`eq_1`, `mk.inj`, `sizeOf_spec`, `deriving`) | 99 |

*Closed* means the kernel accepted the proof and it depends only on `propext`, `Classical.choice` and `Quot.sound`. It says that the statement as written in the file is proved; it does not say that an open problem is solved. Every statement is in `VERIFICACAO.json`. *Conditional* means the proof also uses axioms declared in the repository; *open* means it uses `sorry`. *Checked file by file* covers the files that no build reached: each one went through Lean whole, with a `#print axioms` for each theorem.

| Theorem | Project | State | Axioms beyond the standard three |
|---|---|---|---|
| `ComplexDifferentiability.holomorphic_comp` | `. (file by file)` | open | `sorryAx` |
| `ComplexDifferentiability.holomorphic_iff_wirtinger_conj_zero` | `. (file by file)` | open | `sorryAx` |
| `ComplexDifferentiability.holomorphic_real_part_harmonic` | `. (file by file)` | open | `sorryAx` |
| `ComplexDifferentiability.holomorphic_imag_part_harmonic` | `. (file by file)` | open | `sorryAx` |
| `ComplexDifferentiability.conformal_preserves_angles` | `. (file by file)` | open | `sorryAx` |
| `ComplexDifferentiability.mobius_conformal` | `. (file by file)` | open | `sorryAx` |
| `ComplexDifferentiability.holomorphic_has_power_series` | `. (file by file)` | open | `sorryAx` |
| `ComplexDifferentiability.zeros_isolated` | `. (file by file)` | open | `sorryAx` |
| `ComplexDifferentiability.zero_factorization` | `. (file by file)` | open | `sorryAx` |
| `ComplexDifferentiability.maximum_modulus` | `. (file by file)` | open | `sorryAx` |
| `ComplexDifferentiability.open_mapping` | `. (file by file)` | open | `sorryAx` |
| `ComplexDifferentiability.liouville` | `. (file by file)` | open | `sorryAx` |
| `DerivativesTheory.deriv_inverse'` | `. (file by file)` | open | `sorryAx` |
| `DerivativesTheory.differentiable_iff_left_right` | `. (file by file)` | open | `sorryAx` |
| `DerivativesTheory.schwarz_theorem` | `. (file by file)` | open | `sorryAx` |
| `DerivativesTheory.directional_deriv_eq_gradient` | `. (file by file)` | open | `sorryAx` |
| `DerivativesTheory.gradient_steepest_ascent` | `. (file by file)` | open | `sorryAx` |
| `DerivativesTheory.leibniz_rule` | `. (file by file)` | open | `sorryAx` |
| `DerivativesTheory.lhopital_zero` | `. (file by file)` | open | `sorryAx` |
| `DerivativesTheory.lhopital_infty` | `. (file by file)` | open | `sorryAx` |
| `DerivativesTheory.convex_has_subderivative` | `. (file by file)` | open | `sorryAx` |
| `DerivativesTheory.implicit_deriv` | `. (file by file)` | open | `sorryAx` |
| `DifferentiableManifolds.smooth_comp` | `. (file by file)` | open | `sorryAx` |
| `HigherDerivativesTheory.taylor_lagrange` | `. (file by file)` | open | `sorryAx` |
| `HigherDerivativesTheory.taylor_integral` | `. (file by file)` | open | `sorryAx` |
| `HigherDerivativesTheory.taylor_peano` | `. (file by file)` | open | `sorryAx` |
| `HigherDerivativesTheory.taylor_multivariate` | `. (file by file)` | open | `sorryAx` |
| `HigherDerivativesTheory.faa_di_bruno` | `. (file by file)` | open | `sorryAx` |
| `HigherDerivativesTheory.analytic_is_smooth` | `. (file by file)` | open | `sorryAx` |
| `HigherDerivativesTheory.smooth_not_analytic_example` | `. (file by file)` | open | `sorryAx` |
| `HigherDerivativesTheory.smoothBump_smooth` | `. (file by file)` | open | `sorryAx` |
| `HigherDerivativesTheory.smoothBump_compactSupport` | `. (file by file)` | open | `sorryAx` |
| `HigherDerivativesTheory.borel_theorem` | `. (file by file)` | open | `sorryAx` |
| `HigherDerivativesTheory.zygmund_between_lip` | `. (file by file)` | open | `sorryAx` |
| `ImplicitFunctionTheory.implicit_function_2d` | `. (file by file)` | open | `sorryAx` |
| `ImplicitFunctionTheory.implicit_function_deriv` | `. (file by file)` | open | `sorryAx` |
| `ImplicitFunctionTheory.level_set_graph` | `. (file by file)` | open | `sorryAx` |
| `ImplicitFunctionTheory.lagrange_multiplier` | `. (file by file)` | open | `sorryAx` |
| `ImplicitFunctionTheory.lagrange_multiplier_multiple` | `. (file by file)` | open | `sorryAx` |
| `ImplicitFunctionTheory.second_order_max_condition` | `. (file by file)` | open | `sorryAx` |
| `ImplicitFunctionTheory.kkt_conditions` | `. (file by file)` | open | `sorryAx` |
| `InverseFunctionTheory.inverse_function_1d` | `. (file by file)` | open | `sorryAx` |
| `InverseFunctionTheory.deriv_inverse` | `. (file by file)` | open | `sorryAx` |
| `InverseFunctionTheory.local_diffeo_of_invertible_deriv` | `. (file by file)` | open | `sorryAx` |
| `InverseFunctionTheory.hadamard_global_inverse` | `. (file by file)` | open | `sorryAx` |
| `InverseFunctionTheory.constant_rank` | `. (file by file)` | open | `sorryAx` |
| `InverseFunctionTheory.submersion_has_section` | `. (file by file)` | open | `sorryAx` |
| `InverseFunctionTheory.immersion_locally_injective` | `. (file by file)` | open | `sorryAx` |
| `InverseFunctionTheory.ode_flow_exists` | `. (file by file)` | open | `sorryAx` |
| `JacobiansTheory.jacobian_comp` | `. (file by file)` | open | `sorryAx` |
| `JacobiansTheory.jacobian_det_comp` | `. (file by file)` | open | `sorryAx` |
| `JacobiansTheory.polar_jacobian` | `. (file by file)` | open | `sorryAx` |
| `JacobiansTheory.spherical_jacobian` | `. (file by file)` | open | `sorryAx` |
| `JacobiansTheory.inverse_function_jacobian` | `. (file by file)` | open | `sorryAx` |
| `JacobiansTheory.jacobian_inverse` | `. (file by file)` | open | `sorryAx` |
| `JacobiansTheory.curl_antisymm` | `. (file by file)` | open | `sorryAx` |
| `MeanValueTheorems.cauchy_mean_value` | `. (file by file)` | open | `sorryAx` |
| `MeanValueTheorems.mean_value_vector` | `. (file by file)` | open | `sorryAx` |
| `MeanValueTheorems.mean_value_path` | `. (file by file)` | open | `sorryAx` |
| `MeanValueTheorems.integral_mean_value` | `. (file by file)` | open | `sorryAx` |
| `MeanValueTheorems.integral_second_mean_value` | `. (file by file)` | open | `sorryAx` |
| `MeanValueTheorems.flett_mvt` | `. (file by file)` | open | `sorryAx` |
| `MeanValueTheorems.pompeiu_mvt` | `. (file by file)` | open | `sorryAx` |
| `MeanValueTheorems.deriv_eq_const_diff` | `. (file by file)` | open | `sorryAx` |
| `RealDifferentiability.deriv_no_jump` | `. (file by file)` | open | `sorryAx` |
| `RealDifferentiability.local_inverse_exists` | `. (file by file)` | open | `sorryAx` |
| `RealDifferentiability.deriv_inverse_at` | `. (file by file)` | open | `sorryAx` |
| `RealDifferentiability.inflection_second_deriv_zero` | `. (file by file)` | open | `sorryAx` |
| `RealDifferentiability.bounded_deriv_lipschitz` | `. (file by file)` | open | `sorryAx` |
| `RealDifferentiability.lipschitz_const_eq_sup_deriv` | `. (file by file)` | open | `sorryAx` |
| `TaylorSeriesTheory.taylor_poly_approx` | `. (file by file)` | open | `sorryAx` |
| `TaylorSeriesTheory.taylor_error_bound` | `. (file by file)` | open | `sorryAx` |
| `TaylorSeriesTheory.eq_taylor_series` | `. (file by file)` | open | `sorryAx` |
| `TaylorSeriesTheory.analytic_smooth` | `. (file by file)` | open | `sorryAx` |
| `TaylorSeriesTheory.analytic_add` | `. (file by file)` | open | `sorryAx` |
| `TaylorSeriesTheory.analytic_mul` | `. (file by file)` | open | `sorryAx` |
| `TaylorSeriesTheory.cauchy_product_theorem` | `. (file by file)` | open | `sorryAx` |
| `TaylorSeriesTheory.taylor_sin` | `. (file by file)` | open | `sorryAx` |
| `TaylorSeriesTheory.taylor_cos` | `. (file by file)` | open | `sorryAx` |
| `TaylorSeriesTheory.taylor_log` | `. (file by file)` | open | `sorryAx` |
| `TaylorSeriesTheory.binomial_series` | `. (file by file)` | open | `sorryAx` |
| `TaylorSeriesTheory.borel_sum_analytic` | `. (file by file)` | open | `sorryAx` |
| `Integrals.dominated_convergence` | `. (file by file)` | open | `sorryAx` |
| `SigmaAlgebras.generated_smallest` | `. (file by file)` | open | `sorryAx` |
| `SigmaAlgebras.rectangle_measurable` | `. (file by file)` | open | `sorryAx` |
| `SigmaAlgebras.monotone_class` | `. (file by file)` | open | `sorryAx` |
| `BaireCategoryTheory.baire_iff_not_meager` | `. (file by file)` | open | `sorryAx` |
| `BaireCategoryTheory.dense_Gδ_not_meager` | `. (file by file)` | open | `sorryAx` |
| `BaireCategoryTheory.residual_is_comeager` | `. (file by file)` | open | `sorryAx` |
| `BaireCategoryTheory.residual_countable_inter` | `. (file by file)` | open | `sorryAx` |
| `BaireCategoryTheory.exists_continuous_nowhere_differentiable` | `. (file by file)` | open | `sorryAx` |
| `BaireCategoryTheory.irrationals_comeager` | `. (file by file)` | open | `sorryAx` |
| `BaireCategoryTheory.countable_non_condensation` | `. (file by file)` | open | `sorryAx` |
| `BaireCategoryTheory.perfect_uncountable` | `. (file by file)` | open | `sorryAx` |
| `BaireCategoryTheory.cantor_bendixson` | `. (file by file)` | open | `sorryAx` |
| `Compactness.compact_iff_seq_compact` | `. (file by file)` | open | `sorryAx` |
| `Compactness.seq_compact_implies_limit_point_compact` | `. (file by file)` | open | `sorryAx` |
| `Connectedness.zero_dim_is_totally_disc` | `. (file by file)` | open | `sorryAx` |
| `ContinuityTheory.continuous_iff_seq_continuous` | `. (file by file)` | open | `sorryAx` |
| `HomeomorphismsTheory.interval_homeo_real` | `. (file by file)` | open | `sorryAx` |
| `HomeomorphismsTheory.punctured_plane_homeo_cylinder` | `. (file by file)` | open | `sorryAx` |
| `HomeomorphismsTheory.covering_is_local_homeo` | `. (file by file)` | open | `sorryAx` |
| `HomeomorphismsTheory.invariance_of_domain` | `. (file by file)` | open | `sorryAx` |
| `MetricSpaces.bounded_iff_finite_diameter` | `. (file by file)` | open | `sorryAx` |
| `StoneWeierstrassTheory.bernstein_uniform_convergence` | `. (file by file)` | open | `sorryAx` |
| `StoneWeierstrassTheory.korovkin` | `. (file by file)` | open | `sorryAx` |
| `StoneWeierstrassTheory.stone_weierstrass_lattice` | `. (file by file)` | open | `sorryAx` |
| `StoneWeierstrassTheory.chebyshev_cos` | `. (file by file)` | open | `sorryAx` |
| `StoneWeierstrassTheory.stone_weierstrass_vector` | `. (file by file)` | open | `sorryAx` |
| `UniformSpacesTheory.totally_bounded_complete_compact` | `. (file by file)` | open | `sorryAx` |
| `RH_FullFormal.functional_equation` | `. (file by file)` | open | `sorryAx` |
| `RH_FullFormal.rh_equiv_xi` | `. (file by file)` | open | `sorryAx` |
| `RH_FullFormal.infinitely_many_zeros_on_line` | `. (file by file)` | open | `sorryAx` |
| `RH_FullFormal.selberg_proportion` | `. (file by file)` | open | `sorryAx` |
| `RH_FullFormal.rh_implies_lindelof` | `. (file by file)` | open | `sorryAx` |
| `RH_FullFormal.rh_implies_prime_error` | `. (file by file)` | open | `sorryAx` |

### Declared theorems

The `.lean` files of the verified commit declare 371 `theorem`/`lemma` (counting copies). The kernel checked 215 of them (99 closed, 0 conditional, 116 open). The closed count in the table above is larger: it also counts the theorems Lean generates by itself (equation lemmas, structure fields, `deriving`), which are not written in the text. For 156 the kernel has no result:

| Reason | Theorems |
|---|---:|
| checked file by file: the written proof does not pass the kernel | 144 |
| checked file by file: Lean did not reach the theorem (missing import, syntax error or timeout) | 12 |

### MVEI corrections

* `correcoes/imports-no-topo.patch` (import fora do início do arquivo, 2 file(s)): applies to the published sources: `git apply -p1 --directory=imports/universal mvei/universal/correcoes/imports-no-topo.patch` (in order, after the ones above)
* `correcoes/renomear-imports-mathlib.patch` (import de módulo que não existe na versão do Mathlib do projeto (renomeado ou dividido), 40 file(s)): applies to the published sources: `git apply -p1 --directory=imports/universal mvei/universal/correcoes/renomear-imports-mathlib.patch` (in order, after the ones above)
* `correcoes/tatica-encontrada.patch` (prova que não passava (ou axioma) que uma tática padrão fecha no kernel, 2 file(s)): applies to the published sources: `git apply -p1 --directory=imports/universal mvei/universal/correcoes/tatica-encontrada.patch` (in order, after the ones above)
* `correcoes/vocabulario-lean4.patch` (grafia que o Lean 4 não lê (nome acentuado, λ/Σ/Π como nome, ∀ x y ∈ s, docstring solta, constant, tática do Mathlib sem import), 63 file(s)): applies to the published sources: `git apply -p1 --directory=imports/universal mvei/universal/correcoes/vocabulario-lean4.patch` (in order, after the ones above)

## Files in this folder

* `VERIFICACAO.json` — each Lean project of this repository, each theorem the kernel read, its statement, its axioms and its state (`fechado` closed, `condicional` conditional, `aberto-sorry` open)
* `TEOREMAS.csv` — each declared `theorem`/`lemma`: file, line, state in the kernel (`nao_checado` = not checked) and, if not checked, why (in Portuguese)
* `BUILD_LOG.txt` — one block per project: Lean version, result, errors
* `SOURCE.json` — source commit, verified commit and dates, machine-readable
* `SOURCES.sha256` — SHA-256 of every published file

## Reproduce

```
cd imports/universal/<project>   # a project folder from the table above ('.' is imports/universal)
lake exe cache get           # only for projects that require Mathlib
lake build
```

Each project uses the Lean version in its own `lean-toolchain`, which elan installs. The MVEI pipeline that produced these results is in the author's repository and is not public.
