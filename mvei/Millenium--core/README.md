# MVEI kernel check — Millenium--core

This folder records what the Lean 4 kernel said about the Lean sources of the private repository `ShantiDraconis/Millenium--core`. The sources are published in [`imports/Millenium--core/`](../../imports/Millenium--core/).

## What is published

* Source: `ShantiDraconis/Millenium--core`, commit `dc52454bba8a6aefec4baa010494c463f4aa4897` (2026-09-18T09:56:21Z).
* 53 files: 50 `.lean` files and the Lake files (`lakefile.*`, `lean-toolchain`, `lake-manifest.json`), plus 1 license or origin file(s) that third-party code requires (`LICENSE`). Paths are the same as in the source repository.
* Nothing else from the private repository is published (documents, commercial license, prompts, storefront material).
* `SOURCES.sha256` lists every published file with its SHA-256. From the repository root: `sha256sum -c mvei/Millenium--core/SOURCES.sha256`.

## What the kernel said

MVEI verification of 2026-11-05T15:19:16+00:00, on commit `dc52454bba8a6aefec4baa010494c463f4aa4897`. Each theorem was read with `Lean.collectAxioms`, the function behind `#print axioms`.

| Lean project | Lean version | Build | Closed | Conditional | Open (`sorry`) | Checked file by file: closed / conditional / open / proof error / not reached |
|---|---|---|---:|---:|---:|---|
| `.` | v4.14.0 | partial | 17 | 0 | 0 | 4 / 0 / 9 / 4 / 82 |
| `FORMAL/Lean4/Core` | v4.14.0 | partial | 71 | 0 | 0 | 8 / 0 / 3 / 7 / 0 |
| `lean` | v4.19.0 | partial | 54 | 0 | 0 | 4 / 0 / 0 / 4 / 21 |
| `lean4` | padrão do elan | OK | 31 | 0 | 0 | — |

| Closed theorems in this repository | |
|---|---:|
| Counting each project | 189 |
| Unique (name + statement) | 189 |
| Unique, without the lemmas Lean generates itself (`eq_1`, `mk.inj`, `sizeOf_spec`, `deriving`) | 39 |

*Closed* means the kernel accepted the proof and it depends only on `propext`, `Classical.choice` and `Quot.sound`. It says that the statement as written in the file is proved; it does not say that an open problem is solved. Every statement is in `VERIFICACAO.json`. *Conditional* means the proof also uses axioms declared in the repository; *open* means it uses `sorry`. *Checked file by file* covers the files that no build reached: each one went through Lean whole, with a `#print axioms` for each theorem.

| Theorem | Project | State | Axioms beyond the standard three |
|---|---|---|---|
| `TIF.MetaArithmeticState.empty_isClassical` | `. (file by file)` | open | `sorryAx` |
| `TIF.MetaArithmeticState.equivalent_refl` | `. (file by file)` | open | `sorryAx` |
| `TIF.MetaArithmeticState.equivalent_symm` | `. (file by file)` | open | `sorryAx` |
| `TIF.MetaArithmeticState.equivalent_trans` | `. (file by file)` | open | `sorryAx` |
| `TIF.MetaArithmeticState.determined_monotone` | `. (file by file)` | open | `sorryAx` |
| `relative_consistency` | `. (file by file)` | open | `sorryAx` |
| `conservativity` | `. (file by file)` | open | `sorryAx` |
| `TIF.Toy.Boolean.toyVerify_sound` | `. (file by file)` | open | `sorryAx` |
| `TIF.Toy.Boolean.toyVerify_complete` | `. (file by file)` | open | `sorryAx` |
| `MillenniumCore.Classification.pureIndeterminate_collapse_dichotomy` | `FORMAL/Lean4/Core (file by file)` | open | `sorryAx` |
| `MillenniumCore.Classification.mixed_collapse_dichotomy` | `FORMAL/Lean4/Core (file by file)` | open | `sorryAx` |
| `MillenniumCore.Classification.classical_collapse_unique` | `FORMAL/Lean4/Core (file by file)` | open | `sorryAx` |

