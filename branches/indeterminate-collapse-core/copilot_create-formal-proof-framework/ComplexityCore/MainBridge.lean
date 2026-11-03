/-
  ComplexityCore/MainBridge.lean

  Main bridge theorem for ComplexityCore in the I-framework.

  License: MIT
  Author: Indeterminate Collapse Core Project
-/

import I_foundations.Stability
import ComplexityCore.IntermediateLemmas

/-- Structural bridge: the unknown component is indeterminate and the
    known component is determinate, with no contradiction. -/
theorem ComplexityCore_I_bridge :
    IsIndeterminate ComplexityCore_state ∧
    IsDeterminate ComplexityCore_known_state ∧
    ComplexityCore_known_state ≠ ComplexityCore_state :=
  ⟨ComplexityCore_unknown_is_indet, trivial, ComplexityCore_decomposition_nontrivial⟩
