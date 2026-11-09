# MVEI kernel check — millennium-birch-swinnerton-dyer-classical

This folder records what the Lean 4 kernel said about the Lean sources of the private repository `ShantiDraconis/millennium-birch-swinnerton-dyer-classical`. The sources are published in [`imports/millennium-birch-swinnerton-dyer-classical/`](../../imports/millennium-birch-swinnerton-dyer-classical/).

## What is published

* Source: `ShantiDraconis/millennium-birch-swinnerton-dyer-classical`, commit `44edb40cb18d994ff785d95e56d78767d0d5d15c` (2026-09-18T04:12:04Z).
* 52 files: 51 `.lean` files and the Lake files (`lakefile.*`, `lean-toolchain`, `lake-manifest.json`), plus 1 license or origin file(s) that third-party code requires (`LICENSE`). Paths are the same as in the source repository.
* Nothing else from the private repository is published (documents, commercial license, prompts, storefront material).
* `SOURCES.sha256` lists every published file with its SHA-256. From the repository root: `sha256sum -c mvei/millennium-birch-swinnerton-dyer-classical/SOURCES.sha256`.

## What the kernel said

MVEI verification of 2026-11-06T00:22:08+00:00, on commit `44edb40cb18d994ff785d95e56d78767d0d5d15c`. Each theorem was read with `Lean.collectAxioms`, the function behind `#print axioms`.

| Lean project | Lean version | Build | Closed | Conditional | Open (`sorry`) | Checked file by file: closed / conditional / open / proof error / not reached |
|---|---|---|---:|---:|---:|---|
| `src/lean` (no lakefile; project assembled by MVEI) | v4.19.0 | partial | 331 | 23 | 26 | 55 / 2 / 36 / 4 / 0 |
| `tests/lean` (no lakefile; project assembled by MVEI) | padrão do elan | OK | 0 | 0 | 0 | — |

| Closed theorems in this repository | |
|---|---:|
| Counting each project | 386 |
| Unique (name + statement) | 385 |
| Unique, without the lemmas Lean generates itself (`eq_1`, `mk.inj`, `sizeOf_spec`, `deriving`) | 194 |

*Closed* means the kernel accepted the proof and it depends only on `propext`, `Classical.choice` and `Quot.sound`. It says that the statement as written in the file is proved; it does not say that an open problem is solved. Every statement is in `VERIFICACAO.json`. *Conditional* means the proof also uses axioms declared in the repository; *open* means it uses `sorry`. *Checked file by file* covers the files that no build reached: each one went through Lean whole, with a `#print axioms` for each theorem.

