-- Core/Theorems.lean
-- States the fundamental theorems of the Indeterminate Framework.
-- Part II, Section 2.3 of the Blueprint.
--
-- These theorems are stated with `sorry` placeholders; full proofs are the
-- subject of Papers 1 and 2 in the project pipeline (Part IV).

import Core.Types
import Core.State
import Mathlib.Data.Complex.Basic

/-!
## Consistency Vocabulary

We work with a Prop-level notion of "consistent" that is deliberately kept
abstract here.  A theory T is *consistent* if it does not prove False.
The concrete formalisation of ZFC and T_I as Lean objects is deferred to
Paper 2; for now we use opaque constants so that the theorem *statements*
are well-typed and can be checked by Lean.
-/

/-- Abstract placeholder for a theory (a set of sentences). -/
opaque Theory : Type

/-- ZFC as an abstract theory constant. -/
opaque ZFC : Theory

/-- The Indeterminate Theory T_I. -/
opaque T_I : Theory

/-- Proposition: a theory is consistent (does not prove False). -/
opaque Theory.Consistent : Theory → Prop

/-- Proposition: a theory proves a sentence (represented as a Prop). -/
opaque Theory.proves : Theory → Prop → Prop
notation:50 T " ⊢ " φ => Theory.proves T φ

/-!
## Theorem 1 – Relative Consistency

If ZFC is consistent, then T_I is consistent.  Intuitively, every model of
ZFC can be extended to a model of T_I by adjoining the indeterminate symbol I
as a fresh constant satisfying the T_I axioms.
-/
theorem relative_consistency :
    ZFC.Consistent → T_I.Consistent := by
  sorry

/-!
## Theorem 2 – Conservativity

T_I is a *conservative extension* of ZFC: a ZFC-sentence is provable in T_I
if and only if it is already provable in ZFC.  This means that T_I does not
derive any new classical consequences, ensuring that all existing mathematics
is undisturbed.
-/
theorem conservativity (φ : Prop) :
    (T_I ⊢ φ) ↔ (ZFC ⊢ φ) := by
  sorry

/-!
## Theorem 3 – Collapse Criterion

If the expression `e` has a unique classical value `v` under *every* valuation
that satisfies the state `s`, then `collapse e s` returns that unique value.

This theorem connects the semantic notion of "forced classical value" with the
syntactic collapse algorithm defined in `Core.State`.
-/
theorem collapse_criterion (e : Expr ℂ) (s : State ℂ) :
    (∃! v : ℂ, ∀ (val : IndetClass → ℂ),
       State.satisfies s val → Expr.eval val e = some v) →
    ∃ v : ℂ, collapse e s = some (Expr.const v) := by
  sorry

/-!
## Theorem 4 – Non-Contradiction (Axiom A5)

The indeterminate object I is distinct from every classical constant.
In particular, I ≠ 0 and I ≠ 1.  We express this at the expression level:
for any classical constant `c`, the expression `Expr.indet .base` is not
equal (as an `Expr ℂ`) to `Expr.const c`.
-/
theorem indet_neq_classical (c : ℂ) :
    Expr.indet IndetClass.base ≠ (Expr.const c : Expr ℂ) := by
  simp [Expr.indet, Expr.const]

/-!
## Theorem 5 – Classical Non-Zero-Denominator Expressions Collapse

For a classical (indeterminate-free) expression `e` whose `collapse` succeeds,
the result is a `const` node.  Division by zero causes `collapse` to return
`none`; the hypothesis `hc : collapse e s = some r` excludes that case.

The companion `collapse_classical_succeeds'` form shows that under an explicit
"no div-by-zero" side condition the collapse always succeeds.
-/

/-- Predicate: expression `e` does not contain a division whose denominator
    could evaluate to zero at any classical value.  For closed (variable-free)
    constant expressions this is decidable. -/
def Expr.noDivByZero {α : Type} [Field α] [DecidableEq α] : Expr α → Prop
  | Expr.const _   => True
  | Expr.indet _   => True
  | Expr.add l r   => l.noDivByZero ∧ r.noDivByZero
  | Expr.sub l r   => l.noDivByZero ∧ r.noDivByZero
  | Expr.mul l r   => l.noDivByZero ∧ r.noDivByZero
  | Expr.div l r   =>
      l.noDivByZero ∧ r.noDivByZero ∧
      -- the denominator, once collapsed, must be nonzero
      (∀ v : α, collapse r (State.empty) = some (Expr.const v) → v ≠ 0)

