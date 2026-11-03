/-
  HodgeCore/IntermediateLemmas.lean

  Intermediate lemmas for HodgeCore in the I-framework.

  License: MIT
  Author: Indeterminate Collapse Core Project
-/

import I_foundations.Consistency
import HodgeCore.IReformulation

theorem HodgeCore_known_consistent :
    HodgeCore_known_state ≠ OpState.Indet := by
  unfold HodgeCore_known_state; intro h; cases h

theorem HodgeCore_decomposition_nontrivial :
    HodgeCore_known_state ≠ HodgeCore_state := by
  unfold HodgeCore_known_state HodgeCore_state; intro h; cases h

theorem HodgeCore_collapse_idempotent :
    Collapse HodgeCore_collapse = HodgeCore_collapse := by
  unfold Collapse HodgeCore_collapse; rfl
