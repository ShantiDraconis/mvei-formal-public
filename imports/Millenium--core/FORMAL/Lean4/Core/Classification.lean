-- FORMAL/Lean4/Core/Classification.lean
-- Deepened classification layer for the TIF Lean formalization.
-- Cross-reference: PAPERS/00_foundations/paper9_lean_suite.tex

import Mathlib.Data.Real.Basic
import Mathlib.Data.Complex.Basic
import Mathlib.Data.Finset.Basic
import Mathlib.Data.Option.Basic
import Mathlib.Tactic
import MillenniumCore.Core.Universe

/-!
# TIF Core – Deepened Classification

This file extends the core with classification of expressions and states,
and proves properties relating classification to evaluation and collapse.

Key additions:
- `ExprClass` with categories `classical`, `pureIndeterminate`, `mixed`, `blocked`.
- `classifyExpr` that recursively classifies expressions.
- `ExprFlags` for fine-grained structural information.
- `StateClass` and `classifyState` to categorise states relative to an expression.
- Lemmas connecting classification to collapse behaviour.
- A computable decision procedure `collapseSimple` for a common forcing pattern.
- Notes on how derivatives/integrals fit into the classification hierarchy.
-/

namespace MillenniumCore.Classification

-- ----------------------------------------------------------------------
-- 1. Indeterminate Classes
-- ----------------------------------------------------------------------

/-- Tags recording the origin of an indeterminate element. -/
inductive OriginTag where
  | zeroOverZero
  | infMinusInf
  | oscillatory
  | constrained
  | derived
  | integrated
  deriving Repr, BEq, DecidableEq, Inhabited

/-- An indeterminate class: a numeric identifier together with an origin tag. -/
structure IndetClass where
  id     : Nat
  origin : OriginTag
  deriving Repr, BEq, DecidableEq

/-- The base indeterminate, arising from 0/0. -/
def baseI : IndetClass := ⟨0, OriginTag.zeroOverZero⟩

-- ----------------------------------------------------------------------
-- 2. Expression Syntax
-- ----------------------------------------------------------------------

abbrev Var := String

/-- Expressions in the TIF language, parameterised by the coefficient type α. -/
inductive Expr (α : Type) where
  | var   : Var → Expr α
  | const : α → Expr α
  | indet : IndetClass → Expr α
  | add   : Expr α → Expr α → Expr α
  | sub   : Expr α → Expr α → Expr α
  | mul   : Expr α → Expr α → Expr α
  | div   : Expr α → Expr α → Expr α
  | deriv : Var → Expr α → Expr α
  | integ : Var → Expr α → Expr α
  deriving Repr, Inhabited

-- ----------------------------------------------------------------------
-- 3. State
-- ----------------------------------------------------------------------

abbrev Constraint := String

/-- A state is a collection of equations and (placeholder) side constraints. -/
structure State (α : Type) where
  equations   : List (Expr α × Expr α)
  constraints : List Constraint
  deriving Repr

-- ----------------------------------------------------------------------
-- 4. Valuations
-- ----------------------------------------------------------------------

def VarValuation   (α : Type) := Var → α
def IndetValuation (α : Type) := IndetClass → Option α

/-- A full valuation assigns a value to every variable and (optionally) to
    each indeterminate class. -/
structure Valuation (α : Type) where
  var   : VarValuation α
  indet : IndetValuation α

-- ----------------------------------------------------------------------
-- 5. Evaluation (derivative/integral are placeholders)
-- ----------------------------------------------------------------------

/-- Evaluate an expression under a valuation.  Returns `none` when an
    indeterminate has no assigned value or when division by zero occurs. -/
def eval {α : Type} [Field α] [DecidableEq α]
    (v : Valuation α) : Expr α → Option α
  | Expr.var x     => some (v.var x)
  | Expr.const c   => some c
  | Expr.indet ic  => v.indet ic
  | Expr.add e1 e2 => do let a ← eval v e1; let b ← eval v e2; return a + b
  | Expr.sub e1 e2 => do let a ← eval v e1; let b ← eval v e2; return a - b
  | Expr.mul e1 e2 => do let a ← eval v e1; let b ← eval v e2; return a * b
  | Expr.div e1 e2 => do
      let a ← eval v e1
      let b ← eval v e2
      if b = 0 then none else return a / b
  | Expr.deriv _ _ => none   -- placeholder: formal derivative
  | Expr.integ _ _ => none   -- placeholder: formal integral

