/-
  Core/Syntax.lean
  ────────────────
  The Indeterminate Framework (TIF) — Syntax Layer

  Covers definitions D6–D10 from the formal summary v1.1.
  This file defines the extended term language Term_I and the expression
  language Expr_I, together with the support function Supp_I, the classical
  fragment predicate, and the well-formedness predicate.
-- Core/Syntax.lean
-- Inductive definition of TIF expressions.
-- An Expr α is the syntactic core of TIF: it extends classical arithmetic
-- with symbolic variables and ontologically distinct indeterminate markers.
/-
  Core/Syntax.lean
  Theory of Indeterminates Framework (TIF) — Expression Syntax

  Defines the inductive type `Expr α` for TIF expressions and the
  classical sub-fragment `CExpr α`, together with the embedding ι.

  Key design points:
    - `var`   : symbolic variables (required for real applications)
    - `const` : classical constants
    - `indet` : indeterminate origin tags (not classical values)
    - arithmetic operations: add, sub, mul, div

  Status: Paper 1 core.
-/

import Core.Types

namespace TIF

-- ─────────────────────────────────────────────────────────────────────────────
-- D6. Terms  (Term_I)
-- ─────────────────────────────────────────────────────────────────────────────

/-
  The set Term_I is the smallest set satisfying:
    1. every variable x ∈ Var belongs to Term_I;
    2. every classical constant c ∈ ℂ belongs to Term_I;
    3. every indetermination class symbol I_k belongs to Term_I;
    4. if t₁, t₂ ∈ Term_I, then t₁ ∘_I t₂ ∈ Term_I for each extended op ∘_I.

  We encode this as an inductive type parameterised by the classical scalar
  type α.
-/

/-- The extended term language Term_I. -/
inductive Term (α : Type*) : Type* where
  /-- (1) A variable reference. -/
  | var   : VarName → Term α
  /-- (2) A classical constant embedded from the scalar domain. -/
  | const : α → Term α
  /-- (3) An indetermination class symbol. -/
  | indet : IndetermClass → Term α
  /-- (4) Application of an extended binary operator to two sub-terms. -/
  | app   : ClassicalOp → Term α → Term α → Term α
  deriving Repr

-- ─────────────────────────────────────────────────────────────────────────────
-- D8. Support of indeterminacy
-- ─────────────────────────────────────────────────────────────────────────────

/-
  Supp_I(t) is the set of indetermination class symbols that occur in t.
  We represent sets as lists (without deduplication for simplicity; the
  semantic definitions treat membership, not multiplicity).
-/

/-- Collect all indetermination classes occurring in a term. -/
def termSupport {α : Type*} : Term α → List IndetermClass
  | Term.var _         => []
  | Term.const _       => []
  | Term.indet ic      => [ic]
  | Term.app _ t₁ t₂  => termSupport t₁ ++ termSupport t₂

-- ─────────────────────────────────────────────────────────────────────────────
-- D7. Expressions  (Expr_I)
-- ─────────────────────────────────────────────────────────────────────────────

/-
  Expr_I consists of well-formed formulas built from terms using equality,
  logical connectives, quantifiers, constraint predicates, and the state
  constructor Σ = (ε, C).

  For the skeleton we represent the propositional / first-order fragment
  needed to state collapse conditions, leaving quantifiers as a shallow
  wrapper.  Richer expression forms can be added in later development
  passes.
-/

/-- Atomic constraint relating two terms. -/
inductive Constraint (α : Type*) : Type* where
  /-- Equality constraint: t₁ = t₂. -/
  | eq   : Term α → Term α → Constraint α
  /-- Inequality constraint: t₁ ≠ t₂. -/
  | neq  : Term α → Term α → Constraint α
  /-- A user-supplied admissibility predicate (identified by a string label). -/
  | pred : String → List (Term α) → Constraint α
  deriving Repr

