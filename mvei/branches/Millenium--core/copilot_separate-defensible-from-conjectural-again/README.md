# Millenium--core — branch `copilot/separate-defensible-from-conjectural-again`

Lean sources from the branch `copilot/separate-defensible-from-conjectural-again` of the private repository `ShantiDraconis/Millenium--core`, commit `82edf75d47467e1648af3b7e16abd5b78632c068` (2026-04-13T03:04:23-03:00), that hold theorems found only on branches (no default branch of any repository has a theorem with the same name). Published here: the files with the theorems the kernel closed, the local files they import and the Lake files of their project.

* Branch state: incorporada (already in the default branch).
* Theorems only on branches, in this branch: 92 — closed 23, conditional 0, open 0, proof error 0, not reached 69, no result 0.
* History: 0 commit(s) of this branch that are not in the default branch, with date and subject, in `certificate.json`.
* `certificate.json` (SHA-256 of its content: `680e8248cc3d03c64618f221ed64bfde1eaf63499b69adf29993aad85b79443b`) lists every theorem with its state and the axioms beyond the standard three, and the SHA-256 of every published file. From the repository root: `sha256sum -c mvei/branches/Millenium--core/copilot_separate-defensible-from-conjectural-again/SOURCES.sha256`.

Closed means the kernel accepted the proof and it depends only on `propext`, `Classical.choice` and `Quot.sound`; it proves the statement written in the file and is not a claim that an open problem is solved.

