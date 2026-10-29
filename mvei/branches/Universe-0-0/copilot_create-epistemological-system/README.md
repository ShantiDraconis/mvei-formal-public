# Universe-0-0 — branch `copilot/create-epistemological-system`

Lean sources from the branch `copilot/create-epistemological-system` of the private repository `ShantiDraconis/Universe-0-0`, commit `d14fb83f59d2c4f10203c3bcd9dcac20695a19a5` (2025-12-31T02:15:57+00:00), that hold theorems found only on branches (no default branch of any repository has a theorem with the same name). Published here: the files with the theorems the kernel closed, the local files they import and the Lake files of their project.

* Branch state: parada (not in the default branch).
* Theorems only on branches, in this branch: 65 — closed 23, conditional 0, open 5, proof error 1, not reached 36, no result 0.
* History: 6 commit(s) of this branch that are not in the default branch, with date and subject, in `certificate.json`.
* `certificate.json` (SHA-256 of its content: `65fad8f215776afc52167adf13142a836a30bce7a526acc955e5f1fdedf51720`) lists every theorem with its state and the axioms beyond the standard three, and the SHA-256 of every published file. From the repository root: `sha256sum -c mvei/branches/Universe-0-0/copilot_create-epistemological-system/SOURCES.sha256`.

Closed means the kernel accepted the proof and it depends only on `propext`, `Classical.choice` and `Quot.sound`; it proves the statement written in the file and is not a claim that an open problem is solved.

