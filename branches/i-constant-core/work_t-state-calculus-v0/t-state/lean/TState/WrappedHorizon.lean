import TState.Boundary

namespace TState

/-- Optional experimental relation that adds exactly one wrap edge:
after +infinity -> before -infinity.
This is not asserted to be the topology or arithmetic of the extended reals. -/
inductive WrappedStep : State → State → Prop
  | structural {a b : State} :
      State.structuralNext a = some b → WrappedStep a b
  | wrap :
      WrappedStep State.posInfinityAfter State.negInfinityBefore

theorem wrapped_after_posInfinity :
    WrappedStep State.posInfinityAfter State.negInfinityBefore :=
  WrappedStep.wrap

theorem wrapped_contains_structural {a b : State}
    (h : State.structuralNext a = some b) : WrappedStep a b :=
  WrappedStep.structural h

end TState
