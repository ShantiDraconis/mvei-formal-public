/-!
# MilleniumCore.Core — Lean Core Skeleton v1

This file implements the data types and functions described in the Semantic
Specification (scalar fragment of the Indeterminate Framework 𝒯_I).

## Structure

* `IndetClass`           — labelled indeterminate class ℐ_k
* `Expr α`               — expressions of 𝒯_I over a scalar type α
* `EvalResult α`         — result of evaluation: a classical scalar or an
                            unresolved indeterminate class
* `State α`              — a state Σ = (ℰ, 𝒞) (equality-set fragment)
* `VarValuation α`       — v : Var → α
* `IndetValuation α`     — η : IndetClass →? α  (represented as `IndetClass → Option α`)
* `applyOp`              — extended binary arithmetic on EvalResult
* `eval`                 — evaluation function Eval_{v,η}
* `collapse`             — operational collapse Collapse^op_Σ (returns `Option α`)

## Typeclass requirements

The scalar type α carries only basic arithmetic typeclasses
(`Add`, `Sub`, `Mul`, `Div`, `Zero`, `DecidableEq`) so that the file compiles
without importing Mathlib.  Concretely α = `Float`, `Rat`, or `Complex Float`.

## Notes

* Variables are represented as `String` names for readability.
* The `div` case follows A2: any division by zero produces `ℐ_0` (the 0/0 class).
* `collapse` corresponds to Collapse^op_Σ: returns `some v` on unique resolution,
  `none` in place of ⊥.

See `docs/semantic-specification.md` and `docs/axiom-sheet-v1.2.md` for the
mathematical definitions these types implement.
-/

namespace MilleniumCore

-- ---------------------------------------------------------------------------
-- 1. Indeterminate classes
-- ---------------------------------------------------------------------------

/-- An indeterminate class ℐ_k, identified by a natural-number index.
    In the scalar fragment only ℐ_0 ("the 0/0 origin class") is used. -/
inductive IndetClass : Type where
  /-- ℐ_k for index k. -/
  | mk (k : Nat) : IndetClass
  deriving Repr, BEq, DecidableEq

namespace IndetClass

/-- The canonical "0/0" indeterminate class ℐ_0. -/
def zero : IndetClass := .mk 0

instance : Inhabited IndetClass := ⟨zero⟩

end IndetClass

-- ---------------------------------------------------------------------------
-- 2. Expressions
-- ---------------------------------------------------------------------------

/-- The expression type `Expr α` for the scalar fragment of 𝒯_I.

    Constructors:
    * `var s`        — variable with name `s`
    * `const c`      — classical constant `c ∈ α`
    * `indet k`      — indeterminate symbol ℐ_k
    * `add e₁ e₂`   — e₁ +_I e₂
    * `sub e₁ e₂`   — e₁ -_I e₂
    * `mul e₁ e₂`   — e₁ ×_I e₂
    * `div e₁ e₂`   — e₁ ÷_I e₂
-/
inductive Expr (α : Type) : Type where
  | var   : String    → Expr α
  | const : α         → Expr α
  | indet : IndetClass → Expr α
  | add   : Expr α → Expr α → Expr α
  | sub   : Expr α → Expr α → Expr α
  | mul   : Expr α → Expr α → Expr α
  | div   : Expr α → Expr α → Expr α
  deriving Repr

-- ---------------------------------------------------------------------------
-- 3. Evaluation result
-- ---------------------------------------------------------------------------

/-- The result of evaluating an expression: either a classical scalar or an
    unresolved indeterminate class. -/
inductive EvalResult (α : Type) : Type where
  | scalar : α          → EvalResult α
  | indet  : IndetClass → EvalResult α
  deriving Repr

-- ---------------------------------------------------------------------------
-- 4. States
-- ---------------------------------------------------------------------------

/-- A state Σ = (ℰ, 𝒞).

    In this skeleton the constraint set 𝒞 (formula-level) is not yet
    mechanized; it will be added with the formula layer.  The equality set ℰ
    is represented as a list of expression pairs (lhs, rhs) asserting lhs = rhs. -/