| Theorem | Project | State | Axioms beyond the standard three |
|---|---|---|---|
| `BSD.EllipticCurve.canonicalHeight_quadratic` | `src/lean` | open | `sorryAx` |
| `BSD.EllipticCurve.jInvariant_classifies` | `src/lean` | open | `sorryAx` |
| `EllipticCurve.BSD_37a1` | `src/lean` | conditional | `EllipticCurve.curve_37a1_rank_1`, `EllipticCurve.curve_37a1_analytic_rank_1` |
| `EllipticCurve.BSD_components_pos` | `src/lean` | conditional | `EllipticCurve.L_function`, `EllipticCurve.realPeriod_pos`, `EllipticCurve.torsion_finite` |
| `EllipticCurve.BSD_formula_at_rank_0` | `src/lean` | open | `EllipticCurve.L_function`, `sorryAx` |
| `EllipticCurve.BSD_formula_at_rank_1` | `src/lean` | open | `EllipticCurve.L_function`, `sorryAx` |
| `EllipticCurve.BSD_formula_detailed` | `src/lean` | open | `EllipticCurve.L_function`, `sorryAx` |
| `EllipticCurve.BSD_formula_rank_0` | `src/lean` | conditional | `EllipticCurve.L_function` |
| `EllipticCurve.BSD_formula_rank_1` | `src/lean` | conditional | `EllipticCurve.L_function` |
| `EllipticCurve.L_at_1_self_dual` | `src/lean` | conditional | `EllipticCurve.L_function` |
| `EllipticCurve.L_at_1_zero_if_root_minus_one` | `src/lean` | conditional | `EllipticCurve.L_function` |
| `EllipticCurve.L_at_1_zero_iff_rank_pos` | `src/lean` | conditional | `EllipticCurve.L_function`, `EllipticCurve.analyticRank_spec` |
| `EllipticCurve.L_at_1_zero_iff_root_minus_one` | `src/lean` | open | `EllipticCurve.L_function`, `sorryAx` |
| `EllipticCurve.L_deriv_at_1.eq_1` | `src/lean` | conditional | `EllipticCurve.L_function` |
| `EllipticCurve.L_deriv_nonzero_at_rank` | `src/lean` | conditional | `EllipticCurve.L_function`, `EllipticCurve.analyticRank_spec` |
| `EllipticCurve.L_deriv_zero_below_rank` | `src/lean` | conditional | `EllipticCurve.L_function`, `EllipticCurve.analyticRank_spec` |
| `EllipticCurve.L_has_infinitely_many_zeros` | `src/lean` | open | `EllipticCurve.L_function`, `sorryAx` |
| `EllipticCurve.L_nonvanishing_right_half` | `src/lean` | open | `EllipticCurve.L_function`, `sorryAx` |
| `EllipticCurve.L_taylor_expansion` | `src/lean` | open | `EllipticCurve.L_function`, `sorryAx` |
| `EllipticCurve.L_value_functional_eq` | `src/lean` | conditional | `EllipticCurve.L_function` |
| `EllipticCurve.StrongBSD.eq_1` | `src/lean` | conditional | `EllipticCurve.L_function` |
| `EllipticCurve.StrongBSD_sha_finite` | `src/lean` | conditional | `EllipticCurve.L_function` |
| `EllipticCurve.StrongBSD_sha_from_formula` | `src/lean` | open | `EllipticCurve.L_function`, `sorryAx` |
| `EllipticCurve.StrongBSD_sha_square` | `src/lean` | conditional | `EllipticCurve.L_function`, `EllipticCurve.sha_is_square` |
| `EllipticCurve.WeakBSD_L_function_form` | `src/lean` | open | `EllipticCurve.L_function`, `sorryAx` |
| `EllipticCurve.WeakBSD_holds_rank_0` | `src/lean` | conditional | `EllipticCurve.L_function` |
| `EllipticCurve.WeakBSD_holds_rank_1` | `src/lean` | conditional | `EllipticCurve.L_function` |
| `EllipticCurve.analyticRank_is_order` | `src/lean` | conditional | `EllipticCurve.L_function`, `EllipticCurve.analyticRank_spec` |
| `EllipticCurve.analyticRank_one_iff` | `src/lean` | open | `EllipticCurve.L_function`, `sorryAx` |
| `EllipticCurve.analyticRank_zero_iff_L_nonzero` | `src/lean` | conditional | `EllipticCurve.L_function`, `EllipticCurve.analyticRank_spec` |
| `EllipticCurve.canonicalHeight_zero_iff_torsion` | `src/lean` | open | `sorryAx` |
| `EllipticCurve.euler_product_converges` | `src/lean` | open | `sorryAx` |
| `EllipticCurve.functional_equation_detailed` | `src/lean` | open | `EllipticCurve.L_function`, `sorryAx` |
| `EllipticCurve.functional_equation_sign` | `src/lean` | open | `EllipticCurve.L_function`, `sorryAx` |
| `EllipticCurve.height_bound_constant` | `src/lean` | open | `sorryAx` |
| `EllipticCurve.leadingTerm.eq_1` | `src/lean` | conditional | `EllipticCurve.L_function` |
| `EllipticCurve.leadingTerm_ne_zero` | `src/lean` | conditional | `EllipticCurve.L_function`, `EllipticCurve.analyticRank_spec` |
| `EllipticCurve.rank_one_characterization` | `src/lean` | open | `sorryAx` |
| `EllipticCurve.rank_zero_iff` | `src/lean` | open | `sorryAx` |
| `EllipticCurve.regulator_basis_independent` | `src/lean` | open | `sorryAx` |
| `EllipticCurve.regulator_from_generators` | `src/lean` | open | `sorryAx` |
| `EllipticCurve.regulator_pos` | `src/lean` | open | `sorryAx` |
| `EllipticCurve.rootNumber_product` | `src/lean` | open | `sorryAx` |
| `EllipticCurve.strong_BSD_implies_sha_finite` | `src/lean` | conditional | `EllipticCurve.L_function` |
| `EllipticCurve.strong_BSD_statement` | `src/lean` | conditional | `EllipticCurve.L_function` |
| `EllipticCurve.strong_implies_weak` | `src/lean` | conditional | `EllipticCurve.L_function` |
| `EllipticCurve.torsion_order_possibilities` | `src/lean` | open | `sorryAx` |
| `Weierstrass.conductor_divides_discriminant` | `src/lean` | open | `sorryAx` |
| `tamagawa_good` | `src/lean` | open | `sorryAx` |
| `ModularForm.eigenvalue_eq_coeff` | `src/lean (file by file)` | open | `sorryAx` |
| `ModularForm.hecke_comm` | `src/lean (file by file)` | open | `sorryAx` |
| `ModularForm.hecke_mult` | `src/lean (file by file)` | open | `sorryAx` |
| `EllipticCurveClassical.isomorphic_iff_same_j` | `src/lean (file by file)` | open | `sorryAx` |
| `ShortWeierstrassClassical.j_1728_iff_B_zero` | `src/lean (file by file)` | open | `sorryAx` |
| `finitePointsBoundedHeight` | `src/lean (file by file)` | open | `sorryAx` |
| `canonicalHeight_zero_iff_torsion` | `src/lean (file by file)` | open | `sorryAx` |
| `heightPairing_pos_def` | `src/lean (file by file)` | open | `sorryAx` |
| `regulator_well_defined` | `src/lean (file by file)` | open | `sorryAx` |
| `finitePointsBoundedHeight` | `src/lean (file by file)` | open | `sorryAx` |
| `neronTateHeight_quadratic` | `src/lean (file by file)` | open | `sorryAx` |
| `neronTateHeight_parallelogram` | `src/lean (file by file)` | open | `sorryAx` |
| `heightPairing_symmetric` | `src/lean (file by file)` | open | `sorryAx` |
| `heightPairing_bilinear_left` | `src/lean (file by file)` | open | `sorryAx` |
| `heightPairing_bilinear_right` | `src/lean (file by file)` | open | `sorryAx` |
| `heightPairing_diagonal` | `src/lean (file by file)` | open | `sorryAx` |
| `heightPairing_pos_def` | `src/lean (file by file)` | open | `sorryAx` |
| `heightPairing_torsion` | `src/lean (file by file)` | open | `sorryAx` |
| `heightPairingMatrix_symmetric` | `src/lean (file by file)` | open | `sorryAx` |
| `regulator_basis_independent` | `src/lean (file by file)` | open | `sorryAx` |
| `regulator_pos` | `src/lean (file by file)` | open | `sorryAx` |
| `regulator_rank_zero` | `src/lean (file by file)` | open | `sorryAx` |
| `regulator_rank_one` | `src/lean (file by file)` | open | `sorryAx` |
| `regulator_rank_two` | `src/lean (file by file)` | open | `sorryAx` |
| `heightPairing_cauchy_schwarz` | `src/lean (file by file)` | open | `sorryAx` |
| `regulator_nonneg` | `src/lean (file by file)` | open | `sorryAx` |
| `globalHeight_local_sum` | `src/lean (file by file)` | open | `sorryAx` |
| `regulator_rank_growth` | `src/lean (file by file)` | open | `sorryAx` |
| `regulator_computation_converges` | `src/lean (file by file)` | open | `sorryAx` |
| `absoluteConvergenceRegion` | `src/lean (file by file)` | open | `sorryAx` |
| `conditionalConvergenceRegion` | `src/lean (file by file)` | open | `sorryAx` |
| `lowerDerivativesVanish` | `src/lean (file by file)` | open | `LFunctionClassical`, `sorryAx` |
| `leadingDerivative_nonzero` | `src/lean (file by file)` | open | `LFunctionClassical`, `sorryAx` |
| `taylorExpansionAt1` | `src/lean (file by file)` | conditional | `LFunctionClassical`, `LFunction_entire` |
| `leadingCoefficient_limit` | `src/lean (file by file)` | open | `LFunctionClassical`, `sorryAx` |
| `thetaSeries_convergence` | `src/lean (file by file)` | open | `sorryAx` |
| `weakBSD_implies_parity` | `src/lean (file by file)` | open | `rootNumber`, `sorryAx` |
| `functionalEquation_from_modularity` | `src/lean (file by file)` | conditional | `LFunctionClassical`, `functionalEquation`, `rootNumber` |

