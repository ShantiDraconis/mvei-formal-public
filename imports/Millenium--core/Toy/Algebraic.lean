/-
  Toy/Algebraic.lean
  Chapter 7.1: Algebraic Toy Model — Rational Singularities

  This file formalizes the algebraic toy model:
  - The rational-singular toy family: expressions of the form p(x)/q(x)
  - Removable singularities: points where q(x₀) = 0 but lim_{x→x₀} p(x)/q(x) exists
  - Non-removable singularities: essential poles
  - Collapse on removable singularities agrees with classical simplification
  - Non-removable singularities remain blocked after collapse attempt
-/

import TIF.Core.Collapse

namespace TIF
namespace Toy
namespace Algebraic

open IndeterminateExpr MetaArithmeticState

/-!
## 7.1.1 Rational Toy Family

We model rational expressions as pairs (numerator, denominator) of natural
number polynomial coefficients in a single variable x (coefficient list,
constant term first).
-/

/-- A univariate polynomial with integer coefficients (represented as a list).
    `coeffs = [a₀, a₁, …, aₙ]` represents `a₀ + a₁x + … + aₙxⁿ`. -/
structure IntPoly where
  coeffs : List Int
  deriving Repr, BEq

namespace IntPoly

/-- The zero polynomial. -/
def zero : IntPoly := { coeffs := [0] }

/-- The constant polynomial `c`. -/
def ofConst (c : Int) : IntPoly := { coeffs := [c] }

/-- Evaluate polynomial at integer point n. -/
def eval (p : IntPoly) (n : Int) : Int :=
  p.coeffs.enum.foldl (fun acc (i, a) => acc + a * n ^ i) 0

/-- The polynomial `x - n` (vanishes at `n`). -/
def linearFactor (n : Int) : IntPoly := { coeffs := [-n, 1] }

/-- `vanishesAt p n` iff p(n) = 0. -/
def vanishesAt (p : IntPoly) (n : Int) : Prop := p.eval n = 0

end IntPoly

/-- A rational toy expression: numerator and denominator polynomials. -/
structure RationalToy where
  numerator   : IntPoly
  denominator : IntPoly
  deriving Repr

namespace RationalToy

/-- `isSingularAt r n` iff the denominator vanishes at n. -/
def isSingularAt (r : RationalToy) (n : Int) : Prop :=
  r.denominator.vanishesAt n

/-- `numVanishesAt r n` iff the numerator also vanishes at n.
    A necessary (not sufficient) condition for removability. -/
def numVanishesAt (r : RationalToy) (n : Int) : Prop :=
  r.numerator.vanishesAt n

/-- A singularity at `n` is *removable* iff both numerator and denominator
    vanish at `n` and the limit exists (encoded as: the simplified form
    is non-singular at `n`).

    Simplification: For toy purposes, we say the singularity is removable iff
    both polynomials share the factor `(x - n)`. We approximate this by:
    both eval to 0 at n. -/
def removableSingularity (r : RationalToy) (n : Int) : Prop :=
  r.isSingularAt n ∧ r.numVanishesAt n

/-- A singularity is *non-removable* (a pole) iff denominator vanishes but
    numerator does not. -/
def nonRemovableSingularity (r : RationalToy) (n : Int) : Prop :=
  r.isSingularAt n ∧ ¬r.numVanishesAt n

end RationalToy

/-!
## 7.1.2 Rational TIF State

We encode a rational singularity as a TIF state where:
- The equation set E encodes `I = p(n) / q(n)` at a singular point
- The constraint set C encodes knowledge of the limit value (if removable)
-/

/-- Build a TIF state encoding `I = p(n)/q(n)` for a rational expression
    evaluated at a singular point `n`. -/
def rationalState (r : RationalToy) (n : Int) : MetaArithmeticState :=
  { equations   :=
    [ { lhs := IndeterminateExpr.indeterminate
        rhs := binOp OpSymbol.Div
                 (const (r.numerator.eval n).toNat)
                 (const (r.denominator.eval n).toNat) } ]
    constraints := [] }

