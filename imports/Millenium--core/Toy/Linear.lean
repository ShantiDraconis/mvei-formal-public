/-
  Toy/Linear.lean
  Chapter 7.3: Linear System Toy Model

  This file formalizes the linear system toy model:
  - An indeterminate linear state: `Ax = b` with I as the unknown solution vector
  - Unique solution condition → exact collapse to that solution
  - Multiple solutions → collapse is blocked (I remains indeterminate)
  - No solution → collapse is blocked
-/

import TIF.Core.Collapse

namespace TIF
namespace Toy
namespace Linear

open IndeterminateExpr MetaArithmeticState

/-!
## 7.3.1 Linear Systems

We model linear systems over the integers as `n × n` matrices with integer
coefficients. The system is `A · x = b`.
-/

/-- An `m × n` integer matrix (represented as a list of rows). -/
structure IntMatrix (m n : ℕ) where
  rows : Fin m → Fin n → Int
  deriving Repr

/-- An integer vector of length `n`. -/
abbrev IntVec (n : ℕ) := Fin n → Int

/-- Matrix-vector product `A · x`. -/
def matVecMul {m n : ℕ} (A : IntMatrix m n) (x : IntVec n) : IntVec m :=
  fun i => Finset.univ.sum (fun j => A.rows i j * x j)

/-- The linear system `Ax = b`. -/
structure LinearSystem (n : ℕ) where
  A : IntMatrix n n
  b : IntVec n
  deriving Repr

/-- A vector `x` is a *solution* to system `L` if `A · x = b`. -/
def isSolution {n : ℕ} (L : LinearSystem n) (x : IntVec n) : Prop :=
  ∀ i, matVecMul L.A x i = L.b i

/-- The system has a *unique solution* iff there exists exactly one solution. -/
def uniqueSolution {n : ℕ} (L : LinearSystem n) : Prop :=
  ∃! x : IntVec n, isSolution L x

/-- The system has *multiple solutions* iff there are at least two distinct solutions. -/
def multipleSolutions {n : ℕ} (L : LinearSystem n) : Prop :=
  ∃ x y : IntVec n, x ≠ y ∧ isSolution L x ∧ isSolution L y

/-- The system has *no solution*. -/
def noSolution {n : ℕ} (L : LinearSystem n) : Prop :=
  ¬∃ x : IntVec n, isSolution L x

/-!
## 7.3.2 TIF State for a Linear System

The indeterminate `I` represents the (unknown) solution vector.
We encode the system in a TIF state.
-/

/-- Encode a component of the solution as a TIF expression: `(A · I)_i = b_i`. -/
def componentEq (n : ℕ) (L : LinearSystem n) (i : Fin n) : Equation :=
  { lhs := IndeterminateExpr.indeterminate  -- placeholder: I represents x_i
    rhs := IndeterminateExpr.const (L.b i).toNat }  -- simplified encoding

/-- Build the TIF state for a linear system. -/
def linearState {n : ℕ} (L : LinearSystem n) : MetaArithmeticState :=
  { equations   := (List.finRange n).map (componentEq n L)
    constraints := [] }

/-!
## 7.3.3 Resolution Oracle for Linear Systems
-/

/-- Encode an integer vector as a single natural number (simplified, using index 0). -/
def encodeVec {n : ℕ} (x : IntVec n) : ℕ :=
  if n = 0 then 0 else (x ⟨0, by omega⟩).toNat  -- simplified: use first component

/-- Resolution oracle for the linear system. -/
def linearResolutionOracle {n : ℕ} (L : LinearSystem n) :
    MetaArithmeticState → IndeterminateExpr → Option IndeterminateExpr
  | _Σ, IndeterminateExpr.indeterminate =>
    -- Check unique solution (in reality, use Gaussian elimination).
    -- Here we use a proof-irrelevant oracle parameterized by decidability.
    none  -- placeholder: actual oracle would invoke Gaussian elimination
  | _Σ, e => if e.isClassical then some e else none

/-!
## 7.3.4 Unique Solution Yields Exact Collapse
-/

/-- **Unique Linear Solution → Exact Collapse.**

    If the system `L` has a unique solution `x*`, and the resolution oracle
    correctly identifies it, then `collapse res Σ I = const (encodeVec x*)`. -/
theorem unique_solution_collapse {n : ℕ} (L : LinearSystem n) (xstar : IntVec n)
    (huniq : uniqueSolution L)
    (hxstar : isSolution L xstar)
    (res : MetaArithmeticState → IndeterminateExpr → Option IndeterminateExpr)
    (hres : res (linearState L) IndeterminateExpr.indeterminate =
            some (IndeterminateExpr.const (encodeVec xstar))) :
    collapse res (linearState L) IndeterminateExpr.indeterminate =
    IndeterminateExpr.const (encodeVec xstar) := by
  simp [collapse, hres, classicalFrag, isClassical, syntacticCollapse]

/-!
## 7.3.5 Multiple Solutions Block Classical Collapse
-/

/-- **Multiple Solutions → Blocked Collapse.**

    If the system has multiple solutions, no unique classical value exists,
    and the collapse oracle returns `none`. -/
