/-
  HEU-7 Framework: P vs NP - Critical Ordinal
  
  α_PNP = ω: The critical ordinal for P vs NP (polynomial barrier).
-/

import HEU.Core.CriticalLevel

namespace HEU.PvsNP

open HEU.Core

/-- The critical ordinal for P vs NP is ω -/
def α_PNP : Ordinal := Core.α_PNP

theorem α_PNP_eq_omega : α_PNP = omega := rfl

/-- P vs NP critical type is "omega" (finite/infinite distinction) -/
theorem α_PNP_type : criticalTypeOf "PNP" = CriticalType.omega := rfl

end HEU.PvsNP
