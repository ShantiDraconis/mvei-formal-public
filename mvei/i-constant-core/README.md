# MVEI kernel check — i-constant-core

This folder records what the Lean 4 kernel said about the Lean sources of the private repository `ShantiDraconis/i-constant-core`. The sources are published in [`imports/i-constant-core/`](../../imports/i-constant-core/).

## What is published

* Source: `ShantiDraconis/i-constant-core`, commit `06a1646856993da2828a94b5c49798a76e020869` (2026-09-27T18:24:26Z).
* 3 files: 2 `.lean` files and the Lake files (`lakefile.*`, `lean-toolchain`, `lake-manifest.json`), plus 1 license or origin file(s) that third-party code requires (`LICENSE`). Paths are the same as in the source repository.
* Nothing else from the private repository is published (documents, commercial license, prompts, storefront material).
* `SOURCES.sha256` lists every published file with its SHA-256. From the repository root: `sha256sum -c mvei/i-constant-core/SOURCES.sha256`.

## What the kernel said

MVEI verification of 2026-10-30T08:01:18+00:00, on commit `06a1646856993da2828a94b5c49798a76e020869`. Each theorem was read with `Lean.collectAxioms`, the function behind `#print axioms`.

| Lean project | Lean version | Build | Closed | Conditional | Open (`sorry`) | Checked file by file: closed / conditional / open / proof error / not reached |
|---|---|---|---:|---:|---:|---|
| `formal` (no lakefile; project assembled by MVEI) | v4.19.0 | OK | 17 | 0 | 0 | 1 / 0 / 8 / 6 / 0 |

| Closed theorems in this repository | |
|---|---:|
| Counting each project | 18 |
| Unique (name + statement) | 18 |
| Unique, without the lemmas Lean generates itself (`eq_1`, `mk.inj`, `sizeOf_spec`, `deriving`) | 7 |

*Closed* means the kernel accepted the proof and it depends only on `propext`, `Classical.choice` and `Quot.sound`. It says that the statement as written in the file is proved; it does not say that an open problem is solved. Every statement is in `VERIFICACAO.json`. *Conditional* means the proof also uses axioms declared in the repository; *open* means it uses `sorry`. *Checked file by file* covers the files that no build reached: each one went through Lean whole, with a `#print axioms` for each theorem.

| Theorem | Project | State | Axioms beyond the standard three |
|---|---|---|---|
| `IConstant.I_decomposition` | `formal (file by file)` | open | `sorryAx` |
| `IConstant.Delta_existence` | `formal (file by file)` | open | `sorryAx` |
| `IConstant.I_absorption` | `formal (file by file)` | open | `sorryAx` |
| `IConstant.Delta_bound` | `formal (file by file)` | open | `sorryAx` |
| `IConstant.Delta_positive` | `formal (file by file)` | open | `sorryAx` |
| `IConstant.I_idempotent_add` | `formal (file by file)` | open | `sorryAx` |
| `IConstant.I_idempotent_mul` | `formal (file by file)` | open | `sorryAx` |
| `IConstant.Delta_unique` | `formal (file by file)` | open | `sorryAx` |

### Declared theorems

The `.lean` files of the verified commit declare 18 `theorem`/`lemma` (counting copies). The kernel checked 12 of them (4 closed, 0 conditional, 8 open). The closed count in the table above is larger: it also counts the theorems Lean generates by itself (equation lemmas, structure fields, `deriving`), which are not written in the text. For 6 the kernel has no result:

| Reason | Theorems |
|---|---:|
| checked file by file: the written proof does not pass the kernel | 6 |

### MVEI corrections

* `correcoes/vocabulario-lean4.patch` (grafia que o Lean 4 não lê (nome acentuado, λ/Σ/Π como nome, ∀ x y ∈ s, docstring solta, constant, tática do Mathlib sem import), 1 file(s)): applies to the published sources: `git apply -p1 --directory=imports/i-constant-core mvei/i-constant-core/correcoes/vocabulario-lean4.patch` (in order, after the ones above)
* `correcoes/z-provas-reparadas.patch` (prova que não passava no kernel (o enunciado fica igual), 1 file(s)): applies to the published sources: `git apply -p1 --directory=imports/i-constant-core mvei/i-constant-core/correcoes/z-provas-reparadas.patch` (in order, after the ones above)

## Files in this folder

* `VERIFICACAO.json` — each Lean project of this repository, each theorem the kernel read, its statement, its axioms and its state (`fechado` closed, `condicional` conditional, `aberto-sorry` open)
* `TEOREMAS.csv` — each declared `theorem`/`lemma`: file, line, state in the kernel (`nao_checado` = not checked) and, if not checked, why (in Portuguese)
* `BUILD_LOG.txt` — one block per project: Lean version, result, errors
* `SOURCE.json` — source commit, verified commit and dates, machine-readable
* `SOURCES.sha256` — SHA-256 of every published file

## Reproduce

```
cd imports/i-constant-core/<project>   # a project folder from the table above ('.' is imports/i-constant-core)
lake exe cache get           # only for projects that require Mathlib
lake build
```

Each project uses the Lean version in its own `lean-toolchain`, which elan installs. The MVEI pipeline that produced these results is in the author's repository and is not public.
