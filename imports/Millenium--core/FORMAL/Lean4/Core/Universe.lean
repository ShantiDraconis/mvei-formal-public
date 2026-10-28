-- FORMAL/Lean4/Core/Universe.lean
-- Core type definitions for the Indeterminate Framework T_I.
-- This file encodes the ontological layer (FOUNDATIONS/ontology.tex)
-- and the semantic layer (FOUNDATIONS/semantics.tex) as Lean 4 types.
--
-- v1.1 changes:
--   - Added Expr inductive type with var constructor (per syntax.tex).
--   - Added VarValuation and IndetValuation as separate types.
--   - Collapse typed as Expr -> Option ℝ (i.e., C ∪ {bot}).
--   - UI remains the semantic universe; Expr is the syntactic layer.

import Mathlib.Data.Real.Basic

-- ℝ has DecidableEq via classical logic in Mathlib, which gives us BEq ℝ.
noncomputable instance : DecidableEq ℝ := Classical.typeDecidableEq ℝ

/-!
# The Universe U_I and Expression Language

We define two distinct layers:

1. `UI` — the semantic universe, the extended set of values:
   - `Real r` : classical real number
   - `Ind`    : the indeterminate element I (of indeterminate sort)
   - `Meta`   : meta-arithmetic states (0_I, ∞_I)
   - `Undef`  : undecidable state U

2. `Expr` — the syntactic expression language (FOUNDATIONS/syntax.tex):
   - `var`   : a variable symbol
   - `const` : a classical constant
   - `indet` : an indeterminate symbol (sort: IndetClass)
   - `add`, `sub`, `mul`, `div` : extended operators

Valuations are pairs `(VarValuation, IndetValuation)`.
Collapse is typed as `Expr → Option ℝ` (ℝ ∪ {⊥}).
-- Core type definition for the Indeterminate Framework U_I.
-- This file encodes the ontological layer (FOUNDATIONS/ontology.tex)
-- as a Lean 4 inductive type.

import Mathlib.Data.Real.Basic

/-!
# The Universe U_I

We define the extended universe `UI` as an inductive type with four
constructors corresponding to the four ontological categories:
- `Real r` : classical real number
- `Ind`    : the indeterminate element I = 0/0
- `Meta`   : meta-arithmetic states (0_I, ∞_I)
- `Undef`  : undecidable state U
-/

namespace MillenniumCore

/-! ## Semantic Universe UI -/

/-- Meta-arithmetic states beyond I. -/
inductive MetaState
  | Zero   : MetaState   -- 0_I
  | Infty  : MetaState   -- ∞_I

/-- The extended universe U_I. -/
inductive UI
  | Real  : ℝ → UI          -- classical real numbers
  | Ind   : UI               -- the indeterminate element I
  | Meta  : MetaState → UI   -- meta-arithmetic states
  | Undef : UI               -- undecidable state U

namespace UI

/-- Notations -/
notation "𝕀" => UI.Ind
notation "𝟘ᵢ" => UI.Meta MetaState.Zero
notation "∞ᵢ" => UI.Meta MetaState.Infty

/-- Classical embedding ι : ℝ → UI. -/
def ofReal (r : ℝ) : UI := UI.Real r

instance : Coe ℝ UI := ⟨ofReal⟩

/-- I is not a real number. -/
theorem ind_not_real (r : ℝ) : UI.Ind ≠ UI.Real r := by
  intro h; cases h

/-- Classical elements are distinct from I. -/
theorem real_ne_ind (r : ℝ) : UI.Real r ≠ UI.Ind := by
  intro h; cases h

/-! ## Extended Arithmetic Operations -/

/-- Extended addition. -/
def add : UI → UI → UI
  | Real a,  Real b  => Real (a + b)
  | Ind,     _       => Ind
  | _,       Ind     => Ind
  | Meta m,  _       => Meta m   -- conservative stub
  | _,       Meta m  => Meta m
  | Undef,   _       => Undef
  | _,       Undef   => Undef

/-- Extended multiplication. -/
def mul : UI → UI → UI
  | Real a,  Real b  => Real (a * b)
  | Ind,     _       => Ind
  | _,       Ind     => Ind
  | Meta m,  _       => Meta m
  | _,       Meta m  => Meta m
  | Undef,   _       => Undef
  | _,       Undef   => Undef

/-- Extended division — the key operation.
    0 / 0 is NOT asserted equal to I by a global identity;
    the origin-marking rule in FOUNDATIONS/axioms.tex A2 applies
    only relative to a state. Here we record the semantic domain
    value for the UI universe. -/
def div : UI → UI → UI
  | Real a,  Real b  =>
      if b = 0 then
        if a = 0 then Ind          -- zero-over-zero: indeterminate
    0 / 0 = I  (the fundamental collapse rule) -/
def div : UI → UI → UI
  | Real a,  Real b  =>
      if b = 0 then
        if a = 0 then Ind          -- 0/0 = I
        else Meta MetaState.Infty  -- a/0 = ∞_I for a ≠ 0
      else Real (a / b)            -- classical division
  | Ind,     _       => Ind
  | _,       Ind     => Ind
  | Meta m,  _       => Meta m
  | _,       Meta m  => Meta m
  | Undef,   _       => Undef
  | _,       Undef   => Undef

