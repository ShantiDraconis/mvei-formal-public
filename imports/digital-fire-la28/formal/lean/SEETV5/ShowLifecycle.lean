import SEETV5.Axioms

namespace SEETV5

def ValidTransition : SystemState → SystemState → Prop
  | .boot, .calibration => True
  | .calibration, .idle => True
  | .idle, .armed => True
  | .armed, .running => True
  | .running, .braking => True
  | .braking, .idle => True
  | .running, .fault => True
  | .fault, .shutdown => True
  | .shutdown, .boot => True
  | _, _ => False

theorem boot_to_calibration_valid :
  ValidTransition SystemState.boot SystemState.calibration := by
  trivial

end SEETV5
