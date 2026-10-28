/-!
# Core/Syntax.lean
## The Indeterminate Framework (TIF) — Syntactic Layer

This file defines the term language `Term_I` and expression language `Expr_I`,
together with the notions of indeterminate support and the classical fragment,
following definitions D6–D10 of the TIF Formal Summary v1.1.

Depends on: `Core.Types`
-/

import Core.Types

-- ---------------------------------------------------------------------------
-- D6 : Terms  (Term_I)
-- ---------------------------------------------------------------------------

/-- The term language of `𝒯_I` (D6).

    A term is one of:
    - a variable `x ∈ Var`,
    - a classical constant `c ∈ ClassicalScalar`,
    - an indeterminate class symbol `ℐ_k`,
    - a binary application `t₁ ∘_I t₂` for an extended operator `∘_I`. -/
inductive Term : Type where
  /-- A free variable (D4, D6). -/
  | var   (x : Var)                            : Term
  /-- A classical constant (D3, D6). -/
  | const (c : ClassicalScalar)                : Term
  /-- An indeterminate class symbol ℐ_k (D2, D6). -/
  | ind   (k : IndClass)                       : Term
  /-- Binary application of an extended operator (D5, D6). -/
  | app   (op : ExtOp) (t₁ t₂ : Term)         : Term
  deriving Repr

namespace Term

-- ---------------------------------------------------------------------------
-- D8 : Support of indeterminacy  Supp_I(t)
-- ---------------------------------------------------------------------------

/-- The set of indeterminate class indices occurring in term `t` (D8).
    Returns a `List` of `IndClass` values (duplicates possible; use `List.eraseDups` for a set). -/
def suppI : Term → List IndClass
  | var _          => []
  | const _        => []
  | ind k          => [k]
  | app _ t₁ t₂   => t₁.suppI ++ t₂.suppI

-- ---------------------------------------------------------------------------
-- D9 : Classical fragment at the term level
-- ---------------------------------------------------------------------------

/-- A term belongs to the classical fragment iff it contains no indeterminate symbols (D9). -/
def isClassical (t : Term) : Bool := t.suppI.isEmpty

-- ---------------------------------------------------------------------------
-- Syntactic helpers
-- ---------------------------------------------------------------------------

/-- Smart constructor: addition in `𝒯_I`. -/
def add (t₁ t₂ : Term) : Term := Term.app ExtOp.add t₁ t₂

/-- Smart constructor: subtraction in `𝒯_I`. -/
def sub (t₁ t₂ : Term) : Term := Term.app ExtOp.sub t₁ t₂

/-- Smart constructor: multiplication in `𝒯_I`. -/
def mul (t₁ t₂ : Term) : Term := Term.app ExtOp.mul t₁ t₂

/-- Smart constructor: division in `𝒯_I`. -/
def div (t₁ t₂ : Term) : Term := Term.app ExtOp.div t₁ t₂

end Term

-- ---------------------------------------------------------------------------
-- D7 : Expressions  (Expr_I)
-- ---------------------------------------------------------------------------

/-- Admissibility constraints — an opaque placeholder for the full constraint language.
    In a complete development these would be relational formulas between terms. -/
def Constraint := Term × Term   -- represents a binary relation `t₁ ≤ t₂`, `t₁ = t₂`, etc.

/-- Well-formed expressions of `𝒯_I` (D7, D10).

    We represent the expression language inductively.  The `state` constructor
    captures the state expression `Σ = (ℰ, 𝒞)` directly (D7, D11). -/
inductive Expr : Type where
  /-- Lift a term to an expression. -/
  | term     (t : Term)                                  : Expr
  /-- Equality of two terms: `t₁ = t₂`. -/
  | eq       (t₁ t₂ : Term)                             : Expr
  /-- Conjunction of two expressions. -/
  | and      (e₁ e₂ : Expr)                             : Expr
  /-- Disjunction of two expressions. -/
  | or       (e₁ e₂ : Expr)                             : Expr
  /-- Negation. -/
  | not      (e : Expr)                                  : Expr
  /-- Universal quantification over a variable. -/
  | forall_  (x : Var) (e : Expr)                       : Expr
  /-- Existential quantification over a variable. -/
  | exists_  (x : Var) (e : Expr)                       : Expr
  /-- State expression `Σ = (ℰ, 𝒞)` (D7, D11):
      `equations` is a list of term equalities, `constraints` a list of admissibility constraints. -/
  | state    (equations : List (Term × Term))
             (constraints : List Constraint)            : Expr
  deriving Repr

namespace Expr

-- ---------------------------------------------------------------------------
-- D8 : Support of indeterminacy  Supp_I(e)
-- ---------------------------------------------------------------------------

/-- The set of indeterminate class indices occurring in expression `e` (D8). -/
def suppI : Expr → List IndClass
  | term t             => t.suppI
  | eq t₁ t₂          => t₁.suppI ++ t₂.suppI
  | and e₁ e₂         => e₁.suppI ++ e₂.suppI
  | or  e₁ e₂         => e₁.suppI ++ e₂.suppI
  | not e              => e.suppI
  | forall_ _ e        => e.suppI
  | exists_ _ e        => e.suppI
  | state eqs cs       =>
      (eqs.bind fun (l, r) => l.suppI ++ r.suppI) ++
      (cs.bind  fun (l, r) => l.suppI ++ r.suppI)

-- ---------------------------------------------------------------------------
-- D9 : Classical fragment  𝒞_cl
-- ---------------------------------------------------------------------------

/-- An expression belongs to the classical fragment iff `Supp_I(e) = ∅` (D9). -/
def isClassical (e : Expr) : Bool := e.suppI.isEmpty

-- ---------------------------------------------------------------------------
-- D10 : Well-formedness (structural check)
-- ---------------------------------------------------------------------------

/-- Structural well-formedness check (D10).
    A full check would also verify arity, no illegal classical simplification, etc.
    This skeleton returns `true` for all syntactically-formed expressions. -/
def wellFormed (_ : Expr) : Bool := true

end Expr