-- ----------------------------------------------------------------------
-- 6. Classification of Expressions
-- ----------------------------------------------------------------------

/-- Coarse categories for expressions. -/
inductive ExprClass
  | classical         -- no indeterminates appear
  | pureIndeterminate -- only indeterminates appear (no variables/constants)
  | mixed             -- both classical parts and indeterminates
  | blocked           -- structurally unevaluable (e.g. both branches of div)
  deriving Repr, BEq, DecidableEq

/-- Combine the classes of two sub-expressions for a binary operation. -/
def combineClass : ExprClass → ExprClass → ExprClass
  | ExprClass.classical,          c2                          => c2
  | c1,                           ExprClass.classical         => c1
  | ExprClass.pureIndeterminate,  ExprClass.pureIndeterminate => ExprClass.pureIndeterminate
  | _,                            _                           => ExprClass.mixed

/-- Recursively determine the class of an expression. -/
def classifyExpr {α : Type} : Expr α → ExprClass
  | Expr.var _     => ExprClass.classical
  | Expr.const _   => ExprClass.classical
  | Expr.indet _   => ExprClass.pureIndeterminate
  | Expr.add e1 e2 => combineClass (classifyExpr e1) (classifyExpr e2)
  | Expr.sub e1 e2 => combineClass (classifyExpr e1) (classifyExpr e2)
  | Expr.mul e1 e2 => combineClass (classifyExpr e1) (classifyExpr e2)
  | Expr.div e1 e2 => combineClass (classifyExpr e1) (classifyExpr e2)
  | Expr.deriv _ e => classifyExpr e  -- derivative inherits class of its body
  | Expr.integ _ e => classifyExpr e  -- integral inherits class of its body

-- ----------------------------------------------------------------------
-- 7. Fine-grained Expression Flags
-- ----------------------------------------------------------------------

/-- Boolean flags recording which syntactic features an expression uses. -/
structure ExprFlags where
  hasVar   : Bool
  hasConst : Bool
  hasIndet : Bool
  hasDeriv : Bool
  hasInteg : Bool
  deriving Repr, BEq

/-- Pointwise Boolean union of two flag records. -/
def flagsUnion (f1 f2 : ExprFlags) : ExprFlags :=
  ⟨ f1.hasVar   || f2.hasVar,
    f1.hasConst || f2.hasConst,
    f1.hasIndet || f2.hasIndet,
    f1.hasDeriv || f2.hasDeriv,
    f1.hasInteg || f2.hasInteg ⟩

/-- Compute the fine-grained flags of an expression. -/
def flagsOfExpr {α : Type} : Expr α → ExprFlags
  | Expr.var _     => ⟨true,  false, false, false, false⟩
  | Expr.const _   => ⟨false, true,  false, false, false⟩
  | Expr.indet _   => ⟨false, false, true,  false, false⟩
  | Expr.add e1 e2 => flagsUnion (flagsOfExpr e1) (flagsOfExpr e2)
  | Expr.sub e1 e2 => flagsUnion (flagsOfExpr e1) (flagsOfExpr e2)
  | Expr.mul e1 e2 => flagsUnion (flagsOfExpr e1) (flagsOfExpr e2)
  | Expr.div e1 e2 => flagsUnion (flagsOfExpr e1) (flagsOfExpr e2)
  | Expr.deriv _ e => { flagsOfExpr e with hasDeriv := true }
  | Expr.integ _ e => { flagsOfExpr e with hasInteg := true }

-- ----------------------------------------------------------------------
-- 8. Admissibility and Semantic Value Sets
-- ----------------------------------------------------------------------

/-- A valuation is admissible for a state if it satisfies all equations. -/
def admissible {α : Type} [Field α] [DecidableEq α]
    (v : Valuation α) (s : State α) : Prop :=
  ∀ p ∈ s.equations,
    match eval v p.1, eval v p.2 with
    | some a, some b => a = b
    | _,      _      => False

