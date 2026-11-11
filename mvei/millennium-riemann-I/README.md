# MVEI kernel check — millennium-riemann-I

This folder records what the Lean 4 kernel said about the Lean sources of the private repository `ShantiDraconis/millennium-riemann-I`. The sources are published in [`imports/millennium-riemann-I/`](../../imports/millennium-riemann-I/).

## What is published

* Source: `ShantiDraconis/millennium-riemann-I`, commit `ae79aed383c696c2ecce69e24e711d26beddd64d` (2026-10-08T09:04:48Z).
* 68 files: 66 `.lean` files and the Lake files (`lakefile.*`, `lean-toolchain`, `lake-manifest.json`), plus 1 license or origin file(s) that third-party code requires (`LICENSE`). Paths are the same as in the source repository.
* Nothing else from the private repository is published (documents, commercial license, prompts, storefront material).
* `SOURCES.sha256` lists every published file with its SHA-256. From the repository root: `sha256sum -c mvei/millennium-riemann-I/SOURCES.sha256`.

## What the kernel said

MVEI verification of 2026-11-10T04:38:10+00:00, on commit `ae79aed383c696c2ecce69e24e711d26beddd64d`. Each theorem was read with `Lean.collectAxioms`, the function behind `#print axioms`.

| Lean project | Lean version | Build | Closed | Conditional | Open (`sorry`) | Checked file by file: closed / conditional / open / proof error / not reached |
|---|---|---|---:|---:|---:|---|
| `.` | v4.19.0 | partial | 88 | 0 | 1 | 96 / 33 / 23 / 9 / 26 |

| Closed theorems in this repository | |
|---|---:|
| Counting each project | 184 |
| Unique (name + statement) | 184 |
| Unique, without the lemmas Lean generates itself (`eq_1`, `mk.inj`, `sizeOf_spec`, `deriving`) | 147 |

*Closed* means the kernel accepted the proof and it depends only on `propext`, `Classical.choice` and `Quot.sound`. It says that the statement as written in the file is proved; it does not say that an open problem is solved. Every statement is in `VERIFICACAO.json`. *Conditional* means the proof also uses axioms declared in the repository; *open* means it uses `sorry`. *Checked file by file* covers the files that no build reached: each one went through Lean whole, with a `#print axioms` for each theorem.

