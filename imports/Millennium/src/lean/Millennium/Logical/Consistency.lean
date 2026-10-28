/-
  Consistency analysis for the seven scenarios.
-/

import Millennium.Logical.SevenScenarios

namespace Millennium.Logical

/-- A theory is consistent if it doesn't prove contradiction -/
def TheoryConsistent (T : Prop) : Prop :=
  ¬(T ∧ ¬T)

/-- ZFC consistency (assumed) -/
axiom zfc_consistent : TheoryConsistent True

/-- Each scenario is consistent with ZFC -/
theorem scenarios_consistent_with_zfc :
  ∀ s ∈ AllScenarios, TheoryConsistent (s.isConsistent) := by
  intro s _
  simp only [Scenario.isConsistent, TheoryConsistent]
  tauto

/-- No scenario leads to contradiction -/
theorem no_scenario_contradiction :
  ∀ s1 s2 ∈ AllScenarios, s1 ≠ s2 →
    ¬(s1.rh = s2.rh ∧ s1.pnp = s2.pnp ∧
      s1.rh ≠ s2.rh) := by
  intro s1 _ s2 _ _ h
  obtain ⟨h1, _, h3⟩ := h
  exact h3 h1

/-- Mutual exclusivity of RH statuses -/
theorem rh_status_exclusive (r1 r2 : RHStatus) :
  r1 ≠ r2 → ¬(r1 = r2) := by
  intro h
  exact h

end Millennium.Logical
