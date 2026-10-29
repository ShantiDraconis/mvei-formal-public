# MVEI kernel check — universal

This folder records what the Lean 4 kernel said about the Lean sources of the private repository `ShantiDraconis/universal`. The sources are published in [`imports/universal/`](../../imports/universal/).

## What is published

* Source: `ShantiDraconis/universal`, commit `459428bdf95732b15340106312929cb6c0f4ba23` (2025-12-20T19:51:02Z).
* 157 files: 156 `.lean` files and the Lake files (`lakefile.*`, `lean-toolchain`, `lake-manifest.json`). Paths are the same as in the source repository.
* Nothing else from the private repository is published (documents, commercial license, prompts, storefront material).
* `SOURCES.sha256` lists every published file with its SHA-256. From the repository root: `sha256sum -c mvei/universal/SOURCES.sha256`.

## What the kernel said

MVEI verification of 2026-10-29T01:49:57+00:00, on commit `459428bdf95732b15340106312929cb6c0f4ba23`. Each theorem was read with `Lean.collectAxioms`, the function behind `#print axioms`.

| Lean project | Lean version | Build | Closed | Conditional | Open (`sorry`) | Checked file by file: closed / conditional / open / proof error / not reached |
|---|---|---|---:|---:|---:|---|
| `.` | stable | failed | 0 | 0 | 0 | 32 / 0 / 38 / 149 / 152 |

| Closed theorems in this repository | |
|---|---:|
| Counting each project | 32 |
| Unique (name + statement) | 32 |
| Unique, without the lemmas Lean generates itself (`eq_1`, `mk.inj`, `sizeOf_spec`, `deriving`) | 32 |

*Closed* means the kernel accepted the proof and it depends only on `propext`, `Classical.choice` and `Quot.sound`. It says that the statement as written in the file is proved; it does not say that an open problem is solved. Every statement is in `VERIFICACAO.json`. *Conditional* means the proof also uses axioms declared in the repository; *open* means it uses `sorry`. *Checked file by file* covers the files that no build reached: each one went through Lean whole, with a `#print axioms` for each theorem.

| Theorem | Project | State | Axioms beyond the standard three |
|---|---|---|---|
| `ComplexDifferentiability.holomorphic_comp` | `. (file by file)` | open | `sorryAx` |
| `ComplexDifferentiability.holomorphic_iff_wirtinger_conj_zero` | `. (file by file)` | open | `sorryAx` |
| `ComplexDifferentiability.mobius_conformal` | `. (file by file)` | open | `sorryAx` |
| `ComplexDifferentiability.holomorphic_has_power_series` | `. (file by file)` | open | `sorryAx` |
| `ComplexDifferentiability.zeros_isolated` | `. (file by file)` | open | `sorryAx` |
| `ComplexDifferentiability.zero_factorization` | `. (file by file)` | open | `sorryAx` |
| `ComplexDifferentiability.maximum_modulus` | `. (file by file)` | open | `sorryAx` |
| `ComplexDifferentiability.open_mapping` | `. (file by file)` | open | `sorryAx` |
| `ComplexDifferentiability.liouville` | `. (file by file)` | open | `sorryAx` |
| `DerivativesTheory.deriv_inverse'` | `. (file by file)` | open | `sorryAx` |
| `DerivativesTheory.differentiable_iff_left_right` | `. (file by file)` | open | `sorryAx` |
| `DerivativesTheory.lhopital_zero` | `. (file by file)` | open | `sorryAx` |
| `DerivativesTheory.lhopital_infty` | `. (file by file)` | open | `sorryAx` |
| `DerivativesTheory.convex_has_subderivative` | `. (file by file)` | open | `sorryAx` |
| `InverseFunctionTheory.inverse_function_1d` | `. (file by file)` | open | `sorryAx` |
| `InverseFunctionTheory.deriv_inverse` | `. (file by file)` | open | `sorryAx` |
| `InverseFunctionTheory.submersion_has_section` | `. (file by file)` | open | `sorryAx` |
| `InverseFunctionTheory.immersion_locally_injective` | `. (file by file)` | open | `sorryAx` |
| `RealDifferentiability.deriv_no_jump` | `. (file by file)` | open | `sorryAx` |
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
| `SigmaAlgebras.monotone_class` | `. (file by file)` | open | `sorryAx` |
| `Connectedness.zero_dim_is_totally_disc` | `. (file by file)` | open | `sorryAx` |
| `MetricSpaces.bounded_iff_finite_diameter` | `. (file by file)` | open | `sorryAx` |
| `UniformSpacesTheory.totally_bounded_complete_compact` | `. (file by file)` | open | `sorryAx` |

### Declared theorems

The `.lean` files of the verified commit declare 371 `theorem`/`lemma` (counting copies). The kernel checked 70 of them (32 closed, 0 conditional, 38 open). The closed count in the table above is larger: it also counts the theorems Lean generates by itself (equation lemmas, structure fields, `deriving`), which are not written in the text. For 301 the kernel has no result:

| Reason | Theorems |
|---|---:|
| checked file by file: Lean did not reach the theorem (missing import, syntax error or timeout) | 152 |
| checked file by file: the written proof does not pass the kernel | 149 |

### MVEI corrections

* `correcoes/imports-no-topo.patch` (import fora do início do arquivo, 2 file(s)): applies to the published sources: `git apply -p1 --directory=imports/universal mvei/universal/correcoes/imports-no-topo.patch` (in order, after the ones above)
* `correcoes/tatica-encontrada.patch` (prova que não passava (ou axioma) que uma tática padrão fecha no kernel, 1 file(s)): applies to the published sources: `git apply -p1 --directory=imports/universal mvei/universal/correcoes/tatica-encontrada.patch` (in order, after the ones above)

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
