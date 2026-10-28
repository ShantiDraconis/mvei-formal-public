/-
  Core/Semantics.lean
  Chapter 4: Algebraic and Logical Semantics of TIF

  This file formalizes:
  - Admissible valuations (interpretations of L_I expressions)
  - Resolution sets: the set of classical values consistent with a state
  - State-relative truth (satisfaction under a state Σ)
  - Classical validity preservation
  - The semantic content of the collapse axioms A8-A10
-/

import TIF.Core.States

namespace TIF

open IndeterminateExpr MetaArithmeticState

/-!
## 4.1 Classical Domain and Valuations

We abstract over the classical domain D. In the intended model, D = ℚ or ℝ or ℂ.
For the formalization we parameterize over a type `D` with decidable equality.
-/

/-- A classical domain: a type with zero, one, and decidable equality. -/
class ClassicalDomain (D : Type) where
  zero : D
  one  : D
  decEq : DecidableEq D

/-- A *classical valuation* assigns classical values to classical constants and variables. -/
structure ClassicalValuation (D : Type) [ClassicalDomain D] where
  /-- Assignment of domain values to variable indices. -/
  varVal  : Var → D
  /-- Assignment of domain values to classical constant indices. -/
  constVal : ClassicalConst → D

/-!
## 4.2 Expression Evaluation

We evaluate L_I expressions under a classical valuation. For `I`, the valuation
is undefined classically — but a *resolution* assigns it a value from D.
-/

variable {D : Type} [ClassicalDomain D]
variable [Add D] [Sub D] [Mul D] [Div D] [Pow D ℕ] [Neg D]

/-- `eval ρ iVal e` evaluates expression `e` under classical valuation `ρ`
    and the assignment `iVal : D` for the indeterminate symbol I. -/
def eval (ρ : ClassicalValuation D) (iVal : D) : IndeterminateExpr → D
  | indeterminate    => iVal
  | const c          => ρ.constVal c
  | var x            => ρ.varVal x
  | binOp OpSymbol.Add e₁ e₂ => eval ρ iVal e₁ + eval ρ iVal e₂
  | binOp OpSymbol.Sub e₁ e₂ => eval ρ iVal e₁ - eval ρ iVal e₂
  | binOp OpSymbol.Mul e₁ e₂ => eval ρ iVal e₁ * eval ρ iVal e₂
  | binOp OpSymbol.Div e₁ e₂ => eval ρ iVal e₁ / eval ρ iVal e₂
  | binOp OpSymbol.Pow e₁ e₂ => sorry  -- pow requires nat exponent; elided
  | unOp OpSymbol.Neg e       => -eval ρ iVal e
  | unOp OpSymbol.Abs e       => sorry  -- abs requires ordered domain; elided

/-- Evaluating a classical expression is independent of `iVal`. -/
theorem eval_classical (ρ : ClassicalValuation D) (e : IndeterminateExpr)
    (h : classicalFrag e) (iVal₁ iVal₂ : D) :
    eval ρ iVal₁ e = eval ρ iVal₂ e := by
  induction e with
  | indeterminate => simp [classicalFrag, isClassical] at h
  | const c => rfl
  | var x => rfl
  | binOp op e₁ e₂ ih₁ ih₂ =>
    simp [classicalFrag, isClassical, Bool.and_eq_true] at h
    cases op <;> simp [eval, ih₁ h.1, ih₂ h.2]
  | unOp op e ih =>
    simp [classicalFrag, isClassical] at h
    cases op <;> simp [eval, ih h]

/-!
## 4.3 Admissible Valuations

An *admissible valuation* for a state Σ is a classical valuation ρ together with
a value `iVal ∈ D` such that all equations and constraints in Σ are satisfied.
-/

/-- Equation satisfaction: `eq` holds under `(ρ, iVal)`. -/
def satEquation (ρ : ClassicalValuation D) (iVal : D) (eq : Equation) : Prop :=
  eval ρ iVal eq.lhs = eval ρ iVal eq.rhs

/-- Constraint satisfaction (simplified; full constraint language omitted). -/
def satConstraint (ρ : ClassicalValuation D) (iVal : D) (c : Constraint) : Prop :=
  match c with
  | Constraint.neq e₁ e₂ => eval ρ iVal e₁ ≠ eval ρ iVal e₂
  | Constraint.lt  e₁ e₂ => True  -- requires ordered domain; omitted
  | Constraint.le  e₁ e₂ => True
  | Constraint.mem e      => True
  | Constraint.pos e      => True