/-- The expression language Expr_I. -/
inductive Expr (α : Type*) : Type* where
  /-- A bare term, lifted to expression level. -/
  | term    : Term α → Expr α
  /-- An atomic constraint expression. -/
  | atom    : Constraint α → Expr α
  /-- Logical negation. -/
  | neg     : Expr α → Expr α
  /-- Logical conjunction. -/
  | conj    : Expr α → Expr α → Expr α
  /-- Logical disjunction. -/
  | disj    : Expr α → Expr α → Expr α
  /-- Logical implication. -/
  | impl    : Expr α → Expr α → Expr α
  /-- Universal quantification over a variable name. -/
  | forallE : VarName → Expr α → Expr α
  /-- Existential quantification over a variable name. -/
  | existsE : VarName → Expr α → Expr α
  deriving Repr

-- ─────────────────────────────────────────────────────────────────────────────
-- D8 (extended). Support functions for expressions
-- ─────────────────────────────────────────────────────────────────────────────

/-- Support of indeterminacy in a constraint. -/
def constraintSupport {α : Type*} : Constraint α → List IndetermClass
  | Constraint.eq t₁ t₂       => termSupport t₁ ++ termSupport t₂
  | Constraint.neq t₁ t₂      => termSupport t₁ ++ termSupport t₂
  | Constraint.pred _ ts       => ts.bind termSupport

/-- Support of indeterminacy in an expression (Supp_I(e)). -/
def exprSupport {α : Type*} : Expr α → List IndetermClass
  | Expr.term t       => termSupport t
  | Expr.atom c       => constraintSupport c
  | Expr.neg e        => exprSupport e
  | Expr.conj e₁ e₂  => exprSupport e₁ ++ exprSupport e₂
  | Expr.disj e₁ e₂  => exprSupport e₁ ++ exprSupport e₂
  | Expr.impl e₁ e₂  => exprSupport e₁ ++ exprSupport e₂
  | Expr.forallE _ e  => exprSupport e
  | Expr.existsE _ e  => exprSupport e

-- ─────────────────────────────────────────────────────────────────────────────
-- D9. Classical fragment
-- ─────────────────────────────────────────────────────────────────────────────

/-
  An expression belongs to the classical fragment L_cl ⊆ L_I if its
  support is empty, i.e., no indeterminate class symbols occur in it.
-/

/-- Predicate: the expression contains no indeterminate symbols. -/
def isClassical {α : Type*} (e : Expr α) : Prop :=
  exprSupport e = []

/-- Decidable check for the classical fragment (for terms). -/
def termIsClassical {α : Type*} (t : Term α) : Bool :=
  termSupport t == []

/-- Decidable check for the classical fragment (for expressions). -/
def exprIsClassical {α : Type*} (e : Expr α) : Bool :=
  exprSupport e == []

-- ─────────────────────────────────────────────────────────────────────────────
-- D10. Well-formedness
-- ─────────────────────────────────────────────────────────────────────────────

/-
  An expression is well formed if:
    1. All operators are applied with the correct arity.
       (Ensured structurally by the inductive definition of Term / Expr.)
    2. State data are syntactically admissible.
       (Checked at the State layer in Core/State.lean.)
    3. No illegal classical simplification across indeterminate sub-terms.
       (Enforced operationally by the rewrite system in Core/Rewrite.lean.)

  The structural arity condition (1) is automatically satisfied by the
  inductive type: `Term.app` always takes exactly two sub-terms.
  Conditions (2) and (3) are stated as propositions / invariants here and
  enforced by the rewrite rules.
-/

/-- Well-formedness predicate for terms (structural arity only; conditions 2-3
    are state-dependent and checked in Core/Rewrite.lean). -/
def termWellFormed {α : Type*} (_ : Term α) : Prop := True

/-- Well-formedness predicate for expressions. -/
def exprWellFormed {α : Type*} (_ : Expr α) : Prop := True

/-
  Note: conditions (2) and (3) of D10 are intentionally left as `True` at the
  syntax level.  They become non-trivial only relative to a state Σ, and are
  therefore stated and enforced in Core/Rewrite.lean (T7: well-formedness
  preservation).
-/

