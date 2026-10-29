# universal-proof-hub — branch `elyon-open-math-miner`

Lean sources from the branch `elyon-open-math-miner` of the private repository `ShantiDraconis/universal-proof-hub`, commit `11f7479bf76eb28cd58af8c8b0d5c924acb8655c` (2026-09-27T21:01:49+01:00), that hold theorems found only on branches (no default branch of any repository has a theorem with the same name). Published here: the files with the theorems the kernel closed, the local files they import and the Lake files of their project.

* Branch state: parada (not in the default branch).
* Theorems only on branches, in this branch: 9 — closed 9, conditional 0, open 0, proof error 0, not reached 0, no result 0.
* History: 42 commit(s) of this branch that are not in the default branch, with date and subject, in `certificate.json`.
* `certificate.json` (SHA-256 of its content: `312870f194ed038938b0484620da121212f251228626a4f336b899d0d1cd2f83`) lists every theorem with its state and the axioms beyond the standard three, and the SHA-256 of every published file. From the repository root: `sha256sum -c mvei/branches/universal-proof-hub/elyon-open-math-miner/SOURCES.sha256`.

Closed means the kernel accepted the proof and it depends only on `propext`, `Classical.choice` and `Quot.sound`; it proves the statement written in the file and is not a claim that an open problem is solved.

| Theorem | File | State |
|---|---|---|
| `OpenMathMiner.branch_exclusive` | `open-math-miner/src/OpenMathMiner/DualState.lean`:35 | fechado |
| `OpenMathMiner.close_from_producer` | `open-math-miner/src/OpenMathMiner/ProducerFirst.lean`:12 | fechado |
| `OpenMathMiner.dual_exhaustive` | `open-math-miner/src/OpenMathMiner/DualState.lean`:27 | fechado |
| `OpenMathMiner.equal_branch_closed` | `open-math-miner/src/OpenMathMiner/DualState.lean`:19 | fechado |
| `OpenMathMiner.no_two_outcomes` | `open-math-miner/src/OpenMathMiner/Bridge.lean`:21 | fechado |
| `OpenMathMiner.realization_selects_branch` | `open-math-miner/src/OpenMathMiner/DualState.lean`:43 | fechado |
| `OpenMathMiner.separate_branch_closed` | `open-math-miner/src/OpenMathMiner/DualState.lean`:23 | fechado |
| `OpenMathMiner.transportSolved` | `open-math-miner/src/OpenMathMiner/Bridge.lean`:15 | fechado |
| `solvedB` | `open-math-miner/tests/Smoke.lean`:28 | fechado |
