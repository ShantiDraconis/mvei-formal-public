# MVEI kernel check — atk-certified-priority-record

This folder records what the Lean 4 kernel said about the Lean sources of the private repository `ShantiDraconis/atk-certified-priority-record`. The sources are published in [`imports/atk-certified-priority-record/`](../../imports/atk-certified-priority-record/).

## What is published

* Source: `ShantiDraconis/atk-certified-priority-record`, commit `c7f7df5228db78f998b14035273ae37d4c030fdf` (2026-10-12T16:55:56Z).
* 804 files: 804 `.lean` files and the Lake files (`lakefile.*`, `lean-toolchain`, `lake-manifest.json`). Paths are the same as in the source repository.
* Nothing else from the private repository is published (documents, commercial license, prompts, storefront material).
* `SOURCES.sha256` lists every published file with its SHA-256. From the repository root: `sha256sum -c mvei/atk-certified-priority-record/SOURCES.sha256`.

## What the kernel said

MVEI verification of 2026-10-28T16:41:02+00:00, on commit `c7f7df5228db78f998b14035273ae37d4c030fdf`. Each theorem was read with `Lean.collectAxioms`, the function behind `#print axioms`.

| Lean project | Lean version | Build | Closed | Conditional | Open (`sorry`) | Checked file by file: closed / conditional / open / proof error / not reached |
|---|---|---|---:|---:|---:|---|
| `snapshots/Elyon-Public-Proof` | v4.19.0 | partial | 870 | 0 | 0 | 75 / 0 / 0 / 16 / 143 |
| `snapshots/m-core-beal/atk-kernel` (no lakefile; project assembled by MVEI) | v4.19.0 | OK | 1 | 0 | 0 | — |
| `snapshots/m-core-beal/audit` (no lakefile; project assembled by MVEI) | padrão do elan | failed | 0 | 0 | 0 | 0 / 0 / 0 / 0 / 2 |
| `snapshots/m-core-beal/formal` (no lakefile; project assembled by MVEI) | padrão do elan | failed | 0 | 0 | 0 | 1 / 0 / 0 / 2 / 0 |
| `snapshots/m-core-beal/lean` (no lakefile; project assembled by MVEI) | padrão do elan | OK | 128 | 0 | 0 | — |
| `snapshots/m-core-bsd/atk-kernel` (no lakefile; project assembled by MVEI) | v4.19.0 | OK | 3 | 0 | 0 | — |
| `snapshots/m-core-bsd/audit` (no lakefile; project assembled by MVEI) | padrão do elan | failed | 0 | 0 | 0 | 0 / 0 / 0 / 0 / 2 |
| `snapshots/m-core-bsd/lean` (no lakefile; project assembled by MVEI) | padrão do elan | OK | 164 | 0 | 0 | — |
| `snapshots/m-core-hodge/atk-kernel` (no lakefile; project assembled by MVEI) | v4.19.0 | OK | 2 | 0 | 0 | — |
| `snapshots/m-core-hodge/audit` (no lakefile; project assembled by MVEI) | padrão do elan | failed | 0 | 0 | 0 | 0 / 0 / 0 / 0 / 25 |
| `snapshots/m-core-hodge/lean` (no lakefile; project assembled by MVEI) | v4.19.0 | partial | 1 234 | 0 | 0 | — |
| `snapshots/m-core-hodge/open_math` (no lakefile; project assembled by MVEI) | padrão do elan | failed | 0 | 0 | 0 | 0 / 0 / 0 / 0 / 5 |
| `snapshots/m-core-p-vs-np/atk-kernel` (no lakefile; project assembled by MVEI) | v4.19.0 | OK | 2 | 0 | 0 | — |
| `snapshots/m-core-p-vs-np/audit` (no lakefile; project assembled by MVEI) | padrão do elan | failed | 0 | 0 | 0 | 0 / 0 / 0 / 0 / 402 |
| `snapshots/m-core-p-vs-np/lean` (no lakefile; project assembled by MVEI) | v4.19.0 | partial | 1 590 | 0 | 0 | 10 / 0 / 0 / 1 / 0 |
| `snapshots/m-core-p-vs-np/probe` (no lakefile; project assembled by MVEI) | padrão do elan | failed | 0 | 0 | 0 | — |
| `snapshots/m-core-riemann/atk-kernel` (no lakefile; project assembled by MVEI) | padrão do elan | failed | 0 | 0 | 0 | 3 / 0 / 0 / 1 / 0 |
| `snapshots/m-core-riemann/audit` (no lakefile; project assembled by MVEI) | padrão do elan | failed | 0 | 0 | 0 | 0 / 0 / 0 / 0 / 4 |
| `snapshots/m-core-riemann/lean` (no lakefile; project assembled by MVEI) | padrão do elan | partial | 177 | 0 | 0 | 0 / 0 / 1 / 0 / 0 |
| `snapshots/m-core-yang-mills/MCore/YM` (no lakefile; project assembled by MVEI) | padrão do elan | OK | 13 | 0 | 0 | — |
| `snapshots/m-core-yang-mills/atk-kernel` (no lakefile; project assembled by MVEI) | padrão do elan | failed | 0 | 0 | 0 | 0 / 0 / 1 / 1 / 0 |
| `snapshots/m-core-yang-mills/lean` (no lakefile; project assembled by MVEI) | padrão do elan | OK | 94 | 0 | 0 | — |
| `snapshots/navier-stokes-critical-barrier-audit` (no lakefile; project assembled by MVEI) | padrão do elan | failed | 0 | 0 | 0 | — |

