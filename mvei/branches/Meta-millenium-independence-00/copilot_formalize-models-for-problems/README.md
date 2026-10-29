# Meta-millenium-independence-00 — branch `copilot/formalize-models-for-problems`

Lean sources from the branch `copilot/formalize-models-for-problems` of the private repository `ShantiDraconis/Meta-millenium-independence-00`, commit `5a7a1a6fcd74f59896ec9309225b4889c1126b41` (2026-09-09T04:37:04+00:00), that hold theorems found only on branches (no default branch of any repository has a theorem with the same name). Published here: the files with the theorems the kernel closed, the local files they import and the Lake files of their project.

* Branch state: parada (not in the default branch).
* Theorems only on branches, in this branch: 27 — closed 9, conditional 0, open 1, proof error 1, not reached 16, no result 0.
* History: 5 commit(s) of this branch that are not in the default branch, with date and subject, in `certificate.json`.
* `certificate.json` (SHA-256 of its content: `0b3209d722df6373aca0b5c032a5c237b245ef03d93811a55f5963b6f185ed8c`) lists every theorem with its state and the axioms beyond the standard three, and the SHA-256 of every published file. From the repository root: `sha256sum -c mvei/branches/Meta-millenium-independence-00/copilot_formalize-models-for-problems/SOURCES.sha256`.

Closed means the kernel accepted the proof and it depends only on `propext`, `Classical.choice` and `Quot.sound`; it proves the statement written in the file and is not a claim that an open problem is solved.

| Theorem | File | State |
|---|---|---|
| `MetaMillennium.Bridges.ForcingProgram_implies_DualStateForAll` | `src/lean/MetaMillennium/Bridges/DS_From_Forcing.lean`:22 | nao_alcancado |
| `MetaMillennium.Bridges.InnerModelProgram_implies_DualStateForAll` | `src/lean/MetaMillennium/Bridges/DS_From_InnerModels.lean`:21 | nao_alcancado |
| `MetaMillennium.Bridges.LC_program_implies_all_DualState` | `src/lean/MetaMillennium/Bridges/DS_From_LargeCardinals.lean`:24 | nao_alcancado |
| `MetaMillennium.Bridges.bridge_is_complete` | `src/lean/MetaMillennium/Bridges/BridgeOverview.lean`:35 | nao_alcancado |
| `MetaMillennium.Forcing.forcingDualScenario_implies_independent` | `src/lean/MetaMillennium/Forcing/ForcingToDualState.lean`:33 | nao_alcancado |
| `MetaMillennium.InnerModels.L_transitive` | `src/lean/MetaMillennium/InnerModels/L_InnerModel.lean`:30 | fechado |
| `MetaMillennium.InnerModels.L_wellFounded` | `src/lean/MetaMillennium/InnerModels/L_InnerModel.lean`:33 | fechado |
| `MetaMillennium.InnerModels.innerDualScenario_implies_independent` | `src/lean/MetaMillennium/InnerModels/InnerModelsToDualState.lean`:30 | nao_alcancado |
| `MetaMillennium.LargeCardinals.lcDualScenario_implies_independent` | `src/lean/MetaMillennium/LargeCardinals/LC_ToDualState.lean`:28 | nao_alcancado |
| `MetaMillennium.RH.dualState_implies_indep` | `src/lean/MetaMillennium/Problems/RH/RHIndependenceProgram.lean`:29 | nao_alcancado |
| `MetaMillennium.RH.model_program_implies_indep` | `src/lean/MetaMillennium/Problems/RH/RHIndependenceProgram.lean`:52 | nao_alcancado |
| `MetaMillennium.Toy.boolBiModel_is_dual` | `src/lean/MetaMillennium/Models/ToyModels.lean`:64 | nao_alcancado |
| `MetaMillennium.Toy.natTheory_consistent` | `src/lean/MetaMillennium/Models/ToyModels.lean`:80 | nao_alcancado |
| `MetaMillennium.Toy.toyTheory_consistent` | `src/lean/MetaMillennium/Models/ToyModels.lean`:23 | nao_alcancado |
| `MetaMillennium.Toy.α_independent` | `src/lean/MetaMillennium/Models/ToyModels.lean`:34 | nao_alcancado |
| `MetaMillennium.conj_elim_left` | `src/lean/MetaMillennium/Core/LogicBasics.lean`:36 | fechado |
| `MetaMillennium.conj_elim_right` | `src/lean/MetaMillennium/Core/LogicBasics.lean`:39 | fechado |
| `MetaMillennium.conj_intro` | `src/lean/MetaMillennium/Core/LogicBasics.lean`:42 | fechado |
| `MetaMillennium.consistent_preserved` | `src/lean/MetaMillennium/DualState/DualStateLemmas.lean`:56 | nao_alcancado |
| `MetaMillennium.double_neg_intro` | `src/lean/MetaMillennium/Core/LogicBasics.lean`:30 | fechado |
| `MetaMillennium.dualState_implies_consistent` | `src/lean/MetaMillennium/DualState/DualStateLemmas.lean`:39 | nao_alcancado |
| `MetaMillennium.dualState_symmetric` | `src/lean/MetaMillennium/DualState/DualStateDefinition.lean`:35 | fechado |
| `MetaMillennium.independent_implies_undecidable` | `src/lean/MetaMillennium/Core/ConsistencyAndIndependence.lean`:42 | aberto-sorry |
| `MetaMillennium.independent_symmetric` | `src/lean/MetaMillennium/DualState/DualStateLemmas.lean`:45 | nao_alcancado |
| `MetaMillennium.modus_ponens` | `src/lean/MetaMillennium/Core/LogicBasics.lean`:33 | fechado |
| `MetaMillennium.swap_dual` | `src/lean/MetaMillennium/DualState/BiModel.lean`:53 | erro |
| `MetaMillennium.swap_swap` | `src/lean/MetaMillennium/DualState/BiModel.lean`:50 | fechado |
