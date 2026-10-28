namespace FTM.WMonotone

def step (w score : Nat) : Nat :=
  Nat.succ (w + score * score)

theorem le_add_right : ∀ a b : Nat, a ≤ a + b
  | a, 0 => Nat.le_refl a
  | a, Nat.succ b => Nat.le_step (le_add_right a b)

theorem step_strictly_grows (w score : Nat) :
    w < step w score := by
  unfold step
  exact Nat.succ_le_succ (le_add_right w (score * score))

-- This theorem has no claim about networks, availability, security, or DoS.

end FTM.WMonotone
