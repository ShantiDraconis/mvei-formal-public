/-
  BSDCore/IReformulation.lean

  I-framework reformulation for BSDCore.

  License: MIT
  Author: Indeterminate Collapse Core Project
-/

import I_foundations.Axioms
import I_foundations.Definitions

/-- The unknown component of this domain problem is indeterminate. -/
noncomputable def BSDCore_state : OpState Prop := OpState.Indet

/-- The known structural component is determinate. -/
noncomputable def BSDCore_known_state : OpState Prop := OpState.Det True

/-- The collapse of the unknown component. -/
noncomputable def BSDCore_collapse : OpState Prop := Collapse (OpState.Det False)

theorem BSDCore_unknown_collapses_to_I : BSDCore_collapse = OpState.Indet := by
  unfold BSDCore_collapse Collapse; rfl

theorem BSDCore_unknown_is_indet : IsIndeterminate BSDCore_state := trivial
