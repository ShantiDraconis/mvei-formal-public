# MVEI kernel check — Meta-mathematical-foundation-00

This folder records what the Lean 4 kernel said about the Lean sources of the private repository `ShantiDraconis/Meta-mathematical-foundation-00`. The sources are published in [`imports/Meta-mathematical-foundation-00/`](../../imports/Meta-mathematical-foundation-00/).

## What is published

* Source: `ShantiDraconis/Meta-mathematical-foundation-00`, commit `51382911549ca362b73b24d57d6b62027282ca7b` (2026-08-29T18:15:56Z).
* 31 files: 28 `.lean` files and the Lake files (`lakefile.*`, `lean-toolchain`, `lake-manifest.json`), plus 1 license or origin file(s) that third-party code requires (`LICENSE`). Paths are the same as in the source repository.
* Nothing else from the private repository is published (documents, commercial license, prompts, storefront material).
* `SOURCES.sha256` lists every published file with its SHA-256. From the repository root: `sha256sum -c mvei/Meta-mathematical-foundation-00/SOURCES.sha256`.

## What the kernel said

MVEI verification of 2026-10-29T11:55:34+00:00, on commit `51382911549ca362b73b24d57d6b62027282ca7b`. Each theorem was read with `Lean.collectAxioms`, the function behind `#print axioms`.

| Lean project | Lean version | Build | Closed | Conditional | Open (`sorry`) | Checked file by file: closed / conditional / open / proof error / not reached |
|---|---|---|---:|---:|---:|---|
| `.` (no lakefile; project assembled by MVEI) | v4.19.0 | partial | 0 | 1 | 0 | 1 / 0 / 1 / 1 / 5 |
| `lean` | padrão do elan | failed | 0 | 0 | 0 | 0 / 3 / 9 / 6 / 0 |

| Closed theorems in this repository | |
|---|---:|
| Counting each project | 1 |
| Unique (name + statement) | 1 |
| Unique, without the lemmas Lean generates itself (`eq_1`, `mk.inj`, `sizeOf_spec`, `deriving`) | 1 |

*Closed* means the kernel accepted the proof and it depends only on `propext`, `Classical.choice` and `Quot.sound`. It says that the statement as written in the file is proved; it does not say that an open problem is solved. Every statement is in `VERIFICACAO.json`. *Conditional* means the proof also uses axioms declared in the repository; *open* means it uses `sorry`. *Checked file by file* covers the files that no build reached: each one went through Lean whole, with a `#print axioms` for each theorem.

| Theorem | Project | State | Axioms beyond the standard three |
|---|---|---|---|
| `instFamilyDefProdNameCustomOutMkName_packageMkStr1ConfigTarget` | `.` | conditional | `Lake.CustomOut.MetaMillennium` |
| `independence_implies_dual_state` | `. (file by file)` | open | `sorryAx` |
| `MetaMillennium.dualState_implies_independent` | `lean (file by file)` | conditional | `MetaMillennium.Neg`, `MetaMillennium.Provable`, `MetaMillennium.SatisfiesTheory`, `MetaMillennium.TrueIn`, `MetaMillennium.neg_soundness`, `MetaMillennium.soundness` |
| `MetaMillennium.indepScheme_implies_dualState` | `lean (file by file)` | open | `sorryAx`, `MetaMillennium.ExtendWith`, `MetaMillennium.Neg`, `MetaMillennium.Provable`, `MetaMillennium.SatisfiesTheory`, `MetaMillennium.TrueIn`, `MetaMillennium.completeness` |
| `de_intro` | `lean (file by file)` | open | `classical_implies_collapse`, `sorryAx` |
| `collapse_equiv_symm` | `lean (file by file)` | open | `sorryAx` |
| `collapse_equiv_trans` | `lean (file by file)` | open | `sorryAx` |
| `model_divergence_implies_independence` | `lean (file by file)` | open | `Model`, `Provable`, `Satisfies`, `sorryAx` |
| `central_thesis` | `lean (file by file)` | open | `ArithmeticEncoding`, `BSD`, `ChainHasBreak`, `Consistent`, `EquivalenceChain`, `HasAnalyticObstruction`, `Hodge`, `Model`, `NS_Regular`, `P_ne_NP`, `Provable`, `RH`, `Satisfies`, `Theory`, `YangMills_MassGap`, `ZFC`, `sorryAx` |
| `h0_implies_h1` | `lean (file by file)` | open | `BSD`, `Consistent`, `Hodge`, `NS_Regular`, `P_ne_NP`, `Provable`, `RH`, `Theory`, `YangMills_MassGap`, `ZFC`, `sorryAx` |
| `h3_h5_related` | `lean (file by file)` | open | `BSD`, `HasAnalyticObstruction`, `Hodge`, `NS_Regular`, `P_ne_NP`, `RH`, `YangMills_MassGap`, `sorryAx` |
| `rh_analysis` | `lean (file by file)` | open | `Consistent`, `Provable`, `RH`, `Theory`, `ZFC`, `sorryAx` |
| `ns_collapse` | `lean (file by file)` | conditional | `NS_Regular` |
| `ym_spectral` | `lean (file by file)` | conditional | `YangMills_MassGap` |

### Declared theorems

The `.lean` files of the verified commit declare 26 `theorem`/`lemma` (counting copies). The kernel checked 14 of them (1 closed, 3 conditional, 10 open). The closed count in the table above is larger: it also counts the theorems Lean generates by itself (equation lemmas, structure fields, `deriving`), which are not written in the text. For 12 the kernel has no result:

| Reason | Theorems |
|---|---:|
| checked file by file: the written proof does not pass the kernel | 7 |
| checked file by file: Lean did not reach the theorem (missing import, syntax error or timeout) | 5 |

### MVEI corrections

* `correcoes/renomear-imports-mathlib.patch` (import de módulo que não existe na versão do Mathlib do projeto (renomeado ou dividido), 1 file(s)): applies to the published sources: `git apply -p1 --directory=imports/Meta-mathematical-foundation-00 mvei/Meta-mathematical-foundation-00/correcoes/renomear-imports-mathlib.patch` (in order, after the ones above)

## Files in this folder

* `VERIFICACAO.json` — each Lean project of this repository, each theorem the kernel read, its statement, its axioms and its state (`fechado` closed, `condicional` conditional, `aberto-sorry` open)
* `TEOREMAS.csv` — each declared `theorem`/`lemma`: file, line, state in the kernel (`nao_checado` = not checked) and, if not checked, why (in Portuguese)
* `BUILD_LOG.txt` — one block per project: Lean version, result, errors
* `SOURCE.json` — source commit, verified commit and dates, machine-readable
* `SOURCES.sha256` — SHA-256 of every published file

## Reproduce

```
cd imports/Meta-mathematical-foundation-00/<project>   # a project folder from the table above ('.' is imports/Meta-mathematical-foundation-00)
lake exe cache get           # only for projects that require Mathlib
lake build
```

Each project uses the Lean version in its own `lean-toolchain`, which elan installs. The MVEI pipeline that produced these results is in the author's repository and is not public.