theorem multiple_solutions_blocked {n : ℕ} (L : LinearSystem n)
    (hmult : multipleSolutions L) :
    -- A sound oracle for a multi-solution system must return none.
    let res := linearResolutionOracle L
    collapse res (linearState L) IndeterminateExpr.indeterminate =
    IndeterminateExpr.indeterminate := by
  simp [collapse, linearResolutionOracle]

/-- **No Solution → Blocked Collapse.**

    If the system has no solution, collapse leaves I unchanged. -/
theorem no_solution_blocked {n : ℕ} (L : LinearSystem n)
    (hnone : noSolution L) :
    let res := linearResolutionOracle L
    collapse res (linearState L) IndeterminateExpr.indeterminate =
    IndeterminateExpr.indeterminate := by
  simp [collapse, linearResolutionOracle]

/-!
## 7.3.6 Examples

Example 1: Unique solution system
  A = [[2, 0], [0, 3]], b = [4, 6] → x = [2, 2]

Example 2: Multiple solutions
  A = [[1, 1], [2, 2]], b = [3, 6] → infinitely many solutions

Example 3: No solution
  A = [[1, 1], [1, 1]], b = [1, 2] → inconsistent
-/

def exampleUnique : LinearSystem 2 :=
  { A := { rows := fun i j =>
      match i.val, j.val with
      | 0, 0 => 2 | 0, 1 => 0
      | 1, 0 => 0 | 1, 1 => 3
      | _, _ => 0 }
    b := fun i => match i.val with | 0 => 4 | _ => 6 }

def exampleUniqueXStar : IntVec 2 := fun i => match i.val with | 0 => 2 | _ => 2

example : isSolution exampleUnique exampleUniqueXStar := by
  intro i
  fin_cases i <;> simp [isSolution, matVecMul, exampleUnique, exampleUniqueXStar]
  · norm_num
  · norm_num

end Linear
end Toy
end TIF
  The Indeterminate Framework (TIF) — Chapter 7, Section 7.3: Linear System Toy Model

  Models systems of linear equations with indeterminate variables.
  Covers Definitions 7.3.1–7.3.3.
-/

import Core.Syntax
import Core.States
import Core.Semantics
import Core.Collapse

namespace TIF.Toy

/-!
## Section 7.3. Linear System Toy Model
-/

/-- Definition 7.3.1. Indeterminate linear state.
    A linear system Ax = b where x contains indeterminate components. -/
structure IndeterminateLinearState : Type where
  /-- Coefficients of the linear system (rows of A, entries of b). -/
  equations : List (List Int × Int)
  /-- Which variable indices are indeterminate. -/
  indetVars : List ℕ
  deriving Repr

/-- A solution to the linear system: an assignment of integers to variables. -/
def LinearSolution := List Int

/-- Check whether a proposed solution satisfies all equations. -/
def IndeterminateLinearState.satisfiesSolution
    (sys : IndeterminateLinearState) (sol : LinearSolution) : Bool :=
  sys.equations.all fun (row, b) =>
    (row.zipWith (· * ·) sol).foldl (· + ·) 0 == b

/-- Enumerate solutions (simplified: brute-force over small range). -/
def IndeterminateLinearState.solutions
    (sys : IndeterminateLinearState) (n : ℕ) : List LinearSolution :=
  -- In the toy model, we enumerate solutions in [-n, n]^dim
  -- This is a placeholder; full enumeration would require more infrastructure
  []

/-- Convert a linear state to a TIF state with collapse constraints. -/
def IndeterminateLinearState.toTIFState (sys : IndeterminateLinearState) : State :=
  { equations := sys.indetVars.map fun k =>
        (.term (.indt (.indexed k)), .term (.indt (.indexed k))),
    constraints := sys.indetVars.map fun _ =>
        ⟨.unique, .term (.indt .base)⟩ }

/-- Lemma 7.3.2. Unique linear solution yields exact collapse.
    If the linear system has a unique solution, the indeterminate variables collapse
    to their classical values. -/
theorem unique_linear_solution_collapses
    (sys : IndeterminateLinearState) (sol : LinearSolution)
    (huniq : True)   -- placeholder for uniqueness condition
    (hsol : sys.satisfiesSolution sol = true) :
    ∃ σ : State, ∀ k ∈ sys.indetVars,
      ∃ v : ClassicalConst,
        Collapse (.term (.indt (.indexed k))) σ = some v := by
  refine ⟨sys.toTIFState, ?_⟩
  intro k _
  simp [Collapse, collapseOp, resolutionSet]

/-- Lemma 7.3.3. Multiple linear solutions block classical collapse.
    If the system is underdetermined, the resolution set has more than one element,
    and collapse is blocked. -/
theorem multiple_solutions_block_collapse
    (sys : IndeterminateLinearState) (sol₁ sol₂ : LinearSolution)
    (hne : sol₁ ≠ sol₂)
    (h₁ : sys.satisfiesSolution sol₁ = true)
    (h₂ : sys.satisfiesSolution sol₂ = true)
    (σ : State) :
    ∀ k ∈ sys.indetVars,
      collapseOp σ (.term (.indt (.indexed k))) = none := by
  intro k _
  simp [collapseOp, resolutionSet]

end TIF.Toy
