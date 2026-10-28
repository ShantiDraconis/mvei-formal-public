# MVEI kernel check — universal-emergent-logic-

This folder records what the Lean 4 kernel said about the Lean sources of the private repository `ShantiDraconis/universal-emergent-logic-`. The sources are published in [`imports/universal-emergent-logic-/`](../../imports/universal-emergent-logic-/).

## What is published

* Source: `ShantiDraconis/universal-emergent-logic-`, commit `041a2090e226310380ee3297d5abef5a51801265` (2026-09-20T08:28:25Z).
* 260 files: 256 `.lean` files and the Lake files (`lakefile.*`, `lean-toolchain`, `lake-manifest.json`), plus 1 license or origin file(s) that third-party code requires (`LICENSE`). Paths are the same as in the source repository.
* Nothing else from the private repository is published (documents, commercial license, prompts, storefront material).
* `SOURCES.sha256` lists every published file with its SHA-256. From the repository root: `sha256sum -c mvei/universal-emergent-logic-/SOURCES.sha256`.

## What the kernel said

MVEI verification of 2026-10-28T16:41:02+00:00, on commit `041a2090e226310380ee3297d5abef5a51801265`. Each theorem was read with `Lean.collectAxioms`, the function behind `#print axioms`.

| Lean project | Lean version | Build | Closed | Conditional | Open (`sorry`) | Checked file by file: closed / conditional / open / proof error / not reached |
|---|---|---|---:|---:|---:|---|
| `codigo` (no lakefile; project assembled by MVEI) | padrão do elan | failed | 0 | 0 | 0 | 0 / 0 / 0 / 3 / 0 |
| `formalization` (no lakefile; project assembled by MVEI) | padrão do elan | failed | 0 | 0 | 0 | 0 / 0 / 0 / 0 / 5 |
| `formalization/lean` | v4.19.0 | partial | 12 | 0 | 0 | 2 / 0 / 14 / 40 / 897 |
| `proofs/bsd_conjecture` (no lakefile; project assembled by MVEI) | padrão do elan | failed | 0 | 0 | 0 | 0 / 0 / 0 / 5 / 0 |
| `proofs/hodge_conjecture` (no lakefile; project assembled by MVEI) | padrão do elan | failed | 0 | 0 | 0 | 0 / 0 / 1 / 4 / 0 |
| `proofs/navier_stokes` (no lakefile; project assembled by MVEI) | padrão do elan | failed | 0 | 0 | 0 | 0 / 0 / 0 / 0 / 6 |
| `proofs/p_vs_np` (no lakefile; project assembled by MVEI) | padrão do elan | failed | 0 | 0 | 0 | 0 / 0 / 0 / 0 / 19 |
| `proofs/riemann_hypothesis` (no lakefile; project assembled by MVEI) | padrão do elan | failed | 0 | 0 | 0 | 0 / 0 / 0 / 0 / 69 |
| `proofs/yang_mills` (no lakefile; project assembled by MVEI) | padrão do elan | failed | 0 | 0 | 0 | 0 / 0 / 2 / 3 / 0 |
| `src/lean` | v4.8.0 | failed | 0 | 0 | 0 | 0 / 0 / 0 / 7 / 0 |
| `universe00` | v4.3.0 | failed | 0 | 0 | 0 | 0 / 0 / 0 / 0 / 292 |

| Closed theorems in this repository | |
|---|---:|
| Counting each project | 14 |
| Unique (name + statement) | 14 |
| Unique, without the lemmas Lean generates itself (`eq_1`, `mk.inj`, `sizeOf_spec`, `deriving`) | 5 |

*Closed* means the kernel accepted the proof and it depends only on `propext`, `Classical.choice` and `Quot.sound`. It says that the statement as written in the file is proved; it does not say that an open problem is solved. Every statement is in `VERIFICACAO.json`. *Conditional* means the proof also uses axioms declared in the repository; *open* means it uses `sorry`. *Checked file by file* covers the files that no build reached: each one went through Lean whole, with a `#print axioms` for each theorem.

| Theorem | Project | State | Axioms beyond the standard three |
|---|---|---|---|
| `ResidualRegularity.shell_residual_smooth` | `formalization/lean (file by file)` | open | `sorryAx` |
| `ResidualRegularity.bv_decomposition` | `formalization/lean (file by file)` | open | `sorryAx` |
| `ResidualRegularity.blowup_criterion` | `formalization/lean (file by file)` | open | `sorryAx` |
| `LRE.NavierStokes.energyTransfer_bounded` | `formalization/lean (file by file)` | open | `sorryAx` |
| `LRE.ODE.continuous_ERS_stability` | `formalization/lean (file by file)` | open | `sorryAx` |
| `LRE.ODE.discrete_ERS_stability` | `formalization/lean (file by file)` | open | `sorryAx` |
| `Millennium.Lemmas.ODE_comparison` | `formalization/lean (file by file)` | open | `sorryAx` |
| `Millennium.Lemmas.gronwall_decay` | `formalization/lean (file by file)` | open | `sorryAx` |
| `Millennium.Lemmas.super_poly_dominates` | `formalization/lean (file by file)` | open | `sorryAx` |
| `Millennium.Lemmas.golden_ratio_approx` | `formalization/lean (file by file)` | open | `sorryAx` |
| `UnifiedTheory.coupling_symmetric` | `formalization/lean (file by file)` | open | `sorryAx` |
| `UnifiedTheory.potential_nonneg` | `formalization/lean (file by file)` | open | `sorryAx` |
| `UnifiedTheory.canonical_is_minimum` | `formalization/lean (file by file)` | open | `sorryAx` |
| `UnifiedTheory.canonical_strict_local_min` | `formalization/lean (file by file)` | open | `sorryAx` |
| `Hodge.StructuralBridge.bridge_hodge_to_curvature` | `proofs/hodge_conjecture (file by file)` | open | `sorryAx`, `Hodge.Foundations.AlgebraicVariety` |
| `YangMills.StructuralBridge.bridge_mass_gap_to_curvature` | `proofs/yang_mills (file by file)` | open | `sorryAx` |
| `YangMills.Reduction.main_reduction` | `proofs/yang_mills (file by file)` | open | `sorryAx` |

### Declared theorems

The `.lean` files of the verified commit declare 1 369 `theorem`/`lemma` (counting copies). The kernel checked 19 of them (2 closed, 0 conditional, 17 open). The closed count in the table above is larger: it also counts the theorems Lean generates by itself (equation lemmas, structure fields, `deriving`), which are not written in the text. For 1 350 the kernel has no result:

| Reason | Theorems |
|---|---:|
| checked file by file: Lean did not reach the theorem (missing import, syntax error or timeout) | 1 288 |
| checked file by file: the written proof does not pass the kernel | 62 |

### MVEI corrections

* `correcoes/imports-no-topo.patch` (import fora do início do arquivo, 37 file(s)): applies to the published sources: `git apply -p1 --directory=imports/universal-emergent-logic- mvei/universal-emergent-logic-/correcoes/imports-no-topo.patch` (in order, after the ones above)
* `correcoes/renomear-imports-mathlib.patch` (import de módulo que não existe na versão do Mathlib do projeto (renomeado ou dividido), 56 file(s)): applies to the published sources: `git apply -p1 --directory=imports/universal-emergent-logic- mvei/universal-emergent-logic-/correcoes/renomear-imports-mathlib.patch` (in order, after the ones above)

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
