# MVEI kernel check — millennium-p-vs-np-classical

This folder records what the Lean 4 kernel said about the Lean sources of the private repository `ShantiDraconis/millennium-p-vs-np-classical`. The sources are published in [`imports/millennium-p-vs-np-classical/`](../../imports/millennium-p-vs-np-classical/).

## What is published

* Source: `ShantiDraconis/millennium-p-vs-np-classical`, commit `1990622af0a0c2ebcbe450979ba48f62025c736d` (2026-09-18T04:11:57Z).
* 30 files: 28 `.lean` files and the Lake files (`lakefile.*`, `lean-toolchain`, `lake-manifest.json`), plus 1 license or origin file(s) that third-party code requires (`LICENSE`). Paths are the same as in the source repository.
* Nothing else from the private repository is published (documents, commercial license, prompts, storefront material).
* `SOURCES.sha256` lists every published file with its SHA-256. From the repository root: `sha256sum -c mvei/millennium-p-vs-np-classical/SOURCES.sha256`.

## What the kernel said

MVEI verification of 2026-11-06T00:22:08+00:00, on commit `1990622af0a0c2ebcbe450979ba48f62025c736d`. Each theorem was read with `Lean.collectAxioms`, the function behind `#print axioms`.

| Lean project | Lean version | Build | Closed | Conditional | Open (`sorry`) | Checked file by file: closed / conditional / open / proof error / not reached |
|---|---|---|---:|---:|---:|---|
| `formal/lean4` | v4.36.0-rc2 | partial | 162 | 1 | 20 | — |
| `formal/lean4/PvsNP` | v4.19.0 | OK | 14 | 0 | 0 | 21 / 1 / 20 / 0 / 0 |
| `src/lean4` | padrão do elan | failed | 0 | 0 | 0 | 43 / 0 / 41 / 0 / 40 |

| Closed theorems in this repository | |
|---|---:|
| Counting each project | 240 |
| Unique (name + statement) | 199 |
| Unique, without the lemmas Lean generates itself (`eq_1`, `mk.inj`, `sizeOf_spec`, `deriving`) | 96 |

*Closed* means the kernel accepted the proof and it depends only on `propext`, `Classical.choice` and `Quot.sound`. It says that the statement as written in the file is proved; it does not say that an open problem is solved. Every statement is in `VERIFICACAO.json`. *Conditional* means the proof also uses axioms declared in the repository; *open* means it uses `sorry`. *Checked file by file* covers the files that no build reached: each one went through Lean whole, with a `#print axioms` for each theorem.

