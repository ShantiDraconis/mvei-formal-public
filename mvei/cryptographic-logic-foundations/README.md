# MVEI kernel check — cryptographic-logic-foundations

This folder records what the Lean 4 kernel said about the Lean sources of the private repository `ShantiDraconis/cryptographic-logic-foundations`. The sources are published in [`imports/cryptographic-logic-foundations/`](../../imports/cryptographic-logic-foundations/).

## What is published

* Source: `ShantiDraconis/cryptographic-logic-foundations`, commit `6a4ece53b5f0df5bf095a8f5500b4f2bd9d1c9eb` (2026-01-16T16:54:52Z).
* 30 files: 28 `.lean` files and the Lake files (`lakefile.*`, `lean-toolchain`, `lake-manifest.json`). Paths are the same as in the source repository.
* Nothing else from the private repository is published (documents, commercial license, prompts, storefront material).
* `SOURCES.sha256` lists every published file with its SHA-256. From the repository root: `sha256sum -c mvei/cryptographic-logic-foundations/SOURCES.sha256`.

## What the kernel said

MVEI verification of 2026-10-29T18:57:14+00:00, on commit `6a4ece53b5f0df5bf095a8f5500b4f2bd9d1c9eb`. Each theorem was read with `Lean.collectAxioms`, the function behind `#print axioms`.

| Lean project | Lean version | Build | Closed | Conditional | Open (`sorry`) | Checked file by file: closed / conditional / open / proof error / not reached |
|---|---|---|---:|---:|---:|---|
| `.` | v4.19.0 | partial | 29 | 0 | 4 | 8 / 0 / 7 / 12 / 5 |
| `formal/lean4` | padrão do elan | failed | 0 | 0 | 0 | 4 / 0 / 0 / 1 / 0 |
| `provers/lean` | v4.3.0 | partial | 2 | 0 | 1 | 1 / 1 / 1 / 2 / 0 |

| Closed theorems in this repository | |
|---|---:|
| Counting each project | 44 |
| Unique (name + statement) | 44 |
| Unique, without the lemmas Lean generates itself (`eq_1`, `mk.inj`, `sizeOf_spec`, `deriving`) | 17 |

*Closed* means the kernel accepted the proof and it depends only on `propext`, `Classical.choice` and `Quot.sound`. It says that the statement as written in the file is proved; it does not say that an open problem is solved. Every statement is in `VERIFICACAO.json`. *Conditional* means the proof also uses axioms declared in the repository; *open* means it uses `sorry`. *Checked file by file* covers the files that no build reached: each one went through Lean whole, with a `#print axioms` for each theorem.

| Theorem | Project | State | Axioms beyond the standard three |
|---|---|---|---|
| `RiemannHypothesis.critical_line_hypothesis` | `.` | open | `sorryAx` |
| `RiemannHypothesis.riemann_hypothesis` | `.` | open | `sorryAx` |
| `RiemannHypothesis.zeta_functional_equation` | `.` | open | `sorryAx` |
| `no_leak_between_levels` | `.` | open | `sorryAx` |
| `RiemannHypothesis_equiv` | `provers/lean` | open | `RiemannZeta`, `sorryAx` |
| `Universe00.Layer0.layer0_integrity` | `. (file by file)` | open | `sorryAx`, `Universe00.Layer0.I` |
| `sync_108hz_coherent` | `. (file by file)` | open | `sorryAx` |
| `TimestampProof.chain_integrity_preserved` | `. (file by file)` | open | `sorryAx`, `TimestampProof.encode`, `TimestampProof.hash_function` |
| `TimestampProof.temporal_consistency_monotonic` | `. (file by file)` | open | `sorryAx`, `TimestampProof.encode`, `TimestampProof.hash_function` |
| `StateInvariants.log_immutability_preserved` | `. (file by file)` | open | `sorryAx` |
| `PvsNP.sat_in_np` | `. (file by file)` | open | `sorryAx` |
| `ZKPFoundation.zk_preserves_privacy` | `. (file by file)` | open | `sorryAx` |
| `P_eq_NP_implies_NPComplete_in_P` | `provers/lean (file by file)` | open | `P`, `NP`, `sorryAx` |
| `Sovereign.sovereignIntegrity` | `provers/lean (file by file)` | conditional | `Sovereign.verifiedHashNonEmpty` |

### Declared theorems

The `.lean` files of the verified commit declare 51 `theorem`/`lemma` (counting copies). The kernel checked 31 of them (17 closed, 1 conditional, 13 open). The closed count in the table above is larger: it also counts the theorems Lean generates by itself (equation lemmas, structure fields, `deriving`), which are not written in the text. For 20 the kernel has no result:

| Reason | Theorems |
|---|---:|
| checked file by file: the written proof does not pass the kernel | 15 |
| checked file by file: Lean did not reach the theorem (missing import, syntax error or timeout) | 5 |

### MVEI corrections

* `correcoes/renomear-imports-mathlib.patch` (import de módulo que não existe na versão do Mathlib do projeto (renomeado ou dividido), 1 file(s)): applies to the published sources: `git apply -p1 --directory=imports/cryptographic-logic-foundations mvei/cryptographic-logic-foundations/correcoes/renomear-imports-mathlib.patch` (in order, after the ones above)
* `correcoes/tatica-encontrada.patch` (prova que não passava (ou axioma) que uma tática padrão fecha no kernel, 2 file(s)): applies to the published sources: `git apply -p1 --directory=imports/cryptographic-logic-foundations mvei/cryptographic-logic-foundations/correcoes/tatica-encontrada.patch` (in order, after the ones above)

## Files in this folder

* `VERIFICACAO.json` — each Lean project of this repository, each theorem the kernel read, its statement, its axioms and its state (`fechado` closed, `condicional` conditional, `aberto-sorry` open)
* `TEOREMAS.csv` — each declared `theorem`/`lemma`: file, line, state in the kernel (`nao_checado` = not checked) and, if not checked, why (in Portuguese)
* `BUILD_LOG.txt` — one block per project: Lean version, result, errors
* `SOURCE.json` — source commit, verified commit and dates, machine-readable
* `SOURCES.sha256` — SHA-256 of every published file

## Reproduce

```
cd imports/cryptographic-logic-foundations/<project>   # a project folder from the table above ('.' is imports/cryptographic-logic-foundations)
lake exe cache get           # only for projects that require Mathlib
lake build
```

Each project uses the Lean version in its own `lean-toolchain`, which elan installs. The MVEI pipeline that produced these results is in the author's repository and is not public.
