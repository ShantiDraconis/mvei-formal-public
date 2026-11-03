/-
  BSDCore/IntermediateLemmas.lean

  Intermediate lemmas for BSDCore in the I-framework.

  License: MIT
  Author: Indeterminate Collapse Core Project
-/

import I_foundations.Consistency
import BSDCore.IReformulation

theorem BSDCore_known_consistent :
    BSDCore_known_state ≠ OpState.Indet := by
  unfold BSDCore_known_state; intro h; cases h

theorem BSDCore_decomposition_nontrivial :
    BSDCore_known_state ≠ BSDCore_state := by
  unfold BSDCore_known_state BSDCore_state; intro h; cases h

theorem BSDCore_collapse_idempotent :
    Collapse BSDCore_collapse = BSDCore_collapse := by
  unfold Collapse BSDCore_collapse; rfl
