# Millenium--core — branch `copilot/update-indeterminate-framework-v11`

Lean sources from the branch `copilot/update-indeterminate-framework-v11` of the private repository `ShantiDraconis/Millenium--core`, commit `5367a36b3912ecd77c6615c7b9995a2fb75952c7` (2026-04-13T03:14:47-03:00), that hold theorems found only on branches (no default branch of any repository has a theorem with the same name). Published here: the files with the theorems the kernel closed, the local files they import and the Lake files of their project.

* Branch state: incorporada (already in the default branch).
* Theorems only on branches, in this branch: 58 — closed 6, conditional 0, open 2, proof error 8, not reached 42, no result 0.
* History: 0 commit(s) of this branch that are not in the default branch, with date and subject, in `certificate.json`.
* `certificate.json` (SHA-256 of its content: `2dcf39fe63570801adfadd0bc278e33bc067741ef7312a1c31ab359cf52959a4`) lists every theorem with its state and the axioms beyond the standard three, and the SHA-256 of every published file. From the repository root: `sha256sum -c mvei/branches/Millenium--core/copilot_update-indeterminate-framework-v11/SOURCES.sha256`.

Closed means the kernel accepted the proof and it depends only on `propext`, `Classical.choice` and `Quot.sound`; it proves the statement written in the file and is not a claim that an open problem is solved.

