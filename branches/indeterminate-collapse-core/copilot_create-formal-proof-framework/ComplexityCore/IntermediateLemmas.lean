/-
  ComplexityCore/IntermediateLemmas.lean

  Intermediate lemmas for ComplexityCore in the I-framework.

  License: MIT
  Author: Indeterminate Collapse Core Project
-/

import I_foundations.Consistency
import ComplexityCore.IReformulation

theorem ComplexityCore_known_consistent :
    ComplexityCore_known_state ≠ OpState.Indet := by
  unfold ComplexityCore_known_state; intro h; cases h

theorem ComplexityCore_decomposition_nontrivial :
    ComplexityCore_known_state ≠ ComplexityCore_state := by
  unfold ComplexityCore_known_state ComplexityCore_state; intro h; cases h

theorem ComplexityCore_collapse_idempotent :
    Collapse ComplexityCore_collapse = ComplexityCore_collapse := by
  unfold Collapse ComplexityCore_collapse; rfl
