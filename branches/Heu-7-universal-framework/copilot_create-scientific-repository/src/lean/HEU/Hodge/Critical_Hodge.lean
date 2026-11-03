/-
  HEU-7 Framework: Hodge Conjecture - Critical Ordinal
  
  α_Hodge = ω: The critical ordinal for Hodge.
-/

import HEU.Core.CriticalLevel

namespace HEU.Hodge

open HEU.Core

/-- The critical ordinal for Hodge is ω -/
def α_Hodge : Ordinal := Core.α_Hodge

theorem α_Hodge_eq_omega : α_Hodge = omega := rfl

/-- Hodge critical type is "omega" (finite/infinite distinction) -/
theorem α_Hodge_type : criticalTypeOf "Hodge" = CriticalType.omega := rfl

end HEU.Hodge
