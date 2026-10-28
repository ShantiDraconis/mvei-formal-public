# MVEI kernel check — Trans

This folder records what the Lean 4 kernel said about the Lean sources of the private repository `ShantiDraconis/Trans`. The sources are published in [`imports/Trans/`](../../imports/Trans/).

## What is published

* Source: `ShantiDraconis/Trans`, commit `74cb8d6ab468f31b116bb0cbcbb2776f9d6cac73` (2025-11-23T04:09:03Z).
* 123 files: 113 `.lean` files and the Lake files (`lakefile.*`, `lean-toolchain`, `lake-manifest.json`), plus 1 license or origin file(s) that third-party code requires (`LICENSE`). Paths are the same as in the source repository.
* Nothing else from the private repository is published (documents, commercial license, prompts, storefront material).
* `SOURCES.sha256` lists every published file with its SHA-256. From the repository root: `sha256sum -c mvei/Trans/SOURCES.sha256`.

## What the kernel said

MVEI verification of 2026-10-28T19:11:15+00:00, on commit `74cb8d6ab468f31b116bb0cbcbb2776f9d6cac73`. Each theorem was read with `Lean.collectAxioms`, the function behind `#print axioms`.

| Lean project | Lean version | Build | Closed | Conditional | Open (`sorry`) | Checked file by file: closed / conditional / open / proof error / not reached |
|---|---|---|---:|---:|---:|---|
| `core/lean` (no lakefile; project assembled by MVEI) | v4.19.0 | OK | 3 | 0 | 0 | — |
| `i-constant-core/formal/lean` | stable | OK | 0 | 0 | 0 | — |
| `millennium-bsd-hodge-yangmills-I/formal/lean` | stable | OK | 0 | 0 | 0 | — |
| `millennium-engineering-00/formal/lean` | stable | OK | 0 | 0 | 0 | — |
| `millennium-navier-stokes-I/formal/lean` | stable | OK | 0 | 0 | 0 | — |
| `millennium-p-vs-np-I/formal/lean` | stable | OK | 0 | 0 | 0 | — |
| `millennium-riemann-I/formal/lean4` | stable | OK | 1 | 0 | 0 | — |
| `millennium-symbolic-program/formal-interfaces/lean` | stable | OK | 0 | 0 | 0 | — |
| `millennium/riemann/lean` (no lakefile; project assembled by MVEI) | padrão do elan | failed | 0 | 0 | 0 | — |
| `proofs-multiprover/formal/lean` | v4.19.0 | OK | 0 | 0 | 0 | — |
| `proofs/lean` | v4.36.0-rc2 | OK | 0 | 0 | 0 | — |
| `sbfe-physics-unified/formal/lean` | stable | OK | 0 | 0 | 0 | — |

| Closed theorems in this repository | |
|---|---:|
| Counting each project | 4 |
| Unique (name + statement) | 4 |
| Unique, without the lemmas Lean generates itself (`eq_1`, `mk.inj`, `sizeOf_spec`, `deriving`) | 1 |

*Closed* means the kernel accepted the proof and it depends only on `propext`, `Classical.choice` and `Quot.sound`. It says that the statement as written in the file is proved; it does not say that an open problem is solved. Every statement is in `VERIFICACAO.json`. *Conditional* means the proof also uses axioms declared in the repository; *open* means it uses `sorry`. *Checked file by file* covers the files that no build reached: each one went through Lean whole, with a `#print axioms` for each theorem.

### Declared theorems

The `.lean` files of the verified commit declare 1 `theorem`/`lemma` (counting copies). The kernel checked 1 of them (1 closed, 0 conditional, 0 open). The closed count in the table above is larger: it also counts the theorems Lean generates by itself (equation lemmas, structure fields, `deriving`), which are not written in the text.

## Files in this folder

* `VERIFICACAO.json` — each Lean project of this repository, each theorem the kernel read, its statement, its axioms and its state (`fechado` closed, `condicional` conditional, `aberto-sorry` open)
* `TEOREMAS.csv` — each declared `theorem`/`lemma`: file, line, state in the kernel (`nao_checado` = not checked) and, if not checked, why (in Portuguese)
* `BUILD_LOG.txt` — one block per project: Lean version, result, errors
* `SOURCE.json` — source commit, verified commit and dates, machine-readable
* `SOURCES.sha256` — SHA-256 of every published file

## Reproduce

```
cd imports/Trans/<project>   # a project folder from the table above ('.' is imports/Trans)
lake exe cache get           # only for projects that require Mathlib
lake build
```

Each project uses the Lean version in its own `lean-toolchain`, which elan installs. The MVEI pipeline that produced these results is in the author's repository and is not public.