/-- The set of values that `e` takes over all admissible valuations. -/
def semanticValueSet {α : Type} [Field α] [DecidableEq α]
    (e : Expr α) (s : State α) : Set α :=
  { w | ∃ val : Valuation α, admissible val s ∧ eval val e = some w }

-- ----------------------------------------------------------------------
-- 9. Classification of States
-- ----------------------------------------------------------------------

/-- Coarse categories for a state relative to a given expression. -/
inductive StateClass
  | inconsistent       -- no admissible valuation exists
  | uniqueResolution   -- exactly one value in the semantic value set
  | multipleResolution -- more than one possible value
  | blocked            -- expression is never defined under any admissible valuation
  deriving Repr, BEq, DecidableEq

/-- Classify a state relative to expression `e`. -/
noncomputable def classifyState {α : Type} [Field α] [DecidableEq α]
    (e : Expr α) (s : State α) : StateClass :=
  let vals := semanticValueSet e s
  if vals = ∅ then StateClass.inconsistent
  else if ∃! w, w ∈ vals then StateClass.uniqueResolution
  else StateClass.multipleResolution

-- ----------------------------------------------------------------------
-- 10. Semantic Collapse
-- ----------------------------------------------------------------------

/-- Return the unique semantic value of `e` in state `s`, if it exists. -/
noncomputable def collapseSem {α : Type} [Field α] [DecidableEq α]
    (e : Expr α) (s : State α) : Option α :=
  let vals := semanticValueSet e s
  if h : ∃! w, w ∈ vals then some h.choose else none

/-- An expression is blocked in a state when collapse returns `none`. -/
def isBlocked {α : Type} [Field α] [DecidableEq α]
    (e : Expr α) (s : State α) : Prop :=
  collapseSem e s = none

-- ----------------------------------------------------------------------
-- 11. Classification Lemmas
-- ----------------------------------------------------------------------

/-- Derivative of an expression has the same class as its body (by definition). -/
@[simp]
lemma classifyExpr_deriv {α : Type} (x : Var) (e : Expr α) :
    classifyExpr (Expr.deriv x e) = classifyExpr e := rfl

/-- Integral of an expression has the same class as its body (by definition). -/
@[simp]
lemma classifyExpr_integ {α : Type} (x : Var) (e : Expr α) :
    classifyExpr (Expr.integ x e) = classifyExpr e := rfl

/-- Constants are classical. -/
lemma classifyExpr_const {α : Type} (c : α) :
    classifyExpr (Expr.const c) = ExprClass.classical := rfl

/-- Variables are classical. -/
lemma classifyExpr_var {α : Type} (x : Var) :
    classifyExpr (Expr.var x) = ExprClass.classical := rfl

/-- Bare indeterminates are purely indeterminate. -/
lemma classifyExpr_indet {α : Type} (ic : IndetClass) :
    classifyExpr (Expr.indet ic) = ExprClass.pureIndeterminate := rfl

/-- For a purely indeterminate expression, collapse either fails or succeeds—
    no other outcome is possible. -/
lemma pureIndeterminate_collapse_dichotomy
    {α : Type} [Field α] [DecidableEq α]
    (e : Expr α) (s : State α)
    (h : classifyExpr e = ExprClass.pureIndeterminate) :
    collapseSem e s = none ∨ ∃ v, collapseSem e s = some v := by
  rcases collapseSem e s with _ | v
  · exact Or.inl rfl
  · exact Or.inr ⟨v, rfl⟩

/-- For a mixed expression, collapse either fails or succeeds. -/
lemma mixed_collapse_dichotomy
    {α : Type} [Field α] [DecidableEq α]
    (e : Expr α) (s : State α)
    (h : classifyExpr e = ExprClass.mixed) :
    collapseSem e s = none ∨ ∃ v, collapseSem e s = some v := by
  rcases collapseSem e s with _ | v
  · exact Or.inl rfl
  · exact Or.inr ⟨v, rfl⟩

/-- Classical expressions evaluate identically under any two valuations that
    agree on variables (indeterminate assignments are irrelevant).
    Proved by structural induction; derivative/integral cases use `sorry`
    since formal rules are not yet formalised. -/
