/-
  BSDCore/MainBridge.lean

  Main bridge theorem for BSDCore in the I-framework.

  License: MIT
  Author: Indeterminate Collapse Core Project
-/

import I_foundations.Stability
import BSDCore.IntermediateLemmas

/-- Structural bridge: the unknown component is indeterminate and the
    known component is determinate, with no contradiction. -/
theorem BSDCore_I_bridge :
    IsIndeterminate BSDCore_state ∧
    IsDeterminate BSDCore_known_state ∧
    BSDCore_known_state ≠ BSDCore_state :=
  ⟨BSDCore_unknown_is_indet, trivial, BSDCore_decomposition_nontrivial⟩
