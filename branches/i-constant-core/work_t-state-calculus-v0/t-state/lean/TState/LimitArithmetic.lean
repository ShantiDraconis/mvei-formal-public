import TState.Arithmetic

namespace TState
namespace LimitArithmetic

open State Outcome

/-- Addition law for exact finite values and exact ideal infinities.
Directional and beyond-horizon germs remain outside this law. -/
def add : State → State → Outcome State
  | .finite x, .finite y => .exact (.finite (x + y))
  | .boundary .posInfinity .at, .boundary .negInfinity .at =>
      .exact (.indeterminate .infinityMinusInfinity)
  | .boundary .negInfinity .at, .boundary .posInfinity .at =>
      .exact (.indeterminate .infinityMinusInfinity)
  | .boundary .posInfinity .at, .boundary .posInfinity .at =>
      .exact posInfinityAt
  | .boundary .negInfinity .at, .boundary .negInfinity .at =>
      .exact negInfinityAt
  | .boundary .posInfinity .at, .finite _ => .exact posInfinityAt
  | .finite _, .boundary .posInfinity .at => .exact posInfinityAt
  | .boundary .negInfinity .at, .finite _ => .exact negInfinityAt
  | .finite _, .boundary .negInfinity .at => .exact negInfinityAt
  | _, _ => .undefined

noncomputable def mulPosInfinityFinite (x : ℝ) : Outcome State :=
  if hx0 : x = 0 then
    .exact (.indeterminate .zeroTimesInfinity)
  else if 0 < x then
    .exact posInfinityAt
  else
    .exact negInfinityAt

noncomputable def mulNegInfinityFinite (x : ℝ) : Outcome State :=
  if hx0 : x = 0 then
    .exact (.indeterminate .zeroTimesInfinity)
  else if 0 < x then
    .exact negInfinityAt
  else
    .exact posInfinityAt

/-- Multiplication law for finite values and exact ideal infinities. -/
noncomputable def mul : State → State → Outcome State
  | .finite x, .finite y => .exact (.finite (x * y))
  | .boundary .posInfinity .at, .finite x => mulPosInfinityFinite x
  | .finite x, .boundary .posInfinity .at => mulPosInfinityFinite x
  | .boundary .negInfinity .at, .finite x => mulNegInfinityFinite x
  | .finite x, .boundary .negInfinity .at => mulNegInfinityFinite x
  | .boundary .posInfinity .at, .boundary .posInfinity .at => .exact posInfinityAt
  | .boundary .negInfinity .at, .boundary .negInfinity .at => .exact posInfinityAt
  | .boundary .posInfinity .at, .boundary .negInfinity .at => .exact negInfinityAt
  | .boundary .negInfinity .at, .boundary .posInfinity .at => .exact negInfinityAt
  | _, _ => .undefined

/-- Division law records infinity/infinity as an indeterminate form.
Finite/finite division delegates to the conservative scalar law. -/
noncomputable def div : State → State → Outcome State
  | .boundary .posInfinity .at, .boundary .posInfinity .at =>
      .exact (.indeterminate .infinityOverInfinity)
  | .boundary .posInfinity .at, .boundary .negInfinity .at =>
      .exact (.indeterminate .infinityOverInfinity)
  | .boundary .negInfinity .at, .boundary .posInfinity .at =>
      .exact (.indeterminate .infinityOverInfinity)
  | .boundary .negInfinity .at, .boundary .negInfinity .at =>
      .exact (.indeterminate .infinityOverInfinity)
  | a@(.finite _), b@(.finite _) => StateArithmetic.div a b
  | _, _ => .undefined

@[simp] theorem add_opposite_infinities :
    add posInfinityAt negInfinityAt =
      .exact (.indeterminate .infinityMinusInfinity) := rfl

@[simp] theorem mul_zero_posInfinity :
    mul (.finite 0) posInfinityAt =
      .exact (.indeterminate .zeroTimesInfinity) := by
  simp [mul, mulPosInfinityFinite, State.posInfinityAt]

@[simp] theorem div_posInfinity_posInfinity :
    div posInfinityAt posInfinityAt =
      .exact (.indeterminate .infinityOverInfinity) := rfl

end LimitArithmetic
end TState