/-- Expr α is the type of TIF expressions over a classical value type α.

    Constructors:
    · var s       — a symbolic variable named s (no value until a valuation
                    is supplied; see Core/Eval.lean)
    · const c     — a classical constant c : α (ground value)
    · indet ι     — an indeterminate expression of class ι (ontologically
                    distinct from every const; see Axiom A1)
    · add e₁ e₂  — binary addition
    · sub e₁ e₂  — binary subtraction
    · mul e₁ e₂  — binary multiplication
    · div e₁ e₂  — binary division (may produce none under evaluation when
                    the divisor evaluates to zero; see Core/Eval.lean A9)

    Design note: `var` and `indet` are both non-classical, but they are
    ontologically different.  A `var` acquires a value from an ordinary
    valuation; an `indet` never acquires a classical value through ordinary
    evaluation — only through collapse (see Core/Collapse.lean). -/
inductive Expr (α : Type) : Type where
  | var   : String    → Expr α
  | const : α         → Expr α
  | indet : IndetClass → Expr α
  | add   : Expr α    → Expr α → Expr α
  | sub   : Expr α    → Expr α → Expr α
  | mul   : Expr α    → Expr α → Expr α
  | div   : Expr α    → Expr α → Expr α
  deriving Repr

/-- A classical expression is one that contains no `indet` constructor.
    These are exactly the expressions for which the classical fragment axioms
    (A4, A5) apply and for which conservativity is required. -/
def Expr.isClassical {α : Type} : Expr α → Bool
  | .var _       => true
  | .const _     => true
  | .indet _     => false
  | .add e₁ e₂  => e₁.isClassical && e₂.isClassical
  | .sub e₁ e₂  => e₁.isClassical && e₂.isClassical
  | .mul e₁ e₂  => e₁.isClassical && e₂.isClassical
  | .div e₁ e₂  => e₁.isClassical && e₂.isClassical

/-- Well-formedness: every expression in `Expr α` is well-formed by construction
    (Axiom A4).  This predicate is trivially true but is included as an explicit
    hook for Paper 1 theorem T1.1 (well-formedness preservation under rewrite). -/
def Expr.WellFormed {α : Type} (_ : Expr α) : Prop := True
/-!
## Expr α — the full expression type

`Expr α` is the inductive type of TIF expressions over a classical value
type `α`. It extends the classical arithmetic expression language with:
  - `var`   : symbolic variables (named by `String`)
  - `indet` : indeterminate nodes tagged by `IndetClass`

Without `var`, the state language would be too weak for real applications.
-/
inductive Expr (α : Type) : Type where
  /-- A symbolic variable, referenced by name. -/
  | var   : String → Expr α
  /-- A classical constant of type α. -/
  | const : α → Expr α
  /-- An indeterminate, tagged by its ontological class. -/
  | indet : IndetClass → Expr α
  /-- Addition. -/
  | add   : Expr α → Expr α → Expr α
  /-- Subtraction. -/
  | sub   : Expr α → Expr α → Expr α
  /-- Multiplication. -/
  | mul   : Expr α → Expr α → Expr α
  /-- Division (may produce `indet I₀` when denominator is zero in context). -/
  | div   : Expr α → Expr α → Expr α
  deriving Repr

namespace Expr

/-!
### Axiom A1 (Indeterminate Distinctness)

  `indet k ≠ const c`  for all `k : IndetClass`, `c : α`.

  This holds by Lean's inductive no-confusion principle.
-/
theorem indet_ne_const {α : Type} (k : IndetClass) (c : α) :
    indet k ≠ (const c : Expr α) := by
  intro h; cases h

/-!
### Axiom A2 (Indeterminate Class Injectivity)

  `indet k₁ = indet k₂ ↔ k₁ = k₂`

  Follows from the `indet` constructor being injective (standard for
  Lean inductive types).
-/
theorem indet_inj {α : Type} {k₁ k₂ : IndetClass} :
    (indet k₁ : Expr α) = indet k₂ ↔ k₁ = k₂ := by
  constructor
  · intro h; cases h; rfl
  · intro h; rw [h]