infixl:65 " +ᵢ " => add
infixl:70 " *ᵢ " => mul
infixl:70 " /ᵢ " => div

/-! ## Key Theorems -/

/-- The fundamental collapse: 0/0 = I. -/
theorem zero_div_zero : UI.Real 0 /ᵢ UI.Real 0 = 𝕀 := by
  simp [div]

/-- Classical recovery: for b ≠ 0, Real a / Real b = Real (a/b). -/
theorem classical_div (a b : ℝ) (hb : b ≠ 0) :
    UI.Real a /ᵢ UI.Real b = UI.Real (a / b) := by
  simp [div, hb]

/-- I is not zero. -/
theorem ind_ne_zero : 𝕀 ≠ UI.Real 0 := by
  intro h; cases h

/-- Classical addition is preserved. -/
theorem classical_add (a b : ℝ) :
    UI.Real a +ᵢ UI.Real b = UI.Real (a + b) := by
  simp [add]

end UI

/-! ## Syntactic Expression Layer -/

/-- Indeterminate symbol tags: one per distinct indeterminate constant in L_I.
    Covers all symbols listed in FOUNDATIONS/syntax.tex (alphabet section). -/
inductive IndetClass
  | I0    : IndetClass   -- I  — the principal indeterminate (zero-over-zero)
  | ZeroI : IndetClass   -- 0_I — indeterminate zero
  | InfI  : IndetClass   -- ∞_I — indeterminate infinity
  | UndefI : IndetClass  -- U   — undecidable / undetermined state
  deriving Repr, DecidableEq

/-- The syntactic expression type for L_I (FOUNDATIONS/syntax.tex).
    Variables are first-class; indeterminate symbols have an IndetClass tag. -/
inductive Expr where
  | var   : String → Expr               -- variable symbol x, y, z, …
  | const : ℝ → Expr                    -- classical constant
  | indet : IndetClass → Expr           -- indeterminate symbol (I, …)
  | mark  : IndetClass → Expr → Expr    -- origin-marked indeterminate form
  | add   : Expr → Expr → Expr          -- extended addition +_I
  | sub   : Expr → Expr → Expr          -- extended subtraction -_I
  | mul   : Expr → Expr → Expr          -- extended multiplication ×_I
  | div   : Expr → Expr → Expr          -- extended division ÷_I
  deriving Repr, Inhabited

/-! ## Valuations -/

/-- Variable valuation: total map from variable names to classical values. -/
abbrev VarValuation := String → ℝ

/-- Indeterminate valuation: partial map from IndetClass to classical values.
    `none` means the indeterminate symbol is not resolved in the current state. -/
abbrev IndetValuation := IndetClass → Option ℝ

/-- An admissible valuation for a state is a pair (v, η). -/
structure Valuation where
  varVal   : VarValuation
  indetVal : IndetValuation

/-! ## Evaluation and Semantic Collapse -/

/-- Evaluate an Expr under a valuation.
    Returns `none` when an indeterminate symbol is not resolved,
    when division by zero occurs, or for origin-marked forms. -/
def Expr.eval (val : Valuation) : Expr → Option ℝ
  | Expr.var x         => some (val.varVal x)
  | Expr.const c       => some c
  | Expr.indet cls     => val.indetVal cls
  | Expr.mark _ _      => none            -- origin-marked: no classical value in isolation
  | Expr.add e1 e2     =>
      (Expr.eval val e1).bind fun a =>
      (Expr.eval val e2).map  fun b => a + b
  | Expr.sub e1 e2     =>
      (Expr.eval val e1).bind fun a =>
      (Expr.eval val e2).map  fun b => a - b
  | Expr.mul e1 e2     =>
      (Expr.eval val e1).bind fun a =>
      (Expr.eval val e2).map  fun b => a * b
  | Expr.div e1 e2     =>
      (Expr.eval val e1).bind fun a =>
      (Expr.eval val e2).bind fun b =>
      if b = 0 then none else some (a / b)

/-- Semantic collapse relative to a list of admissible valuations.
    Computes agreement over the set of *defined* evaluations only:
    admissible valuations where `Expr.eval` returns `none` do not contribute
    a semantic value. Returns the unique classical value if all defined
    evaluations agree, or `none` (i.e. ⊥) otherwise.

    Type: Expr → Option ℝ  (i.e. ℝ ∪ {⊥}) as required by semantics.tex.

    Matches FOUNDATIONS/semantics.tex Definition of Unique Resolution:
      |⟦e⟧_Σ| = 1  ↔  all defined evaluations agree on the same c. -/
def collapse (admissible : List Valuation) (e : Expr) : Option ℝ :=
  let definedVals : List ℝ := admissible.filterMap (fun v => Expr.eval v e)
  match definedVals with
  | []      => none   -- no admissible valuation resolves e: blocked
  | c :: cs =>
    if cs.all (fun d => d == c)
    then some c       -- all defined evaluations agree on c: unique resolution
    else none         -- multiple defined values possible: blocked

end MillenniumCore
