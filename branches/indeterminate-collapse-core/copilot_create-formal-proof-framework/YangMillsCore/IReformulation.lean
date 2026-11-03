/-
  YangMillsCore/IReformulation.lean

  I-framework reformulation for YangMillsCore.

  License: MIT
  Author: Indeterminate Collapse Core Project
-/

import I_foundations.Axioms
import I_foundations.Definitions

/-- The unknown component of this domain problem is indeterminate. -/
noncomputable def YangMillsCore_state : OpState Prop := OpState.Indet

/-- The known structural component is determinate. -/
noncomputable def YangMillsCore_known_state : OpState Prop := OpState.Det True

/-- The collapse of the unknown component. -/
noncomputable def YangMillsCore_collapse : OpState Prop := Collapse (OpState.Det False)

theorem YangMillsCore_unknown_collapses_to_I : YangMillsCore_collapse = OpState.Indet := by
  unfold YangMillsCore_collapse Collapse; rfl

theorem YangMillsCore_unknown_is_indet : IsIndeterminate YangMillsCore_state := trivial