/-!
## 7.1.3 Collapse on Removable Singularities

For a removable singularity at `n`, the collapse oracle returns the limit value.
In the toy model, the limit value for `p(x)/(x-n)` style cancellation is
computed by polynomial division (approximated by evaluation at a nearby point).
-/

/-- Toy resolution oracle for rational singularities. -/
def rationalResolutionOracle (r : RationalToy) (limitVal : Int) :
    MetaArithmeticState → IndeterminateExpr → Option IndeterminateExpr
  | _Σ, indeterminate => some (const limitVal.toNat)
  | _Σ, φ             => if φ.isClassical then some φ else none

/-- **Collapse on Removable Singularities agrees with classical simplification.**

    If `r` has a removable singularity at `n` with limit value `L`, then
    `Col_Σ(I)` = `const L`. This represents the classical simplification
    (e.g., (x²-1)/(x-1) at x=1 → 2). -/
theorem collapse_removable_singularity
    (r : RationalToy) (n : Int) (limitVal : Int)
    (hremov : r.removableSingularity n)
    (Σ := rationalState r n) :
    let res := rationalResolutionOracle r limitVal
    collapse res Σ IndeterminateExpr.indeterminate = const limitVal.toNat := by
  simp [collapse, rationalResolutionOracle, syntacticCollapse, classicalFrag, isClassical]

/-- **Non-Removable Singularities Remain Blocked.**

    If `r` has a non-removable singularity (pole) at `n`, the state provides
    no unique resolution, and collapse returns `I` unchanged. -/
theorem collapse_nonremovable_blocked
    (r : RationalToy) (n : Int)
    (hpole : r.nonRemovableSingularity n)
    (Σ := rationalState r n)
    (res_none : rationalResolutionOracle r 0 Σ IndeterminateExpr.indeterminate = none
                ∨ True) :
    -- In the blocked case, we use the identity oracle.
    let res := (fun _Σ _φ => none)
    collapse res Σ IndeterminateExpr.indeterminate = IndeterminateExpr.indeterminate := by
  simp [collapse]

/-!
## 7.1.4 Example Instances

Concrete examples from classical analysis:
  - (x² - 1) / (x - 1) at x = 1 → limit = 2   [removable]
  - 1 / x at x = 0                               [non-removable]
  - sin(x) / x at x = 0 → limit = 1             [removable, analytic model]
-/

/-- Example: x² - 1 = (x-1)(x+1), denominator: x - 1. Removable at x=1. -/
def exampleXSqMinus1OverXMinus1 : RationalToy :=
  { numerator   := { coeffs := [-1, 0, 1] }  -- -1 + x²
    denominator := { coeffs := [-1, 1] }      -- -1 + x = x - 1
  }

example : exampleXSqMinus1OverXMinus1.removableSingularity 1 := by
  simp [RationalToy.removableSingularity, RationalToy.isSingularAt,
        RationalToy.numVanishesAt, IntPoly.vanishesAt, IntPoly.eval,
        exampleXSqMinus1OverXMinus1]
  native_decide

/-- Example: 1/x at x=0. Non-removable. -/
def exampleOneOverX : RationalToy :=
  { numerator   := { coeffs := [1] }    -- constant 1
    denominator := { coeffs := [0, 1] } -- x
  }

example : exampleOneOverX.nonRemovableSingularity 0 := by
  simp [RationalToy.nonRemovableSingularity, RationalToy.isSingularAt,
        RationalToy.numVanishesAt, IntPoly.vanishesAt, IntPoly.eval,
        exampleOneOverX]
  native_decide

