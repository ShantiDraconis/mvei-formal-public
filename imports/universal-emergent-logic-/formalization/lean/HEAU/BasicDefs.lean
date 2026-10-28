/-! Basic definitions for HEAU. -/

namespace HEAU

abbrev ℕ := Nat

def indicatorOne (n : ℕ) : Int := if n >= 1 then 1 else 0

end HEAU