| Theorem | File | State |
|---|---|---|
| `TIF.A10_nonunique_forbids_collapse` | `Core/Collapse.lean`:767 | nao_alcancado |
| `TIF.A11_local_noncontradiction` | `Core/Collapse.lean`:776 | nao_alcancado |
| `TIF.A15_monotone_refinement` | `Core/Collapse.lean`:803 | nao_alcancado |
| `TIF.A16_collapse_idempotent` | `Core/Collapse.lean`:812 | nao_alcancado |
| `TIF.A1_existence_base` | `Core/Collapse.lean`:692 | nao_alcancado |
| `TIF.A2_existence_classes` | `Core/Collapse.lean`:708 | nao_alcancado |
| `TIF.A3_not_classical_real` | `Core/Collapse.lean`:713 | nao_alcancado |
| `TIF.A4_not_classical_complex` | `Core/Collapse.lean`:723 | nao_alcancado |
| `TIF.A5_distinct_from_classical` | `Core/Collapse.lean`:728 | nao_alcancado |
| `TIF.A6_extended_operators` | `Core/Collapse.lean`:733 | nao_alcancado |
| `TIF.A7_extension_coincides_classical` | `Core/Collapse.lean`:742 | nao_alcancado |
| `TIF.A9_unique_resolution_implies_collapse` | `Core/Collapse.lean`:760 | nao_alcancado |
| `TIF.Collapse_unique` | `Core/Collapse.lean`:850 | nao_alcancado |
| `TIF.IndeterminateExpr.classicalFrag_binOp_iff` | `Core/Syntax.lean`:156 | fechado |
| `TIF.IndeterminateExpr.classicalFrag_const` | `Core/Syntax.lean`:149 | fechado |
| `TIF.IndeterminateExpr.depth_binOp_lt` | `Core/Syntax.lean`:129 | erro |
| `TIF.IndeterminateExpr.depth_const` | `Core/Syntax.lean`:123 | erro |
| `TIF.IndeterminateExpr.depth_indeterminate` | `Core/Syntax.lean`:126 | erro |
| `TIF.IndeterminateExpr.iCount_pos_iff_containsI` | `Core/Syntax.lean`:97 | erro |
| `TIF.IndeterminateExpr.iCount_substI_classical` | `Core/Syntax.lean`:233 | aberto-sorry |
| `TIF.IndeterminateExpr.not_classicalFrag_indeterminate` | `Core/Syntax.lean`:152 | fechado |
| `TIF.IndeterminateExpr.substI_classical` | `Core/Syntax.lean`:209 | fechado |
| `TIF.IndeterminateExpr.substI_indeterminate` | `Core/Syntax.lean`:223 | fechado |
| `TIF.IndeterminateExpr.wellFormed_const` | `Core/Syntax.lean`:185 | erro |
| `TIF.IndeterminateExpr.wellFormed_div_indeterminate` | `Core/Syntax.lean`:188 | aberto-sorry |
| `TIF.IndeterminateExpr.wellFormed_indeterminate` | `Core/Syntax.lean`:182 | erro |
| `TIF.TIF.TIF.adm_empty` | `Core/Eval.lean`:380 | nao_alcancado |
| `TIF.TIF.TIF.evalC_add` | `Core/Eval.lean`:425 | nao_alcancado |
| `TIF.TIF.TIF.evalC_const` | `Core/Eval.lean`:422 | nao_alcancado |
| `TIF.TIF.TIF.evalC_div` | `Core/Eval.lean`:443 | nao_alcancado |
| `TIF.TIF.TIF.evalC_div_nonzero` | `Core/Eval.lean`:449 | nao_alcancado |
| `TIF.TIF.TIF.evalC_eq_eval` | `Core/Eval.lean`:401 | nao_alcancado |
| `TIF.TIF.TIF.evalC_mul` | `Core/Eval.lean`:437 | nao_alcancado |
| `TIF.TIF.TIF.evalC_sub` | `Core/Eval.lean`:431 | nao_alcancado |
| `TIF.TIF.TIF.evalC_var` | `Core/Eval.lean`:419 | nao_alcancado |
| `TIF.TIF.TIF.eval_const` | `Core/Eval.lean`:360 | nao_alcancado |
| `TIF.TIF.TIF.eval_indet` | `Core/Eval.lean`:341 | nao_alcancado |
| `TIF.TIF.TIF.eval_var` | `Core/Eval.lean`:352 | nao_alcancado |
| `TIF.TIF.classical_stability` | `Core/Rewrite.lean`:341 | nao_alcancado |
| `TIF.TIF.collapse_correctness` | `Core/Rewrite.lean`:355 | nao_alcancado |
| `TIF.TIF.eval_classical_no_indet` | `Core/Eval.lean`:258 | nao_alcancado |
| `TIF.TIF.restricted_confluence` | `Core/Rewrite.lean`:371 | nao_alcancado |
| `TIF.TIF.wellformedness_preservation` | `Core/Rewrite.lean`:329 | nao_alcancado |
| `TIF.classical_const_stable` | `Core/Eval.lean`:144 | nao_alcancado |
| `TIF.classical_reduction` | `Core/Collapse.lean`:818 | nao_alcancado |
| `TIF.classical_term_is_expr` | `Core/Syntax.lean`:395 | fechado |
| `TIF.collapse_complete` | `Core/Collapse.lean`:73 | nao_alcancado |
| `TIF.collapse_uniqueness` | `Core/Collapse.lean`:827 | nao_alcancado |
| `TIF.const_classicalNF` | `Core/Rewrite.lean`:131 | nao_alcancado |
| `TIF.depth_subexpr_le` | `Core/Syntax.lean`:408 | erro |
| `TIF.indet_isolation` | `Core/Collapse.lean`:835 | nao_alcancado |
| `TIF.indeterminate_blockedNF` | `Core/Rewrite.lean`:144 | nao_alcancado |
| `TIF.rewrite1_depth_le` | `Core/Rewrite.lean`:193 | nao_alcancado |
| `TIF.rewrite1_preserves_wf` | `Core/Rewrite.lean`:156 | nao_alcancado |
| `TIF.rewrite1_to_star` | `Core/Rewrite.lean`:103 | nao_alcancado |
| `TIF.rewriteStar_preserves_wf` | `Core/Rewrite.lean`:185 | nao_alcancado |
| `TIF.rewriteStar_trans` | `Core/Rewrite.lean`:96 | nao_alcancado |
| `TIF.supp_empty_iff_classical` | `Core/Syntax.lean`:403 | erro |
