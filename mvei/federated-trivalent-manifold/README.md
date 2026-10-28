# MVEI kernel check — federated-trivalent-manifold

This folder records what the Lean 4 kernel said about the Lean sources of the private repository `ShantiDraconis/federated-trivalent-manifold`. The sources are published in [`imports/federated-trivalent-manifold/`](../../imports/federated-trivalent-manifold/).

## What is published

* Source: `ShantiDraconis/federated-trivalent-manifold`, commit `95e7a6a7a64832ae25a2342445e429eb17a2098c` (2026-08-26T01:58:06Z).
* 31 files: 22 `.lean` files and the Lake files (`lakefile.*`, `lean-toolchain`, `lake-manifest.json`), plus 1 license or origin file(s) that third-party code requires (`LICENSE`). Paths are the same as in the source repository.
* Nothing else from the private repository is published (documents, commercial license, prompts, storefront material).
* `SOURCES.sha256` lists every published file with its SHA-256. From the repository root: `sha256sum -c mvei/federated-trivalent-manifold/SOURCES.sha256`.

## What the kernel said

MVEI verification of 2026-10-28T16:41:02+00:00, on commit `95e7a6a7a64832ae25a2342445e429eb17a2098c`. Each theorem was read with `Lean.collectAxioms`, the function behind `#print axioms`.

| Lean project | Lean version | Build | Closed | Conditional | Open (`sorry`) | Checked file by file: closed / conditional / open / proof error / not reached |
|---|---|---|---:|---:|---:|---|
| `.` | v4.19.0 | OK | 120 | 0 | 0 | 0 / 0 / 0 / 0 / 8 |
| `formal/lean` | v4.8.0 | partial | 28 | 1 | 0 | 6 / 5 / 0 / 32 / 0 |
| `hub/formal/lean` | v4.8.0 | OK | 23 | 0 | 0 | — |

| Closed theorems in this repository | |
|---|---:|
| Counting each project | 177 |
| Unique (name + statement) | 177 |
| Unique, without the lemmas Lean generates itself (`eq_1`, `mk.inj`, `sizeOf_spec`, `deriving`) | 35 |

*Closed* means the kernel accepted the proof and it depends only on `propext`, `Classical.choice` and `Quot.sound`. It says that the statement as written in the file is proved; it does not say that an open problem is solved. Every statement is in `VERIFICACAO.json`. *Conditional* means the proof also uses axioms declared in the repository; *open* means it uses `sorry`. *Checked file by file* covers the files that no build reached: each one went through Lean whole, with a `#print axioms` for each theorem.

| Theorem | Project | State | Axioms beyond the standard three |
|---|---|---|---|
| `conditional_pipeline` | `formal/lean` | conditional | `CryptoAssumption`, `RiemannHypothesisAssumption` |
| `L_A1_2_Nmax_bound` | `formal/lean (file by file)` | conditional | `Lean.ofReduceBool` |
| `L_A2_1_e_nl_bound` | `formal/lean (file by file)` | conditional | `Lean.ofReduceBool` |
| `L_A2_2_e_linear_negative` | `formal/lean (file by file)` | conditional | `Lean.ofReduceBool` |
| `L_B1_Saros_diff` | `formal/lean (file by file)` | conditional | `Lean.ofReduceBool` |
| `L_B2_Res_bound` | `formal/lean (file by file)` | conditional | `Lean.ofReduceBool` |

### Declared theorems

The `.lean` files of the verified commit declare 74 `theorem`/`lemma` (counting copies). The kernel checked 34 of them (28 closed, 6 conditional, 0 open). The closed count in the table above is larger: it also counts the theorems Lean generates by itself (equation lemmas, structure fields, `deriving`), which are not written in the text. For 40 the kernel has no result:

| Reason | Theorems |
|---|---:|
| checked file by file: the written proof does not pass the kernel | 32 |
| checked file by file: Lean did not reach the theorem (missing import, syntax error or timeout) | 8 |

### MVEI corrections

* `correcoes/renomear-imports-mathlib.patch` (import de módulo que não existe na versão do Mathlib do projeto (renomeado ou dividido), 4 file(s)): applies to the published sources: `git apply -p1 --directory=imports/federated-trivalent-manifold mvei/federated-trivalent-manifold/correcoes/renomear-imports-mathlib.patch` (in order, after the ones above)

## Files in this folder

* `VERIFICACAO.json` — each Lean project of this repository, each theorem the kernel read, its statement, its axioms and its state (`fechado` closed, `condicional` conditional, `aberto-sorry` open)
* `TEOREMAS.csv` — each declared `theorem`/`lemma`: file, line, state in the kernel (`nao_checado` = not checked) and, if not checked, why (in Portuguese)
* `BUILD_LOG.txt` — one block per project: Lean version, result, errors
* `SOURCE.json` — source commit, verified commit and dates, machine-readable
* `SOURCES.sha256` — SHA-256 of every published file

## Reproduce

```
cd imports/federated-trivalent-manifold/<project>   # a project folder from the table above ('.' is imports/federated-trivalent-manifold)
lake exe cache get           # only for projects that require Mathlib
lake build
```

Each project uses the Lean version in its own `lean-toolchain`, which elan installs. The MVEI pipeline that produced these results is in the author's repository and is not public.
