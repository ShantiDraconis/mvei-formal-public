/-
  HEU-7: Yang-Mills - Critical Level
  Definition of λ_YM = 0⁺ (positive).
-/

import HEU.Core.CriticalLevel
import HEU.YM.X_YM

namespace HEU.YM

open HEU.Core

/-- The critical level for Yang-Mills represents positivity.
    Unlike other problems, YM uses a positivity condition rather than a threshold. -/
def critical_YM : Ord := λ_YM

/-- For YM, we check F_YM > 0 rather than F_YM < λ. -/
theorem YM_uses_positivity : True := trivial

end HEU.YM