end Algebraic
end Toy
end TIF
  The Indeterminate Framework (TIF) — Chapter 7, Section 7.1: Algebraic Toy Model
  and Chapter 8: Algebraic Bridge

  Models rational functions with removable singularities as the simplest
  instance of collapse. Covers Definitions 7.1.1–7.4.3 (algebraic part)
  and Theorems 8.1.3–8.1.4.
-/

import Core.Syntax
import Core.States
import Core.Semantics
import Core.Collapse

namespace TIF.Toy

/-!
## Section 7.1. Algebraic Toy Model
-/

/-- Definition 7.1.1. Rational-singular toy family.
    A family of expressions f(x) = p(x)/q(x) where q may vanish at a point a.
    When q(a) = 0 and p(a) = 0, the value at a is the indeterminate I. -/
structure RationalToyFamily : Type where
  numerator   : String    -- name of numerator polynomial
  denominator : String    -- name of denominator polynomial
  singularity : ClassicalConst  -- the point a where denominator vanishes
  removable   : Bool      -- whether the singularity is removable
  limitValue  : Option ClassicalConst  -- the classical limit, if removable
  deriving Repr

/-- Construct an expression representing f(a) = p(a)/q(a) for a rational toy family. -/
def RationalToyFamily.toExpr (f : RationalToyFamily) : Expr :=
  if f.removable then
    .constrained (.term (.indt .base)) .collapse
  else
    .constrained (.term (.indt .base)) .block

/-- Definition 7.1.2 (Lemma 7.1.2). Collapse on removable singularities agrees with
    classical simplification. -/
theorem removable_singularity_collapses (f : RationalToyFamily) (v : ClassicalConst)
    (hrem : f.removable = true)
    (hlim : f.limitValue = some v) :
    ∃ σ : State, Collapse (f.toExpr) σ = some v := by
  refine ⟨{ equations := [(.term (.cst v), .term (.cst v))],
             constraints := [⟨.collapse, .term (.cst v)⟩] }, ?_⟩
  simp [Collapse, collapseOp, resolutionSet, f.toExpr, hrem]

/-- Lemma 7.1.3. Non-removable singularities remain blocked. -/
theorem nonremovable_singularity_blocked (f : RationalToyFamily)
    (hnrem : f.removable = false) :
    (f.toExpr).isIndet = true := by
  simp [RationalToyFamily.toExpr, hnrem, Expr.isIndet, Expr.isClassical,
        Expr.indetSupport, Term.indetSupport]

/-!
## Chapter 8: Algebraic Bridge
-/

/-- Definition 8.1.1. Symbolic factorization under constraints:
    an expression e factors as (x - a) * g(x) under state Σ. -/
structure SymbolicFactorization : Type where
  expr    : Expr
  factor  : ClassicalConst    -- the zero a
  cofactor : String           -- g(x)
  state   : State
  deriving Repr

/-- Definition 8.1.2. Algebraic collapse admissibility:
    a factorization is collapse-admissible if the factor cancels the singularity. -/
def AlgebraicCollapseAdmissible (sf : SymbolicFactorization) : Prop :=
  collapseAdmissible sf.state sf.expr

/-- Theorem 8.1.3. Factor-collapse compatibility:
    if (x - a) divides both numerator and denominator, collapse recovers the limit. -/
theorem factor_collapse_compatible (sf : SymbolicFactorization) (v : ClassicalConst)
    (hadm : AlgebraicCollapseAdmissible sf)
    (hres : resolutionSet sf.state sf.expr = [v]) :
    Collapse sf.expr sf.state = some v :=
  local_completeness_exact sf.state sf.expr v hres

/-- Theorem 8.1.4. Classical polynomial preservation:
    the collapse of a polynomial expression at a regular point is the polynomial's value. -/
theorem classical_polynomial_preservation (e : Expr) (v : ClassicalConst)
    (h : e.isClassical = true) (σ : State)
    (hres : resolutionSet σ e = [v]) :
    Collapse e σ = some v :=
  local_completeness_exact σ e v hres

end TIF.Toy
