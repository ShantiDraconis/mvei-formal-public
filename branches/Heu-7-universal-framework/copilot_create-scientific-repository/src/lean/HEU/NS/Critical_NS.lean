/-
  HEU-7 Framework: Navier-Stokes - Critical Ordinal
  
  α_NS = ω: The critical ordinal for Navier-Stokes.
-/

import HEU.Core.CriticalLevel

namespace HEU.NS

open HEU.Core

/-- The critical ordinal for Navier-Stokes is ω -/
def α_NS : Ordinal := Core.α_NS

theorem α_NS_eq_omega : α_NS = omega := rfl

/-- NS critical type is "omega" (finite/infinite distinction) -/
theorem α_NS_type : criticalTypeOf "NS" = CriticalType.omega := rfl

end HEU.NS
