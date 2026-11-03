/-
  Core/Syntax.lean
  The Indeterminate Framework (TIF) — Chapter 1: Language and Syntax

  Covers Definitions 1.1.1–1.5.3 from the Formal Master Outline.
  Background: classical base theory instantiated as Lean's type theory.
-/

namespace TIF

/-!
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
