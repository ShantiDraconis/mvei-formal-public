# MVEI kernel check — lc-rh-coercivity

This folder records what the Lean 4 kernel said about the Lean sources of the private repository `ShantiDraconis/lc-rh-coercivity`. The sources are published in [`imports/lc-rh-coercivity/`](../../imports/lc-rh-coercivity/).

## What is published

* Source: `ShantiDraconis/lc-rh-coercivity`, commit `5283a63651a53c57fc3e8d11972f2169e38de3c6` (2026-09-18T04:13:17Z).
* 22 files: 21 `.lean` files and the Lake files (`lakefile.*`, `lean-toolchain`, `lake-manifest.json`), plus 1 license or origin file(s) that third-party code requires (`LICENSE`). Paths are the same as in the source repository.
* Nothing else from the private repository is published (documents, commercial license, prompts, storefront material).
* `SOURCES.sha256` lists every published file with its SHA-256. From the repository root: `sha256sum -c mvei/lc-rh-coercivity/SOURCES.sha256`.

## What the kernel said

MVEI verification of 2026-10-29T01:06:09+00:00, on commit `5283a63651a53c57fc3e8d11972f2169e38de3c6`. Each theorem was read with `Lean.collectAxioms`, the function behind `#print axioms`.

| Lean project | Lean version | Build | Closed | Conditional | Open (`sorry`) | Checked file by file: closed / conditional / open / proof error / not reached |
|---|---|---|---:|---:|---:|---|
| `formal/lean` (no lakefile; project assembled by MVEI) | v4.19.0 | partial | 30 | 0 | 0 | — |

| Closed theorems in this repository | |
|---|---:|
| Counting each project | 30 |
| Unique (name + statement) | 30 |
| Unique, without the lemmas Lean generates itself (`eq_1`, `mk.inj`, `sizeOf_spec`, `deriving`) | 0 |

*Closed* means the kernel accepted the proof and it depends only on `propext`, `Classical.choice` and `Quot.sound`. It says that the statement as written in the file is proved; it does not say that an open problem is solved. Every statement is in `VERIFICACAO.json`. *Conditional* means the proof also uses axioms declared in the repository; *open* means it uses `sorry`. *Checked file by file* covers the files that no build reached: each one went through Lean whole, with a `#print axioms` for each theorem.

### MVEI corrections

* `correcoes/imports-no-topo.patch` (import fora do início do arquivo, 1 file(s)): applies to the published sources: `git apply -p1 --directory=imports/lc-rh-coercivity mvei/lc-rh-coercivity/correcoes/imports-no-topo.patch` (in order, after the ones above)

## Files in this folder

* `VERIFICACAO.json` — each Lean project of this repository, each theorem the kernel read, its statement, its axioms and its state (`fechado` closed, `condicional` conditional, `aberto-sorry` open)
* `TEOREMAS.csv` — each declared `theorem`/`lemma`: file, line, state in the kernel (`nao_checado` = not checked) and, if not checked, why (in Portuguese)
* `BUILD_LOG.txt` — one block per project: Lean version, result, errors
* `SOURCE.json` — source commit, verified commit and dates, machine-readable
* `SOURCES.sha256` — SHA-256 of every published file

## Reproduce

```
cd imports/lc-rh-coercivity/<project>   # a project folder from the table above ('.' is imports/lc-rh-coercivity)
lake exe cache get           # only for projects that require Mathlib
lake build
```

Each project uses the Lean version in its own `lean-toolchain`, which elan installs. The MVEI pipeline that produced these results is in the author's repository and is not public.
