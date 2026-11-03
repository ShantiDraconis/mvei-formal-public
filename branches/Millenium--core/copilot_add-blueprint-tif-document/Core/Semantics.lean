/-
  Core/Semantics.lean
  The Indeterminate Framework (TIF) — Chapter 4: Algebraic and Logical Semantics

  Covers free algebra semantics, relational semantics, logical semantics,
  and semantics of collapse (Definitions 4.1–4.4 and Theorems 4.4.4–4.4.6).
-/

import Core.Syntax
import Core.States

namespace TIF

/-!
## Section 4.1. Free Algebra Semantics
-/

/-- Definition 4.1.1. Free indeterminate algebra A_I = FreeAlg(C ∪ {I}).
    We represent it as the quotient of Term by a congruence relation. -/
def FreeIndetAlgebra := Term  -- terms form the free algebra

/-- Definition 4.1.2. Congruence relation on A_I: equality of terms under state Σ. -/
def Congruent (σ : State) (t₁ t₂ : Term) : Prop :=
  ∃ _ : State, σ.extends ‹_› ∧ t₁ = t₂  -- simplified: extensional equality

/-- Definition 4.1.3. Classical embedding map: embeds classical constants into A_I. -/
def classicalEmbed (c : ClassicalConst) : Term := Term.cst c

/-- Definition 4.1.4. Extended interpretation map: maps terms to their semantic values
    (here represented as optional classical constants). -/
def extendedInterp (σ : State) : Term → Option ClassicalConst
  | .cst c     => some c
  | .indt _    => none    -- indeterminate: no classical value without collapse
  | .var _     => none    -- variables need binding
  | .app op l r =>
    match op with
    | .classical _ => do
        let _ ← extendedInterp σ l
        let _ ← extendedInterp σ r
        none  -- placeholder: operator semantics expanded in Chapter 5
    | .extended _ => none  -- extended operator: indeterminate result

/-!
## Section 4.2. Relational Semantics
-/

/-- Definition 4.2.1. Admissible valuation: a map from variable symbols to classical constants. -/
def Valuation := VarSymbol → Option ClassicalConst

/-- Definition 4.2.2. State-relative valuation: a valuation consistent with state Σ. -/
structure StateValuation : Type where
  σ   : State
  val : Valuation

/-- Definition 4.2.3. Resolution set ⟦e⟧_Σ: the set of admissible classical values for e under Σ. -/
def resolutionSet (σ : State) (e : Expr) : List ClassicalConst :=
  match e with
  | .term (.cst c)  => [c]   -- classical constant resolves to itself
  | .term (.indt _) => []    -- indeterminate: no classical resolution without constraints
  | .term (.var _)  => []    -- unbound variable
  | .term (.app _ _ _) => []
  | .constrained e' _ => resolutionSet σ e'

/-- Definition 4.2.4. Unique resolution: ⟦e⟧_Σ is a singleton. -/
def hasUniqueResolution (σ : State) (e : Expr) : Bool :=
  (resolutionSet σ e).length == 1

/-- Definition 4.2.5. Blocked resolution: ⟦e⟧_Σ is empty. -/
def isBlocked (σ : State) (e : Expr) : Bool :=
  (resolutionSet σ e).isEmpty

/-!
## Section 4.3. Logical Semantics
-/

/-- Definition 4.3.1. State-relative truth: a formula φ is true relative to state Σ. -/
def satisfies (σ : State) : Formula → Prop
  | .atom .top   => True
  | .atom .bot   => False
  | .atom _      => True  -- placeholder for predicate semantics
  | .neg φ       => ¬ satisfies σ φ
  | .conj φ ψ    => satisfies σ φ ∧ satisfies σ ψ
  | .disj φ ψ    => satisfies σ φ ∨ satisfies σ ψ
  | .impl φ ψ    => satisfies σ φ → satisfies σ ψ
  | .all _ φ     => satisfies σ φ   -- simplified: no variable binding context
  | .ex _ φ      => satisfies σ φ

/-- Definition 4.3.2. Universal admissible validity: φ holds in all consistent states. -/
def universallyValid (φ : Formula) : Prop :=
  ∀ σ : State, σ.isConsistent = true → satisfies σ φ

/-- Definition 4.3.3. Classical validity preservation: classical validities remain valid. -/
def classicallyValid (φ : Formula) : Prop :=
  universallyValid φ

/-- Definition 4.3.4. Indeterminate satisfiability: φ is satisfiable in some consistent state. -/
def indetSatisfiable (φ : Formula) : Prop :=
  ∃ σ : State, σ.isConsistent = true ∧ satisfies σ φ

/-!
## Section 4.4. Semantics of Collapse
-/

/-- Definition 4.4.1. Semantic collapse operator: maps (e, Σ) to a classical constant when unique. -/
noncomputable def collapseOp (σ : State) (e : Expr) : Option ClassicalConst :=
  match resolutionSet σ e with
  | [c] => some c
  | _   => none

/-- Definition 4.4.2. Collapse soundness: if collapseOp returns v, then v ∈ ⟦e⟧_Σ. -/
theorem collapse_soundness (σ : State) (e : Expr) (v : ClassicalConst)
    (h : collapseOp σ e = some v) :
    v ∈ resolutionSet σ e := by
  simp [collapseOp] at h
  split at h
  · next eq => simp_all [List.mem_cons, List.mem_nil_iff]
  · next => exact absurd h (by simp)

/-- Definition 4.4.3. Collapse completeness on unique states:
    if ⟦e⟧_Σ = {v}, then collapseOp returns v. -/
theorem collapse_completeness (σ : State) (e : Expr) (v : ClassicalConst)
    (h : resolutionSet σ e = [v]) :
    collapseOp σ e = some v := by
  simp [collapseOp, h]

/-- Theorem 4.4.4. Soundness of collapse (alias of collapse_soundness). -/
theorem soundness_of_collapse := @collapse_soundness

/-- Theorem 4.4.5. Uniqueness implies classical value recovery. -/
theorem uniqueness_implies_recovery (σ : State) (e : Expr)
    (h : hasUniqueResolution σ e = true) :
    ∃ v : ClassicalConst, collapseOp σ e = some v := by
  simp [hasUniqueResolution] at h
  match hm : resolutionSet σ e with
  | []      => simp [hm] at h
  | [v]     => exact ⟨v, by simp [collapseOp, hm]⟩
  | _ :: _ :: _ => simp [hm] at h

/-- Theorem 4.4.6. Classical expressions preserve classical semantics. -/
theorem classical_preserves_semantics (e : Expr) (h : e.isClassical = true) (σ : State) :
    isBlocked σ e = false := by
  simp [isBlocked, Expr.isClassical, List.isEmpty_iff_eq_nil] at *
  match e with
  | .term (.cst _) => simp [resolutionSet]
  | .term (.indt _) => simp [Expr.indetSupport] at h
  | _ => simp [resolutionSet]

end TIF