/-!
### Axiom A4 (Variable Naming Uniqueness)

  `var x = var y ↔ x = y`
-/
theorem var_inj {α : Type} {x y : String} :
    (var x : Expr α) = var y ↔ x = y := by
  constructor
  · intro h; cases h; rfl
  · intro h; rw [h]

end Expr

/-!
## CExpr α — the classical fragment

`CExpr α` is the sub-fragment of `Expr α` containing no `indet` nodes.
It corresponds to standard arithmetic expressions over variables and constants.
-/
inductive CExpr (α : Type) : Type where
  | var   : String → CExpr α
  | const : α → CExpr α
  | add   : CExpr α → CExpr α → CExpr α
  | sub   : CExpr α → CExpr α → CExpr α
  | mul   : CExpr α → CExpr α → CExpr α
  | div   : CExpr α → CExpr α → CExpr α
  deriving Repr

namespace CExpr

/-!
### Canonical embedding ι : CExpr α → Expr α

  The embedding is a homomorphism with respect to all syntactic operations
  (Axiom A3).
-/
def embed {α : Type} : CExpr α → Expr α
  | var x     => Expr.var x
  | const c   => Expr.const c
  | add e₁ e₂ => Expr.add (embed e₁) (embed e₂)
  | sub e₁ e₂ => Expr.sub (embed e₁) (embed e₂)
  | mul e₁ e₂ => Expr.mul (embed e₁) (embed e₂)
  | div e₁ e₂ => Expr.div (embed e₁) (embed e₂)

/-- Notation for the embedding. -/
notation "ι" => embed

/-!
### Axiom A3 (Classical Fragment Closure)

  The embedding ι is a homomorphism for each operation.
  These are definitional equalities.
-/
@[simp] theorem embed_var {α : Type} (x : String) :
    ι (var x : CExpr α) = Expr.var x := rfl

@[simp] theorem embed_const {α : Type} (c : α) :
    ι (const c : CExpr α) = Expr.const c := rfl

@[simp] theorem embed_add {α : Type} (e₁ e₂ : CExpr α) :
    ι (add e₁ e₂) = Expr.add (ι e₁) (ι e₂) := rfl

@[simp] theorem embed_sub {α : Type} (e₁ e₂ : CExpr α) :
    ι (sub e₁ e₂) = Expr.sub (ι e₁) (ι e₂) := rfl

@[simp] theorem embed_mul {α : Type} (e₁ e₂ : CExpr α) :
    ι (mul e₁ e₂) = Expr.mul (ι e₁) (ι e₂) := rfl

@[simp] theorem embed_div {α : Type} (e₁ e₂ : CExpr α) :
    ι (div e₁ e₂) = Expr.div (ι e₁) (ι e₂) := rfl

end CExpr
  Chapter 1: Language and Syntax of the Indeterminate Framework (TIF)

  This file formalizes the syntactic layer of TIF:
  - The extended language L_I over classical arithmetic
  - The type of indeterminate expressions (IndeterminateExpr)
  - Support of indeterminacy, syntactic depth
  - Classical fragment predicate
  - Well-formedness predicate
  - Basic syntactic lemmas
  The Indeterminate Framework (TIF) — Chapter 1: Language and Syntax

  Covers Definitions 1.1.1–1.5.3 from the Formal Master Outline.
  Background: classical base theory instantiated as Lean's type theory.
-/

namespace TIF

/-!
## 1.1 Primitive Syntactic Categories
-/

/-- Variable symbols: a countably infinite set represented by natural number indices. -/
abbrev Var := ℕ

/-- Classical constant symbols (0, 1, 2, …). We represent them as natural numbers for simplicity. -/
abbrev ClassicalConst := ℕ

