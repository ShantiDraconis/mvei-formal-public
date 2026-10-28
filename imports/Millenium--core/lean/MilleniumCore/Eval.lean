/-
  MilleniumCore.Eval

  Defines the evaluation function

      eval : VarValuation α → IndetValuation α → Expr α → Option α

  for the scalar fragment of ℒ_I.

  Corresponds to:
    Semantic Specification, §4 (The Evaluation Function)
    Axiom Sheet v1.2, §4 (Key Definitions — admissible valuation, value set)

  Design notes:
  - The return type is `Option α` (not `α`), reflecting that an expression
    containing an unresolved indeterminate class evaluates to `none` (no
    classical value), not to a classical scalar.
  - Division by zero returns `none` (blocked), consistent with A2 and A8:
    the 0/0 configuration does not silently collapse to any classical value.
  - On the classical fragment (no `indet` constructors), `eval` agrees with
    the standard field interpretation whenever all subexpressions are defined
    (A13 / Semantic Specification §8).
-/

import MilleniumCore.State

namespace MilleniumCore

/-- The lifted binary operator table.

    Given optional classical values for left and right operands, and a
    classical binary operation `op`, attempt to compute the result.
    Returns `none` if either operand is unresolved or the operation is
    undefined (e.g., division by zero). -/
private def liftBinop {α : Type*} (op : α → α → Option α)
    (l r : Option α) : Option α :=
  match l, r with
  | some a, some b => op a b
  | _, _ => none

section
variable {α : Type*} [Field α] [DecidableEq α]

/-- The evaluation function for the scalar fragment.

    Parameters:
    - `v`  : variable valuation v : Var → α
    - `η`  : indeterminate valuation η : {𝒥ₖ} ⇀ α
    - `e`  : expression to evaluate

    Returns `some c` if e evaluates to the classical scalar `c` under (v, η);
    returns `none`   if any indeterminate class is unresolved or a division
    by zero is encountered.

    Semantic Specification, §4:
      Eval_{v,η}(x)        = v(x)
      Eval_{v,η}(c)        = c
      Eval_{v,η}(I)        = η(𝒥₀)   -- some c if resolved, none otherwise
      Eval_{v,η}(e₁ ∘ e₂) = lifted ∘ applied to Eval_{v,η}(e₁), Eval_{v,η}(e₂)
-/
def eval (v : VarValuation α) (η : IndetValuation α) : Expr α → Option α
  | .var n        => some (v n)
  | .const c      => some c
  | .indet k      => η k
  | .add e₁ e₂   => liftBinop (fun a b => some (a + b)) (eval v η e₁) (eval v η e₂)
  | .sub e₁ e₂   => liftBinop (fun a b => some (a - b)) (eval v η e₁) (eval v η e₂)
  | .mul e₁ e₂   => liftBinop (fun a b => some (a * b)) (eval v η e₁) (eval v η e₂)
  | .div e₁ e₂   => liftBinop (fun a b => if b = 0 then none else some (a / b))
                               (eval v η e₁) (eval v η e₂)

end

/-!
## Semantic Value Set

The semantic value set ⟦e⟧_Σ is, in principle, the set of all classical
values produced by admissible valuations for Σ.  For the Lean skeleton v1,
we represent a single evaluation against a concrete state (single valuation).
Full set-based semantics (quantifying over all admissible valuations) will
be added in a future version alongside the Finset / Set API.
-/

/-- Evaluate an expression against the concrete valuation derived from a state.

    This is a single-valuation approximation of ⟦e⟧_Σ suitable for the
    collapse functions in Collapse.lean.  It uses the state's bindings
    directly and a default classical zero for unbound variables. -/
def evalState {α : Type*} [Field α] [DecidableEq α]
    (s : State α) (dflt : α) (e : Expr α) : Option α :=
  eval (s.toVarValuation dflt) (s.toIndetValuation) e

end MilleniumCore
