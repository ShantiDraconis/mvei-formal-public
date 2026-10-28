/-!
Unified USSF/Millennium lock layer.

This file formalizes statuses and obligations, not proofs of the open Clay
problems.
-/

namespace MillenniumLocks

inductive BehaviorState where
  | defined
  | derived
  | testable
  | conjectural
  | blocked
deriving DecidableEq, Repr

inductive Problem where
  | RH | PNP | NS | YM | BSD | Hodge | Poincare
deriving DecidableEq, Repr

def state : Problem → BehaviorState
  | .RH => .blocked
  | .PNP => .blocked
  | .NS => .conjectural
  | .YM => .conjectural
  | .BSD => .blocked
  | .Hodge => .blocked
  | .Poincare => .defined

theorem rh_not_claimed_solved : state Problem.RH = BehaviorState.blocked := by
  rfl

theorem ns_ussf_is_conjectural : state Problem.NS = BehaviorState.conjectural := by
  rfl

end MillenniumLocks
