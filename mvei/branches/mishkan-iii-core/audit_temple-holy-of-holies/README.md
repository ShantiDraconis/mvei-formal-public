# mishkan-iii-core — branch `audit/temple-holy-of-holies`

Lean sources from the branch `audit/temple-holy-of-holies` of the private repository `ShantiDraconis/mishkan-iii-core`, commit `5d81d33dd2c9ec6391f2b347705c3e9e5332d57f` (2026-09-18T20:09:53+02:00), that hold theorems found only on branches (no default branch of any repository has a theorem with the same name). Published here: the files with the theorems the kernel closed, the local files they import and the Lake files of their project.

* Branch state: parada (not in the default branch).
* Theorems only on branches, in this branch: 25 — closed 7, conditional 0, open 0, proof error 0, not reached 18, no result 0.
* History: 47 commit(s) of this branch that are not in the default branch, with date and subject, in `certificate.json`.
* `certificate.json` (SHA-256 of its content: `1dd3212d28aba33d1661a597b302c6ff77b9639c6b3896f4ce97daee48b9187c`) lists every theorem with its state and the axioms beyond the standard three, and the SHA-256 of every published file. From the repository root: `sha256sum -c mvei/branches/mishkan-iii-core/audit_temple-holy-of-holies/SOURCES.sha256`.

Closed means the kernel accepted the proof and it depends only on `propext`, `Classical.choice` and `Quot.sound`; it proves the statement written in the file and is not a claim that an open problem is solved.

| Theorem | File | State |
|---|---|---|
| `chamber_semantics_requires_axiom_no_placebo` | `audit/temple-inner-chambers/InnerChambers.lean`:105 | nao_alcancado |
| `chamber_semantics_requires_constant` | `audit/temple-inner-chambers/InnerChambers.lean`:81 | nao_alcancado |
| `chamber_semantics_requires_hc` | `audit/temple-inner-chambers/InnerChambers.lean`:93 | nao_alcancado |
| `chamber_semantics_requires_quantifier` | `audit/temple-inner-chambers/InnerChambers.lean`:87 | nao_alcancado |
| `chamber_semantics_requires_scaling` | `audit/temple-inner-chambers/InnerChambers.lean`:99 | nao_alcancado |
| `closedTempleCertificate_inner` | `audit/temple-holy-of-holies/HolyOfHoliesClosure.lean`:25 | nao_alcancado |
| `closedTempleCertificate_outer` | `audit/temple-holy-of-holies/HolyOfHoliesClosure.lean`:21 | nao_alcancado |
| `entering_c1_implies_G5_pass` | `audit/temple-outer-gates/TempleOuterGates.lean`:93 | fechado |
| `entering_inner_requires_all_outer_when_closed` | `audit/temple-holy-of-holies/HolyOfHoliesClosure.lean`:48 | nao_alcancado |
| `holy_of_holies_architecture_closed` | `audit/temple-holy-of-holies/HolyOfHoliesClosure.lean`:29 | nao_alcancado |
| `holy_of_holies_requires_all_inner` | `audit/temple-inner-chambers/InnerChambers.lean`:75 | nao_alcancado |
| `holy_of_holies_requires_no_placebo` | `audit/temple-outer-gates/TempleOuterGates.lean`:107 | fechado |
| `holy_of_holies_requires_outer_gates` | `audit/temple-outer-gates/TempleOuterGates.lean`:101 | fechado |
| `matched_hypothesis_conclusion` | `audit/temple-inner-chambers/InnerChambers.lean`:44 | nao_alcancado |
| `messiah_route_requires_all_gates` | `audit/temple-outer-gates/TempleOuterGates.lean`:87 | fechado |
| `no_direct_outside_to_holy_even_when_closed` | `audit/temple-holy-of-holies/HolyOfHoliesClosure.lean`:39 | nao_alcancado |
| `no_shortcut` | `audit/temple-outer-gates/TempleOuterGates.lean`:75 | fechado |
| `no_skip_C2` | `audit/temple-inner-chambers/InnerChambers.lean`:59 | nao_alcancado |
| `no_skip_C3` | `audit/temple-inner-chambers/InnerChambers.lean`:63 | nao_alcancado |
| `no_skip_C4` | `audit/temple-inner-chambers/InnerChambers.lean`:67 | nao_alcancado |
| `no_skip_C5` | `audit/temple-inner-chambers/InnerChambers.lean`:71 | nao_alcancado |
| `no_skip_G5` | `audit/temple-outer-gates/TempleOuterGates.lean`:79 | fechado |
| `no_skip_G5_from_G3` | `audit/temple-outer-gates/TempleOuterGates.lean`:83 | fechado |
| `pointwise_profile_holds` | `audit/temple-inner-chambers/InnerChambers.lean`:27 | nao_alcancado |
| `uniform_profile_fails` | `audit/temple-inner-chambers/InnerChambers.lean`:32 | nao_alcancado |
