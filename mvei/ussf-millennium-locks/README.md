# MVEI kernel check — ussf-millennium-locks

This folder records what the Lean 4 kernel said about the Lean sources of the private repository `ShantiDraconis/ussf-millennium-locks`. The sources are published in [`imports/ussf-millennium-locks/`](../../imports/ussf-millennium-locks/).

## What is published

* Source: `ShantiDraconis/ussf-millennium-locks`, commit `ee952747d91e02a132c61ad93a4fd2a729568247` (2026-07-08T16:57:06Z).
* 3 files: 2 `.lean` files and the Lake files (`lakefile.*`, `lean-toolchain`, `lake-manifest.json`), plus 1 license or origin file(s) that third-party code requires (`LICENSE`). Paths are the same as in the source repository.
* Nothing else from the private repository is published (documents, commercial license, prompts, storefront material).
* `SOURCES.sha256` lists every published file with its SHA-256. From the repository root: `sha256sum -c mvei/ussf-millennium-locks/SOURCES.sha256`.

## What the kernel said

MVEI verification of 2026-10-29T11:55:34+00:00, on commit `ee952747d91e02a132c61ad93a4fd2a729568247`. Each theorem was read with `Lean.collectAxioms`, the function behind `#print axioms`.

| Lean project | Lean version | Build | Closed | Conditional | Open (`sorry`) | Checked file by file: closed / conditional / open / proof error / not reached |
|---|---|---|---:|---:|---:|---|
| `formal/lean` (no lakefile; project assembled by MVEI) | padrão do elan | partial | 16 | 0 | 0 | 0 / 0 / 0 / 1 / 0 |

| Closed theorems in this repository | |
|---|---:|
| Counting each project | 16 |
| Unique (name + statement) | 16 |
| Unique, without the lemmas Lean generates itself (`eq_1`, `mk.inj`, `sizeOf_spec`, `deriving`) | 4 |

*Closed* means the kernel accepted the proof and it depends only on `propext`, `Classical.choice` and `Quot.sound`. It says that the statement as written in the file is proved; it does not say that an open problem is solved. Every statement is in `VERIFICACAO.json`. *Conditional* means the proof also uses axioms declared in the repository; *open* means it uses `sorry`. *Checked file by file* covers the files that no build reached: each one went through Lean whole, with a `#print axioms` for each theorem.

### Declared theorems

The `.lean` files of the verified commit declare 3 `theorem`/`lemma` (counting copies). The kernel checked 2 of them (2 closed, 0 conditional, 0 open). The closed count in the table above is larger: it also counts the theorems Lean generates by itself (equation lemmas, structure fields, `deriving`), which are not written in the text. For 1 the kernel has no result:

| Reason | Theorems |
|---|---:|
| checked file by file: the written proof does not pass the kernel | 1 |

## Files in this folder

* `VERIFICACAO.json` — each Lean project of this repository, each theorem the kernel read, its statement, its axioms and its state (`fechado` closed, `condicional` conditional, `aberto-sorry` open)
* `TEOREMAS.csv` — each declared `theorem`/`lemma`: file, line, state in the kernel (`nao_checado` = not checked) and, if not checked, why (in Portuguese)
* `BUILD_LOG.txt` — one block per project: Lean version, result, errors
* `SOURCE.json` — source commit, verified commit and dates, machine-readable
* `SOURCES.sha256` — SHA-256 of every published file

## Reproduce

```
cd imports/ussf-millennium-locks/<project>   # a project folder from the table above ('.' is imports/ussf-millennium-locks)
lake exe cache get           # only for projects that require Mathlib
lake build
```

Each project uses the Lean version in its own `lean-toolchain`, which elan installs. The MVEI pipeline that produced these results is in the author's repository and is not public.
