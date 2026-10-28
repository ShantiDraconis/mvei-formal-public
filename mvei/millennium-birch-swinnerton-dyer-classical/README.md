# MVEI kernel check — millennium-birch-swinnerton-dyer-classical

This folder records what the Lean 4 kernel said about the Lean sources of the private repository `ShantiDraconis/millennium-birch-swinnerton-dyer-classical`. The sources are published in [`imports/millennium-birch-swinnerton-dyer-classical/`](../../imports/millennium-birch-swinnerton-dyer-classical/).

## What is published

* Source: `ShantiDraconis/millennium-birch-swinnerton-dyer-classical`, commit `44edb40cb18d994ff785d95e56d78767d0d5d15c` (2026-09-18T04:12:04Z).
* 52 files: 51 `.lean` files and the Lake files (`lakefile.*`, `lean-toolchain`, `lake-manifest.json`), plus 1 license or origin file(s) that third-party code requires (`LICENSE`). Paths are the same as in the source repository.
* Nothing else from the private repository is published (documents, commercial license, prompts, storefront material).
* `SOURCES.sha256` lists every published file with its SHA-256. From the repository root: `sha256sum -c mvei/millennium-birch-swinnerton-dyer-classical/SOURCES.sha256`.

## What the kernel said

MVEI verification of 2026-10-28T16:41:02+00:00, on commit `44edb40cb18d994ff785d95e56d78767d0d5d15c`. Each theorem was read with `Lean.collectAxioms`, the function behind `#print axioms`.

| Lean project | Lean version | Build | Closed | Conditional | Open (`sorry`) | Checked file by file: closed / conditional / open / proof error / not reached |
|---|---|---|---:|---:|---:|---|
| `src/lean` (no lakefile; project assembled by MVEI) | v4.19.0 | partial | 17 | 0 | 0 | 0 / 0 / 9 / 6 / 209 |
| `tests/lean` (no lakefile; project assembled by MVEI) | padrão do elan | OK | 0 | 0 | 0 | — |

| Closed theorems in this repository | |
|---|---:|
| Counting each project | 17 |
| Unique (name + statement) | 17 |
| Unique, without the lemmas Lean generates itself (`eq_1`, `mk.inj`, `sizeOf_spec`, `deriving`) | 3 |

*Closed* means the kernel accepted the proof and it depends only on `propext`, `Classical.choice` and `Quot.sound`. It says that the statement as written in the file is proved; it does not say that an open problem is solved. Every statement is in `VERIFICACAO.json`. *Conditional* means the proof also uses axioms declared in the repository; *open* means it uses `sorry`. *Checked file by file* covers the files that no build reached: each one went through Lean whole, with a `#print axioms` for each theorem.

| Theorem | Project | State | Axioms beyond the standard three |
|---|---|---|---|
| `LSeriesCoefficients.a_multiplicative` | `src/lean (file by file)` | open | `sorryAx` |
| `LSeriesCoefficients.a_one` | `src/lean (file by file)` | open | `sorryAx` |
| `absoluteConvergenceRegion` | `src/lean (file by file)` | open | `sorryAx` |
| `conditionalConvergenceRegion` | `src/lean (file by file)` | open | `sorryAx` |
| `lowerDerivativesVanish` | `src/lean (file by file)` | open | `LFunctionClassical`, `sorryAx` |
| `leadingDerivative_nonzero` | `src/lean (file by file)` | open | `LFunctionClassical`, `sorryAx` |
| `leadingCoefficient_limit` | `src/lean (file by file)` | open | `LFunctionClassical`, `sorryAx` |
| `thetaSeries_convergence` | `src/lean (file by file)` | open | `sorryAx` |
| `functionalEquation_from_modularity` | `src/lean (file by file)` | open | `LFunctionClassical`, `functionalEquation`, `rootNumber`, `sorryAx` |

### Declared theorems

The `.lean` files of the verified commit declare 225 `theorem`/`lemma` (counting copies). The kernel checked 10 of them (1 closed, 0 conditional, 9 open). The closed count in the table above is larger: it also counts the theorems Lean generates by itself (equation lemmas, structure fields, `deriving`), which are not written in the text. For 215 the kernel has no result:

| Reason | Theorems |
|---|---:|
| checked file by file: Lean did not reach the theorem (missing import, syntax error or timeout) | 209 |
| checked file by file: the written proof does not pass the kernel | 6 |

### MVEI corrections

* `correcoes/imports-no-topo.patch` (import fora do início do arquivo, 12 file(s)): applies to the published sources: `git apply -p1 --directory=imports/millennium-birch-swinnerton-dyer-classical mvei/millennium-birch-swinnerton-dyer-classical/correcoes/imports-no-topo.patch` (in order, after the ones above)
* `correcoes/renomear-imports-mathlib.patch` (import de módulo que não existe na versão do Mathlib do projeto (renomeado ou dividido), 4 file(s)): applies to the published sources: `git apply -p1 --directory=imports/millennium-birch-swinnerton-dyer-classical mvei/millennium-birch-swinnerton-dyer-classical/correcoes/renomear-imports-mathlib.patch` (in order, after the ones above)

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
