# Universe-0-0 — branch `copilot/refute-logical-limits`

Lean sources from the branch `copilot/refute-logical-limits` of the private repository `ShantiDraconis/Universe-0-0`, commit `cb0c5333604a7eca6cd192e8b1e42c1eae13a9ba` (2025-12-31T16:35:54+00:00), that hold theorems found only on branches (no default branch of any repository has a theorem with the same name). Published here: the files with the theorems the kernel closed, the local files they import and the Lake files of their project.

* Branch state: parada (not in the default branch).
* Theorems only on branches, in this branch: 37 — closed 1, conditional 0, open 0, proof error 0, not reached 36, no result 0.
* History: 1 commit(s) of this branch that are not in the default branch, with date and subject, in `certificate.json`.
* `certificate.json` (SHA-256 of its content: `a3cc0f46d3b18c6334ce4c1df1bdd41abc038fe930e51e53b288e76de6e02cda`) lists every theorem with its state and the axioms beyond the standard three, and the SHA-256 of every published file. From the repository root: `sha256sum -c mvei/branches/Universe-0-0/copilot_refute-logical-limits/SOURCES.sha256`.

Closed means the kernel accepted the proof and it depends only on `propext`, `Classical.choice` and `Quot.sound`; it proves the statement written in the file and is not a claim that an open problem is solved.

| Theorem | File | State |
|---|---|---|
| `SelfRefutation.allOptionalClaimsEnsureSafety` | `provers/lean/SelfRefutation/TypeIV.lean`:66 | nao_alcancado |
| `SelfRefutation.canonicalExamplesEnsureTestability` | `provers/lean/SelfRefutation/TypeV.lean`:85 | nao_alcancado |
| `SelfRefutation.completeCriteriaPreventTypeV` | `provers/lean/SelfRefutation/TypeV.lean`:69 | nao_alcancado |
| `SelfRefutation.conservativityViolationImpliesTypeI` | `provers/lean/SelfRefutation/TypeI.lean`:78 | nao_alcancado |
| `SelfRefutation.distinctTypesPreserveInfo` | `provers/lean/SelfRefutation/TypeII.lean`:105 | nao_alcancado |
| `SelfRefutation.explicitCostsPreventTypeIII` | `provers/lean/SelfRefutation/TypeIII.lean`:63 | nao_alcancado |
| `SelfRefutation.formalizedRegimePreventsAdHoc` | `provers/lean/SelfRefutation/TypeIII.lean`:92 | nao_alcancado |
| `SelfRefutation.frameworkOptionality` | `provers/lean/SelfRefutation/SelfRefutationTheorems.lean`:124 | nao_alcancado |
| `SelfRefutation.granularityImpliesDistinction` | `provers/lean/SelfRefutation/TypeII.lean`:91 | nao_alcancado |
| `SelfRefutation.highLimitRatioCausesTypeI` | `provers/lean/SelfRefutation/TypeI.lean`:59 | nao_alcancado |
| `SelfRefutation.informationLossImpliesTypeII` | `provers/lean/SelfRefutation/TypeII.lean`:69 | nao_alcancado |
| `SelfRefutation.limitExplainsOrRefutes` | `provers/lean/SelfRefutation/SelfRefutationTheorems.lean`:154 | nao_alcancado |
| `SelfRefutation.limitInformativeness` | `provers/lean/SelfRefutation/SelfRefutationTheorems.lean`:78 | nao_alcancado |
| `SelfRefutation.metaTotalityAvoided` | `provers/lean/SelfRefutation/TypeIV.lean`:102 | nao_alcancado |
| `SelfRefutation.missingCostsImplyTypeIII` | `provers/lean/SelfRefutation/TypeIII.lean`:48 | nao_alcancado |
| `SelfRefutation.optionalityPreventsTypeIV` | `provers/lean/SelfRefutation/TypeIV.lean`:44 | nao_alcancado |
| `SelfRefutation.regimeCostNonTriviality` | `provers/lean/SelfRefutation/SelfRefutationTheorems.lean`:100 | nao_alcancado |
| `SelfRefutation.regimeFormalizationDecidable` | `provers/lean/SelfRefutation/TypeIII.lean`:126 | nao_alcancado |
| `SelfRefutation.scientificValidityRequiresTestability` | `provers/lean/SelfRefutation/TypeV.lean`:117 | nao_alcancado |
| `SelfRefutation.selfRefutationDecidable` | `provers/lean/SelfRefutation/SelfRefutationTheorems.lean`:146 | nao_alcancado |
| `SelfRefutation.systemConsistencyCompleteness` | `provers/lean/SelfRefutation/SelfRefutationTheorems.lean`:26 | nao_alcancado |
| `SelfRefutation.systemConsistentIffNoViolations` | `provers/lean/SelfRefutation/Core.lean`:178 | fechado |
| `SelfRefutation.systemVitalityThroughRefutability` | `provers/lean/SelfRefutation/SelfRefutationTheorems.lean`:181 | nao_alcancado |
| `SelfRefutation.testabilityRequirement` | `provers/lean/SelfRefutation/SelfRefutationTheorems.lean`:131 | nao_alcancado |
| `SelfRefutation.typeIDetectionSound` | `provers/lean/SelfRefutation/TypeI.lean`:151 | nao_alcancado |
| `SelfRefutation.typeIIDetectionSound` | `provers/lean/SelfRefutation/TypeII.lean`:178 | nao_alcancado |
| `SelfRefutation.typeIIIDetectionSound` | `provers/lean/SelfRefutation/TypeIII.lean`:107 | nao_alcancado |
| `SelfRefutation.typeIIPreventedByDiversity` | `provers/lean/SelfRefutation/TypeII.lean`:117 | nao_alcancado |
| `SelfRefutation.typeIPreventedByClassicalAttempts` | `provers/lean/SelfRefutation/TypeI.lean`:107 | nao_alcancado |
| `SelfRefutation.typeIVDetectionSound` | `provers/lean/SelfRefutation/TypeIV.lean`:89 | nao_alcancado |
| `SelfRefutation.typeIViolationImpliesInconsistency` | `provers/lean/SelfRefutation/TypeI.lean`:51 | nao_alcancado |
| `SelfRefutation.typeVDetectionSound` | `provers/lean/SelfRefutation/TypeV.lean`:104 | nao_alcancado |
| `SelfRefutation.uniqueCausesImplyTypeIISafety` | `provers/lean/SelfRefutation/TypeII.lean`:154 | nao_alcancado |
| `SelfRefutation.universalizingClaimsImplyTypeIV` | `provers/lean/SelfRefutation/TypeIV.lean`:30 | nao_alcancado |
| `SelfRefutation.untestedLimitsImplyTypeV` | `provers/lean/SelfRefutation/TypeV.lean`:46 | nao_alcancado |
| `SelfRefutation.validateTypeIMaintainsOrIncreases` | `provers/lean/SelfRefutation/TypeI.lean`:135 | nao_alcancado |
| `SelfRefutation.validationMonotonic` | `provers/lean/SelfRefutation/SelfRefutationTheorems.lean`:138 | nao_alcancado |
