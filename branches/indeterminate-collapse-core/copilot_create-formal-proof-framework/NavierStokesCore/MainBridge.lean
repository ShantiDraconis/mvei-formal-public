/-
  NavierStokesCore/MainBridge.lean

  Main bridge theorem for NavierStokesCore in the I-framework.

  License: MIT
  Author: Indeterminate Collapse Core Project
-/

import I_foundations.Stability
import NavierStokesCore.IntermediateLemmas

/-- Structural bridge: the unknown component is indeterminate and the
    known component is determinate, with no contradiction. -/
theorem NavierStokesCore_I_bridge :
    IsIndeterminate NavierStokesCore_state ∧
    IsDeterminate NavierStokesCore_known_state ∧
    NavierStokesCore_known_state ≠ NavierStokesCore_state :=
  ⟨NavierStokesCore_unknown_is_indet, trivial, NavierStokesCore_decomposition_nontrivial⟩
