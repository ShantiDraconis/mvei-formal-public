/-
  YangMillsCore/IntermediateLemmas.lean

  Intermediate lemmas for YangMillsCore in the I-framework.

  License: MIT
  Author: Indeterminate Collapse Core Project
-/

import I_foundations.Consistency
import YangMillsCore.IReformulation

theorem YangMillsCore_known_consistent :
    YangMillsCore_known_state ≠ OpState.Indet := by
  unfold YangMillsCore_known_state; intro h; cases h

theorem YangMillsCore_decomposition_nontrivial :
    YangMillsCore_known_state ≠ YangMillsCore_state := by
  unfold YangMillsCore_known_state YangMillsCore_state; intro h; cases h

theorem YangMillsCore_collapse_idempotent :
    Collapse YangMillsCore_collapse = YangMillsCore_collapse := by
  unfold Collapse YangMillsCore_collapse; rfl
