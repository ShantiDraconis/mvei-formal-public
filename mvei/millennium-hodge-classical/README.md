# MVEI kernel check — millennium-hodge-classical

This folder records what the Lean 4 kernel said about the Lean sources of the private repository `ShantiDraconis/millennium-hodge-classical`. The sources are published in [`imports/millennium-hodge-classical/`](../../imports/millennium-hodge-classical/).

## What is published

* Source: `ShantiDraconis/millennium-hodge-classical`, commit `63d59b2c49c25d98d25ae462a57fe79cae26adfc` (2026-09-18T04:11:53Z).
* 31 files: 29 `.lean` files and the Lake files (`lakefile.*`, `lean-toolchain`, `lake-manifest.json`), plus 1 license or origin file(s) that third-party code requires (`LICENSE`). Paths are the same as in the source repository.
* Nothing else from the private repository is published (documents, commercial license, prompts, storefront material).
* `SOURCES.sha256` lists every published file with its SHA-256. From the repository root: `sha256sum -c mvei/millennium-hodge-classical/SOURCES.sha256`.

## What the kernel said

MVEI verification of 2026-10-28T19:11:15+00:00, on commit `63d59b2c49c25d98d25ae462a57fe79cae26adfc`. Each theorem was read with `Lean.collectAxioms`, the function behind `#print axioms`.

| Lean project | Lean version | Build | Closed | Conditional | Open (`sorry`) | Checked file by file: closed / conditional / open / proof error / not reached |
|---|---|---|---:|---:|---:|---|
| `lean` | v4.12.0 | partial | 19 | 0 | 0 | 72 / 0 / 3 / 62 / 0 |

| Closed theorems in this repository | |
|---|---:|
| Counting each project | 91 |
| Unique (name + statement) | 89 |
| Unique, without the lemmas Lean generates itself (`eq_1`, `mk.inj`, `sizeOf_spec`, `deriving`) | 75 |

*Closed* means the kernel accepted the proof and it depends only on `propext`, `Classical.choice` and `Quot.sound`. It says that the statement as written in the file is proved; it does not say that an open problem is solved. Every statement is in `VERIFICACAO.json`. *Conditional* means the proof also uses axioms declared in the repository; *open* means it uses `sorry`. *Checked file by file* covers the files that no build reached: each one went through Lean whole, with a `#print axioms` for each theorem.

| Theorem | Project | State | Axioms beyond the standard three |
|---|---|---|---|
| `Hodge.hodgeForProductOfCurves` | `lean (file by file)` | open | `sorryAx` |
| `Hodge.hodgeSymmetryHarmonic` | `lean (file by file)` | open | `sorryAx` |
| `Hodge.hodgeSymmetry'` | `lean (file by file)` | open | `sorryAx` |

### Declared theorems

The `.lean` files of the verified commit declare 141 `theorem`/`lemma` (counting copies). The kernel checked 79 of them (76 closed, 0 conditional, 3 open). The closed count in the table above is larger: it also counts the theorems Lean generates by itself (equation lemmas, structure fields, `deriving`), which are not written in the text. For 62 the kernel has no result:

| Reason | Theorems |
|---|---:|
| checked file by file: the written proof does not pass the kernel | 62 |

## Files in this folder

* `VERIFICACAO.json` — each Lean project of this repository, each theorem the kernel read, its statement, its axioms and its state (`fechado` closed, `condicional` conditional, `aberto-sorry` open)
* `TEOREMAS.csv` — each declared `theorem`/`lemma`: file, line, state in the kernel (`nao_checado` = not checked) and, if not checked, why (in Portuguese)
* `BUILD_LOG.txt` — one block per project: Lean version, result, errors
* `SOURCE.json` — source commit, verified commit and dates, machine-readable
* `SOURCES.sha256` — SHA-256 of every published file

## Reproduce

```
cd imports/millennium-hodge-classical/<project>   # a project folder from the table above ('.' is imports/millennium-hodge-classical)
lake exe cache get           # only for projects that require Mathlib
lake build
```

Each project uses the Lean version in its own `lean-toolchain`, which elan installs. The MVEI pipeline that produced these results is in the author's repository and is not public.
