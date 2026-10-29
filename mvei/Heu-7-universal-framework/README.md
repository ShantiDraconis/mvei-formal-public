# MVEI kernel check — Heu-7-universal-framework

This folder records what the Lean 4 kernel said about the Lean sources of the private repository `ShantiDraconis/Heu-7-universal-framework`. The sources are published in [`imports/Heu-7-universal-framework/`](../../imports/Heu-7-universal-framework/).

## What is published

* Source: `ShantiDraconis/Heu-7-universal-framework`, commit `63b80b7623e831645f843e1f04385a1cfe17717a` (2025-12-02T13:31:55Z).
* 42 files: 41 `.lean` files and the Lake files (`lakefile.*`, `lean-toolchain`, `lake-manifest.json`), plus 1 license or origin file(s) that third-party code requires (`LICENSE`). Paths are the same as in the source repository.
* Nothing else from the private repository is published (documents, commercial license, prompts, storefront material).
* `SOURCES.sha256` lists every published file with its SHA-256. From the repository root: `sha256sum -c mvei/Heu-7-universal-framework/SOURCES.sha256`.

## What the kernel said

MVEI verification of 2026-10-29T01:06:09+00:00, on commit `63b80b7623e831645f843e1f04385a1cfe17717a`. Each theorem was read with `Lean.collectAxioms`, the function behind `#print axioms`.

| Lean project | Lean version | Build | Closed | Conditional | Open (`sorry`) | Checked file by file: closed / conditional / open / proof error / not reached |
|---|---|---|---:|---:|---:|---|
| `src/lean` | v4.19.0 | partial | 6 | 0 | 0 | 1 / 5 / 0 / 0 / 77 |

| Closed theorems in this repository | |
|---|---:|
| Counting each project | 7 |
| Unique (name + statement) | 7 |
| Unique, without the lemmas Lean generates itself (`eq_1`, `mk.inj`, `sizeOf_spec`, `deriving`) | 1 |

*Closed* means the kernel accepted the proof and it depends only on `propext`, `Classical.choice` and `Quot.sound`. It says that the statement as written in the file is proved; it does not say that an open problem is solved. Every statement is in `VERIFICACAO.json`. *Conditional* means the proof also uses axioms declared in the repository; *open* means it uses `sorry`. *Checked file by file* covers the files that no build reached: each one went through Lean whole, with a `#print axioms` for each theorem.

| Theorem | Project | State | Axioms beyond the standard three |
|---|---|---|---|
| `HEU.Core.ZF.dne` | `src/lean (file by file)` | conditional | `HEU.Core.ZF.em` |
| `HEU.Core.ZF.byContradiction` | `src/lean (file by file)` | conditional | `HEU.Core.ZF.em` |
| `HEU.Core.ZF.deMorgan1` | `src/lean (file by file)` | conditional | `HEU.Core.ZF.em` |
| `HEU.Core.ZF.classicalImpl` | `src/lean (file by file)` | conditional | `HEU.Core.ZF.em` |
| `HEU.Core.ZF.peirce` | `src/lean (file by file)` | conditional | `HEU.Core.ZF.em` |

### Declared theorems

The `.lean` files of the verified commit declare 83 `theorem`/`lemma` (counting copies). The kernel checked 6 of them (1 closed, 5 conditional, 0 open). The closed count in the table above is larger: it also counts the theorems Lean generates by itself (equation lemmas, structure fields, `deriving`), which are not written in the text. For 77 the kernel has no result:

| Reason | Theorems |
|---|---:|
| checked file by file: Lean did not reach the theorem (missing import, syntax error or timeout) | 77 |

## Files in this folder

* `VERIFICACAO.json` — each Lean project of this repository, each theorem the kernel read, its statement, its axioms and its state (`fechado` closed, `condicional` conditional, `aberto-sorry` open)
* `TEOREMAS.csv` — each declared `theorem`/`lemma`: file, line, state in the kernel (`nao_checado` = not checked) and, if not checked, why (in Portuguese)
* `BUILD_LOG.txt` — one block per project: Lean version, result, errors
* `SOURCE.json` — source commit, verified commit and dates, machine-readable
* `SOURCES.sha256` — SHA-256 of every published file

## Reproduce

```
cd imports/Heu-7-universal-framework/<project>   # a project folder from the table above ('.' is imports/Heu-7-universal-framework)
lake exe cache get           # only for projects that require Mathlib
lake build
```

Each project uses the Lean version in its own `lean-toolchain`, which elan installs. The MVEI pipeline that produced these results is in the author's repository and is not public.
