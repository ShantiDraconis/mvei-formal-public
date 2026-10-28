import SEETV5.Axioms

namespace SEETV5

theorem recovery_less_than_or_equal_input
  (input : PowerInput)
  (recovered : PowerRecovered)
  (h : dissipative input recovered) :
  recovered.watts ≤ input.watts := h

theorem zero_recovery_is_dissipative
  (input : PowerInput) :
  dissipative input { watts := 0 } := by
  simp [dissipative]

end SEETV5
