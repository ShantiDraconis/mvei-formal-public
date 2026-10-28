# MVEI kernel check — mishkan-iii-core

This folder records what the Lean 4 kernel said about the Lean sources of the private repository `ShantiDraconis/mishkan-iii-core`. The sources are published in [`imports/mishkan-iii-core/`](../../imports/mishkan-iii-core/).

## What is published

* Source: `ShantiDraconis/mishkan-iii-core`, commit `2e43209371b6c345d28b5dcabf4953bbb2cff104` (2026-09-18T09:56:23Z).
* 15 files: 15 `.lean` files and the Lake files (`lakefile.*`, `lean-toolchain`, `lake-manifest.json`). Paths are the same as in the source repository.
* Nothing else from the private repository is published (documents, commercial license, prompts, storefront material).
* `SOURCES.sha256` lists every published file with its SHA-256. From the repository root: `sha256sum -c mvei/mishkan-iii-core/SOURCES.sha256`.

## What the kernel said

MVEI verification of 2026-10-28T19:11:15+00:00, on commit `2e43209371b6c345d28b5dcabf4953bbb2cff104`. Each theorem was read with `Lean.collectAxioms`, the function behind `#print axioms`.

| Lean project | Lean version | Build | Closed | Conditional | Open (`sorry`) | Checked file by file: closed / conditional / open / proof error / not reached |
|---|---|---|---:|---:|---:|---|
| `core` (no lakefile; project assembled by MVEI) | v4.19.0 | partial | 14 | 0 | 0 | 46 / 1 / 8 / 624 / 17886 |

| Closed theorems in this repository | |
|---|---:|
| Counting each project | 60 |
| Unique (name + statement) | 60 |
| Unique, without the lemmas Lean generates itself (`eq_1`, `mk.inj`, `sizeOf_spec`, `deriving`) | 48 |

*Closed* means the kernel accepted the proof and it depends only on `propext`, `Classical.choice` and `Quot.sound`. It says that the statement as written in the file is proved; it does not say that an open problem is solved. Every statement is in `VERIFICACAO.json`. *Conditional* means the proof also uses axioms declared in the repository; *open* means it uses `sorry`. *Checked file by file* covers the files that no build reached: each one went through Lean whole, with a `#print axioms` for each theorem.

| Theorem | Project | State | Axioms beyond the standard three |
|---|---|---|---|
| `HarappaCatalog.all_signs_have_valid_indices` | `core (file by file)` | open | `sorryAx` |
| `HarappaCatalog.catalog_authenticated` | `core (file by file)` | open | `sorryAx` |
| `PhaseZero.logic_predates_system` | `core (file by file)` | conditional | `PhaseZero.archaeological_priority_check` |
| `HarappaExpansion.timeline_fully_connected` | `core (file by file)` | open | `sorryAx` |
| `Migration2025System.migration_is_sequential` | `core (file by file)` | open | `sorryAx` |
| `ExhumationProof.all_evidence_supports_exhumation` | `core (file by file)` | open | `sorryAx` |
| `LineageMap.harappa_only_root` | `core (file by file)` | open | `sorryAx` |
| `fragmentation_unintelligible` | `core (file by file)` | open | `sorryAx` |
| `s5_requires_lineage` | `core (file by file)` | open | `sorryAx` |

### Declared theorems

The `.lean` files of the verified commit declare 18 567 `theorem`/`lemma` (counting copies). The kernel checked 57 of them (48 closed, 1 conditional, 8 open). The closed count in the table above is larger: it also counts the theorems Lean generates by itself (equation lemmas, structure fields, `deriving`), which are not written in the text. For 18 510 the kernel has no result:

| Reason | Theorems |
|---|---:|
| checked file by file: Lean did not reach the theorem (missing import, syntax error or timeout) | 17 886 |
| checked file by file: the written proof does not pass the kernel | 624 |

### MVEI corrections

* `correcoes/imports-no-topo.patch` (import fora do início do arquivo, 8 file(s)): applies to the published sources: `git apply -p1 --directory=imports/mishkan-iii-core mvei/mishkan-iii-core/correcoes/imports-no-topo.patch` (in order, after the ones above)
* `correcoes/renomear-imports-mathlib.patch` (import de módulo que não existe na versão do Mathlib do projeto (renomeado ou dividido), 2 file(s)): applies to the published sources: `git apply -p1 --directory=imports/mishkan-iii-core mvei/mishkan-iii-core/correcoes/renomear-imports-mathlib.patch` (in order, after the ones above)

## Files in this folder

* `VERIFICACAO.json` — each Lean project of this repository, each theorem the kernel read, its statement, its axioms and its state (`fechado` closed, `condicional` conditional, `aberto-sorry` open)
* `TEOREMAS.csv` — each declared `theorem`/`lemma`: file, line, state in the kernel (`nao_checado` = not checked) and, if not checked, why (in Portuguese)
* `BUILD_LOG.txt` — one block per project: Lean version, result, errors
* `SOURCE.json` — source commit, verified commit and dates, machine-readable
* `SOURCES.sha256` — SHA-256 of every published file

## Reproduce

```
cd imports/mishkan-iii-core/<project>   # a project folder from the table above ('.' is imports/mishkan-iii-core)
lake exe cache get           # only for projects that require Mathlib
lake build
```

Each project uses the Lean version in its own `lean-toolchain`, which elan installs. The MVEI pipeline that produced these results is in the author's repository and is not public.
