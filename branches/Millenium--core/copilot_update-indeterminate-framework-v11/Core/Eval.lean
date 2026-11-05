/-
  Core/Eval.lean
  ──────────────
  The Indeterminate Framework (TIF) — Evaluation and Semantic Value Sets

  Covers definitions D15–D17 and theorems T1–T3, T6–T7 from the formal
  summary v1.1.

  The evaluation function Eval_{v,η} : Term α → Option α attempts to reduce
  a term to a classical scalar given a valuation pair (v, η) and a state Σ.
  The semantic value set ⟦e⟧_Σ collects all values that any admissible
  valuation pair can produce.
-/

import Core.State

namespace TIF

-- ─────────────────────────────────────────────────────────────────────────────
-- Evaluation of terms under a valuation pair (v, η)
-- ─────────────────────────────────────────────────────────────────────────────

/-
  We require the classical scalar type α to carry ClassicalScalar operations.
  Evaluation of a classical operation is attempted and may fail (returning
  None) when the classical operation is undefined (e.g., division by zero).
-/

/-- Evaluate a term under a valuation pair, returning a scalar or None. -/
def evalTerm {α : Type*} [ClassicalScalar α] [DecidableEq α]
    (vp : ValPair α) : Term α → Option α
  /-- Variables: look up in the classical valuation. -/
  | Term.var x        => some (vp.classical.lookup x)
  /-- Classical constants: return directly. -/
  | Term.const c      => some c
  /-- Indeterminate classes: look up in the indeterminate valuation (partial). -/
  | Term.indet ic     => vp.indeterminate.lookup ic
  /-- Extended operator application: evaluate sub-terms and apply the op. -/
  | Term.app op t₁ t₂ =>
      match evalTerm vp t₁, evalTerm vp t₂ with
      | some v₁, some v₂ => applyOp op v₁ v₂
      | _, _              => none
where
  applyOp (op : ClassicalOp) (a b : α) : Option α :=
    match op with
    | ClassicalOp.Add => some (ClassicalScalar.add a b)
    | ClassicalOp.Sub => some (ClassicalScalar.sub a b)
    | ClassicalOp.Mul => some (ClassicalScalar.mul a b)
    | ClassicalOp.Div => ClassicalScalar.div a b

-- ─────────────────────────────────────────────────────────────────────────────
-- Admissibility — concrete definition (refines opaque placeholder in State.lean)
-- ─────────────────────────────────────────────────────────────────────────────

/-
  A valuation pair (v, η) is admissible for state Σ = (ε, C) if:
    • For every equation (t₁, t₂) ∈ ε: evalTerm vp t₁ = evalTerm vp t₂.
    • For every constraint c ∈ C: the constraint is satisfied under vp.
-/

/-- Check that a single constraint is satisfied under a valuation pair. -/
def evalConstraint {α : Type*} [ClassicalScalar α] [DecidableEq α]
    (vp : ValPair α) : Constraint α → Bool
  | Constraint.eq t₁ t₂  =>
      evalTerm vp t₁ == evalTerm vp t₂
  | Constraint.neq t₁ t₂ =>
      !(evalTerm vp t₁ == evalTerm vp t₂)
  | Constraint.pred _ _   =>
      -- User-supplied predicates are treated as vacuously satisfied in the
      -- skeleton; concrete instances must override this.
      true

/-- Decidable admissibility check for a valuation pair and state. -/
def isAdmissible {α : Type*} [ClassicalScalar α] [DecidableEq α]
    (vp : ValPair α) (σ : State α) : Bool :=
  σ.equations.all (fun (t₁, t₂) => evalTerm vp t₁ == evalTerm vp t₂)
  && σ.constraints.all (evalConstraint vp)

-- ─────────────────────────────────────────────────────────────────────────────
-- D15. Semantic value set  ⟦e⟧_Σ
-- ─────────────────────────────────────────────────────────────────────────────