| Theorem | File | State |
|---|---|---|
| `Universe00.Core.LimitTheorems.first_limit_dominates` | `provers/lean/Universe00/Core/LimitState.lean`:211 | fechado |
| `Universe00.Core.LimitTheorems.limit_not_explosion` | `provers/lean/Universe00/Core/LimitState.lean`:184 | fechado |
| `Universe00.Core.LimitTheorems.limit_preserved_by_map` | `provers/lean/Universe00/Core/LimitState.lean`:192 | fechado |
| `Universe00.Core.LimitTheorems.resolution_requires_declaration` | `provers/lean/Universe00/Core/LimitState.lean`:198 | nao_alcancado |
| `Universe00.Core.OutcomeTheorems.bind_assoc` | `provers/lean/Universe00/Core/Outcome.lean`:169 | fechado |
| `Universe00.Core.OutcomeTheorems.bind_limit_dominates` | `provers/lean/Universe00/Core/Outcome.lean`:188 | fechado |
| `Universe00.Core.OutcomeTheorems.bind_pure_is_map` | `provers/lean/Universe00/Core/Outcome.lean`:183 | fechado |
| `Universe00.Core.OutcomeTheorems.bind_pure_left` | `provers/lean/Universe00/Core/Outcome.lean`:159 | fechado |
| `Universe00.Core.OutcomeTheorems.bind_pure_right` | `provers/lean/Universe00/Core/Outcome.lean`:163 | fechado |
| `Universe00.Core.OutcomeTheorems.map_limit` | `provers/lean/Universe00/Core/Outcome.lean`:179 | fechado |
| `Universe00.Core.OutcomeTheorems.map_value` | `provers/lean/Universe00/Core/Outcome.lean`:175 | fechado |
| `Universe00.Core.OutcomeTheorems.no_explosion_from_limit` | `provers/lean/Universe00/Core/Outcome.lean`:192 | fechado |
| `Universe00.Core.RegimeTheorems.reframe_identity` | `provers/lean/Universe00/Core/Regime.lean`:229 | fechado |
| `Universe00.Core.RegimeTheorems.reframe_preserves_value` | `provers/lean/Universe00/Core/Regime.lean`:221 | fechado |
| `Universe00.Core.RegimeTheorems.transition_requires_declaration` | `provers/lean/Universe00/Core/Regime.lean`:236 | erro |
| `Universe00.Core.StatusTheorems.conjectural_isolation` | `provers/lean/Universe00/Core/Status.lean`:248 | aberto-sorry |
| `Universe00.Core.StatusTheorems.proved_with_trusted_deps_is_trusted` | `provers/lean/Universe00/Core/Status.lean`:233 | aberto-sorry |
| `Universe00.Laws.AntiAdHocTheorems.applied_regularizations_traceable` | `provers/lean/Universe00/Laws/AntiAdHoc.lean`:223 | nao_alcancado |
| `Universe00.Laws.AntiAdHocTheorems.regularization_has_method` | `provers/lean/Universe00/Laws/AntiAdHoc.lean`:218 | aberto-sorry |
| `Universe00.Laws.AntiAdHocTheorems.regularization_has_status` | `provers/lean/Universe00/Laws/AntiAdHoc.lean`:212 | nao_alcancado |
| `Universe00.Laws.ClassicalContrast.universe00_non_explosion` | `provers/lean/Universe00/Laws/NonExplosion.lean`:101 | nao_alcancado |
| `Universe00.Laws.ConservativityTheorems.classical_no_explosion` | `provers/lean/Universe00/Laws/Conservativity.lean`:166 | nao_alcancado |
| `Universe00.Laws.ConservativityTheorems.conservativity_implies_preservation` | `provers/lean/Universe00/Laws/Conservativity.lean`:155 | nao_alcancado |
| `Universe00.Laws.ConservativityTheorems.conservativity_regime_aware` | `provers/lean/Universe00/Laws/Conservativity.lean`:176 | nao_alcancado |
| `Universe00.Laws.ExplicitRegimeTheorems.laws_have_regime` | `provers/lean/Universe00/Laws/ExplicitRegimes.lean`:215 | nao_alcancado |
| `Universe00.Laws.ExplicitRegimeTheorems.operations_have_regime` | `provers/lean/Universe00/Laws/ExplicitRegimes.lean`:208 | nao_alcancado |
| `Universe00.Laws.ExplicitRegimeTheorems.regime_awareness_explicit` | `provers/lean/Universe00/Laws/ExplicitRegimes.lean`:227 | aberto-sorry |
| `Universe00.Laws.ExplicitRegimeTheorems.theorems_have_regime` | `provers/lean/Universe00/Laws/ExplicitRegimes.lean`:221 | nao_alcancado |
| `Universe00.Laws.NonExplosionProperties.limits_dont_contaminate` | `provers/lean/Universe00/Laws/NonExplosion.lean`:140 | nao_alcancado |
| `Universe00.Laws.NonExplosionProperties.limits_isolated` | `provers/lean/Universe00/Laws/NonExplosion.lean`:126 | nao_alcancado |
| `Universe00.Laws.NonExplosionProperties.non_explosion_preserved_by_bind` | `provers/lean/Universe00/Laws/NonExplosion.lean`:158 | nao_alcancado |
| `Universe00.Laws.NonExplosionProperties.non_explosion_preserved_by_map` | `provers/lean/Universe00/Laws/NonExplosion.lean`:151 | nao_alcancado |
| `Universe00.Laws.NonExplosionTheorems.compatible_with_conservativity` | `provers/lean/Universe00/Laws/NonExplosion.lean`:212 | nao_alcancado |
| `Universe00.Laws.NonExplosionTheorems.compatible_with_preservation` | `provers/lean/Universe00/Laws/NonExplosion.lean`:219 | nao_alcancado |
| `Universe00.Laws.NonExplosionTheorems.ensures_soundness` | `provers/lean/Universe00/Laws/NonExplosion.lean`:227 | nao_alcancado |
| `Universe00.Laws.PreservationTheorems.limits_are_sticky` | `provers/lean/Universe00/Laws/Preservation.lean`:177 | nao_alcancado |
| `Universe00.Laws.PreservationTheorems.map_preserves_limit_property` | `provers/lean/Universe00/Laws/Preservation.lean`:168 | nao_alcancado |
| `Universe00.Laws.PreservationTheorems.no_arbitrary_choices` | `provers/lean/Universe00/Laws/Preservation.lean`:187 | nao_alcancado |
| `Universe00.Laws.PreservationTheorems.preservation_transitive` | `provers/lean/Universe00/Laws/Preservation.lean`:161 | nao_alcancado |
| `Universe00.Laws.TraceabilityTheorems.assumed_has_id` | `provers/lean/Universe00/Laws/Traceability.lean`:296 | nao_alcancado |
| `Universe00.Laws.TraceabilityTheorems.proved_has_path` | `provers/lean/Universe00/Laws/Traceability.lean`:288 | nao_alcancado |
| `Universe00.Laws.TraceabilityTheorems.traceability_ensures_accountability` | `provers/lean/Universe00/Laws/Traceability.lean`:310 | aberto-sorry |
| `Universe00.Laws.TraceabilityTheorems.traceable_has_status` | `provers/lean/Universe00/Laws/Traceability.lean`:282 | nao_alcancado |
| `Universe00.Laws.classical_not_limit` | `provers/lean/Universe00/Laws/Conservativity.lean`:38 | nao_alcancado |
| `Universe00.Laws.limit_propagates_through_bind` | `provers/lean/Universe00/Laws/Preservation.lean`:61 | nao_alcancado |
| `Universe00.Laws.limit_propagates_through_map` | `provers/lean/Universe00/Laws/Preservation.lean`:55 | nao_alcancado |
| `Universe00.Laws.limit_reason_preserved` | `provers/lean/Universe00/Laws/NonExplosion.lean`:52 | nao_alcancado |
| `Universe00.Laws.no_explosion_to_limit` | `provers/lean/Universe00/Laws/NonExplosion.lean`:43 | nao_alcancado |
| `Universe00.Laws.no_explosion_to_value` | `provers/lean/Universe00/Laws/NonExplosion.lean`:36 | nao_alcancado |
| `Universe00.Operators.BasicTheorems.compose_assoc` | `provers/lean/Universe00/Operators/Basic.lean`:195 | fechado |
| `Universe00.Operators.BasicTheorems.filter_limit` | `provers/lean/Universe00/Operators/Basic.lean`:182 | fechado |
| `Universe00.Operators.BasicTheorems.filter_value` | `provers/lean/Universe00/Operators/Basic.lean`:176 | fechado |
| `Universe00.Operators.BasicTheorems.liftA2_limit_left` | `provers/lean/Universe00/Operators/Basic.lean`:164 | fechado |
| `Universe00.Operators.BasicTheorems.liftA2_limit_right` | `provers/lean/Universe00/Operators/Basic.lean`:169 | fechado |
| `Universe00.Operators.BasicTheorems.recover_limit` | `provers/lean/Universe00/Operators/Basic.lean`:191 | fechado |
| `Universe00.Operators.BasicTheorems.recover_value` | `provers/lean/Universe00/Operators/Basic.lean`:186 | fechado |
| `Universe00.Operators.ClassicalComparison.universe00_more_explicit` | `provers/lean/Universe00/Operators/SafeDivision.lean`:207 | nao_alcancado |
| `Universe00.Operators.SafeDecisionTheorems.decidable_has_value` | `provers/lean/Universe00/Operators/SafeDecision.lean`:150 | fechado |
| `Universe00.Operators.SafeDecisionTheorems.decision_respects_equivalence` | `provers/lean/Universe00/Operators/SafeDecision.lean`:165 | fechado |
| `Universe00.Operators.SafeDecisionTheorems.undecidable_has_limit` | `provers/lean/Universe00/Operators/SafeDecision.lean`:159 | fechado |
| `Universe00.Operators.SafeDivisionTheorems.sdiv_nonzero_classical` | `provers/lean/Universe00/Operators/SafeDivision.lean`:94 | nao_alcancado |
| `Universe00.Operators.SafeDivisionTheorems.sdiv_preserves_mul` | `provers/lean/Universe00/Operators/SafeDivision.lean`:114 | nao_alcancado |
| `Universe00.Operators.SafeDivisionTheorems.sdiv_total_meadow` | `provers/lean/Universe00/Operators/SafeDivision.lean`:105 | nao_alcancado |
| `Universe00.Operators.SafeDivisionTheorems.sdiv_zero_classical` | `provers/lean/Universe00/Operators/SafeDivision.lean`:99 | nao_alcancado |
| `Universe00.Operators.sdivIFramework_is_regularization` | `provers/lean/Universe00/Operators/SafeDivision.lean`:173 | nao_alcancado |