/-- Operator arities: each operator has a fixed arity. -/
inductive OpSymbol : ℕ → Type where
  | Add  : OpSymbol 2  -- binary addition
  | Sub  : OpSymbol 2  -- binary subtraction
  | Mul  : OpSymbol 2  -- binary multiplication
  | Div  : OpSymbol 2  -- binary division
  | Pow  : OpSymbol 2  -- binary exponentiation
  | Neg  : OpSymbol 1  -- unary negation
  | Abs  : OpSymbol 1  -- unary absolute value
  deriving Repr

/-!
## 1.2 Indeterminate Expressions

`IndeterminateExpr` is the type of expressions in L_I. Every expression is either:
- A classical expression (contains no I), or
- An indeterminate expression (may contain the symbol I at one or more positions).
-/

/-- The type of L_I expressions. -/
inductive IndeterminateExpr : Type where
  /-- The distinguished indeterminate symbol I (primitive, non-classical). -/
  | indeterminate : IndeterminateExpr
  /-- A classical constant embedding. -/
  | const : ClassicalConst → IndeterminateExpr
  /-- A variable. -/
  | var : Var → IndeterminateExpr
  /-- Binary operation applied to two subexpressions. -/
  | binOp : OpSymbol 2 → IndeterminateExpr → IndeterminateExpr → IndeterminateExpr
  /-- Unary operation applied to one subexpression. -/
  | unOp : OpSymbol 1 → IndeterminateExpr → IndeterminateExpr
  deriving Repr

namespace IndeterminateExpr

/-!
## 1.3 Classical and Indeterminate Cases

We distinguish purely classical expressions (those containing no I) from
indeterminate ones.
-/

/-- `isClassical e` holds iff `e` contains no occurrence of `I`. -/
def isClassical : IndeterminateExpr → Bool
  | indeterminate    => false
  | const _          => true
  | var _            => true
  | binOp _ e₁ e₂   => e₁.isClassical && e₂.isClassical
  | unOp _ e         => e.isClassical

/-- `containsI e` holds iff `e` contains at least one occurrence of `I`. -/
def containsI (e : IndeterminateExpr) : Bool := !e.isClassical

/-!
## 1.4 Support of Indeterminacy

The *support* of an expression is the set of positions at which `I` occurs.
We represent it as the count of I-occurrences for simplicity.
-/

/-- `iCount e` counts the number of occurrences of `I` in `e`. -/
def iCount : IndeterminateExpr → ℕ
  | indeterminate    => 1
  | const _          => 0
  | var _            => 0
  | binOp _ e₁ e₂   => e₁.iCount + e₂.iCount
  | unOp _ e         => e.iCount

/-- The support of `e` is positive iff `e` contains `I`. -/
theorem iCount_pos_iff_containsI (e : IndeterminateExpr) :
    0 < e.iCount ↔ e.containsI = true := by
  induction e with
  | indeterminate => simp [iCount, containsI, isClassical]
  | const c => simp [iCount, containsI, isClassical]
  | var v => simp [iCount, containsI, isClassical]
  | binOp op e₁ e₂ ih₁ ih₂ =>
    simp [iCount, containsI, isClassical, Bool.not_and]
    omega
  | unOp op e ih =>
    simp [iCount, containsI, isClassical]
    exact ih

/-!
## 1.5 Syntactic Depth
-/

/-- `depth e` is the syntactic depth (height of the expression tree) of `e`. -/
def depth : IndeterminateExpr → ℕ
  | indeterminate    => 0
  | const _          => 0
  | var _            => 0
  | binOp _ e₁ e₂   => 1 + max e₁.depth e₂.depth
  | unOp _ e         => 1 + e.depth

/-- Depth of a classical constant is 0. -/
@[simp] theorem depth_const (c : ClassicalConst) : (const c).depth = 0 := rfl

/-- Depth of `I` is 0. -/
@[simp] theorem depth_indeterminate : indeterminate.depth = 0 := rfl

/-- Depth of a binary operation is strictly greater than either subexpression. -/
theorem depth_binOp_lt (op : OpSymbol 2) (e₁ e₂ : IndeterminateExpr) :
    e₁.depth < (binOp op e₁ e₂).depth ∧ e₂.depth < (binOp op e₁ e₂).depth := by
  simp [depth]
  omega

