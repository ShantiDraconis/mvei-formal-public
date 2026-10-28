import FormalSuite.I.Universal.Operations

namespace FormalSuite.I.Universal

inductive ITransition where
  | traction
  | retraction
  | twist
  | stabilize
deriving DecidableEq

def applyTransition : ITransition → IState → IState
  | .traction, x => traction x
  | .retraction, x => retraction x
  | .twist, x => twist x
  | .stabilize, x => stabilize x

theorem transition_preserves_projection (t : ITransition) (x : IState) :
    projection (applyTransition t x) = projection x := by
  cases t with
  | traction => exact traction_preserves_projection x
  | retraction => exact retraction_preserves_projection x
  | twist => exact twist_preserves_projection x
  | stabilize => rfl

theorem traction_retraction_transition (x : IState) :
    applyTransition .retraction (applyTransition .traction x) = x := by
  exact retraction_traction x

theorem retraction_traction_transition (x : IState) :
    applyTransition .traction (applyTransition .retraction x) = x := by
  exact traction_retraction x

theorem stabilize_transition_idempotent (x : IState) :
    applyTransition .stabilize (applyTransition .stabilize x) =
      applyTransition .stabilize x := by
  exact stabilize_idempotent x

end FormalSuite.I.Universal
