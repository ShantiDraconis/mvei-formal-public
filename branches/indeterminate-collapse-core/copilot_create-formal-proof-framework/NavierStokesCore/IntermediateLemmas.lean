/-
  NavierStokesCore/IntermediateLemmas.lean

  Intermediate lemmas for NavierStokesCore in the I-framework.

  License: MIT
  Author: Indeterminate Collapse Core Project
-/

import I_foundations.Consistency
import NavierStokesCore.IReformulation

theorem NavierStokesCore_known_consistent :
    NavierStokesCore_known_state ≠ OpState.Indet := by
  unfold NavierStokesCore_known_state; intro h; cases h

theorem NavierStokesCore_decomposition_nontrivial :
    NavierStokesCore_known_state ≠ NavierStokesCore_state := by
  unfold NavierStokesCore_known_state NavierStokesCore_state; intro h; cases h

theorem NavierStokesCore_collapse_idempotent :
    Collapse NavierStokesCore_collapse = NavierStokesCore_collapse := by
  unfold Collapse NavierStokesCore_collapse; rfl
