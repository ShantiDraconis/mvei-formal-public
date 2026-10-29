# MVEI kernel check — mishkan-iii-core

This folder records what the Lean 4 kernel said about the Lean sources of the private repository `ShantiDraconis/mishkan-iii-core`. The sources are published in [`imports/mishkan-iii-core/`](../../imports/mishkan-iii-core/).

## What is published

* Source: `ShantiDraconis/mishkan-iii-core`, commit `2e43209371b6c345d28b5dcabf4953bbb2cff104` (2026-09-18T09:56:23Z).
* 15 files: 15 `.lean` files and the Lake files (`lakefile.*`, `lean-toolchain`, `lake-manifest.json`). Paths are the same as in the source repository.
* Nothing else from the private repository is published (documents, commercial license, prompts, storefront material).
* `SOURCES.sha256` lists every published file with its SHA-256. From the repository root: `sha256sum -c mvei/mishkan-iii-core/SOURCES.sha256`.

## What the kernel said

MVEI verification of 2026-10-29T05:36:17+00:00, on commit `2e43209371b6c345d28b5dcabf4953bbb2cff104`. Each theorem was read with `Lean.collectAxioms`, the function behind `#print axioms`.

| Lean project | Lean version | Build | Closed | Conditional | Open (`sorry`) | Checked file by file: closed / conditional / open / proof error / not reached |
|---|---|---|---:|---:|---:|---|
| `core` (no lakefile; project assembled by MVEI) | v4.19.0 | partial | 14 | 0 | 0 | 5190 / 1 / 203 / 13171 / 0 |

| Closed theorems in this repository | |
|---|---:|
| Counting each project | 5 204 |
| Unique (name + statement) | 5 204 |
| Unique, without the lemmas Lean generates itself (`eq_1`, `mk.inj`, `sizeOf_spec`, `deriving`) | 5 192 |

*Closed* means the kernel accepted the proof and it depends only on `propext`, `Classical.choice` and `Quot.sound`. It says that the statement as written in the file is proved; it does not say that an open problem is solved. Every statement is in `VERIFICACAO.json`. *Conditional* means the proof also uses axioms declared in the repository; *open* means it uses `sorry`. *Checked file by file* covers the files that no build reached: each one went through Lean whole, with a `#print axioms` for each theorem.

