# MVEI kernel check — S5-Core-Private

This folder records what the Lean 4 kernel said about the Lean sources of the private repository `ShantiDraconis/S5-Core-Private`. The sources are published in [`imports/S5-Core-Private/`](../../imports/S5-Core-Private/).

## What is published

* Source: `ShantiDraconis/S5-Core-Private`, commit `feb89339d377722f8749a67abca4932209f003a5` (2026-02-10T12:09:46Z).
* 4 files: 3 `.lean` files and the Lake files (`lakefile.*`, `lean-toolchain`, `lake-manifest.json`). Paths are the same as in the source repository.
* Only the files with theorems the Lean kernel closed are published, with the local files they import; the rest of the repository (including files whose proofs fail, use `sorry` or declare axioms) stays private.
* Nothing else from the private repository is published (documents, commercial license, prompts, storefront material).
* `SOURCES.sha256` lists every published file with its SHA-256. From the repository root: `sha256sum -c mvei/S5-Core-Private/SOURCES.sha256`.

## What the kernel said

MVEI verification of 2026-10-28T19:11:15+00:00, on commit `feb89339d377722f8749a67abca4932209f003a5`. Each theorem was read with `Lean.collectAxioms`, the function behind `#print axioms`.

| Lean project | Lean version | Build | Closed | Conditional | Open (`sorry`) | Checked file by file: closed / conditional / open / proof error / not reached |
|---|---|---|---:|---:|---:|---|
| `lean` | padrão do elan | failed | 0 | 0 | 0 | 7 / 0 / 2 / 11 / 0 |

| Closed theorems in this repository | |
|---|---:|
| Counting each project | 7 |
| Unique (name + statement) | 7 |
| Unique, without the lemmas Lean generates itself (`eq_1`, `mk.inj`, `sizeOf_spec`, `deriving`) | 7 |

*Closed* means the kernel accepted the proof and it depends only on `propext`, `Classical.choice` and `Quot.sound`. It says that the statement as written in the file is proved; it does not say that an open problem is solved. Every statement is in `VERIFICACAO.json`. *Conditional* means the proof also uses axioms declared in the repository; *open* means it uses `sorry`. *Checked file by file* covers the files that no build reached: each one went through Lean whole, with a `#print axioms` for each theorem.

| Theorem | Project | State | Axioms beyond the standard three |
|---|---|---|---|
| `ShantiDraconis.sovereign_access_unique` | `lean (file by file)` | open | `sorryAx` |
| `ShantiDraconis.unauthorized_is_fraud` | `lean (file by file)` | open | `sorryAx` |

### Declared theorems

The `.lean` files of the verified commit declare 20 `theorem`/`lemma` (counting copies). The kernel checked 9 of them (7 closed, 0 conditional, 2 open). The closed count in the table above is larger: it also counts the theorems Lean generates by itself (equation lemmas, structure fields, `deriving`), which are not written in the text. For 11 the kernel has no result:

| Reason | Theorems |
|---|---:|
| checked file by file: the written proof does not pass the kernel | 11 |

## Files in this folder

* `VERIFICACAO.json` — each Lean project of this repository, each theorem the kernel read, its statement, its axioms and its state (`fechado` closed, `condicional` conditional, `aberto-sorry` open)
* `TEOREMAS.csv` — each declared `theorem`/`lemma`: file, line, state in the kernel (`nao_checado` = not checked) and, if not checked, why (in Portuguese)
* `BUILD_LOG.txt` — one block per project: Lean version, result, errors
* `SOURCE.json` — source commit, verified commit and dates, machine-readable
* `SOURCES.sha256` — SHA-256 of every published file

## Reproduce

```
cd imports/S5-Core-Private/<project>   # a project folder from the table above ('.' is imports/S5-Core-Private)
lake exe cache get           # only for projects that require Mathlib
lake build
```

Each project uses the Lean version in its own `lean-toolchain`, which elan installs. The MVEI pipeline that produced these results is in the author's repository and is not public.
