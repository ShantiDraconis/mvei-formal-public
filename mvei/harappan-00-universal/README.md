# MVEI kernel check — harappan-00-universal

This folder records what the Lean 4 kernel said about the Lean sources of the private repository `ShantiDraconis/harappan-00-universal`. The sources are published in [`imports/harappan-00-universal/`](../../imports/harappan-00-universal/).

## What is published

* Source: `ShantiDraconis/harappan-00-universal`, commit `1f57a02dcde2bad96265461e03daa0ab4c9ab798` (2026-09-18T09:52:44Z).
* 100 files: 97 `.lean` files and the Lake files (`lakefile.*`, `lean-toolchain`, `lake-manifest.json`), plus 1 license or origin file(s) that third-party code requires (`LICENSE`). Paths are the same as in the source repository.
* Nothing else from the private repository is published (documents, commercial license, prompts, storefront material).
* `SOURCES.sha256` lists every published file with its SHA-256. From the repository root: `sha256sum -c mvei/harappan-00-universal/SOURCES.sha256`.

## What the kernel said

MVEI verification of 2026-10-29T01:06:09+00:00, on commit `1f57a02dcde2bad96265461e03daa0ab4c9ab798`. Each theorem was read with `Lean.collectAxioms`, the function behind `#print axioms`.

| Lean project | Lean version | Build | Closed | Conditional | Open (`sorry`) | Checked file by file: closed / conditional / open / proof error / not reached |
|---|---|---|---:|---:|---:|---|
| `INDUS-KERNEL-CORE/formal/lean` (no lakefile; project assembled by MVEI) | padrão do elan | OK | 55 | 0 | 0 | — |
| `Provas` | v4.3.0 | failed | 0 | 0 | 0 | 8 / 0 / 0 / 3 / 0 |
| `docs/9_IMPLEMENTATION/lean` (no lakefile; project assembled by MVEI) | padrão do elan | OK | 116 | 1 | 0 | — |
| `formal/lean` | v4.3.0 | partial | 246 | 3 | 0 | 75 / 11 / 22 / 197 / 1 |
| `src/lean` (no lakefile; project assembled by MVEI) | padrão do elan | partial | 31 | 0 | 0 | 15 / 7 / 0 / 19 / 7 |

| Closed theorems in this repository | |
|---|---:|
| Counting each project | 546 |
| Unique (name + statement) | 447 |
| Unique, without the lemmas Lean generates itself (`eq_1`, `mk.inj`, `sizeOf_spec`, `deriving`) | 184 |

*Closed* means the kernel accepted the proof and it depends only on `propext`, `Classical.choice` and `Quot.sound`. It says that the statement as written in the file is proved; it does not say that an open problem is solved. Every statement is in `VERIFICACAO.json`. *Conditional* means the proof also uses axioms declared in the repository; *open* means it uses `sorry`. *Checked file by file* covers the files that no build reached: each one went through Lean whole, with a `#print axioms` for each theorem.

