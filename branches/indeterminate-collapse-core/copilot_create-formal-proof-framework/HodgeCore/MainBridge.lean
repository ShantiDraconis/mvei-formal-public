/-
  HodgeCore/MainBridge.lean

  Main bridge theorem for HodgeCore in the I-framework.

  License: MIT
  Author: Indeterminate Collapse Core Project
-/

import I_foundations.Stability
import HodgeCore.IntermediateLemmas

/-- Structural bridge: the unknown component is indeterminate and the
    known component is determinate, with no contradiction. -/
theorem HodgeCore_I_bridge :
    IsIndeterminate HodgeCore_state ∧
    IsDeterminate HodgeCore_known_state ∧
    HodgeCore_known_state ≠ HodgeCore_state :=
  ⟨HodgeCore_unknown_is_indet, trivial, HodgeCore_decomposition_nontrivial⟩
