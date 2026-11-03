/-
  HodgeCore/IReformulation.lean

  I-framework reformulation for HodgeCore.

  License: MIT
  Author: Indeterminate Collapse Core Project
-/

import I_foundations.Axioms
import I_foundations.Definitions

/-- The unknown component of this domain problem is indeterminate. -/
noncomputable def HodgeCore_state : OpState Prop := OpState.Indet

/-- The known structural component is determinate. -/
noncomputable def HodgeCore_known_state : OpState Prop := OpState.Det True

/-- The collapse of the unknown component. -/
noncomputable def HodgeCore_collapse : OpState Prop := Collapse (OpState.Det False)

theorem HodgeCore_unknown_collapses_to_I : HodgeCore_collapse = OpState.Indet := by
  unfold HodgeCore_collapse Collapse; rfl

theorem HodgeCore_unknown_is_indet : IsIndeterminate HodgeCore_state := trivial
