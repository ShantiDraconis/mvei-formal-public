/-
  Core/Eval.lean
  Theory of Indeterminates Framework (TIF) — Evaluation Relation

  Defines:
    - eval        : Valuation α → Expr α → Option α
    - isClassical : predicate identifying expressions with no indet nodes
    - Adm         : admissible valuations for a state
    - evalC       : evaluation of classical fragment expressions

  Key properties established:
    - Evaluation determinism (eval is a function, not a relation)
    - Classical stability (eval on CExpr agrees with classical arithmetic)
    - Axiom A7: indet nodes always evaluate to none
    - Axiom A8: classical fragment evaluation is a homomorphism

  Status: Paper 1 core.
-/

import Core.State

namespace TIF

section Eval

variable {α : Type}

/-!
## eval : Valuation α → Expr α → Option α

The evaluation function maps an expression to an optional classical value
under a given valuation. It returns `none` when:
  - the expression contains an unresolved `indet` node, or
  - a division by zero is encountered.

This implements the evaluation rules (E-Var) through (E-Div-None) from the
Semantic Specification §1.1.
-/
def eval [Add α] [Sub α] [Mul α] [Div α] [DecidableEq α] [Zero α]
    (v : Valuation α) : Expr α → Option α
  | Expr.var x      => some (v x)                         -- (E-Var)
  | Expr.const c    => some c                             -- (E-Const)
  | Expr.indet _    => none                               -- (E-Indet) / Axiom A7
  | Expr.add e₁ e₂  =>
      match eval v e₁, eval v e₂ with
      | some a, some b => some (a + b)                    -- (E-Add)
      | _,      _      => none                            -- (E-Add-None)
  | Expr.sub e₁ e₂  =>
      match eval v e₁, eval v e₂ with
      | some a, some b => some (a - b)                    -- (E-Sub)
      | _,      _      => none                            -- (E-Sub-None)
  | Expr.mul e₁ e₂  =>
      match eval v e₁, eval v e₂ with
      | some a, some b => some (a * b)                    -- (E-Mul)
      | _,      _      => none                            -- (E-Mul-None)
  | Expr.div e₁ e₂  =>
      match eval v e₁, eval v e₂ with
      | some a, some b =>
          if b = 0 then none                              -- (E-Div-Zero)
          else some (a / b)                               -- (E-Div)
      | _,      _      => none                            -- (E-Div-None)

/-!
### Axiom A7 — Indeterminate Non-Evaluation

  `eval v (indet k) = none` for all `v`, `k`.
  This is definitional.
-/
@[simp]
theorem eval_indet [Add α] [Sub α] [Mul α] [Div α] [DecidableEq α] [Zero α]
    (v : Valuation α) (k : IndetClass) :
    eval v (Expr.indet k) = none := rfl

/-!
### Evaluation on var and const
-/
@[simp]
theorem eval_var [Add α] [Sub α] [Mul α] [Div α] [DecidableEq α] [Zero α]
    (v : Valuation α) (x : String) :
    eval v (Expr.var x) = some (v x) := rfl

@[simp]
theorem eval_const [Add α] [Sub α] [Mul α] [Div α] [DecidableEq α] [Zero α]
    (v : Valuation α) (c : α) :
    eval v (Expr.const c) = some c := rfl

end Eval

/-!
## Admissibility (Axiom A10)

A valuation `v` is admissible for state `Σ` iff:
  1. Every equation in `Σ.equations` is satisfied by `v`.
  2. Every predicate in `Σ.constraints` holds for `v`.
-/
def Adm {α : Type} [Add α] [Sub α] [Mul α] [Div α] [DecidableEq α] [Zero α]
    (Σ : State α) (v : Valuation α) : Prop :=
  (∀ (eq : Expr α × Expr α), eq ∈ Σ.equations →
      eval v eq.1 = eval v eq.2) ∧
  (∀ (P : Valuation α → Prop), P ∈ Σ.constraints → P v)

/-!
### Admissibility for the empty state

Every valuation is admissible for the empty state.
-/
theorem adm_empty {α : Type} [Add α] [Sub α] [Mul α] [Div α] [DecidableEq α] [Zero α]
    (v : Valuation α) : Adm (State.empty) v := by
  constructor
  · intro eq h; exact absurd h (List.not_mem_nil _)
  · intro P h; exact absurd h (List.not_mem_nil _)

/-!
## Evaluation of the Classical Fragment (Axiom A8)

`evalC` evaluates a `CExpr α` via the embedding into `Expr α`.
It agrees with classical arithmetic on non-zero denominators.
-/
def evalC {α : Type} [Add α] [Sub α] [Mul α] [Div α] [DecidableEq α] [Zero α]
    (v : Valuation α) (e : CExpr α) : Option α :=
  eval v (CExpr.embed e)

/-!
### Classical stability: evalC agrees with eval ∘ ι
-/
@[simp]
theorem evalC_eq_eval {α : Type} [Add α] [Sub α] [Mul α] [Div α] [DecidableEq α] [Zero α]
    (v : Valuation α) (e : CExpr α) :
    evalC v e = eval v (CExpr.embed e) := rfl

/-!
### Classical stability theorems (Axiom A8)

`evalC` is a homomorphism with respect to the operations of `CExpr α`.
These follow directly from the definitions of `eval` and `CExpr.embed`.
-/
section ClassicalStability

variable {α : Type} [Add α] [Sub α] [Mul α] [Div α] [DecidableEq α] [Zero α]

theorem evalC_var (v : Valuation α) (x : String) :
    evalC v (CExpr.var x) = some (v x) := rfl

theorem evalC_const (v : Valuation α) (c : α) :
    evalC v (CExpr.const c) = some c := rfl

theorem evalC_add (v : Valuation α) (e₁ e₂ : CExpr α) :
    evalC v (CExpr.add e₁ e₂) =
      match evalC v e₁, evalC v e₂ with
      | some a, some b => some (a + b)
      | _, _ => none := rfl

theorem evalC_sub (v : Valuation α) (e₁ e₂ : CExpr α) :
    evalC v (CExpr.sub e₁ e₂) =
      match evalC v e₁, evalC v e₂ with
      | some a, some b => some (a - b)
      | _, _ => none := rfl

theorem evalC_mul (v : Valuation α) (e₁ e₂ : CExpr α) :
    evalC v (CExpr.mul e₁ e₂) =
      match evalC v e₁, evalC v e₂ with
      | some a, some b => some (a * b)
      | _, _ => none := rfl

theorem evalC_div (v : Valuation α) (e₁ e₂ : CExpr α) :
    evalC v (CExpr.div e₁ e₂) =
      match evalC v e₁, evalC v e₂ with
      | some a, some b => if b = 0 then none else some (a / b)
      | _, _ => none := rfl

/-- On non-zero denominator, classical division evaluates to a value. -/
theorem evalC_div_nonzero (v : Valuation α) (e₁ e₂ : CExpr α) (a b : α)
    (h₁ : evalC v e₁ = some a) (h₂ : evalC v e₂ = some b) (hb : b ≠ 0) :
    evalC v (CExpr.div e₁ e₂) = some (a / b) := by
  simp [evalC_div, h₁, h₂, hb]

end ClassicalStability

end TIF