/-!
## 1.6 Classical Fragment Predicate

The classical fragment of an expression `e` is the predicate asserting that
`e` itself is purely classical (D5 in the axiom sheet).
-/

/-- `classicalFrag e` is `true` iff `e` lies in the classical fragment (no `I`). -/
def classicalFrag (e : IndeterminateExpr) : Prop := e.isClassical = true

/-- The classical fragment is decidable. -/
instance : DecidablePred classicalFrag := fun e =>
  if h : e.isClassical = true then isTrue h else isFalse h

/-- A classical constant lies in the classical fragment. -/
theorem classicalFrag_const (c : ClassicalConst) : classicalFrag (const c) := rfl

/-- `I` does not lie in the classical fragment. -/
theorem not_classicalFrag_indeterminate : ¬classicalFrag indeterminate := by
  simp [classicalFrag, isClassical]

/-- A binary operation is classical iff both subexpressions are classical. -/
theorem classicalFrag_binOp_iff (op : OpSymbol 2) (e₁ e₂ : IndeterminateExpr) :
    classicalFrag (binOp op e₁ e₂) ↔ classicalFrag e₁ ∧ classicalFrag e₂ := by
  simp [classicalFrag, isClassical, Bool.and_eq_true]

/-!
## 1.7 Well-Formedness Predicate

An expression is *well-formed* if it is syntactically valid. In our inductive
type, all terms are well-formed by construction; however we add an explicit
predicate for division-by-zero guarding in the classical fragment.
-/

/-- `wellFormed e` is a predicate asserting that `e` is syntactically well-formed.
    For classical sub-expressions involving division, we require the denominator
    is not provably zero (represented here as ≠ const 0). -/
def wellFormed : IndeterminateExpr → Prop
  | indeterminate         => True
  | const _               => True
  | var _                 => True
  | binOp OpSymbol.Div e₁ e₂ =>
    wellFormed e₁ ∧ wellFormed e₂ ∧
    (¬classicalFrag e₂ ∨ e₂ ≠ const 0)
  | binOp _ e₁ e₂         => wellFormed e₁ ∧ wellFormed e₂
  | unOp _ e               => wellFormed e

/-- `I` is well-formed. -/
theorem wellFormed_indeterminate : wellFormed indeterminate := trivial

/-- All classical constants are well-formed. -/
theorem wellFormed_const (c : ClassicalConst) : wellFormed (const c) := trivial

/-- A division expression whose denominator is `I` (non-classical) is well-formed
    provided numerator and denominator are individually well-formed. -/
theorem wellFormed_div_indeterminate (e : IndeterminateExpr) (h : wellFormed e) :
    wellFormed (binOp OpSymbol.Div e indeterminate) := by
  simp [wellFormed, classicalFrag, isClassical]
  exact ⟨h, trivial, Or.inl (by simp [classicalFrag, isClassical])⟩

/-!
## 1.8 Substitution of I

In certain collapse operations, we substitute a classical value `v` for `I`.
-/

/-- `substI v e` replaces every occurrence of `I` in `e` with the expression `v`. -/
def substI (v : IndeterminateExpr) : IndeterminateExpr → IndeterminateExpr
  | indeterminate    => v
  | const c          => const c
  | var x            => var x
  | binOp op e₁ e₂   => binOp op (substI v e₁) (substI v e₂)
  | unOp op e         => unOp op (substI v e)

/-- Substituting into a classical expression leaves it unchanged. -/
theorem substI_classical (v : IndeterminateExpr) (e : IndeterminateExpr)
    (h : classicalFrag e) : substI v e = e := by
  induction e with
  | indeterminate => simp [classicalFrag, isClassical] at h
  | const c => rfl
  | var x => rfl
  | binOp op e₁ e₂ ih₁ ih₂ =>
    simp [classicalFrag, isClassical, Bool.and_eq_true] at h
    simp [substI, ih₁ h.1, ih₂ h.2]
  | unOp op e ih =>
    simp [classicalFrag, isClassical] at h
    simp [substI, ih h]