| Theorem | Project | State | Axioms beyond the standard three |
|---|---|---|---|
| `ATKTerminalStaging.terminal_closure` | `.` | open | `sorryAx` |
| `Collapse.CollapseComplex.mul_inv_cancel` | `. (file by file)` | open | `sorryAx` |
| `Collapse.CollapseComplex.inv_mul_cancel` | `. (file by file)` | open | `sorryAx` |
| `Collapse.CollapseComplex.normI_smul_nonneg` | `. (file by file)` | open | `sorryAx` |
| `Collapse.CollapseComplex.normI_mul_le` | `. (file by file)` | open | `sorryAx` |
| `Millennium.Riemann.Anomalous.Theorems.critical_zero_no_I_contribution` | `. (file by file)` | open | `sorryAx` |
| `Millennium.Riemann.Anomalous.Theorems.anomalous_I_contribution` | `. (file by file)` | open | `sorryAx` |
| `Riemann.Collapse.RH_from_I_ne_one` | `. (file by file)` | open | `sorryAx`, `Riemann.Collapse.IConstant` |
| `Riemann.Zeros.anomalous_left_or_right` | `. (file by file)` | open | `sorryAx` |
| `Millennium.Riemann.CollapseProof.symbolicRiemannHypothesis` | `. (file by file)` | open | `sorryAx`, `Millennium.Riemann.Core.zeta` |
| `Millennium.Riemann.CollapseProof.no_zeros_left_strip` | `. (file by file)` | open | `sorryAx`, `Millennium.Riemann.Core.zeta` |
| `Millennium.Riemann.CollapseProof.no_zeros_right_strip` | `. (file by file)` | open | `sorryAx`, `Millennium.Riemann.Core.zeta` |
| `Millennium.Riemann.CollapseProof.no_exceptional_zeros` | `. (file by file)` | open | `sorryAx`, `Millennium.Riemann.Core.zeta` |
| `Millennium.Riemann.CollapseProof.symbolic_proof_summary` | `. (file by file)` | open | `sorryAx`, `Millennium.Riemann.Core.zeta` |
| `Millennium.Riemann.CollapseProof.I_collapse_alternative` | `. (file by file)` | open | `sorryAx`, `Millennium.Riemann.Core.zeta` |
| `Millennium.Riemann.CollapseProof.not_RH_contradiction` | `. (file by file)` | open | `sorryAx`, `Millennium.Riemann.Core.zeta` |
| `Millennium.Riemann.Core.reflection_symmetry` | `. (file by file)` | conditional | `Millennium.Riemann.Core.functional_equation`, `Millennium.Riemann.Core.zeta` |
| `Millennium.Riemann.IConstant.vertical_symmetry` | `. (file by file)` | conditional | `Millennium.Riemann.Core.zeta`, `Millennium.Riemann.IConstant.Delta_preserves_zeros` |
| `Millennium.Riemann.IKernel.kernel_pure_I` | `. (file by file)` | open | `sorryAx` |
| `Millennium.Riemann.symbolicRH_statement` | `. (file by file)` | conditional | `Millennium.Riemann.zetaSymbolic` |
| `Millennium.Riemann.functional_equation_symmetry` | `. (file by file)` | conditional | `Millennium.Riemann.chiSymbolic`, `Millennium.Riemann.symbolicFunctionalEquation`, `Millennium.Riemann.zetaSymbolic` |
| `Millennium.Riemann.Zeros.I_collapse_contradiction` | `. (file by file)` | open | `sorryAx`, `Millennium.Riemann.zetaSymbolic` |
| `Millennium.Riemann.Zeros.symbolic_RH_via_I_collapse` | `. (file by file)` | open | `sorryAx`, `Millennium.Riemann.zetaSymbolic` |
| `Millennium.Riemann.Zeros.vertical_symmetry_from_Delta` | `. (file by file)` | conditional | `Millennium.Riemann.zetaSymbolic`, `Millennium.Riemann.Zeros.DeltaCollapse_preserves_zeros` |
| `Millennium.Riemann.Zeros.critical_orbit_size` | `. (file by file)` | conditional | `Millennium.Riemann.Core.zeta` |
| `Millennium.Riemann.Zeros.generic_orbit_size` | `. (file by file)` | conditional | `Millennium.Riemann.Core.zeta` |
| `Millennium.Riemann.Zeros.Delta_unifies_orbit` | `. (file by file)` | open | `sorryAx`, `Millennium.Riemann.Core.zeta` |
| `Riemann.CollapseProof.collapse_law_critical_line` | `. (file by file)` | conditional | `Riemann.CollapseProof.collapse_law`, `Riemann.Core.zetaClassical`, `Riemann.IConstant.I` |
| `Riemann.CollapseProof.collapse_law_contrapositive` | `. (file by file)` | conditional | `Riemann.CollapseProof.collapse_law`, `Riemann.Core.zetaClassical`, `Riemann.IConstant.I` |
| `Riemann.CollapseProof.RH_by_I_collapse` | `. (file by file)` | conditional | `Riemann.CollapseProof.collapse_law`, `Riemann.Core.zetaClassical`, `Riemann.IConstant.I`, `Riemann.IConstant.I_ne_one` |
| `Riemann.CollapseProof.RH_by_I_collapse_contrapositive` | `. (file by file)` | conditional | `Riemann.CollapseProof.collapse_law`, `Riemann.Core.zetaClassical`, `Riemann.IConstant.I`, `Riemann.IConstant.I_ne_one` |
| `Riemann.CollapseProof.riemann_hypothesis` | `. (file by file)` | conditional | `Riemann.CollapseProof.collapse_law`, `Riemann.Core.zetaClassical`, `Riemann.IConstant.I`, `Riemann.IConstant.I_ne_one` |
| `Riemann.CollapseProof.all_nontrivial_zeros_on_critical_line` | `. (file by file)` | conditional | `Riemann.CollapseProof.collapse_law`, `Riemann.Core.zetaClassical`, `Riemann.IConstant.I`, `Riemann.IConstant.I_ne_one` |
| `Riemann.CollapseProof.no_nontrivial_zero_off_critical_line` | `. (file by file)` | conditional | `Riemann.CollapseProof.collapse_law`, `Riemann.Core.zetaClassical`, `Riemann.IConstant.I`, `Riemann.IConstant.I_ne_one` |
| `Riemann.CollapseProof.all_nontrivial_zeros_real_part_half` | `. (file by file)` | conditional | `Riemann.CollapseProof.collapse_law`, `Riemann.Core.zetaClassical`, `Riemann.IConstant.I`, `Riemann.IConstant.I_ne_one` |
| `Riemann.CollapseProof.not_RH_means_exists_off_line` | `. (file by file)` | conditional | `Riemann.Core.zetaClassical` |
| `Riemann.CollapseProof.not_RH_implies_I_eq_one` | `. (file by file)` | conditional | `Riemann.CollapseProof.collapse_law`, `Riemann.Core.zetaClassical`, `Riemann.IConstant.I` |
| `Riemann.CollapseProof.not_RH_implies_I_eq_one_direct` | `. (file by file)` | conditional | `Riemann.CollapseProof.collapse_law`, `Riemann.Core.zetaClassical`, `Riemann.IConstant.I` |
| `Riemann.Core.reflectionSymmetry` | `. (file by file)` | open | `sorryAx`, `Riemann.Core.zetaClassical` |
| `Riemann.Core.zeroPairs` | `. (file by file)` | open | `sorryAx`, `Riemann.Core.zetaClassical` |
| `Riemann.IConstant.noAnomalousFromI` | `. (file by file)` | conditional | `Riemann.Core.zetaClassical`, `Riemann.IConstant.I`, `Riemann.IConstant.deltaCollapse` |
| `Riemann.IConstant.symmetryFromI` | `. (file by file)` | conditional | `Riemann.Core.nontrivialInStrip`, `Riemann.Core.zetaClassical`, `Riemann.IConstant.I`, `Riemann.IConstant.deltaCollapse` |
| `Riemann.IConstant.collapseFromAnomalous` | `. (file by file)` | conditional | `Riemann.Core.zetaClassical`, `Riemann.IConstant.I`, `Riemann.IConstant.deltaCollapse` |
| `Riemann.IKernel.zero_integral_equation` | `. (file by file)` | conditional | `Riemann.Core.zetaClassical`, `Riemann.IKernel.zeros_preserved`, `Riemann.IKernel.zetaI_equals_integral` |
| `Riemann.IKernel.reflection_zero` | `. (file by file)` | conditional | `Riemann.IKernel.zetaI_functional_equation` |
| `Riemann.IKernel.RH_integral_formulation` | `. (file by file)` | open | `sorryAx`, `Riemann.Core.zetaClassical` |
| `Riemann.Zeros.nontrivialInStrip'` | `. (file by file)` | conditional | `Riemann.Core.zetaClassical` |
| `Riemann.Zeros.zeroClassification` | `. (file by file)` | conditional | `Riemann.Core.zetaClassical` |
| `Riemann.Zeros.criticalAnomalousExclusive` | `. (file by file)` | conditional | `Riemann.Core.zetaClassical` |
| `Riemann.Zeros.RH_iff_noAnomalous` | `. (file by file)` | conditional | `Riemann.Core.zetaClassical` |
| `Riemann.Zeros.verticalSymmetry` | `. (file by file)` | conditional | `Riemann.Core.zetaClassical`, `Riemann.Zeros.reflectionPair` |
| `Riemann.Zeros.horizontalSymmetry` | `. (file by file)` | conditional | `Riemann.Core.zetaClassical`, `Riemann.Zeros.conjugatePair` |
| `Riemann.Zeros.quartetStructure` | `. (file by file)` | conditional | `Riemann.Core.zetaClassical`, `Riemann.Zeros.conjugatePair`, `Riemann.Zeros.reflectionPair` |
| `Riemann.Zeros.criticalPairStructure` | `. (file by file)` | conditional | `Riemann.Core.zetaClassical`, `Riemann.Zeros.conjugatePair` |
| `Riemann.Zeros.anomalousBreaksSymmetry` | `. (file by file)` | open | `sorryAx`, `Riemann.Core.zetaClassical` |
| `Riemann.Zeros.negEvenIsZero` | `. (file by file)` | conditional | `Riemann.Core.zetaClassical`, `Riemann.Core.zetaTrivialZeros` |
| `Riemann.Zeros.trivialNotInStrip` | `. (file by file)` | conditional | `Riemann.Core.zetaClassical` |

