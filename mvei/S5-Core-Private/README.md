# MVEI kernel check — S5-Core-Private

This folder records what the Lean 4 kernel said about the Lean sources of the private repository `ShantiDraconis/S5-Core-Private`. The sources are published in [`imports/S5-Core-Private/`](../../imports/S5-Core-Private/).

## What is published

* Source: `ShantiDraconis/S5-Core-Private`, commit `feb89339d377722f8749a67abca4932209f003a5` (2026-02-10T12:09:46Z).
* 3 files: 2 `.lean` files and the Lake files (`lakefile.*`, `lean-toolchain`, `lake-manifest.json`). Paths are the same as in the source repository.
* Only the files with theorems the Lean kernel closed are published, with the local files they import; the rest of the repository (including files whose proofs fail, use `sorry` or declare axioms) stays private.
* The author's identity signature was removed before publishing: the literal is replaced by `[assinatura removida]` in comments and string values, and `lean/ShantiDraconisIdentity.lean` (whose theorems are about that signature) stays private. The replacement does not change any closed theorem; they were checked again in the Lean kernel on the published files (Lean 4.19.0 and 4.35.0). Because of the replacement, the SHA-256 of these files differs from the source commit.
* Nothing else from the private repository is published (documents, commercial license, prompts, storefront material).
* `SOURCES.sha256` lists every published file with its SHA-256. From the repository root: `sha256sum -c mvei/S5-Core-Private/SOURCES.sha256`.

## What the kernel said

MVEI verification of 2026-10-29T11:55:34+00:00, on commit `feb89339d377722f8749a67abca4932209f003a5`. Each theorem was read with `Lean.collectAxioms`, the function behind `#print axioms`.

| Lean project | Lean version | Build | Closed | Conditional | Open (`sorry`) | Checked file by file: closed / conditional / open / proof error / not reached |
|---|---|---|---:|---:|---:|---|
| `lean` | padrão do elan | failed | 0 | 0 | 0 | 5 / 0 / 0 / 6 / 0 |

| Closed theorems in this repository | |
|---|---:|
| Counting each project | 5 |
| Unique (name + statement) | 5 |
| Unique, without the lemmas Lean generates itself (`eq_1`, `mk.inj`, `sizeOf_spec`, `deriving`) | 5 |

*Closed* means the kernel accepted the proof and it depends only on `propext`, `Classical.choice` and `Quot.sound`. It says that the statement as written in the file is proved; it does not say that an open problem is solved. Every statement is in `VERIFICACAO.json`. *Conditional* means the proof also uses axioms declared in the repository; *open* means it uses `sorry`. *Checked file by file* covers the files that no build reached: each one went through Lean whole, with a `#print axioms` for each theorem.

### Declared theorems

The `.lean` files of the verified commit declare 11 `theorem`/`lemma` (counting copies). The kernel checked 5 of them (5 closed, 0 conditional, 0 open). The closed count in the table above is larger: it also counts the theorems Lean generates by itself (equation lemmas, structure fields, `deriving`), which are not written in the text. For 6 the kernel has no result:

| Reason | Theorems |
|---|---:|
| checked file by file: the written proof does not pass the kernel | 6 |

### MVEI corrections

* `correcoes/imports-no-topo.patch` (import fora do início do arquivo, 1 file(s)): applies to the published sources: `git apply -p1 --directory=imports/S5-Core-Private mvei/S5-Core-Private/correcoes/imports-no-topo.patch` (in order, after the ones above)

## Files in this folder

* `VERIFICACAO.json` — each Lean project of this repository, each theorem the kernel read, its statement, its axioms and its state (`fechado` closed, `condicional` conditional, `aberto-sorry` open)
* `TEOREMAS.csv` — each declared `theorem`/`lemma`: file, line, state in the kernel (`nao_checado` = not checked) and, if not checked, why (in Portuguese)
* `BUILD_LOG.txt` — one block per project: Lean version, result, errors
* `SOURCE.json` — source commit, verified commit and dates, machine-readable
* `SOURCES.sha256` — SHA-256 of every published file

## Reproduce

```
cd imports/S5-Core-Private/<project>   # a project folder from the table above ('.' is imports/S5-Core-Private)
lake exe cache get           # only for projects that require Mathlib
lake build
```

Each project uses the Lean version in its own `lean-toolchain`, which elan installs. The MVEI pipeline that produced these results is in the author's repository and is not public.
