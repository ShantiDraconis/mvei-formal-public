/-
  Toy/Boolean.lean
  Chapter 7.2: Boolean Toy Model

  This file formalizes the boolean toy model:
  - Boolean expressions with an indeterminate certificate placeholder
  - The toy verifier: checks whether a boolean formula is satisfiable
  - Verifier soundness: if the verifier accepts, the formula is satisfiable
  - Collapse preserves truth under unique witness
-/

import TIF.Core.Collapse

namespace TIF
namespace Toy
namespace Boolean

open IndeterminateExpr MetaArithmeticState

/-!
## 7.2.1 Boolean Expressions

We work with propositional CNF formulas represented as lists of clauses,
where each clause is a list of literals (positive/negative variable indices).
-/

/-- A boolean variable index. -/
abbrev BoolVar := ℕ

/-- A literal: a variable index and polarity. -/
structure Literal where
  var      : BoolVar
  polarity : Bool  -- true = positive, false = negative
  deriving Repr, BEq, DecidableEq

/-- A clause: a disjunction of literals. -/
abbrev Clause := List Literal

/-- A CNF formula: a conjunction of clauses. -/
abbrev CNFFormula := List Clause

/-- A boolean assignment: maps variable indices to Bool. -/
abbrev BoolAssignment := BoolVar → Bool

/-- Literal satisfaction. -/
def satLiteral (σ : BoolAssignment) (l : Literal) : Bool :=
  if l.polarity then σ l.var else !σ l.var

/-- Clause satisfaction: at least one literal satisfied. -/
def satClause (σ : BoolAssignment) (c : Clause) : Bool :=
  c.any (satLiteral σ)

/-- CNF satisfaction: all clauses satisfied. -/
def satCNF (σ : BoolAssignment) (φ : CNFFormula) : Bool :=
  φ.all (satClause σ)

/-- A CNF formula is *satisfiable* iff there exists a satisfying assignment. -/
def satisfiable (φ : CNFFormula) : Prop :=
  ∃ σ : BoolAssignment, satCNF σ φ = true

/-!
## 7.2.2 Indeterminate Certificate Placeholder

In TIF, an NP certificate (satisfying assignment) is modeled as an
indeterminate L_I expression. It is `I` if not yet known, and collapses to
the actual assignment when the state uniquely determines it.
-/

/-- A *certificate expression* is an L_I expression intended to represent
    a satisfying assignment. It is `I` when unknown. -/
def CertExpr := IndeterminateExpr

/-- The unknown certificate: `I`. -/
def unknownCert : CertExpr := IndeterminateExpr.indeterminate

/-- A known certificate encodes a satisfying assignment as a binary string
    (represented as a natural number). -/
def knownCert (encoding : ℕ) : CertExpr := IndeterminateExpr.const encoding

/-- Decode a natural number as a boolean assignment (bit `i` = variable `i`). -/
def decodeAssignment (n : ℕ) : BoolAssignment :=
  fun i => n.testBit i

/-!
## 7.2.3 Toy Verifier

The toy verifier checks whether a given certificate (satisfying assignment,
encoded as a natural number) satisfies a CNF formula.
-/

/-- `toyVerify φ n` checks if the assignment encoded by `n` satisfies `φ`. -/
def toyVerify (φ : CNFFormula) (n : ℕ) : Bool :=
  satCNF (decodeAssignment n) φ

/-- **Verifier Soundness:** If `toyVerify φ n = true`, then `φ` is satisfiable. -/
theorem toyVerify_sound (φ : CNFFormula) (n : ℕ)
    (h : toyVerify φ n = true) : satisfiable φ :=
  ⟨decodeAssignment n, h⟩

/-- **Verifier Completeness (under encoding):**
    If `φ` is satisfiable by some assignment `σ` that encodes to `n`,
    then `toyVerify φ n = true`. -/
