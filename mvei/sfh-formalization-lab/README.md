# MVEI kernel check — sfh-formalization-lab

This folder records what the Lean 4 kernel said about the Lean sources of the private repository `ShantiDraconis/sfh-formalization-lab`. The sources are published in [`imports/sfh-formalization-lab/`](../../imports/sfh-formalization-lab/).

## What is published

* Source: `ShantiDraconis/sfh-formalization-lab`, commit `b770052dbe60a6ab123f127ea1b82499619d6f2b` (2026-09-18T04:11:43Z).
* 22 files: 20 `.lean` files and the Lake files (`lakefile.*`, `lean-toolchain`, `lake-manifest.json`), plus 1 license or origin file(s) that third-party code requires (`LICENSE`). Paths are the same as in the source repository.
* Nothing else from the private repository is published (documents, commercial license, prompts, storefront material).
* `SOURCES.sha256` lists every published file with its SHA-256. From the repository root: `sha256sum -c mvei/sfh-formalization-lab/SOURCES.sha256`.

## What the kernel said

MVEI verification of 2026-10-29T18:57:14+00:00, on commit `b770052dbe60a6ab123f127ea1b82499619d6f2b`. Each theorem was read with `Lean.collectAxioms`, the function behind `#print axioms`.

| Lean project | Lean version | Build | Closed | Conditional | Open (`sorry`) | Checked file by file: closed / conditional / open / proof error / not reached |
|---|---|---|---:|---:|---:|---|
| `formal/lean` (no lakefile; project assembled by MVEI) | v4.19.0 | partial | 3 | 0 | 5 | 1 / 0 / 14 / 10 / 26 |
| `problems/p-vs-np/approximation-logic/lean` (no lakefile; project assembled by MVEI) | padrão do elan | failed | 0 | 0 | 0 | 1 / 0 / 0 / 2 / 0 |
| `problems/p-vs-np/formal-proofs/lean` (no lakefile; project assembled by MVEI) | padrão do elan | failed | 0 | 0 | 0 | 0 / 0 / 0 / 3 / 0 |
| `problems/p-vs-np/formalization/lean` | v4.3.0 | failed | 0 | 0 | 0 | 0 / 0 / 2 / 5 / 0 |
| `problems/p-vs-np/formalizations/lean` (no lakefile; project assembled by MVEI) | padrão do elan | failed | 0 | 0 | 0 | 0 / 0 / 1 / 0 / 0 |
| `proofs/p-vs-np/lean` (no lakefile; project assembled by MVEI) | padrão do elan | failed | 0 | 0 | 0 | 0 / 0 / 0 / 4 / 0 |

| Closed theorems in this repository | |
|---|---:|
| Counting each project | 5 |
| Unique (name + statement) | 5 |
| Unique, without the lemmas Lean generates itself (`eq_1`, `mk.inj`, `sizeOf_spec`, `deriving`) | 2 |

*Closed* means the kernel accepted the proof and it depends only on `propext`, `Classical.choice` and `Quot.sound`. It says that the statement as written in the file is proved; it does not say that an open problem is solved. Every statement is in `VERIFICACAO.json`. *Conditional* means the proof also uses axioms declared in the repository; *open* means it uses `sorry`. *Checked file by file* covers the files that no build reached: each one went through Lean whole, with a `#print axioms` for each theorem.