### Declared theorems

The `.lean` files of the verified commit declare 225 `theorem`/`lemma` (counting copies). The kernel checked 219 of them (133 closed, 22 conditional, 64 open). The closed count in the table above is larger: it also counts the theorems Lean generates by itself (equation lemmas, structure fields, `deriving`), which are not written in the text. For 6 the kernel has no result:

| Reason | Theorems |
|---|---:|
| the file did not compile (an error in it or in a file it imports) | 3 |
| checked file by file: the written proof does not pass the kernel | 3 |

### MVEI corrections

* `correcoes/a-arquivos-corrompidos.patch` (arquivo corrompido no repositório (merge add/add resolvido aceitando os dois lados: linhas das duas versões intercaladas), 12 file(s)): applies to the published sources: `git apply -p1 --directory=imports/millennium-birch-swinnerton-dyer-classical mvei/millennium-birch-swinnerton-dyer-classical/correcoes/a-arquivos-corrompidos.patch` (in order, after the ones above)
* `correcoes/imports-no-topo.patch` (import fora do início do arquivo, 12 file(s)): applies to the published sources: `git apply -p1 --directory=imports/millennium-birch-swinnerton-dyer-classical mvei/millennium-birch-swinnerton-dyer-classical/correcoes/imports-no-topo.patch` (in order, after the ones above)
* `correcoes/renomear-imports-mathlib.patch` (import de módulo que não existe na versão do Mathlib do projeto (renomeado ou dividido), 4 file(s)): applies to the published sources: `git apply -p1 --directory=imports/millennium-birch-swinnerton-dyer-classical mvei/millennium-birch-swinnerton-dyer-classical/correcoes/renomear-imports-mathlib.patch` (in order, after the ones above)
* `correcoes/tatica-encontrada.patch` (prova que não passava (ou axioma) que uma tática padrão fecha no kernel, 15 file(s)): applies to the published sources: `git apply -p1 --directory=imports/millennium-birch-swinnerton-dyer-classical mvei/millennium-birch-swinnerton-dyer-classical/correcoes/tatica-encontrada.patch` (in order, after the ones above)
* `correcoes/vocabulario-lean4.patch` (grafia que o Lean 4 não lê (nome acentuado, λ/Σ/Π como nome, ∀ x y ∈ s, docstring solta, constant, tática do Mathlib sem import), 30 file(s)): applies to the published sources: `git apply -p1 --directory=imports/millennium-birch-swinnerton-dyer-classical mvei/millennium-birch-swinnerton-dyer-classical/correcoes/vocabulario-lean4.patch` (in order, after the ones above)
* `correcoes/z-provas-reparadas.patch` (prova que não passava no kernel (o enunciado fica igual), 18 file(s)): applies to the published sources: `git apply -p1 --directory=imports/millennium-birch-swinnerton-dyer-classical mvei/millennium-birch-swinnerton-dyer-classical/correcoes/z-provas-reparadas.patch` (in order, after the ones above)
* `correcoes/zy-enunciados-do-autor.patch` (enunciado reescrito a pedido do autor (o original, como escrito, fica registrado), 14 file(s)): applies to the published sources: `git apply -p1 --directory=imports/millennium-birch-swinnerton-dyer-classical mvei/millennium-birch-swinnerton-dyer-classical/correcoes/zy-enunciados-do-autor.patch` (in order, after the ones above)
* `correcoes/zz-refutacoes.patch` (teorema com enunciado falso como o Lean o lê (o original fica como está), 6 file(s)): applies to the published sources: `git apply -p1 --directory=imports/millennium-birch-swinnerton-dyer-classical mvei/millennium-birch-swinnerton-dyer-classical/correcoes/zz-refutacoes.patch` (in order, after the ones above)

## Files in this folder

* `VERIFICACAO.json` — each Lean project of this repository, each theorem the kernel read, its statement, its axioms and its state (`fechado` closed, `condicional` conditional, `aberto-sorry` open)
* `TEOREMAS.csv` — each declared `theorem`/`lemma`: file, line, state in the kernel (`nao_checado` = not checked) and, if not checked, why (in Portuguese)
* `BUILD_LOG.txt` — one block per project: Lean version, result, errors
* `SOURCE.json` — source commit, verified commit and dates, machine-readable
* `SOURCES.sha256` — SHA-256 of every published file

## Reproduce

```
cd imports/millennium-birch-swinnerton-dyer-classical/<project>   # a project folder from the table above ('.' is imports/millennium-birch-swinnerton-dyer-classical)
lake exe cache get           # only for projects that require Mathlib
lake build
```

Each project uses the Lean version in its own `lean-toolchain`, which elan installs. The MVEI pipeline that produced these results is in the author's repository and is not public.
