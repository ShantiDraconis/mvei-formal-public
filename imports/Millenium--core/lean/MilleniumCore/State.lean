/-
  MilleniumCore.State

  Defines:
    · VarValuation α   — total function Var → α  (variable valuation v)
    · IndetValuation α — partial function {𝒥ₖ} ⇀ α  (indeterminate valuation η)
    · State α          — a pair (equalities, indeterminate assignments)
                         representing Σ = (ℰ, 𝒞) from Axiom Sheet v1.2, §2

  Corresponds to:
    Axiom Sheet v1.2, §4 (Key Definitions)
    Semantic Specification, §§2–3
-/

import MilleniumCore.Expr

namespace MilleniumCore

/-!
## Variable Valuation

A variable valuation assigns a classical value to every variable.
In the mathematical presentation: v : Var → ℂ.
-/

/-- A variable valuation: a total assignment of classical values to variables.

    In the scalar fragment, `α` is instantiated to `ℂ` (or any field).
    Variables are identified by their `VarName` index. -/
def VarValuation (α : Type*) := VarName → α

namespace VarValuation

/-- The constant valuation that assigns `dflt` to every variable. -/
def const {α : Type*} (dflt : α) : VarValuation α := fun _ => dflt

/-- Update a valuation: set variable `n` to value `a`. -/
def update {α : Type*} (v : VarValuation α) (n : VarName) (a : α) :
    VarValuation α :=
  fun m => if m = n then a else v m

end VarValuation

/-!
## Indeterminate Valuation

An indeterminate valuation optionally assigns a classical value to each
indetermination class 𝒥ₖ.  It is a partial function: `none` means 𝒥ₖ
remains unresolved.

In the mathematical presentation: η : {𝒥ₖ} ⇀ ℂ.
-/

/-- An indeterminate valuation: a partial assignment of classical values to
    indetermination classes.  `none` means the class is unresolved. -/
def IndetValuation (α : Type*) := IndetClass → Option α

namespace IndetValuation

/-- The everywhere-unresolved valuation. -/
def none {α : Type*} : IndetValuation α := fun _ => Option.none

/-- Resolve indetermination class `k` to value `a`. -/
def resolve {α : Type*} (η : IndetValuation α) (k : IndetClass) (a : α) :
    IndetValuation α :=
  fun k' => if k' = k then some a else η k'

end IndetValuation

/-!
## State

A state Σ = (equalities, indeterminate assignments) constrains which pairs
(v, η) are admissible valuations.

For the Lean skeleton (v1), the state records:
  · A list of `(VarName, α)` pairs fixing certain variable values.
  · A list of `(IndetClass, α)` pairs resolving certain indeterminate classes.

This is a simplified model of the full (ℰ, 𝒞) presentation; it is
sufficient for proving the collapse lemmas in the scalar fragment.
A future version will support arbitrary equalities and constraint formulas.
-/

/-- A state for the scalar fragment.

    `varBindings`   : variable assignments forced by ℰ.
    `indetBindings` : indeterminate-class resolutions forced by ℰ.

    Corresponds to Σ = (ℰ, 𝒞) from Axiom Sheet v1.2, §2 (scalar case).
-/
structure State (α : Type*) where
  varBindings   : List (VarName × α)
  indetBindings : List (IndetClass × α)
  deriving Repr

namespace State

/-- The empty state: no equations, no constraints. -/
def empty {α : Type*} : State α := ⟨[], []⟩

/-- Build a variable valuation from the state's variable bindings,
    falling back to `dflt` for unbound variables. -/
def toVarValuation {α : Type*} [DecidableEq α] (s : State α) (dflt : α) :
    VarValuation α :=
  fun n =>
    match s.varBindings.find? (fun p => p.1 = n) with
    | some (_, a) => a
    | none        => dflt

/-- Build an indeterminate valuation from the state's indeterminate bindings. -/
def toIndetValuation {α : Type*} (s : State α) : IndetValuation α :=
  fun k =>
    match s.indetBindings.find? (fun p => p.1 = k) with
    | some (_, a) => some a
    | none        => Option.none

end State
end MilleniumCore
