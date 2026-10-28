/-!
# Core/Rewrite.lean
## The Indeterminate Framework (TIF) — Rewrite System

This file defines:
  - `RewriteStep`   : the one-step rewrite relation `e →_Σ e'` (D22)
  - `NormalForm`    : the three normal-form classes (D23)
  - `RewriteSeq`    : the reflexive-transitive closure of `RewriteStep`
  - T6              : Rewrite Preservation (semantic value sets are invariant)
  - T7              : Well-formedness Preservation

Depends on: `Core.Types`, `Core.Syntax`, `Core.State`, `Core.Eval`, `Core.Collapse`
-/

import Core.Types
import Core.Syntax
import Core.State
import Core.Eval
import Core.Collapse

-- ---------------------------------------------------------------------------
-- D22 : One-step rewrite relation  t →_Σ t'
-- ---------------------------------------------------------------------------

/-- A one-step rewrite rule applicable in state `σ` (D22).

    The rules below cover:
    - **Classical reduction**: applying a classical operator to two evaluated
      classical sub-terms when both are defined (implements A4).
    - **Congruence**: rewriting under any operator context.
    - **Classical-agreement short-circuit**: if a term is classical and evaluates
      to a unique value, reduce it to that constant (A13).

    In a full development, additional rules for origin marking (A5) and
    indeterminate-specific simplifications would be added here. -/
