# MVEI kernel check — lean-audit-kit

This folder records what the Lean 4 kernel said about the Lean sources of the private repository `ShantiDraconis/lean-audit-kit`. The sources are published in [`imports/lean-audit-kit/`](../../imports/lean-audit-kit/).

## What is published

* Source: `ShantiDraconis/lean-audit-kit`, commit `853c03113860fe4468e6ce3b23845d4ce9780c0e` (2026-10-05T14:10:29Z).
* 13 files: 11 `.lean` files and the Lake files (`lakefile.*`, `lean-toolchain`, `lake-manifest.json`). Paths are the same as in the source repository.
* Nothing else from the private repository is published (documents, commercial license, prompts, storefront material).
* `SOURCES.sha256` lists every published file with its SHA-256. From the repository root: `sha256sum -c mvei/lean-audit-kit/SOURCES.sha256`.

## What the kernel said

MVEI verification of 2026-10-28T19:11:15+00:00, on commit `853c03113860fe4468e6ce3b23845d4ce9780c0e`. Each theorem was read with `Lean.collectAxioms`, the function behind `#print axioms`.

| Lean project | Lean version | Build | Closed | Conditional | Open (`sorry`) | Checked file by file: closed / conditional / open / proof error / not reached |
|---|---|---|---:|---:|---:|---|
| `.` | v4.19.0 | OK | 16 | 0 | 0 | 1 / 1 / 2 / 0 / 0 |

| Closed theorems in this repository | |
|---|---:|
| Counting each project | 17 |
| Unique (name + statement) | 17 |
| Unique, without the lemmas Lean generates itself (`eq_1`, `mk.inj`, `sizeOf_spec`, `deriving`) | 8 |

*Closed* means the kernel accepted the proof and it depends only on `propext`, `Classical.choice` and `Quot.sound`. It says that the statement as written in the file is proved; it does not say that an open problem is solved. Every statement is in `VERIFICACAO.json`. *Conditional* means the proof also uses axioms declared in the repository; *open* means it uses `sorry`. *Checked file by file* covers the files that no build reached: each one went through Lean whole, with a `#print axioms` for each theorem.

| Theorem | Project | State | Axioms beyond the standard three |
|---|---|---|---|
| `bad_admit` | `. (file by file)` | open | `sorryAx` |
| `explosion` | `. (file by file)` | conditional | `hiddenOracle` |
| `bad_sorry` | `. (file by file)` | open | `sorryAx` |

### Declared theorems

The `.lean` files of the verified commit declare 10 `theorem`/`lemma` (counting copies). The kernel checked 10 of them (7 closed, 1 conditional, 2 open). The closed count in the table above is larger: it also counts the theorems Lean generates by itself (equation lemmas, structure fields, `deriving`), which are not written in the text.

## Files in this folder

* `VERIFICACAO.json` — each Lean project of this repository, each theorem the kernel read, its statement, its axioms and its state (`fechado` closed, `condicional` conditional, `aberto-sorry` open)
* `TEOREMAS.csv` — each declared `theorem`/`lemma`: file, line, state in the kernel (`nao_checado` = not checked) and, if not checked, why (in Portuguese)
* `BUILD_LOG.txt` — one block per project: Lean version, result, errors
* `SOURCE.json` — source commit, verified commit and dates, machine-readable
* `SOURCES.sha256` — SHA-256 of every published file

## Reproduce

```
cd imports/lean-audit-kit/<project>   # a project folder from the table above ('.' is imports/lean-audit-kit)
lake exe cache get           # only for projects that require Mathlib
lake build
```

Each project uses the Lean version in its own `lean-toolchain`, which elan installs. The MVEI pipeline that produced these results is in the author's repository and is not public.
