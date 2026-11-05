/-
  Core/State.lean
  ───────────────
  The Indeterminate Framework (TIF) — States and Valuations

  Covers definitions D11–D14 from the formal summary v1.1.
  A state Σ = (ε, C) pairs a finite set of equations with a finite set of
  admissibility constraints.  Valuations assign classical scalars to
  variables (classical valuation) and, partially, to indetermination classes
  (indeterminate valuation).
-- Core/State.lean
-- State and admissibility definitions for TIF.
-- Implements Definition 3.1 (State) and Definition 4.3 (Admissible Valuation)
-- from glossary.md, and Axioms A11–A12 from axiom-sheet-v1.md.

import Core.Eval

namespace TIF

/-! ## State -/

/-- A TIF state `Σ = (ℰ, 𝒞)` pairs a finite list of expression equations with
    a finite list of constraint predicates on valuations.

    · `equations` — pairs `(lhs, rhs)` of expressions that must evaluate to the
      same classical value under any admissible valuation (Axiom A11, clause 1).
    · `constraints` — predicates `P : Valuation α → Prop` that must hold for any
      admissible valuation (Axiom A11, clause 2).

    (Definition 3.1 in glossary.md) -/
structure State (α : Type) [Add α] [Sub α] [Mul α] [Div α] [DecidableEq α] [OfNat α 0] where
  equations   : List (Expr α × Expr α)
  constraints : List (Valuation α → Prop)

/-! ## Admissibility -/

/-- A valuation `v` is *admissible for state `Σ`*, written `v ⊨ Σ`, if:
    1. every equation `(lhs, rhs) ∈ Σ.equations` is satisfied: the two sides
       evaluate to the same `Option α` value under `v`; and
    2. every constraint predicate `P ∈ Σ.constraints` holds of `v`.

    (Definition 4.3 in glossary.md; Axiom A11) -/
def Admissible {α : Type} [Add α] [Sub α] [Mul α] [Div α] [DecidableEq α] [OfNat α 0]
    (σ : State α) (v : Valuation α) : Prop :=
  (∀ eq ∈ σ.equations, eval v eq.1 = eval v eq.2) ∧
  (∀ P ∈ σ.constraints, P v)

/-- Notation: `v ⊨ σ` for admissibility. -/
notation:50 v " ⊨ " σ => Admissible σ v

/-- The admissible set of a state: the collection of all admissible valuations.
    (Definition 2.2 in semantics.md) -/
def AdmSet {α : Type} [Add α] [Sub α] [Mul α] [Div α] [DecidableEq α] [OfNat α 0]
    (σ : State α) : Set (Valuation α) :=
  { v | v ⊨ σ }

/-- A state is *vacuous* (over-determined) if it has no admissible valuation.
    (Axiom A12: TIF does not assert every state is consistent.) -/
def State.IsVacuous {α : Type} [Add α] [Sub α] [Mul α] [Div α] [DecidableEq α] [OfNat α 0]
    (σ : State α) : Prop :=
  ∀ v : Valuation α, ¬(v ⊨ σ)

/-- The empty state has no equations and no constraints; every valuation is
    admissible for it. -/
def State.empty {α : Type} [Add α] [Sub α] [Mul α] [Div α] [DecidableEq α] [OfNat α 0]
    : State α :=
  { equations := [], constraints := [] }

theorem State.empty_admissible {α : Type} [Add α] [Sub α] [Mul α] [Div α] [DecidableEq α] [OfNat α 0]
    (v : Valuation α) : v ⊨ (State.empty (α := α)) := by
  simp [Admissible, State.empty]

end TIF
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

-- ─────────────────────────────────────────────────────────────────────────────
-- D11. State
-- ─────────────────────────────────────────────────────────────────────────────

/-
  A state is a pair Σ = (ε, C) where:
    • ε  is a finite list of equations between terms;
    • C  is a finite list of admissibility constraints.

  We use List rather than Finset to keep the definition computable without
  requiring a DecidableEq instance on the full term type.
-/

/-- A state Σ = (equations, constraints). -/
structure State (α : Type*) where
  /-- ε : finite list of equations between terms. -/
  equations   : List (Term α × Term α)
  /-- C : finite list of admissibility constraints. -/
  constraints : List (Constraint α)
  deriving Repr

/-- The empty (trivial) state with no equations or constraints. -/
def State.empty {α : Type*} : State α :=
  { equations := [], constraints := [] }

-- ─────────────────────────────────────────────────────────────────────────────
-- D12. Classical valuation
-- ─────────────────────────────────────────────────────────────────────────────

/-
  A classical valuation is a total function v : Var → α.
  We represent it as a list of (VarName, scalar) pairs with a default value,
  keeping the development computable.
-/

/-- A classical valuation maps variable names to classical scalars. -/
structure ClassicalVal (α : Type*) where
  /-- Explicit bindings. -/
  bindings : List (VarName × α)
  /-- Default value returned for unbound variables. -/
  default  : α

/-- Look up a variable in a classical valuation. -/
def ClassicalVal.lookup {α : Type*} (v : ClassicalVal α) (x : VarName) : α :=
  match v.bindings.find? (fun p => p.1 == x) with
  | some (_, c) => c
  | none        => v.default

-- ─────────────────────────────────────────────────────────────────────────────
-- D13. Indeterminate valuation
-- ─────────────────────────────────────────────────────────────────────────────

/-
  An indeterminate valuation is a partial function
    η : {I_k}_{k ∈ ℕ} ⇀ α
  represented as a list of (IndetermClass, scalar) bindings.
  The function is partial: a class with no binding is genuinely unmapped.
-/

/-- A partial mapping from indetermination classes to classical scalars. -/
structure IndetermVal (α : Type*) where
  /-- Explicit partial bindings. -/
  bindings : List (IndetermClass × α)
  deriving Repr

/-- Look up an indetermination class; returns None if not bound. -/
def IndetermVal.lookup {α : Type*} (η : IndetermVal α) (k : IndetermClass) : Option α :=
  match η.bindings.find? (fun p => p.1 == k) with
  | some (_, c) => some c
  | none        => none

-- ─────────────────────────────────────────────────────────────────────────────
-- D14. Admissible valuation
-- ─────────────────────────────────────────────────────────────────────────────

/-
  A pair (v, η) is admissible for Σ if every equation in ε and every
  constraint in C is satisfied under the induced evaluation.

  The full admissibility check depends on the evaluation function defined in
  Core/Eval.lean.  Here we introduce the type of valuation pairs and a
  placeholder predicate; the concrete version is completed in Core/Eval.lean.
-/

/-- A valuation pair (v, η) combining classical and indeterminate valuations. -/
structure ValPair (α : Type*) where
  /-- Classical valuation v : Var → α. -/
  classical   : ClassicalVal α
  /-- Indeterminate valuation η : {I_k} ⇀ α. -/
  indeterminate : IndetermVal α

/-
  Admissibility is stated as a Prop here and instantiated in Core/Eval.lean
  once the evaluation function Eval_{v,η} is available.
-/

/-- Placeholder: (v, η) is admissible for state Σ.
    Concrete definition provided in Core/Eval.lean. -/
opaque admissible {α : Type*} (_ : ValPair α) (_ : State α) : Prop

end TIF
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