structure State (α : Type) : Type where
  /-- The equality set ℰ: list of pairs (t, t') asserting t = t'. -/
  equalities : List (Expr α × Expr α)
  deriving Repr

namespace State

/-- The empty state Σ = (∅, ∅). -/
def empty : State α := { equalities := [] }

instance : Inhabited (State α) := ⟨empty⟩

end State

-- ---------------------------------------------------------------------------
-- 5. Valuations
-- ---------------------------------------------------------------------------

/-- A variable valuation `v : VarValuation α` is a total function from
    variable names to classical scalars. -/
def VarValuation (α : Type) := String → α

/-- An indeterminate valuation `η : IndetValuation α` optionally assigns a
    classical scalar to each indeterminate class.
    `η k = none`   means ℐ_k is *unresolved*.
    `η k = some c` means ℐ_k is *resolved* to the value `c`. -/
def IndetValuation (α : Type) := IndetClass → Option α

-- ---------------------------------------------------------------------------
-- 6. Evaluation
-- ---------------------------------------------------------------------------

section Eval

/-  We require:
    * `Add`, `Sub`, `Mul`, `Div` for the four extended operators.
    * `Zero` so that we can test divisors against 0.
    * `DecidableEq` so that equality of scalars is decidable (used in collapse). -/
variable {α : Type} [Add α] [Sub α] [Mul α] [Div α] [Zero α] [DecidableEq α]

/-- `applyOp op isDivision l r` — lift a binary classical operation to `EvalResult`.

    Rules:
    * (scalar, scalar) in non-division mode → apply `op` classically.
    * (scalar a, scalar 0) in division mode → produce ℐ_0  (implements A2 / Def 3.1).
    * (scalar a, scalar b≠0) in division mode → apply `op` classically.
    * Any operand is an unresolved indeterminate → propagate the indeterminate
      (left operand takes priority if both are indeterminate). -/
def applyOp
    (op : α → α → α)
    (isDivision : Bool)
    (l r : EvalResult α) : EvalResult α :=
  match l, r with
  | .scalar a, .scalar b =>
    if isDivision && (b == 0) then
      .indet IndetClass.zero
    else
      .scalar (op a b)
  | .indet k, _ => .indet k
  | _,         .indet k => .indet k

/-- The evaluation function `eval v η e = Eval_{v,η}(e)`.

    * Variables look up their value in `v`.
    * Classical constants evaluate to themselves.
    * An indeterminate class ℐ_k evaluates to `η k` if resolved, else stays as ℐ_k.
    * Binary operators delegate to `applyOp`. -/
def eval (v : VarValuation α) (η : IndetValuation α) : Expr α → EvalResult α
  | .var   s    => .scalar (v s)
  | .const c    => .scalar c
  | .indet k    =>
      match η k with
      | some c => .scalar c
      | none   => .indet k
  | .add   l r  => applyOp (· + ·) false (eval v η l) (eval v η r)
  | .sub   l r  => applyOp (· - ·) false (eval v η l) (eval v η r)
  | .mul   l r  => applyOp (· * ·) false (eval v η l) (eval v η r)
  | .div   l r  => applyOp (· / ·) true  (eval v η l) (eval v η r)

end Eval

-- ---------------------------------------------------------------------------
-- 7. Collapse
-- ---------------------------------------------------------------------------

section Collapse

variable {α : Type} [Add α] [Sub α] [Mul α] [Div α] [Zero α] [DecidableEq α]

/-- Check whether a valuation pair `(v, η)` satisfies all equalities in
    state `σ` (the ℰ component of Σ). -/
def satisfiesState
    (v : VarValuation α) (η : IndetValuation α) (σ : State α) : Bool :=
  σ.equalities.all fun ⟨lhs, rhs⟩ =>
    match eval v η lhs, eval v η rhs with
    | .scalar a, .scalar b => a == b
    | .indet k₁, .indet k₂ => k₁ == k₂
    | _,         _          => false

/-- `collapse σ candidates e` — Operational collapse `Collapse^op_Σ(e)`.

    Given a finite list of candidate valuation pairs `candidates` (a finite
    approximation of `Adm(Σ)`), the function:
    1. Filters to those satisfying the equalities in `σ`.
    2. Evaluates `e` under each admissible pair, keeping only classical scalars.
    3. Returns `some v` if every admissible pair produces the same value `v`
       (unique resolution); returns `none` (⊥) otherwise.

    **Finite-approximation note.**  In the full framework `Adm(Σ)` is infinite;
    a sound mechanization requires the formula layer for `𝒞`, deferred to future
    work.  This function is correct *relative to* the supplied candidate list. -/
def collapse
    (σ : State α)
    (candidates : List (VarValuation α × IndetValuation α))
    (e : Expr α) : Option α :=
  let values : List α :=
    candidates
    |>.filter  (fun ⟨v, η⟩ => satisfiesState v η σ)
    |>.filterMap (fun ⟨v, η⟩ =>
        match eval v η e with
        | .scalar c => some c
        | .indet _  => none)
  match values with
  | []       => none
  | c :: rest =>
    if rest.all (· == c) then some c
    else none

end Collapse

-- ---------------------------------------------------------------------------
-- 8. Basic lemmas
-- ---------------------------------------------------------------------------

section Lemmas

variable {α : Type} [Add α] [Sub α] [Mul α] [Div α] [Zero α] [DecidableEq α]

/-- Classical constants evaluate to themselves, independent of the valuation
    pair.  (Implements Def 3.1, row 2 of the Semantic Specification.) -/
@[simp]
theorem eval_const (v : VarValuation α) (η : IndetValuation α) (c : α) :
    eval v η (.const c) = .scalar c := rfl

/-- Variables evaluate to their value under `v`.
    (Def 3.1, row 1.) -/
@[simp]
theorem eval_var (v : VarValuation α) (η : IndetValuation α) (s : String) :
    eval v η (.var s) = .scalar (v s) := rfl

/-- A resolved indeterminate evaluates to its assigned scalar.
    (Def 3.1, row 3, resolved branch.) -/
theorem eval_indet_resolved
    (v : VarValuation α) (η : IndetValuation α) (k : IndetClass) (c : α)
    (h : η k = some c) :
    eval v η (.indet k) = .scalar c := by
  simp only [eval, h]

/-- An unresolved indeterminate evaluates to the indeterminate class.
    (Def 3.1, row 3, unresolved branch.) -/
theorem eval_indet_unresolved
    (v : VarValuation α) (η : IndetValuation α) (k : IndetClass)
    (h : η k = none) :
    eval v η (.indet k) = .indet k := by
  simp only [eval, h]

/-- If both operands of addition evaluate to classical scalars, the result
    is their classical sum.  (Lemma 6.2 / A4 for addition.) -/
theorem eval_add_scalars
    (v : VarValuation α) (η : IndetValuation α) (e₁ e₂ : Expr α) (a b : α)
    (h₁ : eval v η e₁ = .scalar a) (h₂ : eval v η e₂ = .scalar b) :
    eval v η (.add e₁ e₂) = .scalar (a + b) := by
  simp [eval, applyOp, h₁, h₂]

/-- Agreement on classical constant inputs for addition (A4 instance). -/
@[simp]
theorem eval_add_const (v : VarValuation α) (η : IndetValuation α) (a b : α) :
    eval v η (.add (.const a) (.const b)) = .scalar (a + b) := by
  simp [eval, applyOp]

/-- If the left operand of addition is an unresolved indeterminate,
    the result is that indeterminate (indeterminate propagation rule). -/
theorem eval_add_indet_left
    (v : VarValuation α) (η : IndetValuation α) (e₁ e₂ : Expr α) (k : IndetClass)
    (h : eval v η e₁ = .indet k) :
    eval v η (.add e₁ e₂) = .indet k := by
  simp [eval, applyOp, h]

/-- Division by zero produces the indeterminate class ℐ_0.
    (Implements A2: the 0/0 origin marking, and the a/0 blocking rule.) -/
theorem eval_div_zero
    (v : VarValuation α) (η : IndetValuation α) (e₁ e₂ : Expr α) (a : α)
    (hnum : eval v η e₁ = .scalar a) (hden : eval v η e₂ = .scalar 0) :
    eval v η (.div e₁ e₂) = .indet IndetClass.zero := by
  simp [eval, applyOp, hnum, hden]

end Lemmas

end MilleniumCore
