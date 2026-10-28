# MVEI — formal sources of ShantiDraconis

Lean sources of the private repositories of Tiago Paschoalatto Fagliari (ORCID [0009-0006-6874-3910](https://orcid.org/0009-0006-6874-3910)), published with what the Lean 4 kernel said about each theorem. The M-Core family (M-Core, P vs NP, Hodge, Riemann, BSD, Beal, Yang–Mills, Navier–Stokes) is in the atk-*-public repositories and Elyon in Elyon-Public-Proof; everything else that the kernel closed at least one theorem in is here.

## What is here

* `imports/<repo>/` — the `.lean` files, the Lake files (`lakefile.*`, `lean-toolchain`, `lake-manifest.json`) and any license that third-party code requires, at the same paths as in the source repository. Nothing else from the private repositories is published (documents, prompts, commercial material).
* `mvei/<repo>/` — the kernel result for that repository: `README.md` (summary, how to reproduce), `VERIFICACAO.json` (each theorem, its statement and its axioms), `TEOREMAS.csv` (each declared `theorem`/`lemma` with file, line and state), `BUILD_LOG.txt`, `SOURCE.json` (source commit and date) and `SOURCES.sha256` (check with `sha256sum -c mvei/<repo>/SOURCES.sha256` from this folder).

*Closed* means the kernel accepted the proof and it depends only on `propext`, `Classical.choice` and `Quot.sound`: the statement written in the file is proved. It is not a claim that an open problem is solved, and many closed statements are about objects defined in the same file. *Conditional* means the proof uses axioms declared in the repository; *open* means it uses `sorry`.

MVEI verification of 2026-10-28T16:41:02+00:00. Totals over the 48 repositories: 2 541 files (2 450 `.lean`), 7 107 closed theorems counting each project, 59 conditional, 249 open; 26 848 declared `theorem`/`lemma`, 23 983 of them without a kernel result (the reason for each is in `TEOREMAS.csv`).

| Repository | Source commit | Files | Closed | Closed, unique without auto-generated lemmas | Conditional | Open | Declared without a result |
|---|---|---:|---:|---:|---:|---:|---:|
| [`atk-certified-priority-record`](mvei/atk-certified-priority-record/README.md) | `c7f7df5` (2026-10-12) | 804 | 4 367 | 1 839 | 0 | 2 | 1 303 |
| [`axiomatic-millenium`](mvei/axiomatic-millenium/README.md) | `609d100` (2026-10-11) | 58 | 731 | 249 | 0 | 0 | 0 |
| [`harappan-00-universal`](mvei/harappan-00-universal/README.md) | `1f57a02` (2026-09-18) | 100 | 462 | 100 | 11 | 0 | 344 |
| [`Millennium`](mvei/Millennium/README.md) | `5c5ec3d` (2026-10-21) | 285 | 338 | 95 | 26 | 97 | 523 |
| [`federated-trivalent-manifold`](mvei/federated-trivalent-manifold/README.md) | `95e7a6a` (2026-08-26) | 31 | 177 | 35 | 6 | 0 | 40 |
| [`riemann-offcritical-zero-certifier`](mvei/riemann-offcritical-zero-certifier/README.md) | `94ae8e7` (2026-09-27) | 18 | 118 | 63 | 0 | 0 | 0 |
| [`open-math-scoped-final`](mvei/open-math-scoped-final/README.md) | `e0f15e7` (2026-09-25) | 39 | 110 | 67 | 0 | 0 | 3 |
| [`meta-mathematics-indeterminate-I`](mvei/meta-mathematics-indeterminate-I/README.md) | `919fc81` (2026-09-18) | 14 | 108 | 53 | 0 | 0 | 0 |
| [`0-0-FORMAL-SUITE`](mvei/0-0-FORMAL-SUITE/README.md) | `fcc67dd` (2026-10-05) | 19 | 92 | 60 | 0 | 2 | 44 |
| [`millennium-hodge-classical`](mvei/millennium-hodge-classical/README.md) | `63d59b2` (2026-09-18) | 31 | 91 | 75 | 0 | 3 | 62 |
| [`Millenium--core`](mvei/Millenium--core/README.md) | `dc52454` (2026-09-18) | 53 | 60 | 17 | 0 | 0 | 162 |
| [`mishkan-iii-core`](mvei/mishkan-iii-core/README.md) | `2e43209` (2026-09-18) | 15 | 60 | 48 | 1 | 8 | 18 510 |
| [`stationary-photon-moving-geometry`](mvei/stationary-photon-moving-geometry/README.md) | `bfd0557` (2026-09-27) | 10 | 52 | 22 | 0 | 0 | 0 |
| [`millennium-hodge`](mvei/millennium-hodge/README.md) | `3110624` (2026-10-08) | 8 | 38 | 26 | 0 | 2 | 2 |
| [`cryptographic-logic-foundations`](mvei/cryptographic-logic-foundations/README.md) | `6a4ece5` (2026-01-16) | 30 | 30 | 12 | 0 | 6 | 33 |
| [`lc-rh-coercivity`](mvei/lc-rh-coercivity/README.md) | `5283a63` (2026-09-18) | 22 | 30 | 0 | 0 | 0 | 0 |
| [`universal`](mvei/universal/README.md) | `459428b` (2025-12-20) | 157 | 27 | 27 | 0 | 31 | 313 |
| [`hawking-singularities-millennium-problems`](mvei/hawking-singularities-millennium-problems/README.md) | `405bd93` (2025-12-02) | 22 | 25 | 10 | 0 | 5 | 20 |
| [`orion`](mvei/orion/README.md) | `6849ba6` (2026-09-12) | 2 | 22 | 15 | 0 | 0 | 1 |
| [`lean-audit-kit`](mvei/lean-audit-kit/README.md) | `853c031` (2026-10-05) | 13 | 17 | 8 | 1 | 2 | 0 |
| [`millennium-birch-swinnerton-dyer-classical`](mvei/millennium-birch-swinnerton-dyer-classical/README.md) | `44edb40` (2026-09-18) | 52 | 17 | 3 | 0 | 9 | 215 |
| [`ussf-millennium-locks`](mvei/ussf-millennium-locks/README.md) | `ee95274` (2026-07-08) | 3 | 16 | 4 | 0 | 0 | 1 |
| [`universal-emergent-logic-`](mvei/universal-emergent-logic-/README.md) | `041a209` (2026-09-20) | 260 | 14 | 5 | 0 | 17 | 1 350 |
| [`LA-2008-R-`](mvei/LA-2008-R-/README.md) | `51e350a` (2026-04-15) | 9 | 12 | 4 | 0 | 0 | 14 |
| [`Universe-0-0`](mvei/Universe-0-0/README.md) | `ad86336` (2026-09-18) | 57 | 12 | 12 | 6 | 30 | 348 |
| [`millennium-p-vs-np-classical`](mvei/millennium-p-vs-np-classical/README.md) | `1990622` (2026-09-18) | 30 | 10 | 8 | 0 | 0 | 158 |
| [`universal-proof-hub`](mvei/universal-proof-hub/README.md) | `83759bc` (2026-10-05) | 2 | 10 | 10 | 0 | 0 | 2 |
| [`00-limit-foundation`](mvei/00-limit-foundation/README.md) | `05a6ad4` (2026-09-30) | 1 | 9 | 9 | 0 | 0 | 0 |
| [`Heu-7-universal-framework`](mvei/Heu-7-universal-framework/README.md) | `63b80b7` (2025-12-02) | 42 | 7 | 1 | 4 | 0 | 78 |
| [`digital-fire-la28`](mvei/digital-fire-la28/README.md) | `04b0f2f` (2026-08-02) | 7 | 6 | 2 | 0 | 0 | 6 |
| [`UMA`](mvei/UMA/README.md) | `62b22ff` (2026-01-16) | 9 | 5 | 2 | 0 | 2 | 62 |
| [`m-core-openai-ns-audit`](mvei/m-core-openai-ns-audit/README.md) | `9e84543` (2026-10-11) | 4 | 4 | 4 | 0 | 0 | 0 |
| [`sfh-formalization-lab`](mvei/sfh-formalization-lab/README.md) | `b770052` (2026-09-18) | 22 | 4 | 1 | 0 | 15 | 58 |
| [`Trans`](mvei/Trans/README.md) | `74cb8d6` (2025-11-23) | 123 | 4 | 1 | 0 | 0 | 0 |
| [`Genesis_Elyon`](mvei/Genesis_Elyon/README.md) | `5f63f2d` (2026-09-22) | 1 | 3 | 3 | 0 | 0 | 13 |
| [`Meta-millenium-independence-00`](mvei/Meta-millenium-independence-00/README.md) | `54627a7` (2026-09-12) | 53 | 3 | 0 | 0 | 0 | 26 |
| [`millennium-navier-stokes-I`](mvei/millennium-navier-stokes-I/README.md) | `c5d4b8d` (2026-10-08) | 7 | 3 | 3 | 0 | 1 | 13 |
| [`i-theology-unified`](mvei/i-theology-unified/README.md) | `fbe8de9` (2026-10-13) | 2 | 2 | 2 | 0 | 0 | 5 |
| [`millennium-riemann-I`](mvei/millennium-riemann-I/README.md) | `ae79aed` (2026-10-08) | 68 | 2 | 2 | 0 | 6 | 227 |
| [`-millennium-bsd-hodge-yangmills-I`](mvei/-millennium-bsd-hodge-yangmills-I/README.md) | `1659b5e` (2026-09-27) | 2 | 1 | 1 | 0 | 0 | 2 |
| [`i-constant-core`](mvei/i-constant-core/README.md) | `06a1646` (2026-09-27) | 3 | 1 | 1 | 0 | 0 | 17 |
| [`indeterminate-collapse-core`](mvei/indeterminate-collapse-core/README.md) | `c2faccb` (2026-02-05) | 2 | 1 | 1 | 1 | 1 | 3 |
| [`lean-winwin-logic`](mvei/lean-winwin-logic/README.md) | `41af157` (2026-09-29) | 3 | 1 | 1 | 0 | 0 | 1 |
| [`Meta-mathematical-foundation-00`](mvei/Meta-mathematical-foundation-00/README.md) | `5138291` (2026-08-29) | 31 | 1 | 1 | 3 | 7 | 16 |
| [`millennium-bsd`](mvei/millennium-bsd/README.md) | `9b4e692` (2026-10-08) | 3 | 1 | 1 | 0 | 1 | 2 |
| [`millennium-p-vs-np-I`](mvei/millennium-p-vs-np-I/README.md) | `870ab93` (2026-10-08) | 10 | 1 | 1 | 0 | 1 | 2 |
| [`millennium-symbolic-program`](mvei/millennium-symbolic-program/README.md) | `86570cf` (2026-09-27) | 2 | 1 | 1 | 0 | 0 | 2 |
| [`millennium-yang-mills`](mvei/millennium-yang-mills/README.md) | `0ab4288` (2026-10-08) | 2 | 1 | 1 | 0 | 1 | 2 |

The MVEI pipeline that produced these results is in the author's repository and is not public; each `mvei/<repo>/README.md` says how to rebuild a project with `lake build`.