| Theorem | Project | State | Axioms beyond the standard three |
|---|---|---|---|
| `PvsNP.L_strictly_subset_PSPACE` | `formal/lean4` | open | `sorryAx` |
| `PvsNP.NP_eq_NP_verifier` | `formal/lean4` | open | `sorryAx` |
| `PvsNP.NP_strictly_subset_NEXP` | `formal/lean4` | open | `sorryAx` |
| `PvsNP.NP_subset_PSPACE` | `formal/lean4` | open | `sorryAx` |
| `PvsNP.PSPACE_subset_EXP` | `formal/lean4` | open | `sorryAx` |
| `PvsNP.P_eq_NP_iff_NPC_in_P` | `formal/lean4` | open | `sorryAx` |
| `PvsNP.P_eq_P'` | `formal/lean4` | open | `sorryAx` |
| `PvsNP.P_strictly_subset_EXP` | `formal/lean4` | open | `sorryAx` |
| `PvsNP.P_subset_PSPACE` | `formal/lean4` | open | `sorryAx` |
| `PvsNP.SAT_NP_hard` | `formal/lean4` | open | `sorryAx` |
| `PvsNP.SAT_in_NP` | `formal/lean4` | open | `sorryAx` |
| `PvsNP.ThreeSAT_is_NPComplete` | `formal/lean4` | open | `sorryAx` |
| `PvsNP.cook_levin` | `formal/lean4` | open | `sorryAx` |
| `PvsNP.eq_of_SAT_in_P` | `formal/lean4` | open | `sorryAx` |
| `PvsNP.master_equality` | `formal/lean4` | open | `sorryAx` |
| `PvsNP.master_theorem_program` | `formal/lean4` | open | `sorryAx` |
| `PvsNP.natural_proofs_insufficient` | `formal/lean4` | open | `sorryAx` |
| `PvsNP.proof_must_not_algebrize` | `formal/lean4` | open | `sorryAx` |
| `PvsNP.proof_must_not_relativize` | `formal/lean4` | conditional | `PvsNP.baker_gill_solovay` |
| `PvsNP.space_hierarchy` | `formal/lean4` | open | `sorryAx` |
| `PvsNP.time_hierarchy` | `formal/lean4` | open | `sorryAx` |
| `PvsNP.proof_must_not_relativize` | `formal/lean4/PvsNP (file by file)` | conditional | `PvsNP.baker_gill_solovay` |
| `PvsNP.natural_proofs_insufficient` | `formal/lean4/PvsNP (file by file)` | open | `sorryAx` |
| `PvsNP.proof_must_not_algebrize` | `formal/lean4/PvsNP (file by file)` | open | `sorryAx` |
| `PvsNP.P_eq_P'` | `formal/lean4/PvsNP (file by file)` | open | `sorryAx` |
| `PvsNP.NP_eq_NP_verifier` | `formal/lean4/PvsNP (file by file)` | open | `sorryAx` |
| `PvsNP.P_eq_NP_iff_NPC_in_P` | `formal/lean4/PvsNP (file by file)` | open | `sorryAx` |
| `PvsNP.time_hierarchy` | `formal/lean4/PvsNP (file by file)` | open | `sorryAx` |
| `PvsNP.P_strictly_subset_EXP` | `formal/lean4/PvsNP (file by file)` | open | `sorryAx` |
| `PvsNP.space_hierarchy` | `formal/lean4/PvsNP (file by file)` | open | `sorryAx` |
| `PvsNP.L_strictly_subset_PSPACE` | `formal/lean4/PvsNP (file by file)` | open | `sorryAx` |
| `PvsNP.NP_strictly_subset_NEXP` | `formal/lean4/PvsNP (file by file)` | open | `sorryAx` |
| `PvsNP.P_subset_PSPACE` | `formal/lean4/PvsNP (file by file)` | open | `sorryAx` |
| `PvsNP.NP_subset_PSPACE` | `formal/lean4/PvsNP (file by file)` | open | `sorryAx` |
| `PvsNP.PSPACE_subset_EXP` | `formal/lean4/PvsNP (file by file)` | open | `sorryAx` |
| `PvsNP.master_equality` | `formal/lean4/PvsNP (file by file)` | open | `sorryAx` |
| `PvsNP.master_theorem_program` | `formal/lean4/PvsNP (file by file)` | open | `sorryAx` |
| `PvsNP.SAT_in_NP` | `formal/lean4/PvsNP (file by file)` | open | `sorryAx` |
| `PvsNP.SAT_NP_hard` | `formal/lean4/PvsNP (file by file)` | open | `sorryAx` |
| `PvsNP.cook_levin` | `formal/lean4/PvsNP (file by file)` | open | `sorryAx` |
| `PvsNP.eq_of_SAT_in_P` | `formal/lean4/PvsNP (file by file)` | open | `sorryAx` |
| `PvsNP.ThreeSAT_is_NPComplete` | `formal/lean4/PvsNP (file by file)` | open | `sorryAx` |
| `PvsNP.baker_gill_solovay` | `src/lean4 (file by file)` | open | `sorryAx` |
| `PvsNP.proof_must_not_relativize` | `src/lean4 (file by file)` | open | `sorryAx` |
| `PvsNP.natural_proofs_barrier` | `src/lean4 (file by file)` | open | `sorryAx` |
| `PvsNP.aaronson_wigderson` | `src/lean4 (file by file)` | open | `sorryAx` |
| `PvsNP.inP_implies_inPpoly` | `src/lean4 (file by file)` | open | `sorryAx` |
| `PvsNP.P_subset_NP_inter_coNP` | `src/lean4 (file by file)` | open | `sorryAx` |
| `PvsNP.P_subset_EXP` | `src/lean4 (file by file)` | open | `sorryAx` |
| `PvsNP.NP_subset_EXP` | `src/lean4 (file by file)` | open | `sorryAx` |
| `PvsNP.time_hierarchy` | `src/lean4 (file by file)` | open | `sorryAx` |
| `PvsNP.P_strictly_subset_EXP` | `src/lean4 (file by file)` | open | `sorryAx` |
| `PvsNP.space_hierarchy` | `src/lean4 (file by file)` | open | `sorryAx` |
| `PvsNP.L_strictly_subset_PSPACE` | `src/lean4 (file by file)` | open | `sorryAx` |
| `PvsNP.ntime_hierarchy` | `src/lean4 (file by file)` | open | `sorryAx` |
| `PvsNP.NP_strictly_subset_NEXP` | `src/lean4 (file by file)` | open | `sorryAx` |
| `PvsNP.complexity_landscape` | `src/lean4 (file by file)` | open | `sorryAx` |
| `PvsNP.SymbolicSeparationProgram` | `src/lean4 (file by file)` | open | `sorryAx` |
| `PvsNP.MasterTheorem` | `src/lean4 (file by file)` | open | `sorryAx` |
| `PvsNP.branches_consistent` | `src/lean4 (file by file)` | open | `sorryAx` |
| `PvsNP.FinalTheorem` | `src/lean4 (file by file)` | open | `sorryAx` |
| `PvsNP.PeqNP_from_SAT` | `src/lean4 (file by file)` | open | `sorryAx` |
| `PvsNP.PeqNP_from_SAT_detailed` | `src/lean4 (file by file)` | open | `sorryAx` |
| `PvsNP.PeqNP_from_SAT_explicit` | `src/lean4 (file by file)` | open | `sorryAx` |
| `PvsNP.P_neq_NP_implies_SAT_not_in_P` | `src/lean4 (file by file)` | open | `sorryAx` |
| `PvsNP.NPC_in_P_implies_P_eq_NP` | `src/lean4 (file by file)` | open | `sorryAx` |
| `PvsNP.P_eq_NP_from_3SAT` | `src/lean4 (file by file)` | open | `sorryAx` |
| `PvsNP.SAT_in_P_gives_universal_algorithm` | `src/lean4 (file by file)` | open | `sorryAx` |
| `PvsNP.PneqNP_from_NPnotPpoly` | `src/lean4 (file by file)` | open | `sorryAx` |
| `PvsNP.PneqNP_from_witness` | `src/lean4 (file by file)` | open | `sorryAx` |
| `PvsNP.PneqNP_from_NPnotPpoly_detailed` | `src/lean4 (file by file)` | open | `sorryAx` |
| `PvsNP.PH_infinite_implies_PneqNP` | `src/lean4 (file by file)` | open | `sorryAx` |
| `PvsNP.circuit_lower_bound_implies_separation` | `src/lean4 (file by file)` | open | `sorryAx` |
| `PvsNP.PneqNP_from_Stone` | `src/lean4 (file by file)` | open | `sorryAx` |
| `PvsNP.P_eq_NP_implies_not_Stone` | `src/lean4 (file by file)` | open | `sorryAx` |
| `PvsNP.eq_of_NPC_in_P` | `src/lean4 (file by file)` | open | `sorryAx` |
| `PvsNP.P_eq_NP_iff_NPC_in_P` | `src/lean4 (file by file)` | open | `sorryAx` |
| `PvsNP.cook_levin` | `src/lean4 (file by file)` | open | `sorryAx` |
| `PvsNP.eq_of_SAT_in_P` | `src/lean4 (file by file)` | open | `sorryAx` |
| `PvsNP.sep_of_stone` | `src/lean4 (file by file)` | open | `sorryAx` |
| `PvsNP.CLIQUE_candidate` | `src/lean4 (file by file)` | open | `sorryAx` |
| `PvsNP.PARITY_linear_lower_bound` | `src/lean4 (file by file)` | open | `sorryAx` |
| `PvsNP.implications_chain` | `src/lean4 (file by file)` | open | `sorryAx` |