| Closed theorems in this repository | |
|---|---:|
| Counting each project | 4 367 |
| Unique (name + statement) | 3 565 |
| Unique, without the lemmas Lean generates itself (`eq_1`, `mk.inj`, `sizeOf_spec`, `deriving`) | 1 839 |

*Closed* means the kernel accepted the proof and it depends only on `propext`, `Classical.choice` and `Quot.sound`. It says that the statement as written in the file is proved; it does not say that an open problem is solved. Every statement is in `VERIFICACAO.json`. *Conditional* means the proof also uses axioms declared in the repository; *open* means it uses `sorry`. *Checked file by file* covers the files that no build reached: each one went through Lean whole, with a `#print axioms` for each theorem.

| Theorem | Project | State | Axioms beyond the standard three |
|---|---|---|---|
| `MCore.Material.closure_produces_bound` | `snapshots/m-core-riemann/lean (file by file)` | open | `sorryAx` |
| `ATK.YangMills.effective_mass_slope_nonpos` | `snapshots/m-core-yang-mills/atk-kernel (file by file)` | open | `sorryAx` |

### Declared theorems

The `.lean` files of the verified commit declare 3 043 `theorem`/`lemma` (counting copies). The kernel checked 1 740 of them (1 738 closed, 0 conditional, 2 open). The closed count in the table above is larger: it also counts the theorems Lean generates by itself (equation lemmas, structure fields, `deriving`), which are not written in the text. For 1 303 the kernel has no result:

| Reason | Theorems |
|---|---:|
| the file did not compile (an error in it or in a file it imports) | 670 |
| checked file by file: Lean did not reach the theorem (missing import, syntax error or timeout) | 583 |
| the file compiled, but the name did not appear in the kernel (private, mutual or macro-generated) | 29 |
| checked file by file: the written proof does not pass the kernel | 21 |

### MVEI corrections

* `correcoes/imports-no-topo.patch` (import fora do início do arquivo, 13 file(s)): applies to the published sources: `git apply -p1 --directory=imports/atk-certified-priority-record mvei/atk-certified-priority-record/correcoes/imports-no-topo.patch` (in order, after the ones above)

## Files in this folder

* `VERIFICACAO.json` — each Lean project of this repository, each theorem the kernel read, its statement, its axioms and its state (`fechado` closed, `condicional` conditional, `aberto-sorry` open)
* `TEOREMAS.csv` — each declared `theorem`/`lemma`: file, line, state in the kernel (`nao_checado` = not checked) and, if not checked, why (in Portuguese)
* `BUILD_LOG.txt` — one block per project: Lean version, result, errors
* `SOURCE.json` — source commit, verified commit and dates, machine-readable
* `SOURCES.sha256` — SHA-256 of every published file

## Reproduce

```
cd imports/atk-certified-priority-record/<project>   # a project folder from the table above ('.' is imports/atk-certified-priority-record)
lake exe cache get           # only for projects that require Mathlib
lake build
```

Each project uses the Lean version in its own `lean-toolchain`, which elan installs. The MVEI pipeline that produced these results is in the author's repository and is not public.
