/-
  YangMills.lean - Yang-Mills Mass Gap in the Δ-Unified Framework
  
  The Yang-Mills problem asks for a rigorous construction of
  quantum Yang-Mills theory with a mass gap.
  
  In the Δ-formulation:
    X_YM = {gauge theories with compact simple gauge group G}
    Δ_YM(G) = measure of failure to have a mass gap
    
  YM Mass Gap ⟺ ∀ G compact simple, Δ_YM(G) = 0
-/

import Millennium.CoreDelta

namespace Millennium.YangMills

/-- Abstract representation of a gauge group -/
structure GaugeGroup where
  /-- Name/type of the group -/
  name : String
  /-- The group is compact -/
  compact : Bool
  /-- The group is simple (or semisimple) -/
  simple : Bool

/-- Standard gauge groups -/
def SU (n : ℕ) : GaugeGroup := ⟨s!"SU({n})", true, n ≥ 2⟩
def SO (n : ℕ) : GaugeGroup := ⟨s!"SO({n})", true, n ≥ 3⟩

/-- Yang-Mills theory configuration -/
structure YMTheory where
  /-- The gauge group -/
  G : GaugeGroup
  /-- Spacetime dimension -/
  dim : ℕ := 4

/-- The space of Yang-Mills theories with compact simple gauge groups -/
def ymTheories : Set YMTheory :=
  {ym | ym.G.compact ∧ ym.G.simple ∧ ym.dim = 4}

/-- Whether a YM theory has a mass gap (axiomatized) -/
axiom hasMassGap : YMTheory → Prop

/-- The YM deviation function -/
noncomputable def delta_YM (ym : YMTheory) : ℝ :=
  if hasMassGap ym then 0 else 1

/-- The Yang-Mills Mass Gap Conjecture -/
def YMMassGap : Prop :=
  ∀ ym ∈ ymTheories, hasMassGap ym

/-- YM in Δ-form -/
theorem YM_delta_formulation :
    YMMassGap ↔ ∀ ym ∈ ymTheories, delta_YM ym = 0 := by
  unfold YMMassGap delta_YM
  constructor
  · intro h ym hym
    simp [h ym hym]
  · intro h ym hym
    have := h ym hym
    split_ifs at this with hgap
    · exact hgap
    · norm_num at this

/-- The YM DeltaProblem structure -/
noncomputable def ymProblem : DeltaProblem YMTheory where
  X_crit := ymTheories
  delta := delta_YM
  delta_nonneg := by
    intro _ _
    unfold delta_YM
    split_ifs <;> norm_num

end Millennium.YangMills