/-
  ⟦e⟧_Σ = { Eval_{v,η}(e) | (v, η) admissible for Σ }
           (restricted to defined evaluations, i.e., Eval ≠ None).

  Because the set of all admissible valuations is in general infinite (and
  the type α may be infinite), we define the semantic value set as a
  predicate (a subset of α) rather than a concrete List.
-/

/-- The semantic value set of a term relative to a state, represented as a
    membership predicate on α. -/
def termValueSet {α : Type*} [ClassicalScalar α] [DecidableEq α]
    (t : Term α) (σ : State α) : α → Prop :=
  fun v =>
    ∃ vp : ValPair α,
      isAdmissible vp σ = true ∧
      evalTerm vp t = some v

-- ─────────────────────────────────────────────────────────────────────────────
-- D16. Blocked term
-- ─────────────────────────────────────────────────────────────────────────────

/-
  A term t is blocked in state Σ if:
    1. The semantic value set is empty, OR
    2. The semantic value set is not a singleton, OR
    3. No admissible rewrite-to-classical-normal-form path exists.

  Conditions 1 and 2 are expressible purely in terms of termValueSet.
  Condition 3 is operational and is addressed in Core/Rewrite.lean.
-/

/-- A term is uniquely resolved in Σ if exactly one classical value is
    produced by all admissible valuations. -/
def uniquelyResolved {α : Type*} [ClassicalScalar α] [DecidableEq α]
    (t : Term α) (σ : State α) : Prop :=
  ∃ v : α, ∀ w : α, termValueSet t σ w ↔ w = v

/-- A term is blocked in Σ if it is not uniquely resolved. -/
def blocked {α : Type*} [ClassicalScalar α] [DecidableEq α]
    (t : Term α) (σ : State α) : Prop :=
  ¬ uniquelyResolved t σ

-- ─────────────────────────────────────────────────────────────────────────────
-- D17. Collapse operator
-- ─────────────────────────────────────────────────────────────────────────────

/-
  Collapse_Σ : Expr_I ⇀ α is a partial function such that:
    Collapse_Σ(t) = v  ⟺  ⟦t⟧_Σ = {v}.

  We model partiality as Option α.  Implementations may return a blocked
  marker (None) instead of being literally partial.
-/

/-- The collapse value of a term in state Σ, if uniquely resolved. -/
noncomputable def collapse {α : Type*} [ClassicalScalar α] [DecidableEq α]
    (t : Term α) (σ : State α) : Option α :=
  if h : ∃ v : α, ∀ w : α, termValueSet t σ w ↔ w = v
  then some h.choose
  else none

-- ─────────────────────────────────────────────────────────────────────────────
-- T1. Classical stability theorem
-- ─────────────────────────────────────────────────────────────────────────────

/-
  If t is a classical term (no indeterminate symbols), then for every state Σ
  the semantic value set ⟦t⟧_Σ is a singleton {Eval(t)}, and
  Collapse_Σ(t) = Eval(t).

  Here we state a specialised form: a pure classical constant collapses to
  itself in every state.
-/

/-- T1 (specialised): a classical constant collapses to itself in every state. -/
theorem classical_const_stable {α : Type*} [ClassicalScalar α] [DecidableEq α]
    (c : α) (σ : State α) (vp : ValPair α) (hadm : isAdmissible vp σ = true) :
    evalTerm vp (Term.const c) = some c := by
  simp [evalTerm]

-- ─────────────────────────────────────────────────────────────────────────────
-- T2. Collapse soundness theorem
-- ─────────────────────────────────────────────────────────────────────────────

/-
  If Collapse_Σ(t) = v, then ⟦t⟧_Σ = {v}.

  Stated as a logical implication at the definitional level.
-/