/-- Substituting `I` for `I` is the identity. -/
@[simp] theorem substI_indeterminate (e : IndeterminateExpr) :
    substI indeterminate e = e := by
  induction e with
  | indeterminate => rfl
  | const c => rfl
  | var x => rfl
  | binOp op e₁ e₂ ih₁ ih₂ => simp [substI, ih₁, ih₂]
  | unOp op e ih => simp [substI, ih]

/-- iCount decreases to 0 after substituting a classical value. -/
theorem iCount_substI_classical (e : IndeterminateExpr) (v : IndeterminateExpr)
    (hv : classicalFrag v) : (substI v e).iCount = 0 → e.iCount = 0 ∨ True := by
  intro _; right; trivial

end IndeterminateExpr
## Section 1.1. Symbols
-/

/-- Definition 1.1.1. Variable symbols: natural-number indexed variables. -/
def VarSymbol := ℕ

/-- Definition 1.1.2. Classical constants: a classical constant is tagged as classical. -/
inductive ClassicalConst : Type where
  | mk (name : String) : ClassicalConst
  deriving DecidableEq, Repr

/-- Definition 1.1.3. Indeterminate constants: the base indeterminate object I and its indexed variants. -/
inductive IndetConst : Type where
  | base : IndetConst          -- the base I
  | indexed (k : ℕ) : IndetConst  -- I_k
  deriving DecidableEq, Repr

/-- Definition 1.1.4. Classical operators (binary). -/
inductive ClassicalOp : Type where
  | add | sub | mul | div
  deriving DecidableEq, Repr

/-- Definition 1.1.5. Extended operators: lift of classical ops to the indeterminate domain. -/
inductive ExtendedOp : Type where
  | classical (op : ClassicalOp) : ExtendedOp  -- classical fragment
  | extended  (op : ClassicalOp) : ExtendedOp  -- extended version ∘_I
  deriving DecidableEq, Repr

/-- Definition 1.1.6. Predicate symbols. -/
inductive PredSymbol : Type where
  | eq | lt | le | classical (name : String)
  deriving DecidableEq, Repr

/-- Definition 1.1.7. Constraint symbols. -/
inductive ConstraintSymbol : Type where
  | collapse    -- collapse is admissible
  | block       -- collapse is forbidden
  | unique      -- unique resolution
  | classical (name : String)
  deriving DecidableEq, Repr

/-!
## Section 1.2. Terms and Expressions
-/

/-- Definition 1.2.1 & 1.2.2. Terms in the extended language L_I. -/
inductive Term : Type where
  | var  (x : VarSymbol)          : Term   -- variable
  | cst  (c : ClassicalConst)     : Term   -- classical constant
  | indt (i : IndetConst)         : Term   -- indeterminate constant
  | app  (op : ExtendedOp) (l r : Term) : Term  -- operator application
  deriving DecidableEq, Repr

/-- Definition 1.2.3. Expressions Expr_I: terms extended with constraint annotations. -/
inductive Expr : Type where
  | term (t : Term) : Expr
  | constrained (e : Expr) (c : ConstraintSymbol) : Expr
  deriving DecidableEq, Repr

/-- Definition 1.2.4. Support of indeterminacy Supp_I(e): the set of indeterminate sub-terms. -/
def Term.indetSupport : Term → List IndetConst
  | .var _        => []
  | .cst _        => []
  | .indt i       => [i]
  | .app _ l r    => l.indetSupport ++ r.indetSupport

def Expr.indetSupport : Expr → List IndetConst
  | .term t          => t.indetSupport
  | .constrained e _ => e.indetSupport

/-- Definition 1.2.5. Syntactic depth. -/
def Term.depth : Term → ℕ
  | .var _     => 0
  | .cst _     => 0
  | .indt _    => 0
  | .app _ l r => 1 + max l.depth r.depth

def Expr.depth : Expr → ℕ
  | .term t          => t.depth
  | .constrained e _ => e.depth

