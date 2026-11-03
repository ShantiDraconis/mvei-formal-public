-- Core/Types.lean
-- Base type definitions for the Totalistic Indeterminate Framework (TIF).
-- This file defines IndetClass and OriginTag, the two foundational type-level
-- primitives that distinguish TIF expressions from classical arithmetic.
--
-- Note: Lean files in this skeleton use explicit type class constraints
-- `[Add α] [Sub α] [Mul α] [Div α] [DecidableEq α] [OfNat α 0]` on each
-- definition.  A future refactoring may introduce a bundled `TIFField α`
-- alias once the full Paper 1 scope is settled.

namespace TIF

/-- IndetClass enumerates the seven classical indeterminate forms.
    Each constructor corresponds to a distinct ontological category of
    indeterminate expression.  They must not be conflated with classical values. -/
inductive IndetClass : Type where
  /-- Form 0/0: simultaneous zero numerator and denominator -/
  | I0         : IndetClass
  /-- Form ∞/∞: divergent ratio -/
  | IInf       : IndetClass
  /-- Form 0 · ∞ -/
  | IZeroInf   : IndetClass
  /-- Form ∞ − ∞ -/
  | IInfMinusInf : IndetClass
  /-- Form 1^∞ -/
  | IOneInf    : IndetClass
  /-- Form 0^0 -/
  | IZeroZero  : IndetClass
  /-- Form ∞^0 -/
  | IInfZero   : IndetClass
  deriving DecidableEq, Repr

/-- OriginTag records the result of tagging an expression with its
    indeterminate class under a given state.  This is a *syntactic annotation*,
    not an assignment of a classical value.

    Convention F1: when `div e₁ e₂` is evaluated in a state that forces both
    `e₁` and `e₂` to zero, the expression receives `OriginTag.mk I0`.
    No algebraic identity is asserted. -/
structure OriginTag where
  /-- The indeterminate class that applies in the originating state. -/
  cls : IndetClass
  deriving DecidableEq, Repr

end TIF
/-
  Core/Types.lean
  Theory of Indeterminates Framework (TIF) — Core Type Definitions

  This file defines the fundamental types used throughout TIF:
    - IndetClass : the enumerated type of indeterminate origin tags
    - Result     : the type of evaluation results (Option-based)

  Status: Paper 1 core.
-/

namespace TIF

/-!
## IndetClass

An `IndetClass` is a syntactic *origin tag* for indeterminate expressions.
It records which classical indeterminate form gave rise to the expression.

These are **not** numerical values. No arithmetic is defined on `IndetClass`.
-/
inductive IndetClass : Type where
  /-- `0/0`: simultaneous zero numerator and denominator -/
  | zeroOverZero  : IndetClass
  /-- `0·∞`: one factor is zero, the other is unbounded -/
  | zeroMulInf    : IndetClass
  /-- `∞−∞`: both operands diverge without a cancellation law -/
  | infMinusInf   : IndetClass
  /-- `∞/∞`: both operands diverge -/
  | infOverInf    : IndetClass
  /-- `0⁰`: base and exponent both approach zero -/
  | zeroPowZero   : IndetClass
  /-- `1^∞`: base approaches 1, exponent diverges -/
  | onePowInf     : IndetClass
  deriving DecidableEq, Repr

namespace IndetClass

/-- Short notation aliases used in mathematical text. -/
abbrev I₀ : IndetClass := zeroOverZero
abbrev I₁ : IndetClass := zeroMulInf
abbrev I₂ : IndetClass := infMinusInf
abbrev I₃ : IndetClass := infOverInf
abbrev I₄ : IndetClass := zeroPowZero
abbrev I₅ : IndetClass := onePowInf

end IndetClass

/-!
## Axiom A1 (derived): Indeterminate class injectivity

`IndetClass` is an inductive type with distinct constructors, so injectivity
holds by `DecidableEq` and the standard Lean inductive machinery.

The statement `indet k₁ = indet k₂ ↔ k₁ = k₂` follows from the `Expr`
definition in `Core/Syntax.lean`.
-/

end TIF
-- Core/Types.lean
-- Defines the fundamental data structures for the Indeterminate Framework (TIF).
-- Part II, Section 2.1 of the Blueprint.

import Mathlib.Data.Real.Basic
import Mathlib.Data.Complex.Basic
import Mathlib.Data.List.Basic

/-- Indeterminate classes track the origin of each indeterminate symbol.
    - `base`      : the canonical indeterminate I (arising from 0/0, ∞−∞, etc.)
    - `ofOrigin s`: an indeterminate labeled by a string describing its source -/
inductive IndetClass where
  | base      : IndetClass
  | ofOrigin  : String → IndetClass
  deriving Repr, BEq, Inhabited

/-- Expressions over a coefficient type α (e.g., ℂ, ℝ, ℚ).
    Constants are classical values; `indet` is a labeled indeterminate symbol;
    the four binary nodes implement extended arithmetic operators ∘_I. -/
inductive Expr (α : Type) where
  | const : α → Expr α
  | indet : IndetClass → Expr α
  | add   : Expr α → Expr α → Expr α
  | sub   : Expr α → Expr α → Expr α
  | mul   : Expr α → Expr α → Expr α
  | div   : Expr α → Expr α → Expr α
  deriving Repr, Inhabited

namespace Expr

/-- Map a function over all constant leaves, leaving indeterminates untouched. -/
def mapConst {α β : Type} (f : α → β) : Expr α → Expr β
  | const c   => const (f c)
  | indet cls => indet cls
  | add l r   => add (mapConst f l) (mapConst f r)
  | sub l r   => sub (mapConst f l) (mapConst f r)
  | mul l r   => mul (mapConst f l) (mapConst f r)
  | div l r   => div (mapConst f l) (mapConst f r)

/-- Substitute every occurrence of a given indeterminate class with an expression. -/
def substIndet {α : Type} (cls : IndetClass) (replacement : Expr α) : Expr α → Expr α
  | const c     => const c
  | indet cls'  => if cls == cls' then replacement else indet cls'
  | add l r     => add (substIndet cls replacement l) (substIndet cls replacement r)
  | sub l r     => sub (substIndet cls replacement l) (substIndet cls replacement r)
  | mul l r     => mul (substIndet cls replacement l) (substIndet cls replacement r)
  | div l r     => div (substIndet cls replacement l) (substIndet cls replacement r)

/-- Evaluate an expression given a valuation for each indeterminate class.
    Returns `none` if a division by zero is encountered. -/
def eval {α : Type} [Field α] [DecidableEq α]
    (val : IndetClass → α) : Expr α → Option α
  | const c   => some c
  | indet cls => some (val cls)
  | add l r   => do
      let lv ← eval val l
      let rv ← eval val r
      some (lv + rv)
  | sub l r   => do
      let lv ← eval val l
      let rv ← eval val r
      some (lv - rv)
  | mul l r   => do
      let lv ← eval val l
      let rv ← eval val r
      some (lv * rv)
  | div l r   => do
      let lv ← eval val l
      let rv ← eval val r
      if rv = 0 then none else some (lv / rv)

/-- Return `true` if the expression contains no `indet` nodes. -/
def isClassical {α : Type} : Expr α → Bool
  | const _   => true
  | indet _   => false
  | add l r   => isClassical l && isClassical r
  | sub l r   => isClassical l && isClassical r
  | mul l r   => isClassical l && isClassical r
  | div l r   => isClassical l && isClassical r

end Expr
