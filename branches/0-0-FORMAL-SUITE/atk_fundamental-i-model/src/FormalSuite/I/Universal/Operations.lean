import FormalSuite.I.Universal.FundamentalIModel

namespace FormalSuite.I.Universal

/-- Enriched addition: classical value adds, hidden state combines internally. -/
def iAdd (x y : IState) : IState := (x.1 && y.1, x.2 + y.2)

/-- Enriched multiplication: classical value multiplies, hidden state combines internally. -/
def iMul (x y : IState) : IState := (x.1 && y.1, x.2 * y.2)

/-- Enriched negation preserves hidden state and negates the classical projection. -/
def iNeg (x : IState) : IState := (x.1, -x.2)

theorem projection_iAdd (x y : IState) :
    projection (iAdd x y) = projection x + projection y := by
  rfl

theorem projection_iMul (x y : IState) :
    projection (iMul x y) = projection x * projection y := by
  rfl

theorem projection_iNeg (x : IState) :
    projection (iNeg x) = - projection x := by
  rfl

theorem embedReal_add (a b : ℝ) :
    iAdd (embedReal a) (embedReal b) = embedReal (a + b) := by
  rfl

theorem embedReal_mul (a b : ℝ) :
    iMul (embedReal a) (embedReal b) = embedReal (a * b) := by
  rfl

theorem embedReal_neg (a : ℝ) :
    iNeg (embedReal a) = embedReal (-a) := by
  rfl

end FormalSuite.I.Universal
