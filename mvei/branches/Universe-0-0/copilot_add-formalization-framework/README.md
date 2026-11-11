# Universe-0-0 — branch `copilot/add-formalization-framework`

Lean sources from the branch `copilot/add-formalization-framework` of the private repository `ShantiDraconis/Universe-0-0`, commit `404da1cfdfc061c0d2e589ba8fbac2efa1466847` (2025-12-31T02:07:55+00:00), that hold theorems found only on branches (no default branch of any repository has a theorem with the same name). Published here: the files with the theorems the kernel closed, the local files they import and the Lake files of their project.

* Branch state: parada (not in the default branch).
* Theorems only on branches, in this branch: 15 — closed 6, conditional 1, open 1, proof error 0, not reached 7, no result 0.
* History: 5 commit(s) of this branch that are not in the default branch, with date and subject, in `certificate.json`.
* `certificate.json` (SHA-256 of its content: `278a37d1cc9fb5caf608f2e0831251af4f66f07491204ce280ab2a7f5e953ac0`) lists every theorem with its state and the axioms beyond the standard three, and the SHA-256 of every published file. From the repository root: `sha256sum -c mvei/branches/Universe-0-0/copilot_add-formalization-framework/SOURCES.sha256`.

Closed means the kernel accepted the proof and it depends only on `propext`, `Classical.choice` and `Quot.sound`; it proves the statement written in the file and is not a claim that an open problem is solved.

| Theorem | File | State |
|---|---|---|
| `Universe00.Examples.div_complement_classical` | `universe-00/complement/lean/Universe00/Examples/Division.lean`:65 | nao_alcancado |
| `Universe00.Examples.div_complement_limit` | `universe-00/complement/lean/Universe00/Examples/Division.lean`:77 | fechado |
| `Universe00.Examples.halts_decidable_returns_value` | `universe-00/complement/lean/Universe00/Examples/Halting.lean`:113 | nao_alcancado |
| `Universe00.Examples.halts_total` | `universe-00/complement/lean/Universe00/Examples/Halting.lean`:104 | aberto-sorry |
| `Universe00.Examples.halts_undecidable_returns_limit` | `universe-00/complement/lean/Universe00/Examples/Halting.lean`:125 | nao_alcancado |
| `Universe00.Laws.classical_addition_preserves` | `universe-00/complement/lean/Universe00/Laws/Conservativity.lean`:60 | fechado |
| `Universe00.Laws.classical_equality_preserves` | `universe-00/complement/lean/Universe00/Laws/Conservativity.lean`:69 | fechado |
| `Universe00.Laws.classical_lifts` | `universe-00/complement/lean/Universe00/Laws/Conservativity.lean`:41 | condicional |
| `Universe00.Laws.classical_undefined_returns_limit` | `universe-00/complement/lean/Universe00/Laws/Preservation.lean`:50 | nao_alcancado |
| `Universe00.Laws.lift_preserves` | `universe-00/complement/lean/Universe00/Laws/Conservativity.lean`:55 | fechado |
| `Universe00.Laws.limit_preserves_consistency` | `universe-00/complement/lean/Universe00/Laws/NonExplosion.lean`:48 | fechado |
| `Universe00.Laws.limits_coexist` | `universe-00/complement/lean/Universe00/Laws/NonExplosion.lean`:58 | nao_alcancado |
| `Universe00.Laws.system_not_trivial_at_limit` | `universe-00/complement/lean/Universe00/Laws/NonExplosion.lean`:70 | nao_alcancado |
| `Universe00.Laws.totalization_requires_sacrifice` | `universe-00/complement/lean/Universe00/Laws/Inescapability.lean`:66 | nao_alcancado |
| `Universe00.Laws.value_limit_disjoint` | `universe-00/complement/lean/Universe00/Laws/NonExplosion.lean`:38 | fechado |