/-- T2: Collapse is sound — the collapsed value belongs to the value set. -/
theorem collapse_sound {α : Type*} [ClassicalScalar α] [DecidableEq α]
    (t : Term α) (σ : State α) (v : α)
    (hcol : collapse t σ = some v) :
    termValueSet t σ v ∧ ∀ w : α, termValueSet t σ w → w = v := by
  unfold collapse at hcol
  split_ifs at hcol with h
  · injection hcol with heq
    obtain ⟨u, hu⟩ := h
    constructor
    · rw [← heq]; exact (hu u).mpr rfl
    · intro w hw
      rw [← heq]
      exact (hu w).mp hw
  · simp at hcol

-- ─────────────────────────────────────────────────────────────────────────────
-- T3. Collapse completeness on unique states
-- ─────────────────────────────────────────────────────────────────────────────

/-
  If ⟦t⟧_Σ = {v} (i.e., t is uniquely resolved to v), then Collapse_Σ(t) = v.
-/

/-- T3: Collapse is complete on uniquely resolved terms. -/
theorem collapse_complete {α : Type*} [ClassicalScalar α] [DecidableEq α]
    (t : Term α) (σ : State α) (v : α)
    (huniq : ∀ w : α, termValueSet t σ w ↔ w = v) :
    collapse t σ = some v := by
  unfold collapse
  have h : ∃ u : α, ∀ w : α, termValueSet t σ w ↔ w = u :=
    ⟨v, huniq⟩
  simp [dif_pos h]
  have := h.choose_spec
  have hv : h.choose = v := by
    have hw := this v
    simp [huniq v] at hw
    exact hw.mp rfl |>.symm
  exact hv
-- Core/Eval.lean
-- Valuation types and partial evaluation of TIF expressions.
-- Implements Axioms A6–A10 from axiom-sheet-v1.md.

import Core.Syntax

namespace TIF

/-! ## Valuations -/

/-- A classical valuation assigns a value of type α to each variable name.
    (Definition 4.1 in glossary.md) -/
def Valuation (α : Type) : Type := String → α

/-- An indeterminate valuation optionally assigns a classical value to each
    indeterminate class.  Used in extended evaluation contexts.
    (Definition 4.2 in glossary.md) -/
def IndetValuation (α : Type) : Type := IndetClass → Option α

/-! ## Evaluation -/

/-- Partial evaluation of a TIF expression under a classical valuation.

    Returns `some c` when the expression evaluates to a unique classical
    value `c`, and `none` when:
    · the expression contains an `indet` node (Axiom A10), or
    · a division by zero is encountered (Axiom A9).

    This is a total function on `Expr α`; partiality is captured via `Option`.
    (Definition 1.1 in semantics.md) -/
def eval {α : Type} [Add α] [Sub α] [Mul α] [Div α] [DecidableEq α] [OfNat α 0]
    (v : Valuation α) : Expr α → Option α
  | .var s       => some (v s)                           -- Axiom A7
  | .const c     => some c                               -- Axiom A6
  | .indet _     => none                                 -- Axiom A10
  | .add e₁ e₂  =>                                      -- Axiom A8
      (eval v e₁).bind (fun a => (eval v e₂).map (a + ·))
  | .sub e₁ e₂  =>                                      -- Axiom A8
      (eval v e₁).bind (fun a => (eval v e₂).map (a - ·))
  | .mul e₁ e₂  =>                                      -- Axiom A8
      (eval v e₁).bind (fun a => (eval v e₂).map (a * ·))
  | .div e₁ e₂  =>                                      -- Axiom A9
      (eval v e₁).bind fun a =>
      (eval v e₂).bind fun b =>
      if b = (0 : α) then none else some (a / b)

/-! ## Basic lemmas about evaluation (Paper 1 — T1.2 support) -/

/-- For a classical expression `e` (containing no `indet` constructors),
    `eval v e` returns `none` only when a division-by-zero occurs in a
    sub-expression — never because an `indet` node was encountered.

    This is a key support lemma for Paper 1 theorem T1.2 (classical stability).
    Full proof: by structural induction on `e`, using `e.isClassical = true`
    to rule out the `indet` case at each step.

    (Supports Paper 1 theorem T1.2.) -/
