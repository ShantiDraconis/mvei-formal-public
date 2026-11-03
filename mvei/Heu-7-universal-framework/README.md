# MVEI kernel check — Heu-7-universal-framework

This folder records what the Lean 4 kernel said about the Lean sources of the private repository `ShantiDraconis/Heu-7-universal-framework`. The sources are published in [`imports/Heu-7-universal-framework/`](../../imports/Heu-7-universal-framework/).

## What is published

* Source: `ShantiDraconis/Heu-7-universal-framework`, commit `63b80b7623e831645f843e1f04385a1cfe17717a` (2025-12-02T13:31:55Z).
* 42 files: 41 `.lean` files and the Lake files (`lakefile.*`, `lean-toolchain`, `lake-manifest.json`), plus 1 license or origin file(s) that third-party code requires (`LICENSE`). Paths are the same as in the source repository.
* Nothing else from the private repository is published (documents, commercial license, prompts, storefront material).
* `SOURCES.sha256` lists every published file with its SHA-256. From the repository root: `sha256sum -c mvei/Heu-7-universal-framework/SOURCES.sha256`.

## What the kernel said

MVEI verification of 2026-11-03T08:19:01+00:00, on commit `63b80b7623e831645f843e1f04385a1cfe17717a`. Each theorem was read with `Lean.collectAxioms`, the function behind `#print axioms`.

| Lean project | Lean version | Build | Closed | Conditional | Open (`sorry`) | Checked file by file: closed / conditional / open / proof error / not reached |
|---|---|---|---:|---:|---:|---|
| `src/lean` | v4.19.0 | partial | 6 | 0 | 0 | 9 / 5 / 65 / 0 / 4 |

| Closed theorems in this repository | |
|---|---:|
| Counting each project | 15 |
| Unique (name + statement) | 15 |
| Unique, without the lemmas Lean generates itself (`eq_1`, `mk.inj`, `sizeOf_spec`, `deriving`) | 9 |

*Closed* means the kernel accepted the proof and it depends only on `propext`, `Classical.choice` and `Quot.sound`. It says that the statement as written in the file is proved; it does not say that an open problem is solved. Every statement is in `VERIFICACAO.json`. *Conditional* means the proof also uses axioms declared in the repository; *open* means it uses `sorry`. *Checked file by file* covers the files that no build reached: each one went through Lean whole, with a `#print axioms` for each theorem.