| Theorem | Project | State | Axioms beyond the standard three |
|---|---|---|---|
| `HarappaCatalog.all_signs_have_valid_indices` | `core (file by file)` | open | `sorryAx` |
| `HarappaCatalog.catalog_authenticated` | `core (file by file)` | open | `sorryAx` |
| `PhaseZero.logic_predates_system` | `core (file by file)` | conditional | `PhaseZero.archaeological_priority_check` |
| `fragmentation_unintelligible` | `core (file by file)` | open | `sorryAx` |
| `s5_requires_lineage` | `core (file by file)` | open | `sorryAx` |
| `TempleArchitecture.golden_ratio_001_approx` | `core (file by file)` | open | `sorryAx` |
| `TempleArchitecture.golden_ratio_002_approx` | `core (file by file)` | open | `sorryAx` |
| `TempleArchitecture.golden_ratio_003_approx` | `core (file by file)` | open | `sorryAx` |
| `TempleArchitecture.golden_ratio_004_approx` | `core (file by file)` | open | `sorryAx` |
| `TempleArchitecture.golden_ratio_005_approx` | `core (file by file)` | open | `sorryAx` |
| `TempleArchitecture.golden_ratio_006_approx` | `core (file by file)` | open | `sorryAx` |
| `TempleArchitecture.golden_ratio_007_approx` | `core (file by file)` | open | `sorryAx` |
| `TempleArchitecture.golden_ratio_008_approx` | `core (file by file)` | open | `sorryAx` |
| `TempleArchitecture.golden_ratio_009_approx` | `core (file by file)` | open | `sorryAx` |
| `TempleArchitecture.golden_ratio_010_approx` | `core (file by file)` | open | `sorryAx` |
| `TempleArchitecture.golden_ratio_011_approx` | `core (file by file)` | open | `sorryAx` |
| `TempleArchitecture.golden_ratio_012_approx` | `core (file by file)` | open | `sorryAx` |
| `TempleArchitecture.golden_ratio_013_approx` | `core (file by file)` | open | `sorryAx` |
| `TempleArchitecture.golden_ratio_014_approx` | `core (file by file)` | open | `sorryAx` |
| `TempleArchitecture.golden_ratio_015_approx` | `core (file by file)` | open | `sorryAx` |
| `TempleArchitecture.golden_ratio_016_approx` | `core (file by file)` | open | `sorryAx` |
| `TempleArchitecture.golden_ratio_017_approx` | `core (file by file)` | open | `sorryAx` |
| `TempleArchitecture.golden_ratio_018_approx` | `core (file by file)` | open | `sorryAx` |
| `TempleArchitecture.golden_ratio_019_approx` | `core (file by file)` | open | `sorryAx` |
| `TempleArchitecture.golden_ratio_020_approx` | `core (file by file)` | open | `sorryAx` |
| `TempleArchitecture.golden_ratio_021_approx` | `core (file by file)` | open | `sorryAx` |
| `TempleArchitecture.golden_ratio_022_approx` | `core (file by file)` | open | `sorryAx` |
| `TempleArchitecture.golden_ratio_023_approx` | `core (file by file)` | open | `sorryAx` |
| `TempleArchitecture.golden_ratio_024_approx` | `core (file by file)` | open | `sorryAx` |
| `TempleArchitecture.golden_ratio_025_approx` | `core (file by file)` | open | `sorryAx` |
| `TempleArchitecture.golden_ratio_026_approx` | `core (file by file)` | open | `sorryAx` |
| `TempleArchitecture.golden_ratio_027_approx` | `core (file by file)` | open | `sorryAx` |
| `TempleArchitecture.golden_ratio_028_approx` | `core (file by file)` | open | `sorryAx` |
| `TempleArchitecture.golden_ratio_029_approx` | `core (file by file)` | open | `sorryAx` |
| `TempleArchitecture.golden_ratio_030_approx` | `core (file by file)` | open | `sorryAx` |
| `TempleArchitecture.golden_ratio_031_approx` | `core (file by file)` | open | `sorryAx` |
| `TempleArchitecture.golden_ratio_032_approx` | `core (file by file)` | open | `sorryAx` |
| `TempleArchitecture.golden_ratio_033_approx` | `core (file by file)` | open | `sorryAx` |
| `TempleArchitecture.golden_ratio_034_approx` | `core (file by file)` | open | `sorryAx` |
| `TempleArchitecture.golden_ratio_035_approx` | `core (file by file)` | open | `sorryAx` |
| `TempleArchitecture.golden_ratio_036_approx` | `core (file by file)` | open | `sorryAx` |
| `TempleArchitecture.golden_ratio_037_approx` | `core (file by file)` | open | `sorryAx` |
| `TempleArchitecture.golden_ratio_038_approx` | `core (file by file)` | open | `sorryAx` |
| `TempleArchitecture.golden_ratio_039_approx` | `core (file by file)` | open | `sorryAx` |
| `TempleArchitecture.golden_ratio_040_approx` | `core (file by file)` | open | `sorryAx` |
| `TempleArchitecture.golden_ratio_041_approx` | `core (file by file)` | open | `sorryAx` |
| `TempleArchitecture.golden_ratio_042_approx` | `core (file by file)` | open | `sorryAx` |
| `TempleArchitecture.golden_ratio_043_approx` | `core (file by file)` | open | `sorryAx` |
| `TempleArchitecture.golden_ratio_044_approx` | `core (file by file)` | open | `sorryAx` |
| `TempleArchitecture.golden_ratio_045_approx` | `core (file by file)` | open | `sorryAx` |
| `TempleArchitecture.golden_ratio_046_approx` | `core (file by file)` | open | `sorryAx` |
| `TempleArchitecture.golden_ratio_047_approx` | `core (file by file)` | open | `sorryAx` |
| `TempleArchitecture.golden_ratio_048_approx` | `core (file by file)` | open | `sorryAx` |
| `TempleArchitecture.golden_ratio_049_approx` | `core (file by file)` | open | `sorryAx` |
| `TempleArchitecture.golden_ratio_050_approx` | `core (file by file)` | open | `sorryAx` |
| `TempleArchitecture.golden_ratio_051_approx` | `core (file by file)` | open | `sorryAx` |
| `TempleArchitecture.golden_ratio_052_approx` | `core (file by file)` | open | `sorryAx` |
| `TempleArchitecture.golden_ratio_053_approx` | `core (file by file)` | open | `sorryAx` |
| `TempleArchitecture.golden_ratio_054_approx` | `core (file by file)` | open | `sorryAx` |
| `TempleArchitecture.golden_ratio_055_approx` | `core (file by file)` | open | `sorryAx` |
| `TempleArchitecture.golden_ratio_056_approx` | `core (file by file)` | open | `sorryAx` |
| `TempleArchitecture.golden_ratio_057_approx` | `core (file by file)` | open | `sorryAx` |
| `TempleArchitecture.golden_ratio_058_approx` | `core (file by file)` | open | `sorryAx` |
| `TempleArchitecture.golden_ratio_059_approx` | `core (file by file)` | open | `sorryAx` |
| `TempleArchitecture.golden_ratio_060_approx` | `core (file by file)` | open | `sorryAx` |
| `TempleArchitecture.golden_ratio_061_approx` | `core (file by file)` | open | `sorryAx` |
| `TempleArchitecture.golden_ratio_062_approx` | `core (file by file)` | open | `sorryAx` |
| `TempleArchitecture.golden_ratio_063_approx` | `core (file by file)` | open | `sorryAx` |
| `TempleArchitecture.golden_ratio_064_approx` | `core (file by file)` | open | `sorryAx` |
| `TempleArchitecture.golden_ratio_065_approx` | `core (file by file)` | open | `sorryAx` |
| `TempleArchitecture.golden_ratio_066_approx` | `core (file by file)` | open | `sorryAx` |
| `TempleArchitecture.golden_ratio_067_approx` | `core (file by file)` | open | `sorryAx` |
| `TempleArchitecture.golden_ratio_068_approx` | `core (file by file)` | open | `sorryAx` |
| `TempleArchitecture.golden_ratio_069_approx` | `core (file by file)` | open | `sorryAx` |
| `TempleArchitecture.golden_ratio_070_approx` | `core (file by file)` | open | `sorryAx` |
| `TempleArchitecture.golden_ratio_071_approx` | `core (file by file)` | open | `sorryAx` |
| `TempleArchitecture.golden_ratio_072_approx` | `core (file by file)` | open | `sorryAx` |
| `TempleArchitecture.golden_ratio_073_approx` | `core (file by file)` | open | `sorryAx` |
| `TempleArchitecture.golden_ratio_074_approx` | `core (file by file)` | open | `sorryAx` |
| `TempleArchitecture.golden_ratio_075_approx` | `core (file by file)` | open | `sorryAx` |
| `TempleArchitecture.golden_ratio_076_approx` | `core (file by file)` | open | `sorryAx` |
| `TempleArchitecture.golden_ratio_077_approx` | `core (file by file)` | open | `sorryAx` |
| `TempleArchitecture.golden_ratio_078_approx` | `core (file by file)` | open | `sorryAx` |
| `TempleArchitecture.golden_ratio_079_approx` | `core (file by file)` | open | `sorryAx` |
| `TempleArchitecture.golden_ratio_080_approx` | `core (file by file)` | open | `sorryAx` |
| `TempleArchitecture.golden_ratio_081_approx` | `core (file by file)` | open | `sorryAx` |
| `TempleArchitecture.golden_ratio_082_approx` | `core (file by file)` | open | `sorryAx` |
| `TempleArchitecture.golden_ratio_083_approx` | `core (file by file)` | open | `sorryAx` |
| `TempleArchitecture.golden_ratio_084_approx` | `core (file by file)` | open | `sorryAx` |
| `TempleArchitecture.golden_ratio_085_approx` | `core (file by file)` | open | `sorryAx` |
| `TempleArchitecture.golden_ratio_086_approx` | `core (file by file)` | open | `sorryAx` |
| `TempleArchitecture.golden_ratio_087_approx` | `core (file by file)` | open | `sorryAx` |
| `TempleArchitecture.golden_ratio_088_approx` | `core (file by file)` | open | `sorryAx` |
| `TempleArchitecture.golden_ratio_089_approx` | `core (file by file)` | open | `sorryAx` |
| `TempleArchitecture.golden_ratio_090_approx` | `core (file by file)` | open | `sorryAx` |
| `TempleArchitecture.golden_ratio_091_approx` | `core (file by file)` | open | `sorryAx` |
| `TempleArchitecture.golden_ratio_092_approx` | `core (file by file)` | open | `sorryAx` |
| `TempleArchitecture.golden_ratio_093_approx` | `core (file by file)` | open | `sorryAx` |
| `TempleArchitecture.golden_ratio_094_approx` | `core (file by file)` | open | `sorryAx` |
| `TempleArchitecture.golden_ratio_095_approx` | `core (file by file)` | open | `sorryAx` |
| `TempleArchitecture.golden_ratio_096_approx` | `core (file by file)` | open | `sorryAx` |
| `TempleArchitecture.golden_ratio_097_approx` | `core (file by file)` | open | `sorryAx` |
| `TempleArchitecture.golden_ratio_098_approx` | `core (file by file)` | open | `sorryAx` |
| `TempleArchitecture.golden_ratio_099_approx` | `core (file by file)` | open | `sorryAx` |
| `TempleArchitecture.golden_ratio_100_approx` | `core (file by file)` | open | `sorryAx` |
| `TempleArchitecture.golden_ratio_101_approx` | `core (file by file)` | open | `sorryAx` |
| `TempleArchitecture.golden_ratio_102_approx` | `core (file by file)` | open | `sorryAx` |
| `TempleArchitecture.golden_ratio_103_approx` | `core (file by file)` | open | `sorryAx` |
| `TempleArchitecture.golden_ratio_104_approx` | `core (file by file)` | open | `sorryAx` |
| `TempleArchitecture.golden_ratio_105_approx` | `core (file by file)` | open | `sorryAx` |
| `TempleArchitecture.golden_ratio_106_approx` | `core (file by file)` | open | `sorryAx` |
| `TempleArchitecture.golden_ratio_107_approx` | `core (file by file)` | open | `sorryAx` |
| `TempleArchitecture.golden_ratio_108_approx` | `core (file by file)` | open | `sorryAx` |
| `TempleArchitecture.golden_ratio_109_approx` | `core (file by file)` | open | `sorryAx` |
| `TempleArchitecture.golden_ratio_110_approx` | `core (file by file)` | open | `sorryAx` |
| `TempleArchitecture.golden_ratio_111_approx` | `core (file by file)` | open | `sorryAx` |
| `TempleArchitecture.golden_ratio_112_approx` | `core (file by file)` | open | `sorryAx` |
| `TempleArchitecture.golden_ratio_113_approx` | `core (file by file)` | open | `sorryAx` |
| `TempleArchitecture.golden_ratio_114_approx` | `core (file by file)` | open | `sorryAx` |
| `TempleArchitecture.golden_ratio_115_approx` | `core (file by file)` | open | `sorryAx` |
| `TempleArchitecture.golden_ratio_116_approx` | `core (file by file)` | open | `sorryAx` |
| `TempleArchitecture.golden_ratio_117_approx` | `core (file by file)` | open | `sorryAx` |
| `TempleArchitecture.golden_ratio_118_approx` | `core (file by file)` | open | `sorryAx` |
| `TempleArchitecture.golden_ratio_119_approx` | `core (file by file)` | open | `sorryAx` |
| `TempleArchitecture.golden_ratio_120_approx` | `core (file by file)` | open | `sorryAx` |
| `TempleArchitecture.golden_ratio_121_approx` | `core (file by file)` | open | `sorryAx` |
| `TempleArchitecture.golden_ratio_122_approx` | `core (file by file)` | open | `sorryAx` |
| `TempleArchitecture.golden_ratio_123_approx` | `core (file by file)` | open | `sorryAx` |
| `TempleArchitecture.golden_ratio_124_approx` | `core (file by file)` | open | `sorryAx` |
| `TempleArchitecture.golden_ratio_125_approx` | `core (file by file)` | open | `sorryAx` |
| `TempleArchitecture.golden_ratio_126_approx` | `core (file by file)` | open | `sorryAx` |
| `TempleArchitecture.golden_ratio_127_approx` | `core (file by file)` | open | `sorryAx` |
| `TempleArchitecture.golden_ratio_128_approx` | `core (file by file)` | open | `sorryAx` |
| `TempleArchitecture.golden_ratio_129_approx` | `core (file by file)` | open | `sorryAx` |
| `TempleArchitecture.golden_ratio_130_approx` | `core (file by file)` | open | `sorryAx` |
| `TempleArchitecture.golden_ratio_131_approx` | `core (file by file)` | open | `sorryAx` |
| `TempleArchitecture.golden_ratio_132_approx` | `core (file by file)` | open | `sorryAx` |
| `TempleArchitecture.golden_ratio_133_approx` | `core (file by file)` | open | `sorryAx` |
| `TempleArchitecture.golden_ratio_134_approx` | `core (file by file)` | open | `sorryAx` |
| `TempleArchitecture.golden_ratio_135_approx` | `core (file by file)` | open | `sorryAx` |
| `TempleArchitecture.golden_ratio_136_approx` | `core (file by file)` | open | `sorryAx` |
| `TempleArchitecture.golden_ratio_137_approx` | `core (file by file)` | open | `sorryAx` |
| `TempleArchitecture.golden_ratio_138_approx` | `core (file by file)` | open | `sorryAx` |
| `TempleArchitecture.golden_ratio_139_approx` | `core (file by file)` | open | `sorryAx` |
| `TempleArchitecture.golden_ratio_140_approx` | `core (file by file)` | open | `sorryAx` |
| `TempleArchitecture.golden_ratio_141_approx` | `core (file by file)` | open | `sorryAx` |
| `TempleArchitecture.golden_ratio_142_approx` | `core (file by file)` | open | `sorryAx` |
| `TempleArchitecture.golden_ratio_143_approx` | `core (file by file)` | open | `sorryAx` |
| `TempleArchitecture.golden_ratio_144_approx` | `core (file by file)` | open | `sorryAx` |
| `TempleArchitecture.golden_ratio_145_approx` | `core (file by file)` | open | `sorryAx` |
| … 54 more in `VERIFICACAO.json` and `TEOREMAS.csv` | | | |

