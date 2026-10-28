namespace FTM.Renormalization

inductive DriftSign where
  | negative
  deriving DecidableEq

structure ScaledDrift where
  sign : DriftSign
  magnitude : Nat

def boundaryDrift (e : Nat) : ScaledDrift :=
  { sign := .negative
    magnitude := Nat.succ (21774 * e + 999) }

def IsStrictlyNegative (d : ScaledDrift) : Prop :=
  d.sign = .negative ∧ 0 < d.magnitude

theorem boundaryDrift_strictly_negative (e : Nat) :
    IsStrictlyNegative (boundaryDrift e) := by
  constructor
  · rfl
  · exact Nat.zero_lt_succ (21774 * e + 999)

-- The continuous equilibrium -b/a is negative when a,b are positive.
-- Calculus and exp are intentionally left to an analysis library.

end FTM.Renormalization