| Theorem | Project | State | Axioms beyond the standard three |
|---|---|---|---|
| `PvsNP_L1001_P_poly_definition` | `formal/lean` | open | `computes`, `sorryAx` |
| `PvsNP_L1002_P_subset_P_poly` | `formal/lean` | open | `P`, `computes`, `sorryAx` |
| `PvsNP_L1003_Karp_Lipton` | `formal/lean` | open | `NP`, `computes`, `PH`, `Sigma2P`, `sorryAx` |
| `PvsNP_L1004_Shannon_bound` | `formal/lean` | open | `RandomBooleanFunction`, `circuit_size`, `sorryAx` |
| `PvsNP_L1005_need_explicit_hardness` | `formal/lean` | open | `NP`, `computes`, `Explicit`, `sorryAx` |
| `Barriers.relativization_barrier` | `formal/lean (file by file)` | open | `sorryAx`, `Barriers.ComplexityClassWithOracle`, `Barriers.Oracle` |
| `Complexity.P_subset_NP` | `formal/lean (file by file)` | open | `sorryAx` |
| `Complexity.NP_subset_EXP` | `formal/lean (file by file)` | open | `sorryAx` |
| `PvsNP_L0001_TM_RAM_equiv` | `formal/lean (file by file)` | open | `RAMMachine`, `TuringMachine`, `sorryAx`, `time_complexity` |
| `PvsNP_L0001_RAM_Circuit_equiv` | `formal/lean (file by file)` | open | `RAMMachine`, `UniformCircuit`, `sorryAx`, `time_complexity` |
| `PvsNP_L0002_P_definition` | `formal/lean (file by file)` | open | `TuringMachine`, `sorryAx`, `time_complexity` |
| `PvsNP_L0006_Cook_Levin` | `formal/lean (file by file)` | open | `SAT`, `Verifier`, `sorryAx`, `verifies` |
| `PvsNP_L0007_ThreeSAT_NP_complete` | `formal/lean (file by file)` | open | `ThreeSAT`, `Verifier`, `sorryAx`, `verifies` |
| `PvsNP_L0008_CLIQUE_NP_complete` | `formal/lean (file by file)` | open | `CLIQUE`, `Verifier`, `sorryAx`, `verifies` |
| `PvsNP_L0008_VertexCover_NP_complete` | `formal/lean (file by file)` | open | `Verifier`, `VertexCover`, `sorryAx`, `verifies` |
| `PvsNP_L0008_HamiltonianPath_NP_complete` | `formal/lean (file by file)` | open | `HamiltonianPath`, `Verifier`, `sorryAx`, `verifies` |
| `PvsNP_resolution_via_circuits` | `formal/lean (file by file)` | open | `CircuitSize`, `NP`, `P`, `SAT`, `sorryAx` |
| `PvsNP_resolution_via_algorithm` | `formal/lean (file by file)` | open | `NP`, `P`, `SAT`, `computation_time`, `sorryAx` |
| `SC_poly_of_repr` | `formal/lean (file by file)` | open | `sorryAx` |
| `PvsNP.p_eq_np_eliminates_creativity` | `problems/p-vs-np/formalization/lean (file by file)` | open | `sorryAx` |
| `PvsNP.structural_implies_classical` | `problems/p-vs-np/formalization/lean (file by file)` | open | `sorryAx` |
| `ComplexityTheory.npComplete_in_p_implies_p_eq_np` | `problems/p-vs-np/formalizations/lean (file by file)` | open | `sorryAx` |

### Declared theorems

The `.lean` files of the verified commit declare 74 `theorem`/`lemma` (counting copies). The kernel checked 24 of them (2 closed, 0 conditional, 22 open). The closed count in the table above is larger: it also counts the theorems Lean generates by itself (equation lemmas, structure fields, `deriving`), which are not written in the text. For 50 the kernel has no result:

| Reason | Theorems |
|---|---:|
| checked file by file: Lean did not reach the theorem (missing import, syntax error or timeout) | 26 |
| checked file by file: the written proof does not pass the kernel | 24 |

### MVEI corrections

* `correcoes/renomear-imports-mathlib.patch` (import de módulo que não existe na versão do Mathlib do projeto (renomeado ou dividido), 2 file(s)): applies to the published sources: `git apply -p1 --directory=imports/sfh-formalization-lab mvei/sfh-formalization-lab/correcoes/renomear-imports-mathlib.patch` (in order, after the ones above)

## Files in this folder

* `VERIFICACAO.json` — each Lean project of this repository, each theorem the kernel read, its statement, its axioms and its state (`fechado` closed, `condicional` conditional, `aberto-sorry` open)
* `TEOREMAS.csv` — each declared `theorem`/`lemma`: file, line, state in the kernel (`nao_checado` = not checked) and, if not checked, why (in Portuguese)
* `BUILD_LOG.txt` — one block per project: Lean version, result, errors
* `SOURCE.json` — source commit, verified commit and dates, machine-readable
* `SOURCES.sha256` — SHA-256 of every published file

## Reproduce

```
cd imports/sfh-formalization-lab/<project>   # a project folder from the table above ('.' is imports/sfh-formalization-lab)
lake exe cache get           # only for projects that require Mathlib
lake build
```

Each project uses the Lean version in its own `lean-toolchain`, which elan installs. The MVEI pipeline that produced these results is in the author's repository and is not public.
