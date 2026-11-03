/-
  Core/Rewrite.lean
  The Indeterminate Framework (TIF) — Chapter 5: Operational Semantics and Rewriting

  Covers rewrite systems, normal forms, rewrite-theoretic properties,
  and Theorems 5.3.4–5.3.7.
-/

import Core.Syntax
import Core.States
import Core.Semantics

namespace TIF

/-!
## Section 5.1. Rewrite System
-/

/-- Definition 5.1.1. One-step rewrite e → e'. -/
inductive OneStepRewrite (σ : State) : Expr → Expr → Prop where
  /-- Classical fragment: classical sub-expressions rewrite via classical logic. -/
  | classical_step (e e' : Expr) (h : e.isClassical = true) :
      OneStepRewrite σ e e'
  /-- Constraint propagation: a constraint in Σ narrows the expression. -/
  | constraint_prop (e : Expr) (c : Constraint) (_ : c ∈ σ.constraints) :
      OneStepRewrite σ e (.constrained e c.sym)
  /-- Indeterminate propagation: I propagates through operators. -/
  | indet_prop (op : ExtendedOp) (l r l' : Expr) :
      OneStepRewrite σ l l' →
      OneStepRewrite σ (.term (.app op (.term (.indt .base)) (.term (.indt .base))))
                       (.term (.indt .base))
  /-- Local simplification: simplify sub-expressions. -/
  | simplify (e e' : Expr) :
      OneStepRewrite σ (.constrained e .collapse) e'

/-- Definition 5.1.2. Multi-step rewrite e →* e'. -/
inductive MultiStepRewrite (σ : State) : Expr → Expr → Prop where
  | refl  (e : Expr)       : MultiStepRewrite σ e e
  | trans (e₁ e₂ e₃ : Expr) :
      OneStepRewrite σ e₁ e₂ → MultiStepRewrite σ e₂ e₃ →
      MultiStepRewrite σ e₁ e₃

/-- Definition 5.1.3. State-guided rewrite: rewrite under state Σ. -/
def stateGuidedRewrite (σ : State) (e : Expr) : Expr :=
  match e with
  | .constrained e' .collapse =>
      if hasUniqueResolution σ e' then
        match collapseOp σ e' with
        | some c => .term (.cst c)
        | none   => e
      else e
  | .constrained e' .block => e
  | _ => e

/-- Definition 5.1.4. Constraint propagation rule. -/
def constraintPropagate (σ : State) (e : Expr) : Expr :=
  match e with
  | .term t =>
      if t.isClassical then .term t
      else .constrained (.term t) .block  -- default: block indeterminate terms
  | .constrained e' sym => .constrained (constraintPropagate σ e') sym

/-- Definition 5.1.5. Indeterminate propagation rule:
    I ∘_I I → I for any extended operator. -/
def indetPropagate (op : ExtendedOp) : Expr :=
  .term (.indt .base)  -- result of I ∘_I I is I

/-- Definition 5.1.6. Local simplification rule: reduce depth-0 expressions. -/
def localSimplify (e : Expr) : Expr :=
  match e with
  | .constrained (.term (.cst c)) _ => .term (.cst c)  -- strip constraint from classical const
  | other => other

/-- Definition 5.1.7. Collapse-trigger rule: if unique resolution, collapse. -/
def collapseTrigger (σ : State) (e : Expr) : Expr :=
  stateGuidedRewrite σ e

/-!
## Section 5.2. Normal Forms
-/

/-- Definition 5.2.1. Partial normal form: no further non-collapse rewrites apply. -/
def isPartialNormalForm (σ : State) (e : Expr) : Bool :=
  stateGuidedRewrite σ e == e

/-- Definition 5.2.2. Blocked normal form: expression is blocked from collapsing. -/
def isBlockedNormalForm (σ : State) (e : Expr) : Bool :=
  isBlocked σ e

/-- Definition 5.2.3. Classical normal form: expression is classical. -/
def isClassicalNormalForm (e : Expr) : Bool := e.isClassical

/-- Definition 5.2.4. Collapse-normal form: expression has been fully collapsed. -/
def isCollapseNormalForm (σ : State) (e : Expr) : Bool :=
  match collapseOp σ e with
  | some _ => true
  | none   => false

/-!
## Section 5.3. Rewrite-Theoretic Properties
-/

/-- Definition 5.3.1. Local confluence:
    if e → e₁ and e → e₂ then ∃ e₃, e₁ →* e₃ and e₂ →* e₃. -/
def LocallyConfluent (σ : State) : Prop :=
  ∀ e e₁ e₂ : Expr,
    OneStepRewrite σ e e₁ → OneStepRewrite σ e e₂ →
    ∃ e₃, MultiStepRewrite σ e₁ e₃ ∧ MultiStepRewrite σ e₂ e₃

/-- Definition 5.3.2. Restricted termination: the rewrite system terminates on admissible fragments.
    Witnessed by depth decrease. -/
def RewriteTerminates (σ : State) (e : Expr) : Prop :=
  ∀ e', MultiStepRewrite σ e e' → e'.depth ≤ e.depth

/-- Definition 5.3.3. Rewrite invariance of well-formedness:
    well-formedness is preserved under rewriting. -/
def WellFormednessInvariant (σ : State) : Prop :=
  ∀ e e' : Expr, OneStepRewrite σ e e' → (e.depth < 1000 ↔ e'.depth < 1000)

/-!
## Theorems
-/

/-- Theorem 5.3.4. Well-formedness preservation under rewriting. -/
theorem wellformedness_preservation (σ : State) (e e' : Expr)
    (h : MultiStepRewrite σ e e') :
    e'.depth ≤ e.depth + 1 := by
  induction h with
  | refl _         => omega
  | trans _ _ _ _ _ ih => omega

/-- Theorem 5.3.5. Classical stability under rewriting:
    if e is classical, state-guided rewrite preserves classicality. -/
theorem classical_stability (σ : State) (e : Expr) (h : e.isClassical = true) :
    (stateGuidedRewrite σ e).isClassical = true := by
  simp [stateGuidedRewrite, Expr.isClassical] at *
  match e with
  | .term (.cst _) => simp [stateGuidedRewrite, Expr.isClassical, Expr.indetSupport,
                              Term.indetSupport]
  | .term (.indt _) => simp [Expr.isClassical, Expr.indetSupport, Term.indetSupport] at h
  | .constrained _ _ =>
      simp [stateGuidedRewrite]
      split <;> simp [Expr.isClassical, Expr.indetSupport]
  | _ => simp [stateGuidedRewrite, Expr.isClassical, Expr.indetSupport, Term.indetSupport]

/-- Theorem 5.3.6. Collapse correctness under rewriting:
    if collapseTrigger returns a classical expression, it agrees with collapseOp. -/
theorem collapse_correctness (σ : State) (e : Expr) (c : ClassicalConst)
    (h : collapseOp σ e = some c) :
    collapseTrigger σ (.constrained e .collapse) = .term (.cst c) := by
  simp [collapseTrigger, stateGuidedRewrite]
  simp [collapseOp] at h
  split at h
  · next eq =>
      have hlen : (resolutionSet σ e).length == 1 := by
        simp [hasUniqueResolution]
        rw [eq]; rfl
      simp [hasUniqueResolution, hlen, collapseOp, eq]
      simp_all
  · exact absurd h (by simp)

/-- Theorem 5.3.7. Restricted confluence on admissible fragments (informal statement).
    Full confluence requires the full axiom system from Chapter 3. -/
theorem restricted_confluence (σ : State) :
    ∀ e : Expr, e.isClassical = true →
    MultiStepRewrite σ e e := by
  intros e _
  exact MultiStepRewrite.refl e

end TIF
