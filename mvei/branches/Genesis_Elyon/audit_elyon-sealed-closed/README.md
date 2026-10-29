# Genesis_Elyon — branch `audit/elyon-sealed-closed`

Lean sources from the branch `audit/elyon-sealed-closed` of the private repository `ShantiDraconis/Genesis_Elyon`, commit `0f71ffea68ed52691201144140fb1a342d03b8d7` (2026-09-18T20:12:53+02:00), that hold theorems found only on branches (no default branch of any repository has a theorem with the same name). Published here: the files with the theorems the kernel closed, the local files they import and the Lake files of their project.

* Branch state: parada (not in the default branch).
* Theorems only on branches, in this branch: 4 — closed 4, conditional 0, open 0, proof error 0, not reached 0, no result 0.
* History: 23 commit(s) of this branch that are not in the default branch, with date and subject, in `certificate.json`.
* `certificate.json` (SHA-256 of its content: `ddff7d72bb4e84d0142e2a6032eff534d52c98090b514edb05cde54bbe16c28e`) lists every theorem with its state and the axioms beyond the standard three, and the SHA-256 of every published file. From the repository root: `sha256sum -c mvei/branches/Genesis_Elyon/audit_elyon-sealed-closed/SOURCES.sha256`.

Closed means the kernel accepted the proof and it depends only on `propext`, `Classical.choice` and `Quot.sound`; it proves the statement written in the file and is not a claim that an open problem is solved.

| Theorem | File | State |
|---|---|---|
| `certified_all_gates_enters_review_only` | `audit/elyon-sealed-closed/ElyonSealedClosed.lean`:55 | fechado |
| `certified_failed_gate_stays_sealed` | `audit/elyon-sealed-closed/ElyonSealedClosed.lean`:45 | fechado |
| `no_automatic_symbolic_approval` | `audit/elyon-sealed-closed/ElyonSealedClosed.lean`:65 | fechado |
| `uncertified_any_payload_stays_sealed` | `audit/elyon-sealed-closed/ElyonSealedClosed.lean`:37 | fechado |
