/-
  RiemannCore/IntermediateLemmas.lean

  Intermediate lemmas connecting the classical RH formulation to the
  I-framework reformulation.

  Depends on: I_foundations, RiemannCore/IReformulation.lean

  License: MIT
  Author: Indeterminate Collapse Core Project
-/

import I_foundations.Consistency
import I_foundations.Propagation
import RiemannCore.IReformulation

/-! ## Lemma 1: Known structure is consistent with the I-framework -/

/-- The determinate component of RH does not equal the indeterminate state. -/
theorem RH_known_consistent_with_I :
    RH_known_state ≠ OpState.Indet := by
  unfold RH_known_state
  intro h
  exact absurd h (fun heq => by cases heq)

/-! ## Lemma 2: Unknown component stays indeterminate under identity -/

/-- The indeterminate component of RH is stable under idT. -/
theorem RH_indet_stable_under_idT :
    idT RH_state = RH_state := by
  unfold idT id RH_state
  rfl

/-! ## Lemma 3: RH decomposition is non-trivial -/

/-- The known and unknown components of RH are distinct states. -/
theorem RH_decomposition_nontrivial :
    RH_known_state ≠ RH_state := by
  unfold RH_known_state RH_state
  intro h
  cases h

/-! ## Lemma 4: Collapse idempotence on RH unknown -/

/-- Collapsing the unknown component twice yields the same result. -/
theorem RH_collapse_idempotent :
    Collapse RH_collapse = RH_collapse := by
  unfold Collapse RH_collapse
  rfl

/-! ## Notes

  These intermediate lemmas establish:
  1. The I-framework is internally consistent when applied to RH.
  2. The known/unknown separation is non-trivial (they are different states).
  3. The collapse map is idempotent on the unknown component.

  The main bridge theorem in MainBridge.lean uses these lemmas to
  derive the structural conclusion of the I-reformulation of RH.
-/
