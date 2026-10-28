import TState.Core

namespace TState
namespace State

/-- One structural step across a distinguished boundary.
This is adjacency in the state model, not adjacency in R. -/
def structuralNext : State → Option State
  | .boundary .zero .before => some (.boundary .zero .at)
  | .boundary .zero .at => some (.boundary .zero .after)
  | .boundary .posInfinity .before => some (.boundary .posInfinity .at)
  | .boundary .posInfinity .at => some (.boundary .posInfinity .after)
  | .boundary .negInfinity .before => some (.boundary .negInfinity .at)
  | .boundary .negInfinity .at => some (.boundary .negInfinity .after)
  | _ => none

def structuralPrev : State → Option State
  | .boundary .zero .after => some (.boundary .zero .at)
  | .boundary .zero .at => some (.boundary .zero .before)
  | .boundary .posInfinity .after => some (.boundary .posInfinity .at)
  | .boundary .posInfinity .at => some (.boundary .posInfinity .before)
  | .boundary .negInfinity .after => some (.boundary .negInfinity .at)
  | .boundary .negInfinity .at => some (.boundary .negInfinity .before)
  | _ => none

@[simp] theorem next_zero_before :
    structuralNext zeroBefore = some zeroAt := rfl

@[simp] theorem next_zero_at :
    structuralNext zeroAt = some zeroAfter := rfl

@[simp] theorem next_posInfinity_before :
    structuralNext posInfinityBefore = some posInfinityAt := rfl

@[simp] theorem next_posInfinity_at :
    structuralNext posInfinityAt = some posInfinityAfter := rfl

@[simp] theorem prev_zero_after :
    structuralPrev zeroAfter = some zeroAt := rfl

end State
end TState