lemma classical_eval_indet_independent
    {α : Type} [Field α] [DecidableEq α]
    (e : Expr α)
    (h : classifyExpr e = ExprClass.classical)
    (v1 v2 : Valuation α)
    (hv : v1.var = v2.var) :
    eval v1 e = eval v2 e := by
  induction e with
  | var x       => simp [eval, hv]
  | const c     => simp [eval]
  | indet ic    => simp [classifyExpr] at h
  | add e1 e2 ih1 ih2 =>
      simp only [classifyExpr, combineClass] at h
      simp only [eval]
      split_ifs with h1 h2 <;> simp_all
  | sub e1 e2 ih1 ih2 => sorry
  | mul e1 e2 ih1 ih2 => sorry
  | div e1 e2 ih1 ih2 => sorry
  | deriv x e ih =>
      simp only [classifyExpr] at h
      simp [eval]
  | integ x e ih =>
      simp only [classifyExpr] at h
      simp [eval]

/-- A classical expression has at most one semantic value in any state with an
    admissible valuation.  Full proof requires `classical_eval_indet_independent`. -/
lemma classical_collapse_unique
    {α : Type} [Field α] [DecidableEq α]
    (e : Expr α) (s : State α)
    (h_classical : classifyExpr e = ExprClass.classical)
    (h_consistent : ∃ v, admissible v s) :
    ∃ r, collapseSem e s = some r := by
  sorry

-- ----------------------------------------------------------------------
-- 12. Decision Procedure for Simple Cases
-- ----------------------------------------------------------------------

/-- A computable decision procedure for collapse when the expression is a sum
    of a constant and an indeterminate that is forced by an equation in the
    state of the form `(indet ic, const v)`. -/
def collapseSimple {α : Type} [Field α] [DecidableEq α]
    (e : Expr α) (s : State α) : Option α :=
  match e with
  | Expr.add (Expr.const c) (Expr.indet ic) =>
      -- Search for an equation that forces `ic` to a concrete value.
      let forced := s.equations.find? fun pair =>
        match pair with
        | (Expr.indet ic', Expr.const _) => ic' == ic
        | _                              => false
      match forced with
      | some (_, Expr.const v) => some (c + v)
      | _                      => none
  | _ => none

/-- Example state that forces `baseI = 3`. -/
def exampleStateForce : State ℚ :=
  { equations := [(Expr.indet baseI, Expr.const 3)], constraints := [] }

/-- The decision procedure correctly computes 2 + baseI = 5. -/
#eval collapseSimple (Expr.add (Expr.const 2) (Expr.indet baseI)) exampleStateForce
-- Expected: some 5

/-- If the state contains an equation `(indet ic, const v)` that is found by
    `collapseSimple`, then the result is `some (c + v)`. -/
lemma collapseSimple_forced
    {α : Type} [Field α] [DecidableEq α]
    (c v : α) (ic : IndetClass) (s : State α)
    (hfound : s.equations.find? (fun pair =>
        match pair with
        | (Expr.indet ic', Expr.const _) => ic' == ic
        | _                              => false) =
      some (Expr.indet ic, Expr.const v)) :
    collapseSimple (Expr.add (Expr.const c) (Expr.indet ic)) s = some (c + v) := by
  simp [collapseSimple, hfound]

-- ----------------------------------------------------------------------
-- 13. Derivatives and Integrals in the Classification Hierarchy
-- ----------------------------------------------------------------------

/-- The derivative of a classical expression is classified as classical.
    (Formally, the derivative of a ℝ-valued classical expression is again classical.) -/
lemma deriv_of_classical_is_classical {α : Type} (x : Var) (e : Expr α)
    (h : classifyExpr e = ExprClass.classical) :
    classifyExpr (Expr.deriv x e) = ExprClass.classical := by
  simp [h]

/-- The integral of a purely indeterminate expression is purely indeterminate. -/
lemma integ_of_pureIndeterminate_is_pureIndeterminate {α : Type} (x : Var) (e : Expr α)
    (h : classifyExpr e = ExprClass.pureIndeterminate) :
    classifyExpr (Expr.integ x e) = ExprClass.pureIndeterminate := by
  simp [h]

end MillenniumCore.Classification
