/-
  NavierStokesCore/IReformulation.lean

  I-framework reformulation for NavierStokesCore.

  License: MIT
  Author: Indeterminate Collapse Core Project
-/

import I_foundations.Axioms
import I_foundations.Definitions

/-- The unknown component of this domain problem is indeterminate. -/
noncomputable def NavierStokesCore_state : OpState Prop := OpState.Indet

/-- The known structural component is determinate. -/
noncomputable def NavierStokesCore_known_state : OpState Prop := OpState.Det True

/-- The collapse of the unknown component. -/
noncomputable def NavierStokesCore_collapse : OpState Prop := Collapse (OpState.Det False)

theorem NavierStokesCore_unknown_collapses_to_I : NavierStokesCore_collapse = OpState.Indet := by
  unfold NavierStokesCore_collapse Collapse; rfl

theorem NavierStokesCore_unknown_is_indet : IsIndeterminate NavierStokesCore_state := trivial
