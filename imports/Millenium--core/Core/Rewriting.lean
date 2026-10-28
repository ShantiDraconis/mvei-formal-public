-- Core/Rewriting.lean
-- Defines the reduction relation →_R on expressions (rewriting system).
-- Part II, Section 2.4 of the Blueprint.
--
-- The rewriting system is designed to be:
--   · confluent  – any two reductions of the same expression reach the same normal form
--   · terminating – every reduction sequence is finite (for well-formed states)

import Core.Types
import Core.State

/-!
## Reduction Steps

We define a small-step reduction relation `Step` that covers the most
common algebraic simplification rules and the propagation of indeterminates.
The key design principle: indeterminates are propagated *syntactically*
(they are never silently discarded) and collapsed only when forced by state
constraints (via the `collapse` function in `Core.State`).
-/

/-- Single-step reduction relation on `Expr α`. -/
inductive Step {α : Type} [Field α] [DecidableEq α] : Expr α → Expr α → Prop where
  -- Additive identity
  | add_zero_right (e : Expr α) : Step (Expr.add e (Expr.const 0)) e
  | add_zero_left  (e : Expr α) : Step (Expr.add (Expr.const 0) e) e
  -- Multiplicative identity
  | mul_one_right  (e : Expr α) : Step (Expr.mul e (Expr.const 1)) e
  | mul_one_left   (e : Expr α) : Step (Expr.mul (Expr.const 1) e) e
  -- Annihilation
  | mul_zero_right (e : Expr α) : Step (Expr.mul e (Expr.const 0)) (Expr.const 0)
  | mul_zero_left  (e : Expr α) : Step (Expr.mul (Expr.const 0) e) (Expr.const 0)
  -- Constant folding
  | fold_add (a b : α) : Step (Expr.add (Expr.const a) (Expr.const b)) (Expr.const (a + b))
  | fold_sub (a b : α) : Step (Expr.sub (Expr.const a) (Expr.const b)) (Expr.const (a - b))
  | fold_mul (a b : α) : Step (Expr.mul (Expr.const a) (Expr.const b)) (Expr.const (a * b))
  | fold_div (a b : α) (h : b ≠ 0) :
      Step (Expr.div (Expr.const a) (Expr.const b)) (Expr.const (a / b))
  -- Subtraction self-cancellation (x - x → I under no constraints)
  -- When both sides are syntactically equal, the result is the base indeterminate.
  | sub_self (e : Expr α) :
      Step (Expr.sub e e) (Expr.indet IndetClass.base)
  -- Congruence rules (reduce inside compound expressions)
  | congr_add_left  {l l' r : Expr α} : Step l l' → Step (Expr.add l r) (Expr.add l' r)
  | congr_add_right {l r r' : Expr α} : Step r r' → Step (Expr.add l r) (Expr.add l r')
  | congr_sub_left  {l l' r : Expr α} : Step l l' → Step (Expr.sub l r) (Expr.sub l' r)
  | congr_sub_right {l r r' : Expr α} : Step r r' → Step (Expr.sub l r) (Expr.sub l r')
  | congr_mul_left  {l l' r : Expr α} : Step l l' → Step (Expr.mul l r) (Expr.mul l' r)
  | congr_mul_right {l r r' : Expr α} : Step r r' → Step (Expr.mul l r) (Expr.mul l r')
  | congr_div_left  {l l' r : Expr α} : Step l l' → Step (Expr.div l r) (Expr.div l' r)
  | congr_div_right {l r r' : Expr α} : Step r r' → Step (Expr.div l r) (Expr.div l r')

/-- Multi-step (reflexive-transitive closure) reduction. -/
inductive Reduces {α : Type} [Field α] [DecidableEq α] : Expr α → Expr α → Prop where
  | refl  (e : Expr α)                           : Reduces e e
  | trans {e₁ e₂ e₃ : Expr α}
          (h₁ : Step e₁ e₂) (h₂ : Reduces e₂ e₃) : Reduces e₁ e₃

/-!
## Normal Forms

An expression is in *normal form* (with respect to →_R) if no reduction rule
applies.  In practice, a normal form is either:
- a `const` leaf, or
- a compound expression whose sub-expressions are normal and no top-level rule fires.
-/

/-- Decide whether an expression is in normal form.
    This is a conservative syntactic check. -/
def isNormalForm {α : Type} [Field α] [DecidableEq α] [BEq α] : Expr α → Bool
  | Expr.const _         => true
  | Expr.indet _         => true
  | Expr.add (Expr.const _) (Expr.const _) => false  -- can fold
  | Expr.add (Expr.const 0) _              => false  -- add_zero_left
  | Expr.add _ (Expr.const 0)              => false  -- add_zero_right
  | Expr.add l r                           => isNormalForm l && isNormalForm r
  | Expr.sub (Expr.const _) (Expr.const _) => false
  | Expr.sub l r                           =>
    -- sub_self fires when l == r syntactically; we approximate with BEq
    if (decide (l == r)) then false
    else isNormalForm l && isNormalForm r
  | Expr.mul (Expr.const _) (Expr.const _) => false
  | Expr.mul (Expr.const 0) _              => false
  | Expr.mul _ (Expr.const 0)              => false
  | Expr.mul (Expr.const 1) _              => false
  | Expr.mul _ (Expr.const 1)              => false
  | Expr.mul l r                           => isNormalForm l && isNormalForm r
  | Expr.div (Expr.const _) (Expr.const _) => false
  | Expr.div l r                           => isNormalForm l && isNormalForm r

/-!
## Confluence (Statement)

The following states confluence (Church-Rosser property) of →_R.  The full
proof is non-trivial and is deferred to Paper 2.
-/
theorem confluence {α : Type} [Field α] [DecidableEq α]
    {e e₁ e₂ : Expr α} (h₁ : Reduces e e₁) (h₂ : Reduces e e₂) :
    ∃ e', Reduces e₁ e' ∧ Reduces e₂ e' := by
  sorry

/-!
## Termination (Statement)

Every reduction sequence starting from a well-formed expression is finite.
The proof proceeds by a measure on the expression tree (e.g., total number of
operator nodes minus the number of constant leaves), which strictly decreases
at each step.
-/
theorem termination {α : Type} [Field α] [DecidableEq α]
    (e : Expr α) : ¬ (∀ e', Step e e' → ∃ e'', Step e' e'') := by
  sorry
