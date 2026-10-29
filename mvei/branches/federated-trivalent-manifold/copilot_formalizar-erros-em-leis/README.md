# federated-trivalent-manifold — branch `copilot/formalizar-erros-em-leis`

Lean sources from the branch `copilot/formalizar-erros-em-leis` of the private repository `ShantiDraconis/federated-trivalent-manifold`, commit `1f75acedead2db4f6339a427c7551196bcc59f8d` (2026-07-15T11:03:46+00:00), that hold theorems found only on branches (no default branch of any repository has a theorem with the same name). Published here: the files with the theorems the kernel closed, the local files they import and the Lake files of their project.

* Branch state: parada (not in the default branch).
* Theorems only on branches, in this branch: 26 — closed 7, conditional 10, open 4, proof error 1, not reached 4, no result 0.
* History: 1 commit(s) of this branch that are not in the default branch, with date and subject, in `certificate.json`.
* `certificate.json` (SHA-256 of its content: `d04ef8ca0f93b4fd3bab630266171c76f265e0f8b58ffa4457cc15339f58e941`) lists every theorem with its state and the axioms beyond the standard three, and the SHA-256 of every published file. From the repository root: `sha256sum -c mvei/branches/federated-trivalent-manifold/copilot_formalizar-erros-em-leis/SOURCES.sha256`.

Closed means the kernel accepted the proof and it depends only on `propext`, `Classical.choice` and `Quot.sound`; it proves the statement written in the file and is not a claim that an open problem is solved.

| Theorem | File | State |
|---|---|---|
| `Pesquisa.cada_erro_vira_regra` | `lean/Pesquisa.lean`:73 | nao_alcancado |
| `Pesquisa.colapso_com_novo_axioma` | `lean/Pesquisa.lean`:105 | nao_alcancado |
| `Pesquisa.regime_e_meio` | `lean/Pesquisa.lean`:83 | nao_alcancado |
| `Pesquisa.sem_novo_axioma_regime_e_meio` | `lean/Pesquisa.lean`:110 | nao_alcancado |
| `Regra1.teardown_idempotente` | `lean/Regra1.lean`:35 | fechado |
| `Regra1.teardown_obrigatorio` | `lean/Regra1.lean`:26 | fechado |
| `Regra2.cifracao_obrigatoria` | `lean/Regra2.lean`:37 | condicional |
| `Regra2.exodus_nao_perde_dados` | `lean/Regra2.lean`:44 | condicional |
| `Regra3.separacao_gpt_claude_llama` | `lean/Regra3.lean`:47 | condicional |
| `Regra3.separacao_llama_claude` | `lean/Regra3.lean`:53 | condicional |
| `Regra3.separacao_llama_gpt_claude` | `lean/Regra3.lean`:40 | condicional |
| `Regra3.todos_dominios_distintos` | `lean/Regra3.lean`:59 | condicional |
| `Regra4.corolario_novo_axioma_necessario` | `lean/Regra4.lean`:59 | aberto-sorry |
| `Regra4.regra4_barreira` | `lean/Regra4.lean`:52 | aberto-sorry |
| `Regra5.integral_monotone` | `lean/Regra5.lean`:52 | fechado |
| `Regra5.regime_meio_implica_integral_positivo` | `lean/Regra5.lean`:61 | condicional |
| `Regra5.sistema_nao_colapsa_sem_novo_axioma` | `lean/Regra5.lean`:43 | condicional |
| `Regra6.rh_from_axiom` | `lean/Regra6.lean`:57 | condicional |
| `Regra6.zero_nontrivial_re_um_meio` | `lean/Regra6.lean`:47 | condicional |
| `Regra7.conj_comm` | `lean/Regra7.lean`:54 | aberto-sorry |
| `Regra7.disj_comm` | `lean/Regra7.lean`:57 | aberto-sorry |
| `Regra7.meio_nao_e_falso` | `lean/Regra7.lean`:60 | fechado |
| `Regra7.meio_nao_e_verdade` | `lean/Regra7.lean`:63 | fechado |
| `Regra7.neg_neg` | `lean/Regra7.lean`:49 | erro |
| `Regra7.poincare_provado` | `lean/Regra7.lean`:91 | fechado |
| `Regra7.pvsnp_aberto` | `lean/Regra7.lean`:93 | fechado |