inductive RewriteStep (σ : State) : Term → Term → Prop where

  /-- **Classical operator reduction** (A4, A13).
      If both sub-terms are classical constants `a` and `b`, and the operation
      is classically defined, reduce to the classical result. -/
  | classAdd (a b : ClassicalScalar) :
      RewriteStep σ (Term.app ExtOp.add (Term.const a) (Term.const b))
                   (Term.const (csAdd a b))

  | classSub (a b : ClassicalScalar) :
      RewriteStep σ (Term.app ExtOp.sub (Term.const a) (Term.const b))
                   (Term.const (csSub a b))

  | classMul (a b : ClassicalScalar) :
      RewriteStep σ (Term.app ExtOp.mul (Term.const a) (Term.const b))
                   (Term.const (csMul a b))

  /-- Classical division when the divisor is non-zero (A4). -/
  | classDiv (a b r : ClassicalScalar) (h : csDiv a b = some r) :
      RewriteStep σ (Term.app ExtOp.div (Term.const a) (Term.const b))
                   (Term.const r)

  /-- **Left-congruence**: rewrite in the left sub-term. -/
  | congrLeft (op : ExtOp) (t₁ t₁' t₂ : Term)
      (h : RewriteStep σ t₁ t₁') :
      RewriteStep σ (Term.app op t₁ t₂) (Term.app op t₁' t₂)

  /-- **Right-congruence**: rewrite in the right sub-term. -/
  | congrRight (op : ExtOp) (t₁ t₂ t₂' : Term)
      (h : RewriteStep σ t₂ t₂') :
      RewriteStep σ (Term.app op t₁ t₂) (Term.app op t₁ t₂')

-- ---------------------------------------------------------------------------
-- D23 : Normal forms
-- ---------------------------------------------------------------------------

/-- The three normal-form classes of `𝒯_I` (D23). -/
inductive NormalForm : Term → Prop where
  /-- **Classical normal form**: the term is a classical constant. -/
  | classical (c : ClassicalScalar) : NormalForm (Term.const c)

  /-- **Blocked normal form**: no rewrite applies *and* the term is not a
      unique-collapse term (i.e. it is genuinely blocked).
      In the skeleton we mark any `Term.ind k` without state context as blocked. -/
  | blocked (k : IndClass) : NormalForm (Term.ind k)

  /-- **Collapse normal form**: the term is an application whose semantic value
      set in the given state is a singleton — it *could* collapse even though it
      syntactically still contains operator applications.
      We represent this by storing the collapsed value alongside. -/
  | collapseNF (t : Term) (c : ClassicalScalar) : NormalForm (Term.const c)
  --   ↑ After collapse, the term is a classical constant (same as `classical`);
  --     this constructor is provided for clarity in proofs.

-- ---------------------------------------------------------------------------
-- D22 : Reflexive-transitive closure  (multi-step rewrite)
-- ---------------------------------------------------------------------------

/-- Zero or more rewrite steps relative to state `σ`. -/
inductive RewriteSeq (σ : State) : Term → Term → Prop where
  /-- Reflexivity: a term rewrites to itself in zero steps. -/
  | refl (t : Term) : RewriteSeq σ t t
  /-- Transitivity through a one-step rule. -/
  | step (t t' t'' : Term)
         (h₁ : RewriteStep σ t t')
         (h₂ : RewriteSeq σ t' t'') :
         RewriteSeq σ t t''

-- ---------------------------------------------------------------------------
-- A12 / T6 : Rewrite Preservation
-- ---------------------------------------------------------------------------

/-- **Rewrite Preservation** (T6, A12): a single rewrite step preserves the
    semantic value set `⟦t⟧_Σ`. -/
theorem rewrite_preserves_semValueSet
    (σ : State) (t t' : Term)
    (hstep : RewriteStep σ t t') :
    semValueSet σ t = semValueSet σ t' := by
  induction hstep with
  | classAdd a b =>
      ext c
      simp only [semValueSet, Set.mem_setOf_eq]
      constructor
      · rintro ⟨v, η, hadm, heval⟩
        refine ⟨v, η, hadm, ?_⟩
        simp [termEvalDef] at heval ⊢
        rw [termEval_eq] at heval ⊢
        simp [termEvalDef] at heval ⊢
        exact heval
      · rintro ⟨v, η, hadm, heval⟩
        refine ⟨v, η, hadm, ?_⟩
        rw [termEval_eq] at heval ⊢
        simp [termEvalDef] at heval ⊢
        exact heval
  | classSub a b =>
      ext c; simp only [semValueSet, Set.mem_setOf_eq]
      constructor <;> rintro ⟨v, η, hadm, heval⟩ <;> refine ⟨v, η, hadm, ?_⟩ <;>
        (rw [termEval_eq] at heval ⊢; simp [termEvalDef] at heval ⊢; exact heval)
  | classMul a b =>
      ext c; simp only [semValueSet, Set.mem_setOf_eq]
      constructor <;> rintro ⟨v, η, hadm, heval⟩ <;> refine ⟨v, η, hadm, ?_⟩ <;>
        (rw [termEval_eq] at heval ⊢; simp [termEvalDef] at heval ⊢; exact heval)
  | classDiv a b r hdiv =>
      ext c; simp only [semValueSet, Set.mem_setOf_eq]
      constructor <;> rintro ⟨v, η, hadm, heval⟩ <;> refine ⟨v, η, hadm, ?_⟩ <;>
        (rw [termEval_eq] at heval ⊢; simp [termEvalDef, hdiv] at heval ⊢; exact heval)
  | congrLeft op t₁ t₁' t₂ _ ih =>
      ext c; simp only [semValueSet, Set.mem_setOf_eq]
      constructor <;> rintro ⟨v, η, hadm, heval⟩
      · have : semValueSet σ t₁ = semValueSet σ t₁' := ih
        rw [termEval_eq] at heval ⊢
        simp [termEvalDef] at heval ⊢
        exact ⟨v, η, hadm, heval⟩
      · exact ⟨v, η, hadm, heval⟩
  | congrRight op t₁ t₂ t₂' _ ih =>
      ext c; simp only [semValueSet, Set.mem_setOf_eq]
      constructor <;> rintro ⟨v, η, hadm, heval⟩ <;> exact ⟨v, η, hadm, heval⟩

-- ---------------------------------------------------------------------------
-- T7 : Well-formedness Preservation
-- ---------------------------------------------------------------------------

/-- **Well-formedness Preservation** (T7): rewriting preserves syntactic
    well-formedness.  In the skeleton, `wellFormed` always returns `true`,
    so this is immediate. -/
theorem rewrite_preserves_wellFormed
    (σ : State) (t t' : Term)
    (_ : RewriteStep σ t t')
    (_ : (Expr.term t).wellFormed = true) :
    (Expr.term t').wellFormed = true :=
  rfl   -- wellFormed always returns true in the skeleton (D10)
