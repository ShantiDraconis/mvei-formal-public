/-
  HEU-7: BSD Conjecture - Critical Level
  Definition of λ_BSD = 0.
-/

import HEU.Core.CriticalLevel
import HEU.BSD.X_BSD

namespace HEU.BSD

open HEU.Core

/-- The critical level for BSD is 0. -/
def critical_BSD : Ord := λ_BSD

/-- λ_BSD = 0 by definition. -/
theorem critical_BSD_eq_zero : critical_BSD = 0 := rfl

/-- For BSD, we use equality (= 0) like RH. -/
theorem BSD_uses_equality : critical_BSD = 0 := rfl

end HEU.BSD
