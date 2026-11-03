/-
  ComplexityCore/IReformulation.lean

  I-framework reformulation for ComplexityCore.

  License: MIT
  Author: Indeterminate Collapse Core Project
-/

import I_foundations.Axioms
import I_foundations.Definitions

/-- The unknown component of this domain problem is indeterminate. -/
noncomputable def ComplexityCore_state : OpState Prop := OpState.Indet

/-- The known structural component is determinate. -/
noncomputable def ComplexityCore_known_state : OpState Prop := OpState.Det True

/-- The collapse of the unknown component. -/
noncomputable def ComplexityCore_collapse : OpState Prop := Collapse (OpState.Det False)

theorem ComplexityCore_unknown_collapses_to_I : ComplexityCore_collapse = OpState.Indet := by
  unfold ComplexityCore_collapse Collapse; rfl

theorem ComplexityCore_unknown_is_indet : IsIndeterminate ComplexityCore_state := trivial