| Theorem | Project | State | Axioms beyond the standard three |
|---|---|---|---|
| `domain_collapse_consistency` | `docs/9_IMPLEMENTATION/lean` | conditional | `domain_collapse_consistency_axiom` |
| `authorized_requires_quantity_orig` | `formal/lean` | conditional | `commits_are_well_formed` |
| `domain_collapse_consistency` | `formal/lean` | conditional | `domain_collapse_consistency_axiom` |
| `final_implies_validated_orig` | `formal/lean` | conditional | `commits_are_well_formed` |
| `Harappan.Block328_372.global_law_block_328_372` | `formal/lean (file by file)` | open | `sorryAx` |
| `valid_inscription_nonempty` | `formal/lean (file by file)` | conditional | `rtl_direction` |
| `example_validates` | `formal/lean (file by file)` | open | `sorryAx` |
| `harappan_scope_bounded` | `formal/lean (file by file)` | open | `sorryAx` |
| `every_symbol_has_composition` | `formal/lean (file by file)` | open | `sorryAx` |
| `directional_stability_excludes_phonetic` | `formal/lean (file by file)` | open | `Glyph`, `sorryAx` |
| `geometric_symmetry_implies_topological` | `formal/lean (file by file)` | conditional | `Glyph` |
| `commit_position_independence_operational` | `formal/lean (file by file)` | conditional | `Glyph` |
| `indus_glyphs_runic_like` | `formal/lean (file by file)` | conditional | `Glyph` |
| `semantic_invariance_topological` | `formal/lean (file by file)` | conditional | `Glyph` |
| `state_transition_bidirection_invariant` | `formal/lean (file by file)` | conditional | `Glyph` |
| `valid_sentence_has_structure` | `formal/lean (file by file)` | open | `sorryAx` |
| `hscs_is_formal_certification_system` | `formal/lean (file by file)` | open | `sorryAx`, `state_certification`, `verbal_absence_temporal` |
| `helloworld_complete` | `formal/lean (file by file)` | open | `sorryAx` |
| `helloworld_one_record` | `formal/lean (file by file)` | open | `sorryAx` |
| `helloworld_entity` | `formal/lean (file by file)` | open | `sorryAx` |
| `helloworld_object` | `formal/lean (file by file)` | open | `sorryAx` |
| `helloworld_state` | `formal/lean (file by file)` | open | `sorryAx` |
| `helloworld_ledger_growth` | `formal/lean (file by file)` | open | `sorryAx` |
| `parse_deterministic` | `formal/lean (file by file)` | open | `sorryAx` |
| `execute_empty_is_hello` | `formal/lean (file by file)` | open | `sorryAx` |
| `helloworld_grain_object` | `formal/lean (file by file)` | open | `sorryAx` |
| `parse_empty` | `formal/lean (file by file)` | open | `sorryAx` |
| `parse_entity_only` | `formal/lean (file by file)` | open | `sorryAx` |
| `incomplete_no_record` | `formal/lean (file by file)` | open | `sorryAx` |
| `execution_monotonic` | `formal/lean (file by file)` | open | `sorryAx` |
| `collapse_determines_orientation` | `formal/lean (file by file)` | open | `sorryAx` |
| `selfExecution` | `formal/lean (file by file)` | conditional | `Entity`, `Object`, `Symbol`, `parse` |
| `stateTransitionDeterministic` | `formal/lean (file by file)` | conditional | `Entity`, `Object`, `Symbol`, `parse` |
| `commitImpliesValid` | `formal/lean (file by file)` | conditional | `Entity`, `Object` |
| `closureValidates` | `formal/lean (file by file)` | conditional | `Entity`, `Object` |
| `ledgerGrows` | `formal/lean (file by file)` | conditional | `Entity`, `Object`, `Symbol`, `parse` |
| `indusScriptIsStateCertificationSystem` | `formal/lean (file by file)` | open | `sorryAx` |
| `Harappan.Collapse.total_energy_bounded` | `src/lean (file by file)` | conditional | `Harappan.Collapse.class_zero_max_potential` |
| `Harappan.GlobalPhonology.cognate_equiv_refl` | `src/lean (file by file)` | conditional | `Harappan.GlobalPhonology.cognate_distance`, `Harappan.GlobalPhonology.cognate_distance_refl` |
| `Harappan.GlobalPhonology.cognate_equiv_symm` | `src/lean (file by file)` | conditional | `Harappan.GlobalPhonology.cognate_distance`, `Harappan.GlobalPhonology.cognate_distance_symm` |
| `Harappan.Phonology.Harappan.Phonology.equiv_refl` | `src/lean (file by file)` | conditional | `Harappan.Phonology.distance_identity`, `Harappan.Phonology.phoneme_distance` |
| `Harappan.Phonology.Harappan.Phonology.equiv_symm` | `src/lean (file by file)` | conditional | `Harappan.Phonology.distance_symmetric`, `Harappan.Phonology.phoneme_distance` |
| `Harappan.Phonology.Harappan.Phonology.universal_phoneme_class` | `src/lean (file by file)` | conditional | `Harappan.Phonology.phoneme_distance` |
| `Harappan.SemanticAxioms.universal_meaning_axiom` | `src/lean (file by file)` | conditional | `Harappan.SemanticAxioms.concept_valid_archetype` |

### Declared theorems

The `.lean` files of the verified commit declare 442 `theorem`/`lemma` (counting copies). The kernel checked 215 of them (171 closed, 22 conditional, 22 open). The closed count in the table above is larger: it also counts the theorems Lean generates by itself (equation lemmas, structure fields, `deriving`), which are not written in the text. For 227 the kernel has no result:

| Reason | Theorems |
|---|---:|
| checked file by file: the written proof does not pass the kernel | 219 |
| checked file by file: Lean did not reach the theorem (missing import, syntax error or timeout) | 8 |

### MVEI corrections

* `correcoes/imports-no-topo.patch` (import fora do início do arquivo, 3 file(s)): applies to the published sources: `git apply -p1 --directory=imports/harappan-00-universal mvei/harappan-00-universal/correcoes/imports-no-topo.patch` (in order, after the ones above)

## Files in this folder

* `VERIFICACAO.json` — each Lean project of this repository, each theorem the kernel read, its statement, its axioms and its state (`fechado` closed, `condicional` conditional, `aberto-sorry` open)
* `TEOREMAS.csv` — each declared `theorem`/`lemma`: file, line, state in the kernel (`nao_checado` = not checked) and, if not checked, why (in Portuguese)
* `BUILD_LOG.txt` — one block per project: Lean version, result, errors
* `SOURCE.json` — source commit, verified commit and dates, machine-readable
* `SOURCES.sha256` — SHA-256 of every published file

## Reproduce

```
cd imports/harappan-00-universal/<project>   # a project folder from the table above ('.' is imports/harappan-00-universal)
lake exe cache get           # only for projects that require Mathlib
lake build
```

Each project uses the Lean version in its own `lean-toolchain`, which elan installs. The MVEI pipeline that produced these results is in the author's repository and is not public.