### Declared theorems

The `.lean` files of the verified commit declare 168 `theorem`/`lemma` (counting copies). The kernel checked 128 of them (66 closed, 1 conditional, 61 open). The closed count in the table above is larger: it also counts the theorems Lean generates by itself (equation lemmas, structure fields, `deriving`), which are not written in the text. For 40 the kernel has no result:

| Reason | Theorems |
|---|---:|
| checked file by file: Lean did not reach the theorem (missing import, syntax error or timeout) | 40 |

### MVEI corrections

* `correcoes/imports-no-topo.patch` (import fora do início do arquivo, 18 file(s)): applies to the published sources: `git apply -p1 --directory=imports/millennium-p-vs-np-classical mvei/millennium-p-vs-np-classical/correcoes/imports-no-topo.patch` (in order, after the ones above)
* `correcoes/tatica-encontrada.patch` (prova que não passava (ou axioma) que uma tática padrão fecha no kernel, 3 file(s)): applies to the published sources: `git apply -p1 --directory=imports/millennium-p-vs-np-classical mvei/millennium-p-vs-np-classical/correcoes/tatica-encontrada.patch` (in order, after the ones above)
* `correcoes/vocabulario-lean4.patch` (grafia que o Lean 4 não lê (nome acentuado, λ/Σ/Π como nome, ∀ x y ∈ s, docstring solta, constant, tática do Mathlib sem import), 25 file(s)): applies to the published sources: `git apply -p1 --directory=imports/millennium-p-vs-np-classical mvei/millennium-p-vs-np-classical/correcoes/vocabulario-lean4.patch` (in order, after the ones above)
* `correcoes/z-provas-reparadas.patch` (prova que não passava no kernel (o enunciado fica igual), 5 file(s)): applies to the published sources: `git apply -p1 --directory=imports/millennium-p-vs-np-classical mvei/millennium-p-vs-np-classical/correcoes/z-provas-reparadas.patch` (in order, after the ones above)
* `correcoes/zy-enunciados-do-autor.patch` (enunciado reescrito a pedido do autor (o original, como escrito, fica registrado), 2 file(s)): applies to the published sources: `git apply -p1 --directory=imports/millennium-p-vs-np-classical mvei/millennium-p-vs-np-classical/correcoes/zy-enunciados-do-autor.patch` (in order, after the ones above)
* `correcoes/zz-refutacoes.patch` (teorema com enunciado falso como o Lean o lê (o original fica como está), 1 file(s)): applies to the published sources: `git apply -p1 --directory=imports/millennium-p-vs-np-classical mvei/millennium-p-vs-np-classical/correcoes/zz-refutacoes.patch` (in order, after the ones above)

## Files in this folder

* `VERIFICACAO.json` — each Lean project of this repository, each theorem the kernel read, its statement, its axioms and its state (`fechado` closed, `condicional` conditional, `aberto-sorry` open)
* `TEOREMAS.csv` — each declared `theorem`/`lemma`: file, line, state in the kernel (`nao_checado` = not checked) and, if not checked, why (in Portuguese)
* `BUILD_LOG.txt` — one block per project: Lean version, result, errors
* `SOURCE.json` — source commit, verified commit and dates, machine-readable
* `SOURCES.sha256` — SHA-256 of every published file

## Reproduce

```
cd imports/millennium-p-vs-np-classical/<project>   # a project folder from the table above ('.' is imports/millennium-p-vs-np-classical)
lake exe cache get           # only for projects that require Mathlib
lake build
```

Each project uses the Lean version in its own `lean-toolchain`, which elan installs. The MVEI pipeline that produced these results is in the author's repository and is not public.
