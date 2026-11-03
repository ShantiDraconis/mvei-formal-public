/-
  Core/State.lean
  Theory of Indeterminates Framework (TIF) — States and Valuations

  Defines:
    - Valuation       : classical valuation (String → α)
    - IndetValuation  : indeterminate valuation (IndetClass → Option α)
    - State           : a pair (equations, constraints)
    - Adm             : the set of admissible valuations for a state

  Status: Paper 1 core.
-/

import Core.Syntax

namespace TIF

/-!
## Valuation

A *classical valuation* assigns a classical value of type `α` to each
variable name. It is used to evaluate `var` nodes in `Expr α`.
-/
def Valuation (α : Type) : Type := String → α

/-!
## IndetValuation

An *indeterminate valuation* assigns an optional classical resolution to
each indeterminate class. It is used during collapse to attempt resolution
of `indet` nodes.

Note: `IndetValuation` is separate from `Valuation`. A classical valuation
handles `var` nodes; an indeterminate valuation handles `indet` nodes.
-/
def IndetValuation (α : Type) : Type := IndetClass → Option α

/-!
## State

A *state* is a pair `Σ = (ℰ, 𝒞)` where:
  - `equations`   is a list of equation pairs `(e₁, e₂) : Expr α × Expr α`
  - `constraints` is a list of predicate functions `Valuation α → Prop`

Both collections are finite (represented as `List`).

Note: `Prop`-valued constraints are not decidable in general. For toy
models, constraints are restricted to decidable predicates.
-/
structure State (α : Type) : Type where
  /-- Finite set of equations `e₁ = e₂` that must hold under admissible valuations. -/
  equations   : List (Expr α × Expr α)
  /-- Finite set of predicate constraints over valuations. -/
  constraints : List (Valuation α → Prop)

namespace State

/-- The empty state: no equations, no constraints. Every valuation is admissible. -/
def empty {α : Type} : State α :=
  { equations := [], constraints := [] }

/-- Add an equation constraint to a state. -/
def addEquation {α : Type} (Σ : State α) (e₁ e₂ : Expr α) : State α :=
  { Σ with equations := (e₁, e₂) :: Σ.equations }

/-- Add a predicate constraint to a state. -/
def addConstraint {α : Type} (Σ : State α) (P : Valuation α → Prop) : State α :=
  { Σ with constraints := P :: Σ.constraints }

end State

/-!
## Admissibility

A classical valuation `v` is *admissible for state* `Σ = (ℰ, 𝒞)` iff:
  1. For every equation `(e₁, e₂) ∈ ℰ`: `eval v e₁ = eval v e₂`
  2. For every predicate `P ∈ 𝒞`: `P v` holds

This is Axiom A10 from the Axiom Sheet.

Note: `eval` is defined in `Core/Eval.lean`. We forward-declare the
admissibility predicate here; the full definition is in `Core/Eval.lean`.
-/

end TIF
-- Core/State.lean
-- Defines the Meta-Arithmetic State and the Collapse operation.
-- Part II, Section 2.2 of the Blueprint.

import Core.Types
import Mathlib.Data.Complex.Basic

/-- A meta-arithmetic state Σ = (ℰ, 𝒞) records:
    - `equations`  : a list of equalities (e₁, e₂) asserting e₁ = e₂
    - `constraints`: a list of expressions that must evaluate to nonzero
                     (encoding conditions such as x ≠ 0 or x > 0) -/
structure State (α : Type) where
  equations   : List (Expr α × Expr α)
  constraints : List (Expr α)
  deriving Repr

namespace State

/-- The empty state: no equations, no constraints. -/
def empty {α : Type} : State α :=
  { equations := [], constraints := [] }

/-- Add an equality constraint e₁ = e₂ to the state. -/
def addEquation {α : Type} (s : State α) (lhs rhs : Expr α) : State α :=
  { s with equations := (lhs, rhs) :: s.equations }

/-- Add a nonzero constraint `e ≠ 0` to the state. -/
def addConstraint {α : Type} (s : State α) (e : Expr α) : State α :=
  { s with constraints := e :: s.constraints }

/-- Check whether a classical valuation satisfies the state.
    A valuation `val` satisfies a state when:
    - every equation (l, r) evaluates to the same value, and
    - every constraint expression evaluates to a nonzero value. -/
def satisfies {α : Type} [Field α] [DecidableEq α]
    (s : State α) (val : IndetClass → α) : Prop :=
  (∀ (eq : Expr α × Expr α),
     eq ∈ s.equations →
     Expr.eval val eq.1 = Expr.eval val eq.2) ∧
  (∀ (c : Expr α),
     c ∈ s.constraints →
     Expr.eval val c ≠ none ∧
     Expr.eval val c ≠ some 0)

end State

/-- The collapse operation (Part II §2.2).

    `collapse e s` attempts to reduce the expression `e` to a classical constant
    given the state `s`.  The simplified version below is structural: it collapses
    constant sub-expressions by ordinary arithmetic and returns `none` whenever an
    indeterminate leaf is encountered without a forced classical value. -/
def collapse {α : Type} [Field α] [DecidableEq α]
    (e : Expr α) (s : State α) : Option (Expr α) :=
  match e with
  | Expr.const c => some (Expr.const c)
  | Expr.indet _ => none   -- cannot collapse a raw indeterminate without further constraints
  | Expr.add l r => do
      let l' ← collapse l s
      let r' ← collapse r s
      match (l', r') with
      | (Expr.const lv, Expr.const rv) => some (Expr.const (lv + rv))
      | _ => none
  | Expr.sub l r => do
      let l' ← collapse l s
      let r' ← collapse r s
      match (l', r') with
      | (Expr.const lv, Expr.const rv) => some (Expr.const (lv - rv))
      | _ => none
  | Expr.mul l r => do
      let l' ← collapse l s
      let r' ← collapse r s
      match (l', r') with
      | (Expr.const lv, Expr.const rv) => some (Expr.const (lv * rv))
      | _ => none
  | Expr.div l r => do
      let l' ← collapse l s
      let r' ← collapse r s
      match (l', r') with
      | (Expr.const lv, Expr.const rv) =>
        if rv = 0 then none
        else some (Expr.const (lv / rv))
      | _ => none

/-- `collapse` is the identity on classical (indeterminate-free) constants. -/
theorem collapse_const {α : Type} [Field α] [DecidableEq α]
    (c : α) (s : State α) :
    collapse (Expr.const c) s = some (Expr.const c) := by
  simp [collapse]

/-- A raw indeterminate never collapses in the simplified system. -/
theorem collapse_indet_none {α : Type} [Field α] [DecidableEq α]
    (cls : IndetClass) (s : State α) :
    collapse (Expr.indet cls) s = none := by
  simp [collapse]
