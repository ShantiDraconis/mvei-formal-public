# m-core-openai-ns-audit — branch `atk-kernel-check`

Lean sources from the branch `atk-kernel-check` of the private repository `ShantiDraconis/m-core-openai-ns-audit`, commit `f4e694563931fedadb24993278725f1636f5bac1` (2026-10-12T21:14:38+01:00), that hold theorems found only on branches (no default branch of any repository has a theorem with the same name). Published here: the files with the theorems the kernel closed, the local files they import and the Lake files of their project.

* Branch state: parada (not in the default branch).
* Theorems only on branches, in this branch: 2 — closed 2, conditional 0, open 0, proof error 0, not reached 0, no result 0.
* History: 8 commit(s) of this branch that are not in the default branch, with date and subject, in `certificate.json`.
* `certificate.json` (SHA-256 of its content: `899202f066a0f7a85bb8558ae8dc22711e915c1377e2e897da53cc000554f060`) lists every theorem with its state and the axioms beyond the standard three, and the SHA-256 of every published file. From the repository root: `sha256sum -c mvei/branches/m-core-openai-ns-audit/atk-kernel-check/SOURCES.sha256`.

Closed means the kernel accepted the proof and it depends only on `propext`, `Classical.choice` and `Quot.sound`; it proves the statement written in the file and is not a claim that an open problem is solved.

| Theorem | File | State |
|---|---|---|
| `ATK.NSControl.weighted_energy_control` | `atk-kernel/ATK/NSControl.lean`:17 | fechado |
| `ATK.NavierStokes.absorption_without_remainder_forces_decay` | `atk-kernel/ATK/NavierStokes.lean`:84 | fechado |
