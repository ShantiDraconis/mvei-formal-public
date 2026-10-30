# MVEI kernel check — UMA

This folder records what the Lean 4 kernel said about the Lean sources of the private repository `ShantiDraconis/UMA`. The sources are published in [`imports/UMA/`](../../imports/UMA/).

## What is published

* Source: `ShantiDraconis/UMA`, commit `62b22ffb050a526dcb0d40229ce1077405ea701b` (2026-01-16T19:38:57Z).
* 9 files: 9 `.lean` files and the Lake files (`lakefile.*`, `lean-toolchain`, `lake-manifest.json`). Paths are the same as in the source repository.
* Nothing else from the private repository is published (documents, commercial license, prompts, storefront material).
* `SOURCES.sha256` lists every published file with its SHA-256. From the repository root: `sha256sum -c mvei/UMA/SOURCES.sha256`.

## What the kernel said

MVEI verification of 2026-10-30T08:01:18+00:00, on commit `62b22ffb050a526dcb0d40229ce1077405ea701b`. Each theorem was read with `Lean.collectAxioms`, the function behind `#print axioms`.

| Lean project | Lean version | Build | Closed | Conditional | Open (`sorry`) | Checked file by file: closed / conditional / open / proof error / not reached |
|---|---|---|---:|---:|---:|---|
| `.formal_foundations/lean` | v4.36.0-rc2 | OK | 5 | 0 | 0 | 7 / 0 / 0 / 3 / 0 |
| `formal_proofs/lean` (no lakefile; project assembled by MVEI) | padrão do elan | failed | 0 | 0 | 0 | 13 / 4 / 6 / 9 / 0 |
| `formal_verification` (no lakefile; project assembled by MVEI) | padrão do elan | failed | 0 | 0 | 0 | 6 / 0 / 10 / 6 / 0 |

| Closed theorems in this repository | |
|---|---:|
| Counting each project | 31 |
| Unique (name + statement) | 31 |
| Unique, without the lemmas Lean generates itself (`eq_1`, `mk.inj`, `sizeOf_spec`, `deriving`) | 28 |

*Closed* means the kernel accepted the proof and it depends only on `propext`, `Classical.choice` and `Quot.sound`. It says that the statement as written in the file is proved; it does not say that an open problem is solved. Every statement is in `VERIFICACAO.json`. *Conditional* means the proof also uses axioms declared in the repository; *open* means it uses `sorry`. *Checked file by file* covers the files that no build reached: each one went through Lean whole, with a `#print axioms` for each theorem.

| Theorem | Project | State | Axioms beyond the standard three |
|---|---|---|---|
| `BateriaMagnetica.energia_perpetua` | `formal_proofs/lean (file by file)` | open | `sorryAx` |
| `BateriaMagnetica.vantagem_longevidade` | `formal_proofs/lean (file by file)` | open | `sorryAx` |
| `Universe00.potential_conservation_lemma` | `formal_proofs/lean (file by file)` | conditional | `Universe00.potential_conservation` |
| `Universe00.reconstruction_sufficiency` | `formal_proofs/lean (file by file)` | conditional | `Universe00.configuration_realizable` |
| `Universe00.waste_elimination` | `formal_proofs/lean (file by file)` | conditional | `Universe00.pure_potential_exists` |
| `Universe00.system_integration` | `formal_proofs/lean (file by file)` | conditional | `Universe00.pure_potential_exists` |
| `Universe00Extended.compensation_degrades` | `formal_proofs/lean (file by file)` | open | `sorryAx` |
| `Universe00Extended.renewable_target_achievable` | `formal_proofs/lean (file by file)` | open | `sorryAx` |
| `Universe00Extended.higher_snr_increases_capacity` | `formal_proofs/lean (file by file)` | open | `sorryAx` |
| `Universe00Extended.higher_renewable_reduces_carbon` | `formal_proofs/lean (file by file)` | open | `sorryAx` |
| `UMA.Singularity.sinc_removable_singularity` | `formal_verification (file by file)` | open | `sorryAx` |
| `UMA.Singularity.lhopital_rule_zero_over_zero` | `formal_verification (file by file)` | open | `sorryAx` |
| `UMA.PrimeSync.no_resonance_buildup` | `formal_verification (file by file)` | open | `sorryAx` |
| `UMA.Gyroscope.quaternion_no_gimbal_lock` | `formal_verification (file by file)` | open | `sorryAx` |
| `UMA.Logistics.triangle_inequality` | `formal_verification (file by file)` | open | `sorryAx` |
| `UMA.Logistics.nearest_neighbor_approximation` | `formal_verification (file by file)` | open | `sorryAx` |
| `Universe00.lhopital_zero_form` | `formal_verification (file by file)` | open | `sorryAx` |
| `Universe00.unique_prime_factorization` | `formal_verification (file by file)` | open | `sorryAx` |
| `Universe00.prime_event_collision_free` | `formal_verification (file by file)` | open | `sorryAx` |
| `Universe00.universe00_stability` | `formal_verification (file by file)` | open | `sorryAx` |

