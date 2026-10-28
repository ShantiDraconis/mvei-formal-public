import TState.Core
import TState.Outcome

namespace TState
namespace StateArithmetic

open State Outcome

def poleFamily : StateSet State :=
  fun s => s = negInfinityAt ∨ s = posInfinityAt

/-- Conservative addition: ordinary finite addition is exact.
Other cases stay explicitly undefined until a law is supplied. -/
def add : State → State → Outcome State
  | .finite x, .finite y => .exact (.finite (x + y))
  | _, _ => .undefined

/-- Conservative multiplication: ordinary finite multiplication is exact. -/
def mul : State → State → Outcome State
  | .finite x, .finite y => .exact (.finite (x * y))
  | _, _ => .undefined

/-- Division separates 0/0 from nonzero/0.
Without a directional germ, nonzero/0 is a two-pole family. -/
noncomputable def div : State → State → Outcome State
  | .finite x, .finite y =>
      if hy : y = 0 then
        if hx : x = 0 then
          .exact (.indeterminate .zeroOverZero)
        else
          .family poleFamily
      else
        .exact (.finite (x / y))
  | _, _ => .undefined

/-- Directional reciprocal on analytic boundary germs.
Beyond-infinity states intentionally have no arithmetic semantics here. -/
noncomputable def analyticInv : State → Outcome State
  | .finite x =>
      if x = 0 then .family poleFamily
      else .exact (.finite x⁻¹)
  | .boundary .zero .before => .exact negInfinityAfter
  | .boundary .zero .after => .exact posInfinityBefore
  | .boundary .negInfinity .after => .exact zeroBefore
  | .boundary .posInfinity .before => .exact zeroAfter
  | .boundary .negInfinity .at => .exact zeroAt
  | .boundary .posInfinity .at => .exact zeroAt
  | .boundary .zero .at => .family poleFamily
  | _ => .undefined

@[simp] theorem add_finite (x y : ℝ) :
    add (.finite x) (.finite y) = .exact (.finite (x + y)) := rfl

@[simp] theorem mul_finite (x y : ℝ) :
    mul (.finite x) (.finite y) = .exact (.finite (x * y)) := rfl

@[simp] theorem div_zero_zero :
    div (.finite 0) (.finite 0) =
      .exact (.indeterminate .zeroOverZero) := by
  simp [div]

theorem div_nonzero_zero (x : ℝ) (hx : x ≠ 0) :
    div (.finite x) (.finite 0) = .family poleFamily := by
  simp [div, hx]

theorem div_finite_nonzero (x y : ℝ) (hy : y ≠ 0) :
    div (.finite x) (.finite y) = .exact (.finite (x / y)) := by
  simp [div, hy]

@[simp] theorem inv_zero_before :
    analyticInv zeroBefore = .exact negInfinityAfter := rfl

@[simp] theorem inv_zero_after :
    analyticInv zeroAfter = .exact posInfinityBefore := rfl

@[simp] theorem inv_posInfinity_before :
    analyticInv posInfinityBefore = .exact zeroAfter := rfl

@[simp] theorem inv_negInfinity_after :
    analyticInv negInfinityAfter = .exact zeroBefore := rfl

end StateArithmetic
end TState
