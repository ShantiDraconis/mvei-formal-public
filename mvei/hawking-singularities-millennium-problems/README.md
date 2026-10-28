# MVEI kernel check — hawking-singularities-millennium-problems

This folder records what the Lean 4 kernel said about the Lean sources of the private repository `ShantiDraconis/hawking-singularities-millennium-problems`. The sources are published in [`imports/hawking-singularities-millennium-problems/`](../../imports/hawking-singularities-millennium-problems/).

## What is published

* Source: `ShantiDraconis/hawking-singularities-millennium-problems`, commit `405bd93a8ba2e1da819acdd5ebf3eed49f167d51` (2025-12-02T13:22:02Z).
* 22 files: 21 `.lean` files and the Lake files (`lakefile.*`, `lean-toolchain`, `lake-manifest.json`), plus 1 license or origin file(s) that third-party code requires (`LICENSE`). Paths are the same as in the source repository.
* Nothing else from the private repository is published (documents, commercial license, prompts, storefront material).
* `SOURCES.sha256` lists every published file with its SHA-256. From the repository root: `sha256sum -c mvei/hawking-singularities-millennium-problems/SOURCES.sha256`.

## What the kernel said

MVEI verification of 2026-10-28T16:41:02+00:00, on commit `405bd93a8ba2e1da819acdd5ebf3eed49f167d51`. Each theorem was read with `Lean.collectAxioms`, the function behind `#print axioms`.

| Lean project | Lean version | Build | Closed | Conditional | Open (`sorry`) | Checked file by file: closed / conditional / open / proof error / not reached |
|---|---|---|---:|---:|---:|---|
| `lean` (no lakefile; project assembled by MVEI) | v4.19.0 | partial | 22 | 0 | 4 | 0 / 0 / 1 / 1 / 1 |
| `src/lean` (no lakefile; project assembled by MVEI) | padrão do elan | failed | 0 | 0 | 0 | 3 / 0 / 0 / 1 / 17 |

| Closed theorems in this repository | |
|---|---:|
| Counting each project | 25 |
| Unique (name + statement) | 25 |
| Unique, without the lemmas Lean generates itself (`eq_1`, `mk.inj`, `sizeOf_spec`, `deriving`) | 10 |

*Closed* means the kernel accepted the proof and it depends only on `propext`, `Classical.choice` and `Quot.sound`. It says that the statement as written in the file is proved; it does not say that an open problem is solved. Every statement is in `VERIFICACAO.json`. *Conditional* means the proof also uses axioms declared in the repository; *open* means it uses `sorry`. *Checked file by file* covers the files that no build reached: each one went through Lean whole, with a `#print axioms` for each theorem.

| Theorem | Project | State | Axioms beyond the standard three |
|---|---|---|---|
| `Problems.BSD.bsd_hawking_equivalence` | `lean` | open | `Problems.BSD.analytic_rank`, `Problems.BSD.algebraic_rank`, `Problems.BSD.L_function`, `sorryAx` |
| `Problems.Hodge.hodge_hawking_equivalence` | `lean` | open | `Problems.Hodge.is_algebraic`, `sorryAx` |
| `Problems.NavierStokes.ns_hawking_equivalence` | `lean` | open | `sorryAx` |
| `Problems.PvsNP.pnp_hawking_equivalence` | `lean` | open | `sorryAx` |
| `Problems.Riemann.rh_hawking_equivalence` | `lean (file by file)` | open | `sorryAx`, `Problems.Riemann.xi` |

### Declared theorems

The `.lean` files of the verified commit declare 33 `theorem`/`lemma` (counting copies). The kernel checked 13 of them (8 closed, 0 conditional, 5 open). The closed count in the table above is larger: it also counts the theorems Lean generates by itself (equation lemmas, structure fields, `deriving`), which are not written in the text. For 20 the kernel has no result:

| Reason | Theorems |
|---|---:|
| checked file by file: Lean did not reach the theorem (missing import, syntax error or timeout) | 18 |
| checked file by file: the written proof does not pass the kernel | 2 |

## Files in this folder

* `VERIFICACAO.json` — each Lean project of this repository, each theorem the kernel read, its statement, its axioms and its state (`fechado` closed, `condicional` conditional, `aberto-sorry` open)
* `TEOREMAS.csv` — each declared `theorem`/`lemma`: file, line, state in the kernel (`nao_checado` = not checked) and, if not checked, why (in Portuguese)
* `BUILD_LOG.txt` — one block per project: Lean version, result, errors
* `SOURCE.json` — source commit, verified commit and dates, machine-readable
* `SOURCES.sha256` — SHA-256 of every published file

## Reproduce

```
cd imports/hawking-singularities-millennium-problems/<project>   # a project folder from the table above ('.' is imports/hawking-singularities-millennium-problems)
lake exe cache get           # only for projects that require Mathlib
lake build
```

Each project uses the Lean version in its own `lean-toolchain`, which elan installs. The MVEI pipeline that produced these results is in the author's repository and is not public.