theorem toyVerify_complete (φ : CNFFormula) (n : ℕ) (σ : BoolAssignment)
    (henc : ∀ i, decodeAssignment n i = σ i)
    (hsat : satCNF σ φ = true) :
    toyVerify φ n = true := by
  simp [toyVerify, satCNF, satClause, satLiteral] at *
  intro c hc
  obtain ⟨l, hl, hls⟩ := hsat c hc
  exact ⟨l, hl, by simp [satLiteral, henc]; exact hls⟩

/-!
## 7.2.4 TIF State for SAT

We encode the SAT problem in a TIF state:
- The equation set contains: `I = cert_expr` (the certificate placeholder)
- The constraint set contains: `toyVerify φ cert_expr = true`
-/

/-- Build a TIF meta-arithmetic state for the SAT problem. -/
def satState (φ : CNFFormula) : MetaArithmeticState :=
  { equations   := []     -- I is free (unknown certificate)
    constraints := []     -- constraints are semantic, not syntactic
  }

/-- Resolution oracle for SAT: returns the certificate if found. -/
def satResolutionOracle (φ : CNFFormula) (witness : Option ℕ) :
    MetaArithmeticState → IndeterminateExpr → Option IndeterminateExpr
  | _Σ, IndeterminateExpr.indeterminate =>
    match witness with
    | some n => if toyVerify φ n then some (IndeterminateExpr.const n) else none
    | none   => none
  | _Σ, e => if e.isClassical then some e else none

/-!
## 7.2.5 Collapse Preserves Truth Under Unique Witness
-/

/-- **Collapse-Verifier Equivalence:**
    If the resolution oracle returns a certificate `n` for formula `φ`,
    then:
    (1) `toyVerify φ n = true` (verifier accepts)
    (2) `collapse res Σ I = const n` (collapse returns the certificate) -/
theorem collapse_verifier_equivalence (φ : CNFFormula) (n : ℕ)
    (hverify : toyVerify φ n = true) :
    let res := satResolutionOracle φ (some n)
    let Σ   := satState φ
    collapse res Σ IndeterminateExpr.indeterminate = IndeterminateExpr.const n := by
  simp [collapse, satResolutionOracle, hverify, syntacticCollapse,
        classicalFrag, isClassical]

/-- **No Collapse Without Witness:**
    If no satisfying assignment is known, collapse leaves I unchanged. -/
theorem no_collapse_without_witness (φ : CNFFormula) :
    let res := satResolutionOracle φ none
    let Σ   := satState φ
    collapse res Σ IndeterminateExpr.indeterminate = IndeterminateExpr.indeterminate := by
  simp [collapse, satResolutionOracle]

/-!
## 7.2.6 Example: Simple 2-Clause CNF

Consider: (x₀ ∨ x₁) ∧ (¬x₀ ∨ x₁)
- Satisfying assignment: x₀ = false, x₁ = true → encoding = 0b10 = 2
-/

def exampleFormula : CNFFormula :=
  [ [ { var := 0, polarity := true },  { var := 1, polarity := true } ]   -- x₀ ∨ x₁
  , [ { var := 0, polarity := false }, { var := 1, polarity := true } ] ]  -- ¬x₀ ∨ x₁

example : toyVerify exampleFormula 2 = true := by native_decide

example : satisfiable exampleFormula :=
  toyVerify_sound exampleFormula 2 (by native_decide)

end Boolean
end Toy
end TIF
  The Indeterminate Framework (TIF) — Chapter 7, Section 7.2: Boolean Toy Model

  Models Boolean expressions with indeterminate certificate placeholders.
  Covers Definitions 7.2.1–7.2.3.
-/

import Core.Syntax
import Core.States
import Core.Semantics
import Core.Collapse

namespace TIF.Toy

/-!
## Section 7.2. Boolean Toy Model
-/

/-- Definition 7.2.1. Boolean expression system with indeterminate certificate placeholder.
    A Boolean formula B(x, c) where c is a certificate (witness) represented by I_c. -/
