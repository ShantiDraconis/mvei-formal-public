# MVEI kernel check — open-math-scoped-final

This folder records what the Lean 4 kernel said about the Lean sources of the private repository `ShantiDraconis/open-math-scoped-final`. The sources are published in [`imports/open-math-scoped-final/`](../../imports/open-math-scoped-final/).

## What is published

* Source: `ShantiDraconis/open-math-scoped-final`, commit `e0f15e7520f6716188d9c089795bbf0018a0140c` (2026-09-25T09:50:54Z).
* 39 files: 38 `.lean` files and the Lake files (`lakefile.*`, `lean-toolchain`, `lake-manifest.json`). Paths are the same as in the source repository.
* Nothing else from the private repository is published (documents, commercial license, prompts, storefront material).
* `SOURCES.sha256` lists every published file with its SHA-256. From the repository root: `sha256sum -c mvei/open-math-scoped-final/SOURCES.sha256`.

## What the kernel said

MVEI verification of 2026-10-29T01:49:57+00:00, on commit `e0f15e7520f6716188d9c089795bbf0018a0140c`. Each theorem was read with `Lean.collectAxioms`, the function behind `#print axioms`.

| Lean project | Lean version | Build | Closed | Conditional | Open (`sorry`) | Checked file by file: closed / conditional / open / proof error / not reached |
|---|---|---|---:|---:|---:|---|
| `RIEMANN` | v4.19.0 | partial | 95 | 0 | 0 | 15 / 0 / 0 / 0 / 3 |

| Closed theorems in this repository | |
|---|---:|
| Counting each project | 110 |
| Unique (name + statement) | 95 |
| Unique, without the lemmas Lean generates itself (`eq_1`, `mk.inj`, `sizeOf_spec`, `deriving`) | 67 |

*Closed* means the kernel accepted the proof and it depends only on `propext`, `Classical.choice` and `Quot.sound`. It says that the statement as written in the file is proved; it does not say that an open problem is solved. Every statement is in `VERIFICACAO.json`. *Conditional* means the proof also uses axioms declared in the repository; *open* means it uses `sorry`. *Checked file by file* covers the files that no build reached: each one went through Lean whole, with a `#print axioms` for each theorem.

### Declared theorems

The `.lean` files of the verified commit declare 73 `theorem`/`lemma` (counting copies). The kernel checked 70 of them (70 closed, 0 conditional, 0 open). The closed count in the table above is larger: it also counts the theorems Lean generates by itself (equation lemmas, structure fields, `deriving`), which are not written in the text. For 3 the kernel has no result:

| Reason | Theorems |
|---|---:|
| checked file by file: Lean did not reach the theorem (missing import, syntax error or timeout) | 3 |

## Files in this folder

* `VERIFICACAO.json` — each Lean project of this repository, each theorem the kernel read, its statement, its axioms and its state (`fechado` closed, `condicional` conditional, `aberto-sorry` open)
* `TEOREMAS.csv` — each declared `theorem`/`lemma`: file, line, state in the kernel (`nao_checado` = not checked) and, if not checked, why (in Portuguese)
* `BUILD_LOG.txt` — one block per project: Lean version, result, errors
* `SOURCE.json` — source commit, verified commit and dates, machine-readable
* `SOURCES.sha256` — SHA-256 of every published file

## Reproduce

```
cd imports/open-math-scoped-final/<project>   # a project folder from the table above ('.' is imports/open-math-scoped-final)
lake exe cache get           # only for projects that require Mathlib
lake build
```

Each project uses the Lean version in its own `lean-toolchain`, which elan installs. The MVEI pipeline that produced these results is in the author's repository and is not public.