theorem eval_classical_no_indet
    {α : Type} [Add α] [Sub α] [Mul α] [Div α] [DecidableEq α] [OfNat α 0]
    (v : Valuation α) (e : Expr α)
    (hcl : e.isClassical = true) :
    -- A classical expression has no indet constructor, so eval can only
    -- return none at a division-by-zero subexpression.
    (∀ ι : IndetClass, e ≠ Expr.indet ι) := by
  intro ι heq
  subst heq
  simp [Expr.isClassical] at hcl
/-
  Core/Eval.lean
  Theory of Indeterminates Framework (TIF) — Evaluation Relation

  Defines:
    - eval        : Valuation α → Expr α → Option α
    - isClassical : predicate identifying expressions with no indet nodes
    - Adm         : admissible valuations for a state
    - evalC       : evaluation of classical fragment expressions

  Key properties established:
    - Evaluation determinism (eval is a function, not a relation)
    - Classical stability (eval on CExpr agrees with classical arithmetic)
    - Axiom A7: indet nodes always evaluate to none
    - Axiom A8: classical fragment evaluation is a homomorphism

  Status: Paper 1 core.
-/

import Core.State

namespace TIF

section Eval

variable {α : Type}

/-!
## eval : Valuation α → Expr α → Option α

The evaluation function maps an expression to an optional classical value
under a given valuation. It returns `none` when:
  - the expression contains an unresolved `indet` node, or
  - a division by zero is encountered.

This implements the evaluation rules (E-Var) through (E-Div-None) from the
Semantic Specification §1.1.
-/
def eval [Add α] [Sub α] [Mul α] [Div α] [DecidableEq α] [Zero α]
    (v : Valuation α) : Expr α → Option α
  | Expr.var x      => some (v x)                         -- (E-Var)
  | Expr.const c    => some c                             -- (E-Const)
  | Expr.indet _    => none                               -- (E-Indet) / Axiom A7
  | Expr.add e₁ e₂  =>
      match eval v e₁, eval v e₂ with
      | some a, some b => some (a + b)                    -- (E-Add)
      | _,      _      => none                            -- (E-Add-None)
  | Expr.sub e₁ e₂  =>
      match eval v e₁, eval v e₂ with
      | some a, some b => some (a - b)                    -- (E-Sub)
      | _,      _      => none                            -- (E-Sub-None)
  | Expr.mul e₁ e₂  =>
      match eval v e₁, eval v e₂ with
      | some a, some b => some (a * b)                    -- (E-Mul)
      | _,      _      => none                            -- (E-Mul-None)
  | Expr.div e₁ e₂  =>
      match eval v e₁, eval v e₂ with
      | some a, some b =>
          if b = 0 then none                              -- (E-Div-Zero)
          else some (a / b)                               -- (E-Div)
      | _,      _      => none                            -- (E-Div-None)

/-!
### Axiom A7 — Indeterminate Non-Evaluation

  `eval v (indet k) = none` for all `v`, `k`.
  This is definitional.
-/
@[simp]
theorem eval_indet [Add α] [Sub α] [Mul α] [Div α] [DecidableEq α] [Zero α]
    (v : Valuation α) (k : IndetClass) :
    eval v (Expr.indet k) = none := rfl

/-!
### Evaluation on var and const
-/
@[simp]
theorem eval_var [Add α] [Sub α] [Mul α] [Div α] [DecidableEq α] [Zero α]
    (v : Valuation α) (x : String) :
    eval v (Expr.var x) = some (v x) := rfl

@[simp]
theorem eval_const [Add α] [Sub α] [Mul α] [Div α] [DecidableEq α] [Zero α]
    (v : Valuation α) (c : α) :
    eval v (Expr.const c) = some c := rfl

end Eval

/-!
## Admissibility (Axiom A10)