| Theorem | File | State |
|---|---|---|
| `TIF.CExpr.embed_add` | `Core/Syntax.lean`:181 | fechado |
| `TIF.CExpr.embed_const` | `Core/Syntax.lean`:178 | fechado |
| `TIF.CExpr.embed_div` | `Core/Syntax.lean`:190 | fechado |
| `TIF.CExpr.embed_mul` | `Core/Syntax.lean`:187 | fechado |
| `TIF.CExpr.embed_sub` | `Core/Syntax.lean`:184 | fechado |
| `TIF.CExpr.embed_var` | `Core/Syntax.lean`:169 | fechado |
| `TIF.Expr.indet_inj` | `Core/Syntax.lean`:108 | fechado |
| `TIF.Expr.indet_ne_const` | `Core/Syntax.lean`:97 | fechado |
| `TIF.Expr.var_inj` | `Core/Syntax.lean`:122 | fechado |
| `TIF.State.empty_admissible` | `Core/State.lean`:58 | nao_alcancado |
| `TIF.TIF.IndeterminateExpr.classicalFrag_binOp_iff` | `Core/Syntax.lean`:348 | fechado |
| `TIF.TIF.IndeterminateExpr.classicalFrag_const` | `Core/Syntax.lean`:341 | fechado |
| `TIF.TIF.IndeterminateExpr.depth_binOp_lt` | `Core/Syntax.lean`:321 | fechado |
| `TIF.TIF.IndeterminateExpr.depth_const` | `Core/Syntax.lean`:315 | fechado |
| `TIF.TIF.IndeterminateExpr.depth_indeterminate` | `Core/Syntax.lean`:318 | fechado |
| `TIF.TIF.IndeterminateExpr.iCount_pos_iff_containsI` | `Core/Syntax.lean`:289 | nao_alcancado |
| `TIF.TIF.IndeterminateExpr.iCount_substI_classical` | `Core/Syntax.lean`:425 | fechado |
| `TIF.TIF.IndeterminateExpr.not_classicalFrag_indeterminate` | `Core/Syntax.lean`:344 | fechado |
| `TIF.TIF.IndeterminateExpr.substI_classical` | `Core/Syntax.lean`:401 | fechado |
| `TIF.TIF.IndeterminateExpr.substI_indeterminate` | `Core/Syntax.lean`:415 | fechado |
| `TIF.TIF.IndeterminateExpr.wellFormed_const` | `Core/Syntax.lean`:377 | fechado |
| `TIF.TIF.IndeterminateExpr.wellFormed_div_indeterminate` | `Core/Syntax.lean`:380 | nao_alcancado |
| `TIF.TIF.IndeterminateExpr.wellFormed_indeterminate` | `Core/Syntax.lean`:374 | fechado |
| `TIF.TIF.TIF.TIF.A10_nonunique_forbids_collapse` | `Core/Collapse.lean`:592 | nao_alcancado |
| `TIF.TIF.TIF.TIF.A11_local_noncontradiction` | `Core/Collapse.lean`:601 | nao_alcancado |
| `TIF.TIF.TIF.TIF.A15_monotone_refinement` | `Core/Collapse.lean`:628 | nao_alcancado |
| `TIF.TIF.TIF.TIF.A16_collapse_idempotent` | `Core/Collapse.lean`:637 | nao_alcancado |
| `TIF.TIF.TIF.TIF.A1_existence_base` | `Core/Collapse.lean`:517 | nao_alcancado |
| `TIF.TIF.TIF.TIF.A2_existence_classes` | `Core/Collapse.lean`:533 | nao_alcancado |
| `TIF.TIF.TIF.TIF.A3_not_classical_real` | `Core/Collapse.lean`:538 | nao_alcancado |
| `TIF.TIF.TIF.TIF.A4_not_classical_complex` | `Core/Collapse.lean`:548 | nao_alcancado |
| `TIF.TIF.TIF.TIF.A5_distinct_from_classical` | `Core/Collapse.lean`:553 | nao_alcancado |
| `TIF.TIF.TIF.TIF.A6_extended_operators` | `Core/Collapse.lean`:558 | nao_alcancado |
| `TIF.TIF.TIF.TIF.A7_extension_coincides_classical` | `Core/Collapse.lean`:567 | nao_alcancado |
| `TIF.TIF.TIF.TIF.A9_unique_resolution_implies_collapse` | `Core/Collapse.lean`:585 | nao_alcancado |
| `TIF.TIF.TIF.TIF.Collapse_unique` | `Core/Collapse.lean`:675 | nao_alcancado |
| `TIF.TIF.TIF.TIF.classical_reduction` | `Core/Collapse.lean`:643 | nao_alcancado |
| `TIF.TIF.TIF.TIF.collapse_uniqueness` | `Core/Collapse.lean`:652 | nao_alcancado |
| `TIF.TIF.TIF.TIF.indet_isolation` | `Core/Collapse.lean`:660 | nao_alcancado |
| `TIF.TIF.TIF.classical_stability` | `Core/Rewrite.lean`:610 | nao_alcancado |
| `TIF.TIF.TIF.collapse_A10` | `Core/Collapse.lean`:394 | nao_alcancado |
| `TIF.TIF.TIF.collapse_A8` | `Core/Collapse.lean`:370 | nao_alcancado |
| `TIF.TIF.TIF.collapse_A9` | `Core/Collapse.lean`:385 | nao_alcancado |
| `TIF.TIF.TIF.collapse_classical_fragment_stable` | `Core/Collapse.lean`:446 | nao_alcancado |
| `TIF.TIF.TIF.collapse_correctness` | `Core/Rewrite.lean`:624 | nao_alcancado |
| `TIF.TIF.TIF.collapse_div_zero_form` | `Core/Collapse.lean`:476 | nao_alcancado |
| `TIF.TIF.TIF.collapse_idempotent` | `Core/Collapse.lean`:418 | nao_alcancado |
| `TIF.TIF.TIF.collapse_implies_rewrite_star` | `Core/Collapse.lean`:489 | nao_alcancado |
| `TIF.TIF.TIF.collapse_recovery` | `Core/Collapse.lean`:462 | nao_alcancado |
| `TIF.TIF.TIF.collapse_sound` | `Core/Collapse.lean`:401 | nao_alcancado |
| `TIF.TIF.TIF.restricted_confluence` | `Core/Rewrite.lean`:640 | nao_alcancado |
| `TIF.TIF.TIF.wellformedness_preservation` | `Core/Rewrite.lean`:598 | nao_alcancado |
| `TIF.TIF.adm_empty` | `Core/Eval.lean`:168 | nao_alcancado |
| `TIF.TIF.blocked_of_vacuous` | `Core/Collapse.lean`:267 | nao_alcancado |
| `TIF.TIF.classical_collapse_agreement` | `Core/Collapse.lean`:280 | nao_alcancado |
| `TIF.TIF.classical_term_is_expr` | `Core/Syntax.lean`:587 | fechado |
| `TIF.TIF.collapse'_none_iff` | `Core/Collapse.lean`:239 | nao_alcancado |
| `TIF.TIF.collapse_complete` | `Core/Collapse.lean`:171 | nao_alcancado |
| `TIF.TIF.collapse_sound` | `Core/Collapse.lean`:155 | nao_alcancado |
| `TIF.TIF.const_classicalNF` | `Core/Rewrite.lean`:400 | nao_alcancado |
| `TIF.TIF.depth_subexpr_le` | `Core/Syntax.lean`:600 | fechado |
| `TIF.TIF.evalC_add` | `Core/Eval.lean`:213 | nao_alcancado |
| `TIF.TIF.evalC_const` | `Core/Eval.lean`:210 | nao_alcancado |
| `TIF.TIF.evalC_div` | `Core/Eval.lean`:231 | nao_alcancado |
| `TIF.TIF.evalC_div_nonzero` | `Core/Eval.lean`:237 | nao_alcancado |
| `TIF.TIF.evalC_eq_eval` | `Core/Eval.lean`:189 | nao_alcancado |
| `TIF.TIF.evalC_mul` | `Core/Eval.lean`:225 | nao_alcancado |
| `TIF.TIF.evalC_sub` | `Core/Eval.lean`:219 | nao_alcancado |
| `TIF.TIF.evalC_var` | `Core/Eval.lean`:207 | nao_alcancado |
| `TIF.TIF.eval_const` | `Core/Eval.lean`:148 | nao_alcancado |
| `TIF.TIF.eval_indet` | `Core/Eval.lean`:129 | nao_alcancado |
| `TIF.TIF.eval_var` | `Core/Eval.lean`:140 | nao_alcancado |
| `TIF.TIF.indeterminate_blockedNF` | `Core/Rewrite.lean`:413 | nao_alcancado |
| `TIF.TIF.rewrite1_depth_le` | `Core/Rewrite.lean`:462 | nao_alcancado |
| `TIF.TIF.rewrite1_preserves_wf` | `Core/Rewrite.lean`:425 | nao_alcancado |
| `TIF.TIF.rewrite1_to_star` | `Core/Rewrite.lean`:372 | nao_alcancado |
| `TIF.TIF.rewriteStar_preserves_wf` | `Core/Rewrite.lean`:454 | nao_alcancado |
| `TIF.TIF.rewriteStar_trans` | `Core/Rewrite.lean`:365 | nao_alcancado |
| `TIF.TIF.supp_empty_iff_classical` | `Core/Syntax.lean`:595 | fechado |
| `TIF.addComm_preserves_classical` | `Core/Rewrite.lean`:71 | nao_alcancado |
| `TIF.addComm_sound` | `Core/Rewrite.lean`:100 | nao_alcancado |
| `TIF.blocked_iff_not_unique_res` | `Core/Collapse.lean`:61 | nao_alcancado |
| `TIF.classicalFragment_evaluable` | `Core/Rewrite.lean`:206 | nao_alcancado |
| `TIF.collapse_sound` | `Core/Collapse.lean`:47 | nao_alcancado |
| `TIF.eval_classical_no_indet` | `Core/Eval.lean`:46 | nao_alcancado |
| `TIF.eval_never_indet` | `Core/Rewrite.lean`:236 | nao_alcancado |
| `TIF.identityRewrite_preserves_classical` | `Core/Rewrite.lean`:61 | nao_alcancado |
| `TIF.identityRewrite_sound` | `Core/Rewrite.lean`:92 | nao_alcancado |
| `TIF.originTag_zeroOverZero_produces_indet` | `Core/Rewrite.lean`:168 | nao_alcancado |
| `TIF.vacuous_implies_blocked` | `Core/Collapse.lean`:76 | nao_alcancado |
| `collapse_const` | `Core/State.lean`:232 | nao_alcancado |
| `collapse_indet_none` | `Core/State.lean`:238 | nao_alcancado |