### Declared theorems

The `.lean` files of the verified commit declare 18 567 `theorem`/`lemma` (counting copies). The kernel checked 5 396 of them (5 192 closed, 1 conditional, 203 open). The closed count in the table above is larger: it also counts the theorems Lean generates by itself (equation lemmas, structure fields, `deriving`), which are not written in the text. For 13 171 the kernel has no result:

| Reason | Theorems |
|---|---:|
| checked file by file: the written proof does not pass the kernel | 13 171 |

### MVEI corrections

* `correcoes/imports-no-topo.patch` (import fora do início do arquivo, 8 file(s)): applies to the published sources: `git apply -p1 --directory=imports/mishkan-iii-core mvei/mishkan-iii-core/correcoes/imports-no-topo.patch` (in order, after the ones above)
* `correcoes/renomear-imports-mathlib.patch` (import de módulo que não existe na versão do Mathlib do projeto (renomeado ou dividido), 2 file(s)): applies to the published sources: `git apply -p1 --directory=imports/mishkan-iii-core mvei/mishkan-iii-core/correcoes/renomear-imports-mathlib.patch` (in order, after the ones above)
* `correcoes/tatica-encontrada.patch` (prova que não passava (ou axioma) que uma tática padrão fecha no kernel, 4 file(s)): applies to the published sources: `git apply -p1 --directory=imports/mishkan-iii-core mvei/mishkan-iii-core/correcoes/tatica-encontrada.patch` (in order, after the ones above)
* `correcoes/vinculo-estrutura.patch` (arquivos gerados usam ~4 100 nomes que não existem no repositório, 5 file(s)): applies to the published sources: `git apply -p1 --directory=imports/mishkan-iii-core mvei/mishkan-iii-core/correcoes/vinculo-estrutura.patch` (in order, after the ones above)

## Files in this folder

* `VERIFICACAO.json` — each Lean project of this repository, each theorem the kernel read, its statement, its axioms and its state (`fechado` closed, `condicional` conditional, `aberto-sorry` open)
* `TEOREMAS.csv` — each declared `theorem`/`lemma`: file, line, state in the kernel (`nao_checado` = not checked) and, if not checked, why (in Portuguese)
* `BUILD_LOG.txt` — one block per project: Lean version, result, errors
* `SOURCE.json` — source commit, verified commit and dates, machine-readable
* `SOURCES.sha256` — SHA-256 of every published file

## Reproduce

```
cd imports/mishkan-iii-core/<project>   # a project folder from the table above ('.' is imports/mishkan-iii-core)
lake exe cache get           # only for projects that require Mathlib
lake build
```

Each project uses the Lean version in its own `lean-toolchain`, which elan installs. The MVEI pipeline that produced these results is in the author's repository and is not public.