| Theorem | Project | State | Axioms beyond the standard three |
|---|---|---|---|
| `HEU.Core.Functional.criticality_dichotomy` | `src/lean (file by file)` | open | `sorryAx` |
| `HEU.Core.LTC.completeness` | `src/lean (file by file)` | open | `sorryAx` |
| `HEU.Core.LTC.soundness` | `src/lean (file by file)` | open | `sorryAx` |
| `HEU.Core.ZF.dne` | `src/lean (file by file)` | conditional | `HEU.Core.ZF.em` |
| `HEU.Core.ZF.byContradiction` | `src/lean (file by file)` | conditional | `HEU.Core.ZF.em` |
| `HEU.Core.ZF.deMorgan1` | `src/lean (file by file)` | conditional | `HEU.Core.ZF.em` |
| `HEU.Core.ZF.classicalImpl` | `src/lean (file by file)` | conditional | `HEU.Core.ZF.em` |
| `HEU.Core.ZF.peirce` | `src/lean (file by file)` | conditional | `HEU.Core.ZF.em` |
| `HEU.Cross.ubo_validity_uniform` | `src/lean (file by file)` | open | `sorryAx` |
| `HEU.Problems.BSD.BSD_equiv` | `src/lean (file by file)` | open | `sorryAx` |
| `HEU.Problems.Hodge.Hodge_equiv` | `src/lean (file by file)` | open | `sorryAx` |
| `HEU.Problems.NS.smooth_is_critical` | `src/lean (file by file)` | open | `sorryAx` |
| `HEU.Problems.NS.blowup_is_subcritical` | `src/lean (file by file)` | open | `sorryAx` |
| `HEU.Problems.NS.NS_equiv` | `src/lean (file by file)` | open | `sorryAx` |
| `HEU.Problems.NS.NS_LTC_equiv` | `src/lean (file by file)` | open | `sorryAx` |
| `HEU.Problems.NS.UBO_valid_implies_NS` | `src/lean (file by file)` | open | `sorryAx` |
| `HEU.Problems.NS.NS_implies_UBO_valid` | `src/lean (file by file)` | open | `sorryAx` |
| `HEU.Problems.NS.NS_UBO_biequiv_proof` | `src/lean (file by file)` | open | `sorryAx` |
| `HEU.Problems.NS.F_NS_smooth_higher` | `src/lean (file by file)` | open | `sorryAx` |
| `HEU.Problems.NS.F_NS_bounded` | `src/lean (file by file)` | open | `sorryAx` |
| `HEU.Problems.NS.enstrophy_bounds_regularity` | `src/lean (file by file)` | open | `sorryAx` |
| `HEU.Problems.NS.F_NS_preserves_order` | `src/lean (file by file)` | open | `sorryAx` |
| `HEU.Problems.NS.O_NS_reflects_smooth` | `src/lean (file by file)` | open | `sorryAx` |
| `HEU.Problems.NS.divergenceFree_helps` | `src/lean (file by file)` | open | `sorryAx` |
| `HEU.Problems.NS.high_reynolds_difficulty` | `src/lean (file by file)` | open | `sorryAx` |
| `HEU.Problems.NS.NS_equilibrium_iff_NS` | `src/lean (file by file)` | open | `sorryAx` |
| `HEU.Problems.NS.O_NS_zero_for_smooth` | `src/lean (file by file)` | open | `sorryAx` |
| `HEU.Problems.NS.O_NS_negative_for_blowup` | `src/lean (file by file)` | open | `sorryAx` |
| `HEU.Problems.PvsNP.poly_is_critical` | `src/lean (file by file)` | open | `sorryAx` |
| `HEU.Problems.PvsNP.NPComplete_determines_critical` | `src/lean (file by file)` | open | `sorryAx` |
| `HEU.Problems.PvsNP.PNP_equiv` | `src/lean (file by file)` | open | `sorryAx` |
| `HEU.Problems.PvsNP.PNP_LTC_equiv` | `src/lean (file by file)` | open | `sorryAx` |
| `HEU.Problems.PvsNP.SAT_equiv` | `src/lean (file by file)` | open | `sorryAx` |
| `HEU.Problems.PvsNP.UBO_valid_implies_P_eq_NP` | `src/lean (file by file)` | open | `sorryAx` |
| `HEU.Problems.PvsNP.P_eq_NP_implies_UBO_valid` | `src/lean (file by file)` | open | `sorryAx` |
| `HEU.Problems.PvsNP.PNP_UBO_biequiv_proof` | `src/lean (file by file)` | open | `sorryAx` |
| `HEU.Problems.PvsNP.F_PNP_monotone` | `src/lean (file by file)` | open | `sorryAx` |
| `HEU.Problems.PvsNP.F_PNP_max_poly` | `src/lean (file by file)` | open | `sorryAx` |
| `HEU.Problems.PvsNP.F_PNP_bounded` | `src/lean (file by file)` | open | `sorryAx` |
| `HEU.Problems.PvsNP.F_PNP_reflects_gap` | `src/lean (file by file)` | open | `sorryAx` |
| `HEU.Problems.PvsNP.NPComplete_reduction` | `src/lean (file by file)` | open | `sorryAx` |
| `HEU.Problems.PvsNP.F_PNP_preserves_order` | `src/lean (file by file)` | open | `sorryAx` |
| `HEU.Problems.PvsNP.O_PNP_reflects_P` | `src/lean (file by file)` | open | `sorryAx` |
| `HEU.Problems.PvsNP.SAT_hardest` | `src/lean (file by file)` | open | `sorryAx` |
| `HEU.Problems.PvsNP.one_NPComplete_in_P` | `src/lean (file by file)` | open | `sorryAx` |
| `HEU.Problems.PvsNP.PNP_equilibrium_iff_P_eq_NP` | `src/lean (file by file)` | open | `sorryAx` |
| `HEU.Problems.PvsNP.O_PNP_zero_for_P` | `src/lean (file by file)` | open | `sorryAx` |
| `HEU.Problems.PvsNP.O_PNP_negative_for_exp` | `src/lean (file by file)` | open | `sorryAx` |
| `HEU.Problems.PvsNP.O_PNP_NP_complete` | `src/lean (file by file)` | open | `sorryAx` |
| `HEU.Problems.RH.RH_implies_full_density` | `src/lean (file by file)` | open | `sorryAx` |
| `HEU.Problems.RH.RH_equiv` | `src/lean (file by file)` | open | `sorryAx` |
| `HEU.Problems.RH.RH_LTC_equiv` | `src/lean (file by file)` | open | `sorryAx` |
| `HEU.Problems.RH.UBO_valid_implies_RH` | `src/lean (file by file)` | open | `sorryAx` |
| `HEU.Problems.RH.RH_implies_UBO_valid` | `src/lean (file by file)` | open | `sorryAx` |
| `HEU.Problems.RH.RH_UBO_biequiv_proof` | `src/lean (file by file)` | open | `sorryAx` |
| `HEU.Problems.RH.F_RH_monotone` | `src/lean (file by file)` | open | `sorryAx` |
| `HEU.Problems.RH.F_RH_max_on_critical` | `src/lean (file by file)` | open | `sorryAx` |
| `HEU.Problems.RH.F_RH_bounded` | `src/lean (file by file)` | open | `sorryAx` |
| `HEU.Problems.RH.criticalLine_unique` | `src/lean (file by file)` | open | `sorryAx` |
| `HEU.Problems.RH.zeroApprox_bounded` | `src/lean (file by file)` | open | `sorryAx` |
| `HEU.Problems.RH.F_RH_continuous` | `src/lean (file by file)` | open | `sorryAx` |
| `HEU.Problems.RH.O_RH_preserves_order` | `src/lean (file by file)` | open | `sorryAx` |
| `HEU.Problems.RH.ordinal_increases_with_precision` | `src/lean (file by file)` | open | `sorryAx` |
| `HEU.Problems.RH.UBO_nonneg_under_RH` | `src/lean (file by file)` | open | `sorryAx` |
| `HEU.Problems.RH.RH_contrapositive` | `src/lean (file by file)` | open | `sorryAx` |
| `HEU.Problems.RH.RH_equilibrium_iff_RH` | `src/lean (file by file)` | open | `sorryAx` |
| `HEU.Problems.RH.O_RH_zero_on_critical` | `src/lean (file by file)` | open | `sorryAx` |
| `HEU.Problems.RH.O_RH_negative_off_critical` | `src/lean (file by file)` | open | `sorryAx` |
| `HEU.Problems.RH.O_RH_monotone` | `src/lean (file by file)` | open | `sorryAx` |
| `HEU.Problems.YM.YM_equiv` | `src/lean (file by file)` | open | `sorryAx` |

