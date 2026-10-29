# MVEI kernel check — 0-0-FORMAL-SUITE

This folder records what the Lean 4 kernel said about the Lean sources of the private repository `ShantiDraconis/0-0-FORMAL-SUITE`. The sources are published in [`imports/0-0-FORMAL-SUITE/`](../../imports/0-0-FORMAL-SUITE/).

## What is published

* Source: `ShantiDraconis/0-0-FORMAL-SUITE`, commit `fcc67dd53fa0e6d37c0c0c2f8bf682813e8c7850` (2026-10-05T19:31:15Z).
* 19 files: 17 `.lean` files and the Lake files (`lakefile.*`, `lean-toolchain`, `lake-manifest.json`), plus 1 license or origin file(s) that third-party code requires (`LICENSE`). Paths are the same as in the source repository.
* Nothing else from the private repository is published (documents, commercial license, prompts, storefront material).
* `SOURCES.sha256` lists every published file with its SHA-256. From the repository root: `sha256sum -c mvei/0-0-FORMAL-SUITE/SOURCES.sha256`.

## What the kernel said

MVEI verification of 2026-10-29T01:06:09+00:00, on commit `fcc67dd53fa0e6d37c0c0c2f8bf682813e8c7850`. Each theorem was read with `Lean.collectAxioms`, the function behind `#print axioms`.

| Lean project | Lean version | Build | Closed | Conditional | Open (`sorry`) | Checked file by file: closed / conditional / open / proof error / not reached |
|---|---|---|---:|---:|---:|---|
| `.` | v4.12.0 | partial | 81 | 0 | 0 | 13 / 0 / 2 / 10 / 43 |

| Closed theorems in this repository | |
|---|---:|
| Counting each project | 94 |
| Unique (name + statement) | 94 |
| Unique, without the lemmas Lean generates itself (`eq_1`, `mk.inj`, `sizeOf_spec`, `deriving`) | 62 |

*Closed* means the kernel accepted the proof and it depends only on `propext`, `Classical.choice` and `Quot.sound`. It says that the statement as written in the file is proved; it does not say that an open problem is solved. Every statement is in `VERIFICACAO.json`. *Conditional* means the proof also uses axioms declared in the repository; *open* means it uses `sorry`. *Checked file by file* covers the files that no build reached: each one went through Lean whole, with a `#print axioms` for each theorem.

| Theorem | Project | State | Axioms beyond the standard three |
|---|---|---|---|
| `FormalSuite.Geometry.collapse_to_fixed_point` | `. (file by file)` | open | `sorryAx` |
| `FormalSuite.IOperatorAlgebra.projector_complement_sum` | `. (file by file)` | open | `sorryAx` |

### Declared theorems

The `.lean` files of the verified commit declare 102 `theorem`/`lemma` (counting copies). The kernel checked 60 of them (58 closed, 0 conditional, 2 open). The closed count in the table above is larger: it also counts the theorems Lean generates by itself (equation lemmas, structure fields, `deriving`), which are not written in the text. For 42 the kernel has no result:

| Reason | Theorems |
|---|---:|
| checked file by file: Lean did not reach the theorem (missing import, syntax error or timeout) | 32 |
| checked file by file: the written proof does not pass the kernel | 10 |

## Files in this folder

* `VERIFICACAO.json` — each Lean project of this repository, each theorem the kernel read, its statement, its axioms and its state (`fechado` closed, `condicional` conditional, `aberto-sorry` open)
* `TEOREMAS.csv` — each declared `theorem`/`lemma`: file, line, state in the kernel (`nao_checado` = not checked) and, if not checked, why (in Portuguese)
* `BUILD_LOG.txt` — one block per project: Lean version, result, errors
* `SOURCE.json` — source commit, verified commit and dates, machine-readable
* `SOURCES.sha256` — SHA-256 of every published file

## Reproduce

```
cd imports/0-0-FORMAL-SUITE/<project>   # a project folder from the table above ('.' is imports/0-0-FORMAL-SUITE)
lake exe cache get           # only for projects that require Mathlib
lake build
```

Each project uses the Lean version in its own `lean-toolchain`, which elan installs. The MVEI pipeline that produced these results is in the author's repository and is not public.
