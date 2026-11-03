/-
  YangMillsCore/MainBridge.lean

  Main bridge theorem for YangMillsCore in the I-framework.

  License: MIT
  Author: Indeterminate Collapse Core Project
-/

import I_foundations.Stability
import YangMillsCore.IntermediateLemmas

/-- Structural bridge: the unknown component is indeterminate and the
    known component is determinate, with no contradiction. -/
theorem YangMillsCore_I_bridge :
    IsIndeterminate YangMillsCore_state ∧
    IsDeterminate YangMillsCore_known_state ∧
    YangMillsCore_known_state ≠ YangMillsCore_state :=
  ⟨YangMillsCore_unknown_is_indet, trivial, YangMillsCore_decomposition_nontrivial⟩
