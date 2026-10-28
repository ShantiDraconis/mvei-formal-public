import Mathlib
import HEU.BasicDefs

namespace HEU

/-- Re-express emergent operator for convenience. -/
@[simp] def E (S : ArithmeticSystem) (x : ℝ) : ℝ := emergentOperator S x

/-- Wrapper predicate for critical exponent. -/
def criticalExponent (S : ArithmeticSystem) (θ : ℝ) : Prop := hasCriticalExponent S θ

end HEU
