# MVEI kernel check — Meta-millenium-independence-00

This folder records what the Lean 4 kernel said about the Lean sources of the private repository `ShantiDraconis/Meta-millenium-independence-00`. The sources are published in [`imports/Meta-millenium-independence-00/`](../../imports/Meta-millenium-independence-00/).

## What is published

* Source: `ShantiDraconis/Meta-millenium-independence-00`, commit `54627a7b232420e9872020a99e663832a842967d` (2026-09-12T10:07:35Z).
* 53 files: 51 `.lean` files and the Lake files (`lakefile.*`, `lean-toolchain`, `lake-manifest.json`), plus 1 license or origin file(s) that third-party code requires (`LICENSE`). Paths are the same as in the source repository.
* Nothing else from the private repository is published (documents, commercial license, prompts, storefront material).
* `SOURCES.sha256` lists every published file with its SHA-256. From the repository root: `sha256sum -c mvei/Meta-millenium-independence-00/SOURCES.sha256`.

## What the kernel said

MVEI verification of 2026-10-29T01:49:57+00:00, on commit `54627a7b232420e9872020a99e663832a842967d`. Each theorem was read with `Lean.collectAxioms`, the function behind `#print axioms`.

| Lean project | Lean version | Build | Closed | Conditional | Open (`sorry`) | Checked file by file: closed / conditional / open / proof error / not reached |
|---|---|---|---:|---:|---:|---|
| `src/lean` | v4.3.0 | partial | 3 | 0 | 0 | 5 / 0 / 1 / 0 / 20 |

| Closed theorems in this repository | |
|---|---:|
| Counting each project | 8 |
| Unique (name + statement) | 8 |
| Unique, without the lemmas Lean generates itself (`eq_1`, `mk.inj`, `sizeOf_spec`, `deriving`) | 5 |

*Closed* means the kernel accepted the proof and it depends only on `propext`, `Classical.choice` and `Quot.sound`. It says that the statement as written in the file is proved; it does not say that an open problem is solved. Every statement is in `VERIFICACAO.json`. *Conditional* means the proof also uses axioms declared in the repository; *open* means it uses `sorry`. *Checked file by file* covers the files that no build reached: each one went through Lean whole, with a `#print axioms` for each theorem.

| Theorem | Project | State | Axioms beyond the standard three |
|---|---|---|---|
| `MetaMillennium.Core.independence_via_consistency` | `src/lean (file by file)` | open | `sorryAx` |

### Declared theorems

The `.lean` files of the verified commit declare 26 `theorem`/`lemma` (counting copies). The kernel checked 6 of them (5 closed, 0 conditional, 1 open). The closed count in the table above is larger: it also counts the theorems Lean generates by itself (equation lemmas, structure fields, `deriving`), which are not written in the text. For 20 the kernel has no result:

| Reason | Theorems |
|---|---:|
| checked file by file: Lean did not reach the theorem (missing import, syntax error or timeout) | 20 |

## Files in this folder

* `VERIFICACAO.json` — each Lean project of this repository, each theorem the kernel read, its statement, its axioms and its state (`fechado` closed, `condicional` conditional, `aberto-sorry` open)
* `TEOREMAS.csv` — each declared `theorem`/`lemma`: file, line, state in the kernel (`nao_checado` = not checked) and, if not checked, why (in Portuguese)
* `BUILD_LOG.txt` — one block per project: Lean version, result, errors
* `SOURCE.json` — source commit, verified commit and dates, machine-readable
* `SOURCES.sha256` — SHA-256 of every published file

## Reproduce

```
cd imports/Meta-millenium-independence-00/<project>   # a project folder from the table above ('.' is imports/Meta-millenium-independence-00)
lake exe cache get           # only for projects that require Mathlib
lake build
```

Each project uses the Lean version in its own `lean-toolchain`, which elan installs. The MVEI pipeline that produced these results is in the author's repository and is not public.
