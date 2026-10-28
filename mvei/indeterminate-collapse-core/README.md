# MVEI kernel check — indeterminate-collapse-core

This folder records what the Lean 4 kernel said about the Lean sources of the private repository `ShantiDraconis/indeterminate-collapse-core`. The sources are published in [`imports/indeterminate-collapse-core/`](../../imports/indeterminate-collapse-core/).

## What is published

* Source: `ShantiDraconis/indeterminate-collapse-core`, commit `c2faccb496e6f2023be7706ee261e9d17af5a159` (2026-02-05T02:11:44Z).
* 2 files: 1 `.lean` files and the Lake files (`lakefile.*`, `lean-toolchain`, `lake-manifest.json`), plus 1 license or origin file(s) that third-party code requires (`LICENSE`). Paths are the same as in the source repository.
* Nothing else from the private repository is published (documents, commercial license, prompts, storefront material).
* `SOURCES.sha256` lists every published file with its SHA-256. From the repository root: `sha256sum -c mvei/indeterminate-collapse-core/SOURCES.sha256`.

## What the kernel said

MVEI verification of 2026-10-28T16:41:02+00:00, on commit `c2faccb496e6f2023be7706ee261e9d17af5a159`. Each theorem was read with `Lean.collectAxioms`, the function behind `#print axioms`.

| Lean project | Lean version | Build | Closed | Conditional | Open (`sorry`) | Checked file by file: closed / conditional / open / proof error / not reached |
|---|---|---|---:|---:|---:|---|
| `formal_attempts/lean` (no lakefile; project assembled by MVEI) | padrão do elan | failed | 0 | 0 | 0 | 1 / 1 / 1 / 3 / 0 |

| Closed theorems in this repository | |
|---|---:|
| Counting each project | 1 |
| Unique (name + statement) | 1 |
| Unique, without the lemmas Lean generates itself (`eq_1`, `mk.inj`, `sizeOf_spec`, `deriving`) | 1 |

*Closed* means the kernel accepted the proof and it depends only on `propext`, `Classical.choice` and `Quot.sound`. It says that the statement as written in the file is proved; it does not say that an open problem is solved. Every statement is in `VERIFICACAO.json`. *Conditional* means the proof also uses axioms declared in the repository; *open* means it uses `sorry`. *Checked file by file* covers the files that no build reached: each one went through Lean whole, with a `#print axioms` for each theorem.

| Theorem | Project | State | Axioms beyond the standard three |
|---|---|---|---|
| `I_not_known` | `formal_attempts/lean (file by file)` | conditional | `existence` |
| `riemann_collapses` | `formal_attempts/lean (file by file)` | open | `sorryAx` |

### Declared theorems

The `.lean` files of the verified commit declare 6 `theorem`/`lemma` (counting copies). The kernel checked 3 of them (1 closed, 1 conditional, 1 open). The closed count in the table above is larger: it also counts the theorems Lean generates by itself (equation lemmas, structure fields, `deriving`), which are not written in the text. For 3 the kernel has no result:

| Reason | Theorems |
|---|---:|
| checked file by file: the written proof does not pass the kernel | 3 |

## Files in this folder

* `VERIFICACAO.json` — each Lean project of this repository, each theorem the kernel read, its statement, its axioms and its state (`fechado` closed, `condicional` conditional, `aberto-sorry` open)
* `TEOREMAS.csv` — each declared `theorem`/`lemma`: file, line, state in the kernel (`nao_checado` = not checked) and, if not checked, why (in Portuguese)
* `BUILD_LOG.txt` — one block per project: Lean version, result, errors
* `SOURCE.json` — source commit, verified commit and dates, machine-readable
* `SOURCES.sha256` — SHA-256 of every published file

## Reproduce

```
cd imports/indeterminate-collapse-core/<project>   # a project folder from the table above ('.' is imports/indeterminate-collapse-core)
lake exe cache get           # only for projects that require Mathlib
lake build
```

Each project uses the Lean version in its own `lean-toolchain`, which elan installs. The MVEI pipeline that produced these results is in the author's repository and is not public.