/-- If `collapse e s` returns a result, that result is always a `const` node
    (never a compound expression or an `indet`). -/
theorem collapse_returns_const {α : Type} [Field α] [DecidableEq α]
    (e : Expr α) (s : State α) (r : Expr α) (hc : collapse e s = some r) :
    ∃ v : α, r = Expr.const v := by
  induction e with
  | const c => exact ⟨c, by simp [collapse] at hc; exact hc.symm⟩
  | indet _ => simp [collapse] at hc
  | add l r' ihl _ =>
    simp [collapse] at hc
    split at hc <;> simp_all
    rename_i a _ b _
    exact ⟨a + b, by simp_all⟩
  | sub l r' ihl _ =>
    simp [collapse] at hc
    split at hc <;> simp_all
    rename_i a _ b _
    exact ⟨a - b, by simp_all⟩
  | mul l r' ihl _ =>
    simp [collapse] at hc
    split at hc <;> simp_all
    rename_i a _ b _
    exact ⟨a * b, by simp_all⟩
  | div l r' ihl _ =>
    simp [collapse] at hc
    split at hc <;> simp_all
    rename_i a _ b _ hne
    exact ⟨a / b, by simp_all⟩

/-- A classical, indeterminate-free expression with no division by zero
    always collapses to a `const` node. -/
theorem collapse_classical_succeeds {α : Type} [Field α] [DecidableEq α]
    (e : Expr α) (s : State α)
    (hcl : e.isClassical = true)
    (hnd : e.noDivByZero) :
    ∃ v : α, collapse e s = some (Expr.const v) := by
  induction e with
  | const c =>
    exact ⟨c, collapse_const c s⟩
  | indet cls =>
    simp [Expr.isClassical] at hcl
  | add l r ihl ihr =>
    simp [Expr.isClassical, Bool.and_eq_true] at hcl
    simp [Expr.noDivByZero] at hnd
    obtain ⟨hl, hr⟩ := hcl
    obtain ⟨hndl, hndr⟩ := hnd
    obtain ⟨lv, hl'⟩ := ihl hl hndl
    obtain ⟨rv, hr'⟩ := ihr hr hndr
    exact ⟨lv + rv, by simp [collapse, hl', hr']⟩
  | sub l r ihl ihr =>
    simp [Expr.isClassical, Bool.and_eq_true] at hcl
    simp [Expr.noDivByZero] at hnd
    obtain ⟨hl, hr⟩ := hcl
    obtain ⟨hndl, hndr⟩ := hnd
    obtain ⟨lv, hl'⟩ := ihl hl hndl
    obtain ⟨rv, hr'⟩ := ihr hr hndr
    exact ⟨lv - rv, by simp [collapse, hl', hr']⟩
  | mul l r ihl ihr =>
    simp [Expr.isClassical, Bool.and_eq_true] at hcl
    simp [Expr.noDivByZero] at hnd
    obtain ⟨hl, hr⟩ := hcl
    obtain ⟨hndl, hndr⟩ := hnd
    obtain ⟨lv, hl'⟩ := ihl hl hndl
    obtain ⟨rv, hr'⟩ := ihr hr hndr
    exact ⟨lv * rv, by simp [collapse, hl', hr']⟩
  | div l r ihl ihr =>
    simp [Expr.isClassical, Bool.and_eq_true] at hcl
    simp [Expr.noDivByZero] at hnd
    obtain ⟨hl, hr⟩ := hcl
    obtain ⟨hndl, hndr, hne⟩ := hnd
    obtain ⟨lv, hl'⟩ := ihl hl hndl
    obtain ⟨rv, hr'⟩ := ihr hr hndr
    have hrne : rv ≠ 0 := hne rv (by rw [State.empty] at *; exact hr')
    exact ⟨lv / rv, by simp [collapse, hl', hr', hrne]⟩
