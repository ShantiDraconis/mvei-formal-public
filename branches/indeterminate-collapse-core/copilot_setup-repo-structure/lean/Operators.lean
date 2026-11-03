/-
  Operators.lean — Meta-Operators for the I Framework
  Indeterminate Collapse Core, v1.0.0

  Defines arithmetic-like meta-operators that operate on IState values.
  All operators propagate I (Axiom 4): if any operand is I, the result is I.
  This file imports Definitions (which imports Axioms).
-/

import «lean».Definitions

/-! # Arithmetic Meta-Operators -/

/-- Meta-addition: adds two IState values, propagating I.
    If either operand is I, the result is I. -/
def meta_add {α : Type} [Add α] : IState α → IState α → IState α
  | IState.Known x, IState.Known y => IState.Known (x + y)
  | _,              _              => IState.I

/-- Meta-multiplication: multiplies two IState values, propagating I. -/
def meta_mul {α : Type} [Mul α] : IState α → IState α → IState α
  | IState.Known x, IState.Known y => IState.Known (x * y)
  | _,              _              => IState.I

/-- Meta-subtraction: subtracts two IState values, propagating I. -/
def meta_sub {α : Type} [Sub α] : IState α → IState α → IState α
  | IState.Known x, IState.Known y => IState.Known (x - y)
  | _,              _              => IState.I

/-- Meta-negation: negates an IState value, propagating I. -/
def meta_neg {α : Type} [Neg α] : IState α → IState α
  | IState.Known x    => IState.Known (-x)
  | IState.Indeterminate => IState.I

/-! # Composition Operator -/

/-- Compose two Transformations sequentially: (T₂ ∘ T₁)(s) = T₂(T₁(s)) -/
def meta_compose {α β γ : Type}
    (T₁ : Transformation α β) (T₂ : Transformation β γ) :
    Transformation α γ :=
  fun s => T₂ (T₁ s)

/-! # Collapse Operator -/

/-- Collapse operator: maps an IState to I if the predicate p holds on the value,
    otherwise leaves it as Known. This models selective collapse.

    collapse_op p s = I         if s = I (propagation)
    collapse_op p s = I         if s = Known x and p x holds
    collapse_op p s = Known x   otherwise -/
def collapse_op {α : Type} (p : α → Bool) : IState α → IState α
  | IState.Indeterminate  => IState.I
  | IState.Known x        => if p x then IState.I else IState.Known x

/-- Total collapse: collapses any IState to I regardless of content -/
def total_collapse {α : Type} : IState α → IState (IState α)
  | _  => IState.Known IState.I

/-! # Lifting Classical Operators -/

/-- Lift a binary function f : α → α → α to IState -/
def meta_lift2 {α : Type} (f : α → α → α) : IState α → IState α → IState α
  | IState.Known x, IState.Known y => IState.Known (f x y)
  | _,              _              => IState.I

/-- Lift a unary function f : α → α to IState -/
def meta_lift1 {α : Type} (f : α → α) : IState α → IState α
  | IState.Known x    => IState.Known (f x)
  | IState.Indeterminate => IState.I

/-! # Properties of Operators -/

/-- meta_add propagates I in the first argument -/
theorem meta_add_I_left {α : Type} [Add α] (y : IState α) :
    meta_add IState.I y = IState.I := by
  simp [meta_add]

/-- meta_add propagates I in the second argument -/
theorem meta_add_I_right {α : Type} [Add α] (x : IState α) :
    meta_add x IState.I = IState.I := by
  cases x <;> simp [meta_add]

/-- meta_mul propagates I in the first argument -/
theorem meta_mul_I_left {α : Type} [Mul α] (y : IState α) :
    meta_mul IState.I y = IState.I := by
  simp [meta_mul]

/-- meta_mul propagates I in the second argument -/
theorem meta_mul_I_right {α : Type} [Mul α] (x : IState α) :
    meta_mul x IState.I = IState.I := by
  cases x <;> simp [meta_mul]

/-- meta_compose preserves I -/
theorem meta_compose_preserves_I {α β γ : Type}
    (T₁ : Transformation α β) (T₂ : Transformation β γ)
    (h₁ : IPropagating T₁) (h₂ : IPropagating T₂) :
    IPropagating (meta_compose T₁ T₂) := by
  simp [IPropagating, meta_compose, h₁, h₂]

/-- collapse_op always propagates I -/
theorem collapse_op_preserves_I {α : Type} (p : α → Bool) :
    (collapse_op p) IState.I = IState.I := rfl

/-- meta_lift2 is I-propagating in first argument -/
theorem meta_lift2_I_left {α : Type} (f : α → α → α) (y : IState α) :
    meta_lift2 f IState.I y = IState.I := by
  simp [meta_lift2]

/-- meta_lift1 is I-propagating -/
theorem meta_lift1_I {α : Type} (f : α → α) :
    meta_lift1 f IState.I = IState.I := rfl