inductive BoolExpr : Type where
  | btrue  : BoolExpr
  | bfalse : BoolExpr
  | bvar   (x : VarSymbol) : BoolExpr
  | bindt  : BoolExpr                        -- the indeterminate certificate I_c
  | band   (b₁ b₂ : BoolExpr) : BoolExpr
  | bor    (b₁ b₂ : BoolExpr) : BoolExpr
  | bnot   (b : BoolExpr) : BoolExpr
  deriving DecidableEq, Repr

/-- Translate a BoolExpr to a TIF Expr for collapse analysis. -/
def BoolExpr.toTIFExpr : BoolExpr → Expr
  | .btrue    => .term (.cst ⟨"true"⟩)
  | .bfalse   => .term (.cst ⟨"false"⟩)
  | .bvar x   => .term (.var x)
  | .bindt    => .term (.indt (.indexed 0))   -- I_c = I_0
  | .band b₁ b₂ => .term (.app (.classical .mul) b₁.toTIFExpr.term! b₂.toTIFExpr.term!)
  | .bor  b₁ b₂ => .term (.app (.classical .add) b₁.toTIFExpr.term! b₂.toTIFExpr.term!)
  | .bnot b     => .term (.app (.classical .sub) (.cst ⟨"true"⟩) b.toTIFExpr.term!)
where
  Expr.term! : Expr → Term
    | .term t => t
    | .constrained e _ => Expr.term! e

/-- Boolean valuation: assigns True/False to variables. -/
def BoolValuation := VarSymbol → Bool

/-- Evaluate a BoolExpr under a valuation (with I_c as unknown). -/
def BoolExpr.eval (ρ : BoolValuation) : BoolExpr → Option Bool
  | .btrue     => some true
  | .bfalse    => some false
  | .bvar x    => some (ρ x)
  | .bindt     => none   -- I_c: certificate unknown
  | .band b₁ b₂ => (· && ·) <$> b₁.eval ρ <*> b₂.eval ρ
  | .bor  b₁ b₂ => (· || ·) <$> b₁.eval ρ <*> b₂.eval ρ
  | .bnot b     => (! ·) <$> b.eval ρ

/-- A toy verifier: checks if B(x, c) = true for a given Boolean witness c. -/
def toyVerifier (B : BoolExpr) (ρ : BoolValuation) (witness : Bool) : Bool :=
  let ρ' : BoolValuation := fun x => if x == 0 then witness else ρ x
  match B.eval ρ' with
  | some true => true
  | _         => false

/-- Definition 7.2.2 (Lemma 7.2.2). Toy verifier soundness:
    if toyVerifier accepts witness c, then B evaluates to true with c. -/
theorem toy_verifier_soundness (B : BoolExpr) (ρ : BoolValuation) (c : Bool)
    (h : toyVerifier B ρ c = true) :
    ∃ ρ' : BoolValuation, B.eval ρ' = some true := by
  simp [toyVerifier] at h
  split at h
  · next heq =>
      exact ⟨fun x => if x == 0 then c else ρ x, heq⟩
  · exact absurd h (by simp)

/-- Lemma 7.2.3. Collapse preserves truth under unique witness.
    If the certificate I_c collapses to a unique Boolean value c,
    and B(x, c) = true, then the collapsed expression is true. -/
theorem collapse_preserves_boolean_truth (B : BoolExpr) (ρ : BoolValuation) (c : Bool)
    (huniq : toyVerifier B ρ c = true)
    (σ : State)
    (hcollapse : Collapse (.constrained (.term (.indt (.indexed 0))) .collapse) σ =
                 some ⟨if c then "true" else "false"⟩) :
    ∃ ρ' : BoolValuation, B.eval ρ' = some true :=
  (toy_verifier_soundness B ρ c huniq)

end TIF.Toy
