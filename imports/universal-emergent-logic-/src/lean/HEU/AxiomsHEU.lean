import Mathlib
import HEU.BasicDefs
import HEU.EmergentOperators

namespace HEU

axiom universalTheta : ℝ
axiom HEU_universal_theta : ∀ S : ArithmeticSystem, hasCriticalExponent S universalTheta
axiom HEU_theta_eq_half : universalTheta = (1 / 2 : ℝ)

end HEU