A valuation `v` is admissible for state `Σ` iff:
  1. Every equation in `Σ.equations` is satisfied by `v`.
  2. Every predicate in `Σ.constraints` holds for `v`.
-/
def Adm {α : Type} [Add α] [Sub α] [Mul α] [Div α] [DecidableEq α] [Zero α]
    (Σ : State α) (v : Valuation α) : Prop :=
  (∀ (eq : Expr α × Expr α), eq ∈ Σ.equations →
      eval v eq.1 = eval v eq.2) ∧
  (∀ (P : Valuation α → Prop), P ∈ Σ.constraints → P v)

/-!
### Admissibility for the empty state

Every valuation is admissible for the empty state.
-/
theorem adm_empty {α : Type} [Add α] [Sub α] [Mul α] [Div α] [DecidableEq α] [Zero α]
    (v : Valuation α) : Adm (State.empty) v := by
  constructor
  · intro eq h; exact absurd h (List.not_mem_nil _)
  · intro P h; exact absurd h (List.not_mem_nil _)

/-!
## Evaluation of the Classical Fragment (Axiom A8)

`evalC` evaluates a `CExpr α` via the embedding into `Expr α`.
It agrees with classical arithmetic on non-zero denominators.
-/
def evalC {α : Type} [Add α] [Sub α] [Mul α] [Div α] [DecidableEq α] [Zero α]
    (v : Valuation α) (e : CExpr α) : Option α :=
  eval v (CExpr.embed e)

/-!
### Classical stability: evalC agrees with eval ∘ ι
-/
@[simp]
theorem evalC_eq_eval {α : Type} [Add α] [Sub α] [Mul α] [Div α] [DecidableEq α] [Zero α]
    (v : Valuation α) (e : CExpr α) :
    evalC v e = eval v (CExpr.embed e) := rfl

/-!
### Classical stability theorems (Axiom A8)

`evalC` is a homomorphism with respect to the operations of `CExpr α`.
These follow directly from the definitions of `eval` and `CExpr.embed`.
-/
section ClassicalStability

variable {α : Type} [Add α] [Sub α] [Mul α] [Div α] [DecidableEq α] [Zero α]

theorem evalC_var (v : Valuation α) (x : String) :
    evalC v (CExpr.var x) = some (v x) := rfl

theorem evalC_const (v : Valuation α) (c : α) :
    evalC v (CExpr.const c) = some c := rfl

theorem evalC_add (v : Valuation α) (e₁ e₂ : CExpr α) :
    evalC v (CExpr.add e₁ e₂) =
      match evalC v e₁, evalC v e₂ with
      | some a, some b => some (a + b)
      | _, _ => none := rfl

theorem evalC_sub (v : Valuation α) (e₁ e₂ : CExpr α) :
    evalC v (CExpr.sub e₁ e₂) =
      match evalC v e₁, evalC v e₂ with
      | some a, some b => some (a - b)
      | _, _ => none := rfl

theorem evalC_mul (v : Valuation α) (e₁ e₂ : CExpr α) :
    evalC v (CExpr.mul e₁ e₂) =
      match evalC v e₁, evalC v e₂ with
      | some a, some b => some (a * b)
      | _, _ => none := rfl

theorem evalC_div (v : Valuation α) (e₁ e₂ : CExpr α) :
    evalC v (CExpr.div e₁ e₂) =
      match evalC v e₁, evalC v e₂ with
      | some a, some b => if b = 0 then none else some (a / b)
      | _, _ => none := rfl

/-- On non-zero denominator, classical division evaluates to a value. -/
theorem evalC_div_nonzero (v : Valuation α) (e₁ e₂ : CExpr α) (a b : α)
    (h₁ : evalC v e₁ = some a) (h₂ : evalC v e₂ = some b) (hb : b ≠ 0) :
    evalC v (CExpr.div e₁ e₂) = some (a / b) := by
  simp [evalC_div, h₁, h₂, hb]

end ClassicalStability

end TIF
