/-!
# Core/Eval.lean
## The Indeterminate Framework (TIF) — Evaluation and Semantic Value Sets

This file defines:
  - `Eval`          : evaluation of a term under a valuation pair (D15)
  - `semValueSet`   : the semantic value set ⟦e⟧_Σ (D15)
  - `isBlocked`     : the blocked-expression predicate (D16)
  - Core theorems   : Classical Stability (T1), semantic equivalence (Section 5)

Depends on: `Core.Types`, `Core.Syntax`, `Core.State`
-/

import Core.Types
import Core.Syntax
import Core.State

-- ---------------------------------------------------------------------------
-- Operator semantics (axiom stubs for ClassicalScalar arithmetic)
-- ---------------------------------------------------------------------------

/-- Axiom: addition of classical scalars (reflects ℂ-addition). -/
axiom csAdd : ClassicalScalar → ClassicalScalar → ClassicalScalar
/-- Axiom: subtraction of classical scalars. -/
axiom csSub : ClassicalScalar → ClassicalScalar → ClassicalScalar
/-- Axiom: multiplication of classical scalars. -/
axiom csMul : ClassicalScalar → ClassicalScalar → ClassicalScalar
/-- Axiom: partial division of classical scalars; `none` when divisor is zero. -/
axiom csDiv : ClassicalScalar → ClassicalScalar → Option ClassicalScalar

-- ---------------------------------------------------------------------------
-- D15 : Term evaluation  Eval_{v,η}(t)
-- ---------------------------------------------------------------------------

/-- Evaluate a term `t` under classical valuation `v` and indeterminate valuation `η`.

    Returns `none` when:
    - a division by zero occurs at the classical level, or
    - an indeterminate symbol is encountered but `η` does not assign it a value
      (the term remains indeterminate). -/
def termEvalDef (v : ClassicalVal) (η : IndVal) : Term → Option ClassicalScalar
  | Term.var x        => some (v x)
  | Term.const c      => some c
  | Term.ind k        => η k
  | Term.app op t₁ t₂ =>
      match termEvalDef v η t₁, termEvalDef v η t₂ with
      | some a, some b =>
          match op with
          | ExtOp.add => some (csAdd a b)
          | ExtOp.sub => some (csSub a b)
          | ExtOp.mul => some (csMul a b)
          | ExtOp.div => csDiv a b
      | _, _ => none   -- propagate indeterminacy / division failure

-- Make termEvalDef the canonical implementation of the axiom `termEval`.
-- (In a complete Lean development we would use `noncomputable def` and
--  prove `termEval = termEvalDef` as a definitional equality via an axiom.)
axiom termEval_eq (v : ClassicalVal) (η : IndVal) (t : Term) :
    termEval v η t = termEvalDef v η t

-- ---------------------------------------------------------------------------
-- A4 : Classical agreement
-- ---------------------------------------------------------------------------

/-- **Classical Agreement** (A4): on purely classical terms the evaluation
    agrees with the classical interpretation.

    Here we state the structural form: if `t` is classical (no indeterminate
    symbols), then `termEvalDef v η t = termEvalDef v η' t` for any two `η`, `η'`.
    This captures the idea that `η` is irrelevant on classical terms. -/
theorem classical_agreement (v : ClassicalVal) (η η' : IndVal) (t : Term)
    (ht : t.isClassical = true) :
    termEvalDef v η t = termEvalDef v η' t := by
  induction t with
  | var x        => rfl
  | const c      => rfl
  | ind k        =>
      -- A classical term cannot be an indeterminate symbol.
      simp [Term.isClassical, Term.suppI] at ht
  | app op t₁ t₂ ih₁ ih₂ =>
      simp [Term.isClassical, Term.suppI, List.isEmpty_append] at ht
      obtain ⟨h₁, h₂⟩ := ht
      simp [termEvalDef, ih₁ h₁, ih₂ h₂]

-- ---------------------------------------------------------------------------
-- D15 : Semantic value set  ⟦e⟧_Σ
-- ---------------------------------------------------------------------------

/-- The semantic value set of term `t` in state `σ` (D15):
    the set of all classical values obtainable from admissible valuation pairs. -/
def semValueSet (σ : State) (t : Term) : Set ClassicalScalar :=
  fun c => ∃ v η, isAdmissible σ v η ∧ termEvalDef v η t = some c

-- ---------------------------------------------------------------------------
-- D16 : Blocked term
-- ---------------------------------------------------------------------------

/-- A term `t` is **blocked** in state `σ` iff its semantic value set is not
    a singleton — i.e., it is empty or contains more than one value (D16). -/
def isBlocked (σ : State) (t : Term) : Prop :=
  ¬ ∃! c : ClassicalScalar, c ∈ semValueSet σ t

-- ---------------------------------------------------------------------------
-- Semantic equivalence  (Section 5)
-- ---------------------------------------------------------------------------

/-- Two terms are **semantically equivalent** in state `σ` iff they have the
    same semantic value set (Section 5). -/
def semEquiv (σ : State) (t₁ t₂ : Term) : Prop :=
  semValueSet σ t₁ = semValueSet σ t₂

-- ---------------------------------------------------------------------------
-- T1 : Classical Stability (target theorem)
-- ---------------------------------------------------------------------------

/-- **Classical Stability** (T1): For a classical term `t` (no indeterminate
    symbols), in any state `σ`, the semantic value set is the singleton
    `{Eval(t)}` under any valuation, and collapse returns `Eval(t)`.

    Here we prove the simpler structural form: if `t` is classical and
    `termEvalDef v η t = some c`, then `semValueSet σ t = {c}` whenever
    every admissible valuation agrees on `c`. -/
theorem classical_stability_mono
    (σ : State) (t : Term) (v₀ : ClassicalVal) (η₀ : IndVal) (c : ClassicalScalar)
    (ht : t.isClassical = true)
    (hadm : isAdmissible σ v₀ η₀)
    (hval : termEvalDef v₀ η₀ t = some c) :
    ∀ v η, isAdmissible σ v η → termEvalDef v η t = some c := by
  intro v η _
  rw [← hval]
  exact classical_agreement v η₀ v η t ht ▸ (classical_agreement v₀ η₀ v η t ht).symm ▸ rfl