### Declared theorems

The `.lean` files of the verified commit declare 235 `theorem`/`lemma` (counting copies). The kernel checked 199 of them (142 closed, 33 conditional, 24 open). The closed count in the table above is larger: it also counts the theorems Lean generates by itself (equation lemmas, structure fields, `deriving`), which are not written in the text. For 36 the kernel has no result:

| Reason | Theorems |
|---|---:|
| checked file by file: Lean did not reach the theorem (missing import, syntax error or timeout) | 26 |
| checked file by file: the written proof does not pass the kernel | 8 |
| the file did not compile (an error in it or in a file it imports) | 2 |

### MVEI corrections

* `correcoes/a-arquivos-corrompidos.patch` (arquivo corrompido no repositório (restos de conflito de merge: duas versões emendadas e merge add/add resolvido aceitando os dois lados: linhas das duas versões intercaladas), 3 file(s)): applies to the published sources: `git apply -p1 --directory=imports/millennium-riemann-I mvei/millennium-riemann-I/correcoes/a-arquivos-corrompidos.patch` (in order, after the ones above)
* `correcoes/imports-no-topo.patch` (import fora do início do arquivo, 2 file(s)): applies to the published sources: `git apply -p1 --directory=imports/millennium-riemann-I mvei/millennium-riemann-I/correcoes/imports-no-topo.patch` (in order, after the ones above)
* `correcoes/tatica-encontrada.patch` (prova que não passava (ou axioma) que uma tática padrão fecha no kernel, 4 file(s)): applies to the published sources: `git apply -p1 --directory=imports/millennium-riemann-I mvei/millennium-riemann-I/correcoes/tatica-encontrada.patch` (in order, after the ones above)
* `correcoes/vocabulario-lean4.patch` (grafia que o Lean 4 não lê (nome acentuado, λ/Σ/Π como nome, ∀ x y ∈ s, docstring solta, constant, tática do Mathlib sem import), 57 file(s)): applies to the published sources: `git apply -p1 --directory=imports/millennium-riemann-I mvei/millennium-riemann-I/correcoes/vocabulario-lean4.patch` (in order, after the ones above)
* `correcoes/z-provas-reparadas.patch` (prova que não passava no kernel (o enunciado fica igual), 23 file(s)): applies to the published sources: `git apply -p1 --directory=imports/millennium-riemann-I mvei/millennium-riemann-I/correcoes/z-provas-reparadas.patch` (in order, after the ones above)
* `correcoes/zy-enunciados-do-autor.patch` (enunciado reescrito a pedido do autor (o original, como escrito, fica registrado), 25 file(s)): applies to the published sources: `git apply -p1 --directory=imports/millennium-riemann-I mvei/millennium-riemann-I/correcoes/zy-enunciados-do-autor.patch` (in order, after the ones above)
* `correcoes/zz-refutacoes.patch` (teorema com enunciado falso como o Lean o lê (o original fica como está), 4 file(s)): applies to the published sources: `git apply -p1 --directory=imports/millennium-riemann-I mvei/millennium-riemann-I/correcoes/zz-refutacoes.patch` (in order, after the ones above)

## Files in this folder

* `VERIFICACAO.json` — each Lean project of this repository, each theorem the kernel read, its statement, its axioms and its state (`fechado` closed, `condicional` conditional, `aberto-sorry` open)
* `TEOREMAS.csv` — each declared `theorem`/`lemma`: file, line, state in the kernel (`nao_checado` = not checked) and, if not checked, why (in Portuguese)
* `BUILD_LOG.txt` — one block per project: Lean version, result, errors
* `SOURCE.json` — source commit, verified commit and dates, machine-readable
* `SOURCES.sha256` — SHA-256 of every published file

## Reproduce

```
cd imports/millennium-riemann-I/<project>   # a project folder from the table above ('.' is imports/millennium-riemann-I)
lake exe cache get           # only for projects that require Mathlib
lake build
```

Each project uses the Lean version in its own `lean-toolchain`, which elan installs. The MVEI pipeline that produced these results is in the author's repository and is not public.