### Declared theorems

The `.lean` files of the verified commit declare 65 `theorem`/`lemma` (counting copies). The kernel checked 47 of them (27 closed, 4 conditional, 16 open). The closed count in the table above is larger: it also counts the theorems Lean generates by itself (equation lemmas, structure fields, `deriving`), which are not written in the text. For 18 the kernel has no result:

| Reason | Theorems |
|---|---:|
| checked file by file: the written proof does not pass the kernel | 18 |

### MVEI corrections

* `correcoes/renomear-imports-mathlib.patch` (import de módulo que não existe na versão do Mathlib do projeto (renomeado ou dividido), 1 file(s)): applies to the published sources: `git apply -p1 --directory=imports/UMA mvei/UMA/correcoes/renomear-imports-mathlib.patch` (in order, after the ones above)
* `correcoes/tatica-encontrada.patch` (prova que não passava (ou axioma) que uma tática padrão fecha no kernel, 3 file(s)): applies to the published sources: `git apply -p1 --directory=imports/UMA mvei/UMA/correcoes/tatica-encontrada.patch` (in order, after the ones above)
* `correcoes/vocabulario-lean4.patch` (grafia que o Lean 4 não lê (nome acentuado, λ/Σ/Π como nome, ∀ x y ∈ s, docstring solta, constant, tática do Mathlib sem import), 8 file(s)): applies to the published sources: `git apply -p1 --directory=imports/UMA mvei/UMA/correcoes/vocabulario-lean4.patch` (in order, after the ones above)
* `correcoes/z-provas-reparadas.patch` (prova que não passava no kernel (o enunciado fica igual), 1 file(s)): applies to the published sources: `git apply -p1 --directory=imports/UMA mvei/UMA/correcoes/z-provas-reparadas.patch` (in order, after the ones above)
* `correcoes/zz-refutacoes.patch` (teorema com enunciado falso como o Lean o lê (o original fica como está), 1 file(s)): applies to the published sources: `git apply -p1 --directory=imports/UMA mvei/UMA/correcoes/zz-refutacoes.patch` (in order, after the ones above)

## Files in this folder

* `VERIFICACAO.json` — each Lean project of this repository, each theorem the kernel read, its statement, its axioms and its state (`fechado` closed, `condicional` conditional, `aberto-sorry` open)
* `TEOREMAS.csv` — each declared `theorem`/`lemma`: file, line, state in the kernel (`nao_checado` = not checked) and, if not checked, why (in Portuguese)
* `BUILD_LOG.txt` — one block per project: Lean version, result, errors
* `SOURCE.json` — source commit, verified commit and dates, machine-readable
* `SOURCES.sha256` — SHA-256 of every published file

## Reproduce

```
cd imports/UMA/<project>   # a project folder from the table above ('.' is imports/UMA)
lake exe cache get           # only for projects that require Mathlib
lake build
```

Each project uses the Lean version in its own `lean-toolchain`, which elan installs. The MVEI pipeline that produced these results is in the author's repository and is not public.