### Declared theorems

The `.lean` files of the verified commit declare 83 `theorem`/`lemma` (counting copies). The kernel checked 79 of them (9 closed, 5 conditional, 65 open). The closed count in the table above is larger: it also counts the theorems Lean generates by itself (equation lemmas, structure fields, `deriving`), which are not written in the text. For 4 the kernel has no result:

| Reason | Theorems |
|---|---:|
| checked file by file: Lean did not reach the theorem (missing import, syntax error or timeout) | 4 |

### MVEI corrections

* `correcoes/vocabulario-lean4.patch` (grafia que o Lean 4 não lê (nome acentuado, λ/Σ/Π como nome, ∀ x y ∈ s, docstring solta, constant, tática do Mathlib sem import), 31 file(s)): applies to the published sources: `git apply -p1 --directory=imports/Heu-7-universal-framework mvei/Heu-7-universal-framework/correcoes/vocabulario-lean4.patch` (in order, after the ones above)

## Files in this folder

* `VERIFICACAO.json` — each Lean project of this repository, each theorem the kernel read, its statement, its axioms and its state (`fechado` closed, `condicional` conditional, `aberto-sorry` open)
* `TEOREMAS.csv` — each declared `theorem`/`lemma`: file, line, state in the kernel (`nao_checado` = not checked) and, if not checked, why (in Portuguese)
* `BUILD_LOG.txt` — one block per project: Lean version, result, errors
* `SOURCE.json` — source commit, verified commit and dates, machine-readable
* `SOURCES.sha256` — SHA-256 of every published file

## Reproduce

```
cd imports/Heu-7-universal-framework/<project>   # a project folder from the table above ('.' is imports/Heu-7-universal-framework)
lake exe cache get           # only for projects that require Mathlib
lake build
```

Each project uses the Lean version in its own `lean-toolchain`, which elan installs. The MVEI pipeline that produced these results is in the author's repository and is not public.