### Declared theorems

The `.lean` files of the verified commit declare 179 `theorem`/`lemma` (counting copies). The kernel checked 49 of them (37 closed, 0 conditional, 12 open). The closed count in the table above is larger: it also counts the theorems Lean generates by itself (equation lemmas, structure fields, `deriving`), which are not written in the text. For 130 the kernel has no result:

| Reason | Theorems |
|---|---:|
| checked file by file: Lean did not reach the theorem (missing import, syntax error or timeout) | 94 |
| the file did not compile (an error in it or in a file it imports) | 20 |
| checked file by file: the written proof does not pass the kernel | 15 |
| the file compiled, but the name did not appear in the kernel (private, mutual or macro-generated) | 1 |

### MVEI corrections

* `correcoes/a-arquivos-corrompidos.patch` (arquivo corrompido no repositório (merge add/add resolvido aceitando os dois lados: linhas das duas versões intercaladas), 12 file(s)): applies to the published sources: `git apply -p1 --directory=imports/Millenium--core mvei/Millenium--core/correcoes/a-arquivos-corrompidos.patch` (in order, after the ones above)
* `correcoes/imports-no-topo.patch` (import fora do início do arquivo, 11 file(s)): applies to the published sources: `git apply -p1 --directory=imports/Millenium--core mvei/Millenium--core/correcoes/imports-no-topo.patch` (in order, after the ones above)
* `correcoes/tatica-encontrada.patch` (prova que não passava (ou axioma) que uma tática padrão fecha no kernel, 2 file(s)): applies to the published sources: `git apply -p1 --directory=imports/Millenium--core mvei/Millenium--core/correcoes/tatica-encontrada.patch` (in order, after the ones above)
* `correcoes/vocabulario-lean4.patch` (grafia que o Lean 4 não lê (nome acentuado, λ/Σ/Π como nome, ∀ x y ∈ s, docstring solta, constant, tática do Mathlib sem import), 36 file(s)): applies to the published sources: `git apply -p1 --directory=imports/Millenium--core mvei/Millenium--core/correcoes/vocabulario-lean4.patch` (in order, after the ones above)
* `correcoes/z-provas-reparadas.patch` (prova que não passava no kernel (o enunciado fica igual), 3 file(s)): applies to the published sources: `git apply -p1 --directory=imports/Millenium--core mvei/Millenium--core/correcoes/z-provas-reparadas.patch` (in order, after the ones above)
* `correcoes/zy-enunciados-do-autor.patch` (enunciado reescrito a pedido do autor (o original, como escrito, fica registrado), 5 file(s)): applies to the published sources: `git apply -p1 --directory=imports/Millenium--core mvei/Millenium--core/correcoes/zy-enunciados-do-autor.patch` (in order, after the ones above)
* `correcoes/zz-refutacoes.patch` (teorema com enunciado falso como o Lean o lê (o original fica como está), 1 file(s)): applies to the published sources: `git apply -p1 --directory=imports/Millenium--core mvei/Millenium--core/correcoes/zz-refutacoes.patch` (in order, after the ones above)

## Files in this folder

* `VERIFICACAO.json` — each Lean project of this repository, each theorem the kernel read, its statement, its axioms and its state (`fechado` closed, `condicional` conditional, `aberto-sorry` open)
* `TEOREMAS.csv` — each declared `theorem`/`lemma`: file, line, state in the kernel (`nao_checado` = not checked) and, if not checked, why (in Portuguese)
* `BUILD_LOG.txt` — one block per project: Lean version, result, errors
* `SOURCE.json` — source commit, verified commit and dates, machine-readable
* `SOURCES.sha256` — SHA-256 of every published file

## Reproduce

```
cd imports/Millenium--core/<project>   # a project folder from the table above ('.' is imports/Millenium--core)
lake exe cache get           # only for projects that require Mathlib
lake build
```

Each project uses the Lean version in its own `lean-toolchain`, which elan installs. The MVEI pipeline that produced these results is in the author's repository and is not public.
