import SEETV5.Axioms
import SEETV5.Energy
import SEETV5.Safety
import SEETV5.ShowLifecycle
import SEETV5.Telemetry

namespace SEETV5

#eval repr SystemState.boot

example : ValidTransition SystemState.boot SystemState.calibration := by
  trivial

end SEETV5
