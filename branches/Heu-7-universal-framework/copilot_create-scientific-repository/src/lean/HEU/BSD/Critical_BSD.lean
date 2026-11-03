/-
  HEU-7 Framework: BSD - Critical Ordinal
  
  α_BSD(E) = rank(E(ℚ)): The critical ordinal varies with the curve.
-/

import HEU.Core.CriticalLevel
import HEU.BSD.X_BSD

namespace HEU.BSD

open HEU.Core

/-- The critical ordinal for BSD depends on the curve -/
def α_BSD (E : EllipticCurveQ) : Ordinal := 
  Core.α_BSD (algebraicRank E)

/-- BSD critical type is "variable" (depends on object) -/
theorem α_BSD_type : criticalTypeOf "BSD" = CriticalType.variable := rfl

end HEU.BSD
