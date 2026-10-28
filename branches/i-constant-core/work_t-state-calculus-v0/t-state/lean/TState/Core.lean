import Mathlib.Basic.Real.Basic

namespace TState

/-- Structural position relative to a distinguished boundary.
These are states/germs, not immediate predecessors or successors in R. -/
inductive Phase where
  | before
  | at
  | after
deriving DecidableEq, Repr

namespace Phase

def flip : Phase → Phase
  | .before => .after
  | .at => .at
  | .after => .before

@[simp] theorem flip_flip (p : Phase) : flip (flip p) = p := by
  cases p <;> rfl

end Phase

inductive Horizon where
  | negInfinity
  | zero
  | posInfinity
deriving DecidableEq, Repr

namespace Horizon

def neg : Horizon → Horizon
  | .negInfinity => .posInfinity
  | .zero => .zero
  | .posInfinity => .negInfinity

@[simp] theorem neg_neg (h : Horizon) : neg (neg h) = h := by
  cases h <;> rfl

end Horizon

/-- Standard limit-indeterminate forms plus an explicit custom research tag. -/
inductive IndeterminateForm where
  | zeroOverZero
  | infinityOverInfinity
  | zeroTimesInfinity
  | infinityMinusInfinity
  | onePowInfinity
  | zeroPowZero
  | infinityPowZero
  | custom (label : String)
deriving DecidableEq, Repr

/-- A stratified scalar state.
finite x retains ordinary real arithmetic.
boundary h p is a typed boundary/germ state.
indeterminate f records a form, not a new real number. -/
inductive State where
  | finite (x : ℝ)
  | boundary (h : Horizon) (p : Phase)
  | indeterminate (form : IndeterminateForm)

namespace State

def zeroBefore : State := .boundary .zero .before
def zeroAt : State := .boundary .zero .at
def zeroAfter : State := .boundary .zero .after

def posInfinityBefore : State := .boundary .posInfinity .before
def posInfinityAt : State := .boundary .posInfinity .at
def posInfinityAfter : State := .boundary .posInfinity .after

def negInfinityBefore : State := .boundary .negInfinity .before
def negInfinityAt : State := .boundary .negInfinity .at
def negInfinityAfter : State := .boundary .negInfinity .after

/-- Structural negation. Around zero, left/right are exchanged.
Around plus/minus infinity, horizon and orientation are both exchanged. -/
def negate : State → State
  | .finite x => .finite (-x)
  | .boundary h p => .boundary h.neg p.flip
  | .indeterminate f => .indeterminate f

@[simp] theorem negate_involutive (s : State) : negate (negate s) = s := by
  cases s with
  | finite x => simp [negate]
  | boundary h p => simp [negate]
  | indeterminate f => rfl

end State
end TState
