/-
  HEU-7 Framework: Yang-Mills - Critical Ordinal
  
  α_YM = 1: The critical ordinal for Yang-Mills (positive mass).
-/

import HEU.Core.CriticalLevel

namespace HEU.YM

open HEU.Core

/-- The critical ordinal for Yang-Mills is 1 -/
def α_YM : Ordinal := Core.α_YM

theorem α_YM_eq_one : α_YM = 1 := rfl

/-- The critical ordinal is finite -/
theorem α_YM_finite : α_YM < omega := by
  rw [α_YM_eq_one]
  exact Ordinal.one_lt_omega

/-- YM critical type is "one" (binary distinction) -/
theorem α_YM_type : criticalTypeOf "YM" = CriticalType.one := rfl

end HEU.YM
