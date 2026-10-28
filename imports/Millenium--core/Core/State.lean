/-!
# Core/State.lean
## The Indeterminate Framework (TIF) — States and Valuations

This file defines:
  - `State`           : a pair (ℰ, 𝒞) of equations and admissibility constraints (D11)
  - `ClassicalVal`    : classical valuations v : Var → ClassicalScalar (D12)
  - `IndVal`          : indeterminate valuations η : IndClass ⇀ ClassicalScalar (D13)
  - `isAdmissible`    : admissibility of a valuation pair for a given state (D14)

Depends on: `Core.Types`, `Core.Syntax`
-/

import Core.Types
import Core.Syntax

-- ---------------------------------------------------------------------------
-- D11 : State  Σ = (ℰ, 𝒞)
-- ---------------------------------------------------------------------------

/-- A state `Σ = (ℰ, 𝒞)` (D11).

    - `equations`   : finite list of term-level equations that hold in this state.
    - `constraints` : finite list of admissibility constraints. -/
structure State : Type where
  /-- The equation component ℰ: a list of term pairs `(lhs, rhs)` asserted equal. -/
  equations   : List (Term × Term)
  /-- The constraint component 𝒞: a list of admissibility constraints. -/
  constraints : List Constraint
  deriving Repr

namespace State

/-- The empty state `Σ_∅ = (∅, ∅)`. -/
def empty : State := ⟨[], []⟩

/-- Add an equation `lhs = rhs` to a state. -/
def addEq (σ : State) (lhs rhs : Term) : State :=
  { σ with equations := (lhs, rhs) :: σ.equations }

/-- Add an admissibility constraint to a state. -/
def addConstraint (σ : State) (c : Constraint) : State :=
  { σ with constraints := c :: σ.constraints }

end State

-- ---------------------------------------------------------------------------
-- D12 : Classical valuation  v : Var → ClassicalScalar
-- ---------------------------------------------------------------------------

/-- A classical valuation assigns a classical scalar to every variable (D12). -/
def ClassicalVal := Var → ClassicalScalar

-- ---------------------------------------------------------------------------
-- D13 : Indeterminate valuation  η : IndClass ⇀ ClassicalScalar
-- ---------------------------------------------------------------------------

/-- An indeterminate valuation is a partial assignment of classical scalars
    to indeterminate class symbols (D13).
    `none` means the class symbol is not assigned in this valuation. -/
def IndVal := IndClass → Option ClassicalScalar

namespace IndVal

/-- The everywhere-undefined indeterminate valuation. -/
def empty : IndVal := fun _ => none

/-- Update `η` to assign `c` to indeterminate class `k`. -/
def assign (η : IndVal) (k : IndClass) (c : ClassicalScalar) : IndVal :=
  fun k' => if k' == k then some c else η k'

end IndVal

-- ---------------------------------------------------------------------------
-- D14 : Admissible valuation pair
-- ---------------------------------------------------------------------------

-- We need a term-evaluation function to check admissibility.
-- A full definition appears in Core.Eval; here we use an axiom to break the
-- import cycle (State is imported by Eval).

/-- Axiom placeholder: term evaluation under a classical and indeterminate valuation.
    The full definition is given in `Core.Eval`. -/
axiom termEval (v : ClassicalVal) (η : IndVal) (t : Term) : Option ClassicalScalar

/-- Check whether a single equation `(lhs, rhs)` is satisfied by `(v, η)`. -/
def equationSatisfied (v : ClassicalVal) (η : IndVal) (eq : Term × Term) : Prop :=
  termEval v η eq.1 = termEval v η eq.2

/-- Check whether a single admissibility constraint is satisfied by `(v, η)`.
    Constraints are pairs `(t₁, t₂)` interpreted as `t₁ ≤ t₂` (placeholder). -/
def constraintSatisfied (v : ClassicalVal) (η : IndVal) (c : Constraint) : Prop :=
  -- Placeholder: both sides evaluate to the same value, or some ordering holds.
  -- A complete development would use the actual constraint semantics.
  termEval v η c.1 = termEval v η c.2 ∨ True

/-- A valuation pair `(v, η)` is **admissible** for state `Σ` iff it satisfies
    every equation in `Σ.equations` and every constraint in `Σ.constraints` (D14). -/
def isAdmissible (σ : State) (v : ClassicalVal) (η : IndVal) : Prop :=
  (∀ eq ∈ σ.equations,   equationSatisfied v η eq) ∧
  (∀ c  ∈ σ.constraints, constraintSatisfied v η c)
