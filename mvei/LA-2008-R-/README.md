# MVEI kernel check — LA-2008-R-

This folder records what the Lean 4 kernel said about the Lean sources of the private repository `ShantiDraconis/LA-2008-R-`. The sources are published in [`imports/LA-2008-R-/`](../../imports/LA-2008-R-/).

## What is published

* Source: `ShantiDraconis/LA-2008-R-`, commit `51e350a68d32e0322f7e6d9de0296e919791953c` (2026-04-15T15:30:00Z).
* 9 files: 8 `.lean` files and the Lake files (`lakefile.*`, `lean-toolchain`, `lake-manifest.json`), plus 1 license or origin file(s) that third-party code requires (`LICENSE`). Paths are the same as in the source repository.
* Nothing else from the private repository is published (documents, commercial license, prompts, storefront material).
* `SOURCES.sha256` lists every published file with its SHA-256. From the repository root: `sha256sum -c mvei/LA-2008-R-/SOURCES.sha256`.

## What the kernel said

MVEI verification of 2026-11-06T00:22:08+00:00, on commit `51e350a68d32e0322f7e6d9de0296e919791953c`. Each theorem was read with `Lean.collectAxioms`, the function behind `#print axioms`.

| Lean project | Lean version | Build | Closed | Conditional | Open (`sorry`) | Checked file by file: closed / conditional / open / proof error / not reached |
|---|---|---|---:|---:|---:|---|
| `anti-rh-research-os/lean` (no lakefile; project assembled by MVEI) | v4.19.0 | partial | 24 | 0 | 0 | — |
| `anti_rh/lean` (no lakefile; project assembled by MVEI) | v4.19.0 | OK | 32 | 0 | 0 | — |

| Closed theorems in this repository | |
|---|---:|
| Counting each project | 56 |
| Unique (name + statement) | 56 |
| Unique, without the lemmas Lean generates itself (`eq_1`, `mk.inj`, `sizeOf_spec`, `deriving`) | 23 |

*Closed* means the kernel accepted the proof and it depends only on `propext`, `Classical.choice` and `Quot.sound`. It says that the statement as written in the file is proved; it does not say that an open problem is solved. Every statement is in `VERIFICACAO.json`. *Conditional* means the proof also uses axioms declared in the repository; *open* means it uses `sorry`. *Checked file by file* covers the files that no build reached: each one went through Lean whole, with a `#print axioms` for each theorem.

### Declared theorems

The `.lean` files of the verified commit declare 18 `theorem`/`lemma` (counting copies). The kernel checked 18 of them (18 closed, 0 conditional, 0 open). The closed count in the table above is larger: it also counts the theorems Lean generates by itself (equation lemmas, structure fields, `deriving`), which are not written in the text.

### MVEI corrections

* `correcoes/tatica-encontrada.patch` (prova que não passava (ou axioma) que uma tática padrão fecha no kernel, 1 file(s)): applies to the published sources: `git apply -p1 --directory=imports/LA-2008-R- mvei/LA-2008-R-/correcoes/tatica-encontrada.patch` (in order, after the ones above)
* `correcoes/vocabulario-lean4.patch` (grafia que o Lean 4 não lê (nome acentuado, λ/Σ/Π como nome, ∀ x y ∈ s, docstring solta, constant, tática do Mathlib sem import), 6 file(s)): applies to the published sources: `git apply -p1 --directory=imports/LA-2008-R- mvei/LA-2008-R-/correcoes/vocabulario-lean4.patch` (in order, after the ones above)
* `correcoes/z-provas-reparadas.patch` (prova que não passava no kernel (o enunciado fica igual), 5 file(s)): applies to the published sources: `git apply -p1 --directory=imports/LA-2008-R- mvei/LA-2008-R-/correcoes/z-provas-reparadas.patch` (in order, after the ones above)
* `correcoes/zy-enunciados-do-autor.patch` (enunciado reescrito a pedido do autor (o original, como escrito, fica registrado), 3 file(s)): applies to the published sources: `git apply -p1 --directory=imports/LA-2008-R- mvei/LA-2008-R-/correcoes/zy-enunciados-do-autor.patch` (in order, after the ones above)

## Files in this folder

* `VERIFICACAO.json` — each Lean project of this repository, each theorem the kernel read, its statement, its axioms and its state (`fechado` closed, `condicional` conditional, `aberto-sorry` open)
* `TEOREMAS.csv` — each declared `theorem`/`lemma`: file, line, state in the kernel (`nao_checado` = not checked) and, if not checked, why (in Portuguese)
* `BUILD_LOG.txt` — one block per project: Lean version, result, errors
* `SOURCE.json` — source commit, verified commit and dates, machine-readable
* `SOURCES.sha256` — SHA-256 of every published file

## Reproduce

```
cd imports/LA-2008-R-/<project>   # a project folder from the table above ('.' is imports/LA-2008-R-)
lake exe cache get           # only for projects that require Mathlib
lake build
```

Each project uses the Lean version in its own `lean-toolchain`, which elan installs. The MVEI pipeline that produced these results is in the author's repository and is not public.
