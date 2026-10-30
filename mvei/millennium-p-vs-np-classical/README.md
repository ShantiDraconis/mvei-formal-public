# MVEI kernel check — millennium-p-vs-np-classical

This folder records what the Lean 4 kernel said about the Lean sources of the private repository `ShantiDraconis/millennium-p-vs-np-classical`. The sources are published in [`imports/millennium-p-vs-np-classical/`](../../imports/millennium-p-vs-np-classical/).

## What is published

* Source: `ShantiDraconis/millennium-p-vs-np-classical`, commit `1990622af0a0c2ebcbe450979ba48f62025c736d` (2026-09-18T04:11:57Z).
* 30 files: 28 `.lean` files and the Lake files (`lakefile.*`, `lean-toolchain`, `lake-manifest.json`), plus 1 license or origin file(s) that third-party code requires (`LICENSE`). Paths are the same as in the source repository.
* Nothing else from the private repository is published (documents, commercial license, prompts, storefront material).
* `SOURCES.sha256` lists every published file with its SHA-256. From the repository root: `sha256sum -c mvei/millennium-p-vs-np-classical/SOURCES.sha256`.

## What the kernel said

MVEI verification of 2026-10-30T08:01:18+00:00, on commit `1990622af0a0c2ebcbe450979ba48f62025c736d`. Each theorem was read with `Lean.collectAxioms`, the function behind `#print axioms`.

| Lean project | Lean version | Build | Closed | Conditional | Open (`sorry`) | Checked file by file: closed / conditional / open / proof error / not reached |
|---|---|---|---:|---:|---:|---|
| `formal/lean4` | v4.36.0-rc2 | failed | 0 | 0 | 0 | — |
| `formal/lean4/PvsNP` | padrão do elan | failed | 0 | 0 | 0 | 2 / 0 / 0 / 1 / 42 |
| `src/lean4` | padrão do elan | failed | 0 | 0 | 0 | 33 / 0 / 29 / 0 / 62 |

| Closed theorems in this repository | |
|---|---:|
| Counting each project | 35 |
| Unique (name + statement) | 33 |
| Unique, without the lemmas Lean generates itself (`eq_1`, `mk.inj`, `sizeOf_spec`, `deriving`) | 32 |

*Closed* means the kernel accepted the proof and it depends only on `propext`, `Classical.choice` and `Quot.sound`. It says that the statement as written in the file is proved; it does not say that an open problem is solved. Every statement is in `VERIFICACAO.json`. *Conditional* means the proof also uses axioms declared in the repository; *open* means it uses `sorry`. *Checked file by file* covers the files that no build reached: each one went through Lean whole, with a `#print axioms` for each theorem.

| Theorem | Project | State | Axioms beyond the standard three |
|---|---|---|---|
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
| `PvsNP.EXP_ne_NEXP_implies_P_ne_NP` | `src/lean4 (file by file)` | open | `sorryAx` |
| `PvsNP.PneqNP_from_NPnotPpoly` | `src/lean4 (file by file)` | open | `sorryAx` |
| `PvsNP.PneqNP_from_witness` | `src/lean4 (file by file)` | open | `sorryAx` |
| `PvsNP.PneqNP_from_NPnotPpoly_detailed` | `src/lean4 (file by file)` | open | `sorryAx` |
| `PvsNP.PH_infinite_implies_PneqNP` | `src/lean4 (file by file)` | open | `sorryAx` |
| `PvsNP.circuit_lower_bound_implies_separation` | `src/lean4 (file by file)` | open | `sorryAx` |
| `PvsNP.PneqNP_from_Stone` | `src/lean4 (file by file)` | open | `sorryAx` |
| `PvsNP.P_eq_NP_implies_not_Stone` | `src/lean4 (file by file)` | open | `sorryAx` |
| `PvsNP.eq_of_NPC_in_P` | `src/lean4 (file by file)` | open | `sorryAx` |
| `PvsNP.P_eq_NP_iff_NPC_in_P` | `src/lean4 (file by file)` | open | `sorryAx` |
| `PvsNP.sep_of_stone` | `src/lean4 (file by file)` | open | `sorryAx` |
| `PvsNP.CLIQUE_candidate` | `src/lean4 (file by file)` | open | `sorryAx` |
| `PvsNP.PARITY_linear_lower_bound` | `src/lean4 (file by file)` | open | `sorryAx` |
| `PvsNP.implications_chain` | `src/lean4 (file by file)` | open | `sorryAx` |

### Declared theorems

The `.lean` files of the verified commit declare 168 `theorem`/`lemma` (counting copies). The kernel checked 63 of them (34 closed, 0 conditional, 29 open). The closed count in the table above is larger: it also counts the theorems Lean generates by itself (equation lemmas, structure fields, `deriving`), which are not written in the text. For 105 the kernel has no result:

| Reason | Theorems |
|---|---:|
| checked file by file: Lean did not reach the theorem (missing import, syntax error or timeout) | 104 |
| checked file by file: the written proof does not pass the kernel | 1 |

### MVEI corrections

* `correcoes/imports-no-topo.patch` (import fora do início do arquivo, 18 file(s)): applies to the published sources: `git apply -p1 --directory=imports/millennium-p-vs-np-classical mvei/millennium-p-vs-np-classical/correcoes/imports-no-topo.patch` (in order, after the ones above)
* `correcoes/vocabulario-lean4.patch` (grafia que o Lean 4 não lê (nome acentuado, λ/Σ/Π como nome, ∀ x y ∈ s, docstring solta, constant, tática do Mathlib sem import), 25 file(s)): applies to the published sources: `git apply -p1 --directory=imports/millennium-p-vs-np-classical mvei/millennium-p-vs-np-classical/correcoes/vocabulario-lean4.patch` (in order, after the ones above)
* `correcoes/z-provas-reparadas.patch` (prova que não passava no kernel (o enunciado fica igual), 1 file(s)): applies to the published sources: `git apply -p1 --directory=imports/millennium-p-vs-np-classical mvei/millennium-p-vs-np-classical/correcoes/z-provas-reparadas.patch` (in order, after the ones above)
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
