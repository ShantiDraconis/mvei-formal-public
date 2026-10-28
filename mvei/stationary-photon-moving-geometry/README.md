# MVEI kernel check — stationary-photon-moving-geometry

This folder records what the Lean 4 kernel said about the Lean sources of the private repository `ShantiDraconis/stationary-photon-moving-geometry`. The sources are published in [`imports/stationary-photon-moving-geometry/`](../../imports/stationary-photon-moving-geometry/).

## What is published

* Source: `ShantiDraconis/stationary-photon-moving-geometry`, commit `bfd05570b324bdca88319e8c865d9c0b6acd4a98` (2026-09-27T14:39:38Z).
* 10 files: 8 `.lean` files and the Lake files (`lakefile.*`, `lean-toolchain`, `lake-manifest.json`). Paths are the same as in the source repository.
* Nothing else from the private repository is published (documents, commercial license, prompts, storefront material).
* `SOURCES.sha256` lists every published file with its SHA-256. From the repository root: `sha256sum -c mvei/stationary-photon-moving-geometry/SOURCES.sha256`.

## What the kernel said

MVEI verification of 2026-10-28T16:41:02+00:00, on commit `bfd05570b324bdca88319e8c865d9c0b6acd4a98`. Each theorem was read with `Lean.collectAxioms`, the function behind `#print axioms`.

| Lean project | Lean version | Build | Closed | Conditional | Open (`sorry`) | Checked file by file: closed / conditional / open / proof error / not reached |
|---|---|---|---:|---:|---:|---|
| `.` | v4.19.0 | OK | 52 | 0 | 0 | — |

| Closed theorems in this repository | |
|---|---:|
| Counting each project | 52 |
| Unique (name + statement) | 52 |
| Unique, without the lemmas Lean generates itself (`eq_1`, `mk.inj`, `sizeOf_spec`, `deriving`) | 22 |

*Closed* means the kernel accepted the proof and it depends only on `propext`, `Classical.choice` and `Quot.sound`. It says that the statement as written in the file is proved; it does not say that an open problem is solved. Every statement is in `VERIFICACAO.json`. *Conditional* means the proof also uses axioms declared in the repository; *open* means it uses `sorry`. *Checked file by file* covers the files that no build reached: each one went through Lean whole, with a `#print axioms` for each theorem.

### Declared theorems

The `.lean` files of the verified commit declare 12 `theorem`/`lemma` (counting copies). The kernel checked 12 of them (12 closed, 0 conditional, 0 open). The closed count in the table above is larger: it also counts the theorems Lean generates by itself (equation lemmas, structure fields, `deriving`), which are not written in the text.

## Files in this folder

* `VERIFICACAO.json` — each Lean project of this repository, each theorem the kernel read, its statement, its axioms and its state (`fechado` closed, `condicional` conditional, `aberto-sorry` open)
* `TEOREMAS.csv` — each declared `theorem`/`lemma`: file, line, state in the kernel (`nao_checado` = not checked) and, if not checked, why (in Portuguese)
* `BUILD_LOG.txt` — one block per project: Lean version, result, errors
* `SOURCE.json` — source commit, verified commit and dates, machine-readable
* `SOURCES.sha256` — SHA-256 of every published file

## Reproduce

```
cd imports/stationary-photon-moving-geometry/<project>   # a project folder from the table above ('.' is imports/stationary-photon-moving-geometry)
lake exe cache get           # only for projects that require Mathlib
lake build
```

Each project uses the Lean version in its own `lean-toolchain`, which elan installs. The MVEI pipeline that produced these results is in the author's repository and is not public.
