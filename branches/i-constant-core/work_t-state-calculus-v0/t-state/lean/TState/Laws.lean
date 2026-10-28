import TState.Arithmetic
import TState.Boundary
import TState.Bridge
import TState.LimitArithmetic
import TState.Projective

namespace TState

open State

/-- Every modeled horizon has the structural triplet before -> at -> after. -/
theorem boundary_before_to_at (h : Horizon) :
    State.structuralNext (.boundary h .before) = some (.boundary h .at) := by
  cases h <;> rfl

theorem boundary_at_to_after (h : Horizon) :
    State.structuralNext (.boundary h .at) = some (.boundary h .after) := by
  cases h <;> rfl

theorem boundary_after_to_at (h : Horizon) :
    State.structuralPrev (.boundary h .after) = some (.boundary h .at) := by
  cases h <;> rfl

/-- 0/0 and nonzero/0 are not assigned the same semantic constructor. -/
theorem zero_over_zero_classification :
    StateArithmetic.div (.finite 0) (.finite 0) =
      .exact (.indeterminate .zeroOverZero) :=
  StateArithmetic.div_zero_zero

theorem one_over_zero_classification :
    StateArithmetic.div (.finite 1) (.finite 0) =
      .family StateArithmetic.poleFamily := by
  exact StateArithmetic.div_nonzero_zero 1 one_ne_zero

/-- A bridge certificate is sufficient for endpoint validity in its model. -/
theorem bridge_certificate_closes_model
    {P : ProblemSpec} {D : EndpointPartition P}
    (c : BridgeCertificate P D) : ValidEndpoint P D :=
  c.valid

/-- A valid endpoint cannot admit a gap witness. -/
theorem validEndpoint_no_gap
    {P : ProblemSpec} {D : EndpointPartition P}
    (h : ValidEndpoint P D) : ¬ Nonempty (GapWitness P D) := by
  intro w
  rcases w with ⟨w⟩
  exact (gapWitness_refutes_exhaustive P D w) h.1

/-- A valid endpoint cannot admit an overlap witness. -/
theorem validEndpoint_no_overlap
    {P : ProblemSpec} {D : EndpointPartition P}
    (h : ValidEndpoint P D) : ¬ Nonempty (OverlapWitness P D) := by
  intro w
  rcases w with ⟨w⟩
  exact (overlapWitness_refutes_exclusive P D w) h.2.1

end TState