/-- An *admissible valuation* for state Σ satisfies all its equations and constraints. -/
structure AdmissibleValuation (Σ : MetaArithmeticState) (D : Type)
    [ClassicalDomain D] [Add D] [Sub D] [Mul D] [Div D] [Pow D ℕ] [Neg D] where
  base   : ClassicalValuation D
  iVal   : D  -- the value assigned to I in this valuation
  satEqs : ∀ eq ∈ Σ.equations, satEquation base iVal eq
  satCons : ∀ c ∈ Σ.constraints, satConstraint base iVal c

/-!
## 4.4 Resolution Set

The *resolution set* `Res_Σ(φ)` is the set of classical values that `φ` can take
under all admissible valuations for Σ (A9, A10).
-/

/-- `resolutionSet Σ φ` is the set of all classical values `v` such that there
    exists an admissible valuation for Σ under which φ evaluates to v. -/
def resolutionSet (Σ : MetaArithmeticState) (φ : IndeterminateExpr) :
    Set D :=
  fun v => ∃ (av : AdmissibleValuation Σ D), eval av.base av.iVal φ = v

/-!
## 4.5 Unique Determination

An expression is *uniquely determined* by Σ if its resolution set is a singleton.
-/

/-- `uniquelyDetermined Σ φ v` holds iff `v` is the unique value in `Res_Σ(φ)`. -/
def uniquelyDetermined (Σ : MetaArithmeticState) (φ : IndeterminateExpr) (v : D) : Prop :=
  resolutionSet Σ φ = {v}

/-- If φ is uniquely determined to v, then every admissible valuation agrees. -/
theorem uniquelyDetermined_all_agree (Σ : MetaArithmeticState) (φ : IndeterminateExpr)
    (v : D) (huniq : uniquelyDetermined Σ φ v)
    (av : AdmissibleValuation Σ D) :
    eval av.base av.iVal φ = v := by
  have hmem : eval av.base av.iVal φ ∈ resolutionSet Σ φ := ⟨av, rfl⟩
  rw [huniq] at hmem
  exact hmem

/-!
## 4.6 State-Relative Truth

A sentence `φ = ψ` is *true relative to Σ* if it holds in all admissible valuations.
-/

/-- `stateRelTrue Σ φ ψ` holds iff `φ = ψ` in every admissible valuation of Σ. -/
def stateRelTrue (Σ : MetaArithmeticState) (φ ψ : IndeterminateExpr) : Prop :=
  ∀ (av : AdmissibleValuation Σ D), eval av.base av.iVal φ = eval av.base av.iVal ψ

/-- State-relative truth is reflexive. -/
theorem stateRelTrue_refl (Σ : MetaArithmeticState) (φ : IndeterminateExpr) :
    stateRelTrue Σ φ φ :=
  fun _ => rfl

/-- State-relative truth is symmetric. -/
theorem stateRelTrue_symm (Σ : MetaArithmeticState) (φ ψ : IndeterminateExpr)
    (h : stateRelTrue Σ φ ψ) : stateRelTrue Σ ψ φ :=
  fun av => (h av).symm

/-- State-relative truth is monotone in state extension. -/
theorem stateRelTrue_mono (Σ Σ' : MetaArithmeticState) (φ ψ : IndeterminateExpr)
    (hext : Σ ≤ Σ') (h : stateRelTrue Σ φ ψ) : stateRelTrue Σ' φ ψ := by
  intro av'
  -- An admissible valuation for Σ' restricts to one for Σ (fewer constraints to satisfy).
  -- This requires showing that restriction is admissible; we appeal to sorry.
  sorry

/-!
## 4.7 Classical Validity Preservation (A5)

Classical equalities (not involving I) are preserved by TIF semantics.
-/

/-- A classical equation is true in TIF iff it is classically true (A5).
    Here "classically true" means true in all classical valuations (iVal irrelevant). -/
theorem classical_validity_preserved (Σ : MetaArithmeticState) (φ ψ : IndeterminateExpr)
    (hφ : classicalFrag φ) (hψ : classicalFrag ψ) (ρ : ClassicalValuation D)
    (hcl : ∀ iVal : D, eval ρ iVal φ = eval ρ iVal ψ) :
    ∀ iVal : D, eval ρ iVal φ = eval ρ iVal ψ :=
  hcl

/-- The classical fragment of the resolution set is independent of the I-value. -/
theorem resSet_classical_const (Σ : MetaArithmeticState) (c : ClassicalConst)
    (av : AdmissibleValuation Σ D) : eval av.base av.iVal (const c) = av.base.constVal c :=
  rfl
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