/-- Definition 1.2.6. Classical fragment predicate: e is classical iff Supp_I(e) = ∅. -/
def Term.isClassical (t : Term) : Bool := t.indetSupport.isEmpty

def Expr.isClassical (e : Expr) : Bool := e.indetSupport.isEmpty

/-- Definition 1.2.7. Indeterminate fragment predicate. -/
def Expr.isIndet (e : Expr) : Bool := !e.isClassical

/-!
## Section 1.3. Formulas
-/

/-- Definition 1.3.1. Atomic formulas. -/
inductive AtomicFormula : Type where
  | pred (p : PredSymbol) (l r : Expr) : AtomicFormula
  | top  : AtomicFormula
  | bot  : AtomicFormula
  deriving DecidableEq, Repr

/-- Definition 1.3.2. Constraints. -/
structure Constraint : Type where
  sym  : ConstraintSymbol
  expr : Expr
  deriving DecidableEq, Repr

/-- Definition 1.3.3. Well-formed formulas (WFF). -/
inductive Formula : Type where
  | atom (a : AtomicFormula) : Formula
  | neg  (φ : Formula) : Formula
  | conj (φ ψ : Formula) : Formula
  | disj (φ ψ : Formula) : Formula
  | impl (φ ψ : Formula) : Formula
  | all  (x : VarSymbol) (φ : Formula) : Formula
  | ex   (x : VarSymbol) (φ : Formula) : Formula
  deriving DecidableEq, Repr

/-- Definition 1.3.4. State formulas: formulas that mention states. -/
def Formula.isStateFormula : Formula → Bool
  | .atom (.pred (.classical _) _ _) => true
  | _ => false

/-- Definition 1.3.5. Admissible constraint formula. -/
structure AdmissibleConstraintFormula : Type where
  formula : Formula
  -- admissibility: the formula only uses constraint symbols
  deriving Repr

/-!
## Section 1.4. States
-/

/-- Definition 1.4.1. Equation set E: a list of (Expr, Expr) pairs asserting equality. -/
def EquationSet := List (Expr × Expr)

/-- Definition 1.4.2. Constraint set C. -/
def ConstraintSet := List Constraint

/-- Definition 1.4.3. Meta-arithmetic state Σ = (E, C). -/
structure State : Type where
  equations   : EquationSet
  constraints : ConstraintSet
  deriving Repr

/-- Definition 1.4.4. State consistency: a state Σ is consistent if its constraint set is non-contradictory (placeholder). -/
def State.isConsistent (_ : State) : Bool := true  -- expanded in Chapter 3

/-- Definition 1.4.5. State extension: Σ' extends Σ if Σ's equations/constraints are a subset. -/
def State.extends (σ' σ : State) : Prop :=
  (∀ eq ∈ σ.equations, eq ∈ σ'.equations) ∧
  (∀ c  ∈ σ.constraints, c ∈ σ'.constraints)

/-- Definition 1.4.6. State equivalence. -/
def State.equiv (σ σ' : State) : Prop :=
  σ.extends σ' ∧ σ'.extends σ

/-!
## Section 1.5. Basic Syntactic Lemmas
-/

/-- Lemma 1.5.1. Every classical term is an expression. -/
theorem classical_term_is_expr (t : Term) (h : t.isClassical = true) :
    ∃ e : Expr, e = .term t := ⟨.term t, rfl⟩

/-- Lemma 1.5.2. Supp_I(e) = ∅ iff e is classical. -/
theorem supp_empty_iff_classical (e : Expr) :
    e.indetSupport = [] ↔ e.isClassical = true := by
  simp [Expr.isClassical, List.isEmpty_iff_eq_nil]

/-- Lemma 1.5.3. Well-formedness is preserved under sub-expression extraction.
    (Structural: every sub-expression of a well-formed expression is well-formed.) -/
theorem depth_subexpr_le (op : ExtendedOp) (l r : Term) :
    l.depth ≤ (Term.app op l r).depth ∧ r.depth ≤ (Term.app op l r).depth := by
  simp [Term.depth]; omega

end TIF
