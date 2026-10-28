/-
  Core.lean — Lean 4 Formalization of the Indeterminate Framework (TIF)

  This file contains the core definitions (D1–D12) and basic theorems (T1, T4)
  of the Indeterminate Framework as described in docs/TIF_formal_summary.md.

  Status: Foundational skeleton — proofs of T2 and T3 (conservativity and
  unique collapse) are marked as `sorry` and will be completed in subsequent
  work once the operational rewriting system is fully specified.
-/

-- ============================================================
-- Section 1 – Primitive Objects and Notation
-- ============================================================

/-- D1. Indeterminate Object.
    A primitive symbol that is distinct from every classical (complex) number. -/
inductive Indeterminate : Type where
  /-- The base indeterminate I, arising from 0/0-type forms. -/
  | mk (idx : Nat) (originTag : String) : Indeterminate

/-- The canonical base indeterminate I₀ (called I in the summary). -/
def I₀ : Indeterminate := Indeterminate.mk 0 "0/0"

/-- D2. Indetermination class I_k with index k and origin tag. -/
def indClass (k : Nat) (tag : String) : Indeterminate :=
  Indeterminate.mk k tag

-- ============================================================
-- Section 2 – Syntax: Terms and Expressions
-- ============================================================

/-- D5. Terms of the extended language Term_I.
    A term is either a rational literal (representing a classical constant),
    the base indeterminate, a higher indeterminate class, or a binary
    application of an extended operator. -/
inductive Term : Type where
  /-- A rational literal representing a classical constant c ∈ ℚ ⊂ ℂ.
      Convention: the denominator must be non-zero (d ≠ 0). A zero denominator
      is not a valid classical constant; in TIF such a form would instead give
      rise to an indeterminate via A2. Fractions are not automatically reduced
      to lowest terms — semantic equality of rationals is by cross-multiplication,
      not syntactic equality of pairs. -/
  | lit   : Int → Int → Term            -- numerator / denominator (d ≠ 0)
  /-- An indeterminate symbol I_k. -/
  | indet : Indeterminate → Term
  /-- Extended addition: t₁ +_I t₂. -/
  | add   : Term → Term → Term
  /-- Extended subtraction: t₁ -_I t₂. -/
  | sub   : Term → Term → Term
  /-- Extended multiplication: t₁ ×_I t₂. -/
  | mul   : Term → Term → Term
  /-- Extended division: t₁ ÷_I t₂. -/
  | div   : Term → Term → Term

deriving instance BEq for Indeterminate
deriving instance BEq for Term

/-- Convenient notation for the base indeterminate as a Term. -/
def Term.I : Term := Term.indet I₀

/-- D7. Support of a term: the list of indeterminate indices that appear in it.
    May contain duplicates; use `Term.supportSet` (below) for a deduplicated view. -/
def Term.support : Term → List Nat
  | Term.lit _ _    => []
  | Term.indet i    => [i.idx]
  | Term.add t₁ t₂  => t₁.support ++ t₂.support
  | Term.sub t₁ t₂  => t₁.support ++ t₂.support
  | Term.mul t₁ t₂  => t₁.support ++ t₂.support
  | Term.div t₁ t₂  => t₁.support ++ t₂.support

/-- Deduplicated support: each indeterminate index appears at most once. -/
def Term.supportSet (t : Term) : List Nat :=
  t.support.eraseDups

/-- D8. A term is classical (contains no indeterminate) if its support is empty. -/
def Term.isClassical (t : Term) : Bool :=
  t.support.isEmpty

-- ============================================================
-- Section 3 – State and Collapse
-- ============================================================

/-- D6. A constraint is an equation between terms or a domain restriction.
    For the skeleton we represent it as a pair (lhs, rhs) standing for lhs = rhs. -/
structure Equation where
  lhs : Term
  rhs : Term

/-- A state Σ = (ℰ, 𝒞) pairs a set of equations with a set of constraints.
    Here both are modelled as lists for simplicity. -/
structure State where
  equations   : List Equation
  constraints : List Equation   -- inequality/domain constraints (same shape for now)

/-- The result of a collapse attempt. -/
inductive CollapseResult where
  /-- The expression collapsed to a rational value. -/
  | value   : Int → Int → CollapseResult
  /-- The expression is blocked: it contains an indeterminate and
      the state does not force a unique classical value. -/
  | blocked : Term → CollapseResult

/-- D11/A7/A8. Partial collapse function.
    For classical literals the result is immediate (T4).
    For indeterminates and compound terms we check whether the state
    forces a unique value; if not, we return `blocked`. -/
def collapse (t : Term) (σ : State) : CollapseResult :=
  match t with
  | Term.lit n d    => CollapseResult.value n d
  | Term.indet _    =>
      -- Look for an equation of the form (indet i) = (lit n d) in σ.equations.
      match σ.equations.find? (fun eq => eq.lhs == t) with
      | some ⟨_, Term.lit n d⟩ => CollapseResult.value n d
      | _                       => CollapseResult.blocked t
  | Term.add t₁ t₂  =>
      match collapse t₁ σ, collapse t₂ σ with
      | CollapseResult.value n₁ d₁, CollapseResult.value n₂ d₂ =>
          -- (n₁/d₁) + (n₂/d₂) = (n₁·d₂ + n₂·d₁) / (d₁·d₂).
          -- Fractions are not reduced; semantic rational equality uses cross-multiplication.
          CollapseResult.value (n₁ * d₂ + n₂ * d₁) (d₁ * d₂)
      | _, _ => CollapseResult.blocked t
  | Term.sub t₁ t₂  =>
      match collapse t₁ σ, collapse t₂ σ with
      | CollapseResult.value n₁ d₁, CollapseResult.value n₂ d₂ =>
          -- (n₁/d₁) - (n₂/d₂) = (n₁·d₂ - n₂·d₁) / (d₁·d₂).
          CollapseResult.value (n₁ * d₂ - n₂ * d₁) (d₁ * d₂)
      | _, _ => CollapseResult.blocked t
  | Term.mul t₁ t₂  =>
      match collapse t₁ σ, collapse t₂ σ with
      | CollapseResult.value n₁ d₁, CollapseResult.value n₂ d₂ =>
          -- (n₁/d₁) × (n₂/d₂) = (n₁·n₂) / (d₁·d₂).
          CollapseResult.value (n₁ * n₂) (d₁ * d₂)
      | _, _ => CollapseResult.blocked t
  | Term.div t₁ t₂  =>
      match collapse t₁ σ, collapse t₂ σ with
      | CollapseResult.value n₁ d₁, CollapseResult.value n₂ d₂ =>
          -- (n₁/d₁) ÷ (n₂/d₂) = (n₁·d₂) / (d₁·n₂).
          -- If n₂ = 0 the denominator d₁·n₂ = 0 is ill-formed; callers
          -- are expected to avoid this via constraints (cf. A2).
          CollapseResult.value (n₁ * d₂) (d₁ * n₂)
      | _, _ => CollapseResult.blocked t

-- ============================================================
-- Section 4 – Basic Theorems
-- ============================================================

/-- T4. Stability of the Classical Fragment.
    If a term is classical (contains no indeterminates) then collapse
    returns a value for any state. -/
theorem t4_classical_stability (t : Term) (σ : State)
    (h : t.isClassical = true) :
    ∃ n d, collapse t σ = CollapseResult.value n d := by
  simp [Term.isClassical, Term.support] at h
  induction t with
  | lit n d =>
      exact ⟨n, d, rfl⟩
  | indet i =>
      simp [Term.support] at h
  | add t₁ t₂ ih₁ ih₂ =>
      simp [Term.support, List.isEmpty_append] at h
      obtain ⟨h₁, h₂⟩ := h
      obtain ⟨n₁, d₁, hc₁⟩ := ih₁ h₁
      obtain ⟨n₂, d₂, hc₂⟩ := ih₂ h₂
      simp [collapse, hc₁, hc₂]
      exact ⟨_, _, rfl⟩
  | sub t₁ t₂ ih₁ ih₂ =>
      simp [Term.support, List.isEmpty_append] at h
      obtain ⟨h₁, h₂⟩ := h
      obtain ⟨n₁, d₁, hc₁⟩ := ih₁ h₁
      obtain ⟨n₂, d₂, hc₂⟩ := ih₂ h₂
      simp [collapse, hc₁, hc₂]
      exact ⟨_, _, rfl⟩
  | mul t₁ t₂ ih₁ ih₂ =>
      simp [Term.support, List.isEmpty_append] at h
      obtain ⟨h₁, h₂⟩ := h
      obtain ⟨n₁, d₁, hc₁⟩ := ih₁ h₁
      obtain ⟨n₂, d₂, hc₂⟩ := ih₂ h₂
      simp [collapse, hc₁, hc₂]
      exact ⟨_, _, rfl⟩
  | div t₁ t₂ ih₁ ih₂ =>
      simp [Term.support, List.isEmpty_append] at h
      obtain ⟨h₁, h₂⟩ := h
      obtain ⟨n₁, d₁, hc₁⟩ := ih₁ h₁
      obtain ⟨n₂, d₂, hc₂⟩ := ih₂ h₂
      simp [collapse, hc₁, hc₂]
      exact ⟨_, _, rfl⟩

/-- A5. Non-contradiction: the base indeterminate is not the literal 0 or 1.
    This is an axiom; we state it as a definition-level separation. -/
theorem a5_non_contradiction :
    Term.I ≠ Term.lit 0 1 ∧ Term.I ≠ Term.lit 1 1 := by
  constructor <;> simp [Term.I, Term.indet, Term.lit]

/-- A3. Composition with classical operators: two literals combine classically. -/
theorem a3_classical_composition (n₁ d₁ n₂ d₂ : Int) (σ : State) :
    collapse (Term.add (Term.lit n₁ d₁) (Term.lit n₂ d₂)) σ =
    CollapseResult.value (n₁ * d₂ + n₂ * d₁) (d₁ * d₂) := by
  simp [collapse]

-- ============================================================
-- Section 5 – Toy Model 3: Linear System with Indeterminate
-- ============================================================

/-- Toy 3. The linear system
      x + y = 1
      x - y = I
    has the symbolic solution  x = (1 + I)/2,  y = (1 - I)/2.
    We represent this by showing the two expressions add up to 1
    and subtract to I, remaining blocked without further constraints. -/

def toyX : Term :=
  Term.div (Term.add (Term.lit 1 1) Term.I) (Term.lit 2 1)

def toyY : Term :=
  Term.div (Term.sub (Term.lit 1 1) Term.I) (Term.lit 2 1)

/-- Without constraints the solution terms are blocked. -/
theorem toy3_blocked (σ : State)
    (hσ : σ.equations.find? (fun eq => eq.lhs == Term.I) = none) :
    ∃ t, collapse toyX σ = CollapseResult.blocked t := by
  simp [toyX, collapse, Term.I, hσ]
  exact ⟨_, rfl⟩

-- ============================================================
-- Section 6 – Stubs for T2 and T3 (future work)
-- ============================================================

/-- T2. Conservativity (stub).
    For any ZFC-sentence φ, 𝒯_I ⊢ φ iff ZFC ⊢ φ.
    Proof requires a full translation map; deferred to Paper 2. -/
-- theorem t2_conservativity : ... := sorry

/-- T3. Unique Collapse (stub).
    If the semantic value set is a singleton, collapse returns that value.
    Proof is by induction on term structure using rewriting completeness. -/
-- theorem t3_unique_collapse : ... := sorry
  Core.lean — The Indeterminate Framework (TIF)
  Lean 4 Core Type Skeleton (F0–F4)

  This file defines the fundamental types and functions of TIF.
  It corresponds to Levels F0 (Base Language) and F1 (Formal Ontology)
  from docs/glossary.md, plus Level F4 (Operational Syntax) from
  docs/papers/paper1_foundations.md.

  Status: Etapa 1 skeleton — types and function signatures defined;
          proofs marked as `sorry` and scheduled for Etapa 1–2.
-/

namespace TIF

-- ============================================================
-- F0 — Base Language: Types
-- ============================================================

/-- The type of indeterminate objects. Distinct from ℝ, ℂ, and all classical types. -/
inductive Indet : Type where
  /-- The base indeterminate I (canonical origin: 0/0). -/
  | base : Indet
  /-- The k-th indetermination class 𝒥_k. -/
  | cls  : Nat → Indet
  deriving Repr, DecidableEq

/-- The base indeterminate constant I = 𝒥_0. -/
def I : Indet := Indet.base

/-- The k-th indetermination class 𝒥_k. -/
def indetClass (k : Nat) : Indet :=
  if k = 0 then Indet.base else Indet.cls k

-- Verify canonical identity: 𝒥_0 = I
theorem indetClass_zero : indetClass 0 = I := rfl

-- Verify distinctness: 𝒥_k ≠ 𝒥_j for k ≠ j
theorem indetClass_distinct {k j : Nat} (h : k ≠ j) (hk : k ≠ 0) (hj : j ≠ 0) :
    indetClass k ≠ indetClass j := by
  simp [indetClass, hk, hj]
  intro h'
  exact h (Indet.cls.inj h')

-- ============================================================
-- F0.1 — Terms (Definition F0.1)
-- ============================================================

/-- Extended binary operators — total on Term_I. -/
inductive ExtOp : Type where
  | addI : ExtOp   -- +_I
  | subI : ExtOp   -- -_I
  | mulI : ExtOp   -- ×_I
  | divI : ExtOp   -- ÷_I
  deriving Repr, DecidableEq

/-- The inductive type of terms in Term_I (Definition F0.1).
    Terms can be classical rationals, variables, indeterminates,
    or composite expressions using extended operators. -/
inductive Term : Type where
  /-- A classical rational constant. -/
  | const    : Rat → Term
  /-- A named variable. -/
  | var      : String → Term
  /-- An indeterminate object (I or 𝒥_k). -/
  | indet    : Indet → Term
  /-- A composite term using an extended binary operator. -/
  | binOp    : ExtOp → Term → Term → Term
  deriving Repr

-- ============================================================
-- F0.2 — Expressions (Definition F0.2)
-- ============================================================

/-- The inductive type of expressions in Expr_I (Definition F0.2).
    Expressions extend terms with logical structure. -/
inductive Expr : Type where
  /-- A term, viewed as an expression. -/
  | term     : Term → Expr
  /-- Equality of two expressions. -/
  | eq       : Expr → Expr → Expr
  /-- Negation. -/
  | neg      : Expr → Expr
  /-- Conjunction. -/
  | conj     : Expr → Expr → Expr
  /-- Disjunction. -/
  | disj     : Expr → Expr → Expr
  /-- Implication. -/
  | impl     : Expr → Expr → Expr
  /-- Universal quantification over variables. -/
  | forallE  : String → Expr → Expr
  /-- Existential quantification over variables. -/
  | existsE  : String → Expr → Expr
  deriving Repr

-- Convenience coercion: Term → Expr
instance : Coe Term Expr := ⟨Expr.term⟩

-- ============================================================
-- F0.3 — Well-formedness (Definition F0.3)
-- ============================================================

/-- Compute the indeterminate support of a term: the set of sub-terms
    containing I or any 𝒥_k (Definition F0.5, simplified to Bool). -/
def Term.hasIndet : Term → Bool
  | .const _        => false
  | .var _          => false
  | .indet _        => true
  | .binOp _ t₁ t₂ => t₁.hasIndet || t₂.hasIndet

/-- A term is classical if it contains no indeterminate sub-terms.
    Definition F1.4 (classical expression). -/
def Term.isClassical (t : Term) : Bool := !t.hasIndet

/-- Well-formedness predicate for terms (Definition F0.3).
    Extended operators may always be used.
    Classical operators (represented here via ExtOp with classical inputs) are
    permitted only when both operands are classical. -/
def Term.wellFormed : Term → Bool
  | .const _        => true
  | .var _          => true
  | .indet _        => true
  | .binOp _ t₁ t₂ => t₁.wellFormed && t₂.wellFormed

-- (In a full formalization, classical-operator nodes would be a separate constructor
-- that checks isClassical on both operands.)

/-- Well-formedness predicate for expressions (Definition F0.3). -/
def Expr.wellFormed : Expr → Bool
  | .term t        => t.wellFormed
  | .eq e₁ e₂     => e₁.wellFormed && e₂.wellFormed
  | .neg e         => e.wellFormed
  | .conj e₁ e₂   => e₁.wellFormed && e₂.wellFormed
  | .disj e₁ e₂   => e₁.wellFormed && e₂.wellFormed
  | .impl e₁ e₂   => e₁.wellFormed && e₂.wellFormed
  | .forallE _ e   => e.wellFormed
  | .existsE _ e   => e.wellFormed

-- ============================================================
-- F0.4 — Syntactic Depth (Definition F0.4)
-- ============================================================

def Term.depth : Term → Nat
  | .const _        => 0
  | .var _          => 0
  | .indet _        => 0
  | .binOp _ t₁ t₂ => 1 + max t₁.depth t₂.depth

def Expr.depth : Expr → Nat
  | .term t        => t.depth
  | .eq e₁ e₂     => 1 + max e₁.depth e₂.depth
  | .neg e         => 1 + e.depth
  | .conj e₁ e₂   => 1 + max e₁.depth e₂.depth
  | .disj e₁ e₂   => 1 + max e₁.depth e₂.depth
  | .impl e₁ e₂   => 1 + max e₁.depth e₂.depth
  | .forallE _ e   => 1 + e.depth
  | .existsE _ e   => 1 + e.depth

-- ============================================================
-- F1.5 — Meta-Arithmetic State (Definition F1.5)
-- ============================================================

/-- A constraint on a variable: either an exact assignment or an
    approximation within tolerance ε. -/
inductive Constraint : Type where
  /-- Exact assignment: variable x = value v. -/
  | exact  : String → Rat → Constraint
  /-- Approximation: |x - v| < ε. -/
  | approx : String → Rat → Rat → Constraint  -- var, value, ε
  deriving Repr

/-- A meta-arithmetic state Σ = (ℰ, 𝒞) (Definition F1.5).
    ℰ is a list of equation pairs; 𝒞 is a list of constraints. -/
structure State : Type where
  equations   : List (Expr × Expr)
  constraints : List Constraint
  deriving Repr

/-- The empty state Σ_∅. -/
def State.empty : State := { equations := [], constraints := [] }

/-- Add a constraint to a state. -/
def State.addConstraint (σ : State) (c : Constraint) : State :=
  { σ with constraints := c :: σ.constraints }

/-- Look up the exact value of a variable in the constraint set, if any. -/
def State.exactValue (σ : State) (x : String) : Option Rat :=
  σ.constraints.findSome? fun
    | .exact y v => if x == y then some v else none
    | .approx ..  => none

-- ============================================================
-- F4 — Operational Syntax: Rewriting Step (Definition F4.1)
-- ============================================================

/-- The result of a rewriting step on a term.
    Either the term rewrites to a new term, or it is already in normal form. -/
inductive RewriteResult : Type where
  /-- The term rewrote to a new term. -/
  | rewritten : Term → RewriteResult
  /-- The term is already in normal form. -/
  | normal    : RewriteResult
  deriving Repr

/-- Apply one rewriting step to a term under a given state (Definition F4.1, Rules R1–R5).

    Rules:
      R₁ — classical reduction: if both operands are classical and the operation is safe,
            reduce to the classical value.
      R₂ — zero division: if denominator is 0 and numerator is classical, produce 𝒥_0.
      R₃ — indeterminate propagation: extended operator on indeterminate operands stays.
      R₄ — identity rules: a +_I 0 → a, a ×_I 1 → a, etc.
      R₅ — constraint substitution: substitute variable x by its exact value in state.
-/
def Term.rewriteStep (σ : State) : Term → RewriteResult
  -- R₅: substitute variable by exact constraint value
  | .var x =>
    match σ.exactValue x with
    | some v => .rewritten (.const v)
    | none   => .normal
  -- R₄: identity rules for +_I
  | .binOp .addI t (.const 0) => .rewritten t
  | .binOp .addI (.const 0) t => .rewritten t
  -- R₄: identity rules for ×_I
  | .binOp .mulI t (.const 1) => .rewritten t
  | .binOp .mulI (.const 1) t => .rewritten t
  -- R₄: zero rules for ×_I
  | .binOp .mulI _ (.const 0) => .rewritten (.const 0)
  | .binOp .mulI (.const 0) _ => .rewritten (.const 0)
  -- R₂: indeterminate origin — 0 ÷_I 0 → I
  | .binOp .divI (.const 0) (.const 0) => .rewritten (.indet .base)
  -- R₁: classical reduction for ÷_I (non-zero denominator, both classical)
  | .binOp .divI (.const n) (.const d) =>
    if d ≠ 0 then .rewritten (.const (n / d))
    else .rewritten (.indet .base)   -- R₂: n ÷ 0 → 𝒥_0
  -- R₁: classical reduction for +_I
  | .binOp .addI (.const a) (.const b) => .rewritten (.const (a + b))
  -- R₁: classical reduction for -_I
  | .binOp .subI (.const a) (.const b) => .rewritten (.const (a - b))
  -- R₃ / normal: indeterminate or complex — no further reduction here
  | _ => .normal

-- ============================================================
-- F4 — Partial Normal Form (Definition F4.2)
-- ============================================================

/-- Repeatedly apply rewriting steps to a term until no more steps apply.
    Terminates by structural induction / depth decrease (formally: via fuel). -/
def Term.normalize (σ : State) (fuel : Nat) : Term → Term
  | t =>
    match fuel with
    | 0      => t   -- fuel exhausted: return as-is
    | n + 1  =>
      match t.rewriteStep σ with
      | .rewritten t' => Term.normalize σ n t'
      | .normal       =>
        -- Recursively normalize sub-terms
        match t with
        | .binOp op t₁ t₂ =>
          let t₁' := Term.normalize σ n t₁
          let t₂' := Term.normalize σ n t₂
          -- Re-apply rewriting to the resulting composite
          let t' := Term.binOp op t₁' t₂'
          match t'.rewriteStep σ with
          | .rewritten t'' => t''
          | .normal        => t'
        | other => other

-- ============================================================
-- F4 — Collapsible Expression (Definition F4.3)
-- ============================================================

/-- A term is collapsible under state σ if it normalizes to a classical constant. -/
def Term.isCollapsible (σ : State) (t : Term) : Bool :=
  match t.normalize σ 1000 with
  | .const _ => true
  | _        => false

-- ============================================================
-- Syntactic Theorems (Etapa 1 targets)
-- ============================================================

/-- Theorem F4.T2: Rewriting preserves well-formedness. -/
theorem rewrite_preserves_wf (σ : State) (t : Term) (h : t.wellFormed = true) :
    match t.rewriteStep σ with
    | .rewritten t' => t'.wellFormed = true
    | .normal       => True := by
  simp [Term.rewriteStep, Term.wellFormed]
  split
  all_goals simp_all [Term.wellFormed]

/-- Theorem F4.T3: Classical expressions are stable under rewriting.
    (If a term has no indeterminate support and is reduced, the result is also classical.) -/
theorem classical_stable (σ : State) (t : Term) (h : t.isClassical = true) :
    match t.rewriteStep σ with
    | .rewritten t' => t'.isClassical = true
    | .normal       => True := by
  simp [Term.rewriteStep, Term.isClassical, Term.hasIndet]
  split
  all_goals simp_all [Term.isClassical, Term.hasIndet]

-- ============================================================
-- Basic Examples
-- ============================================================

section Examples

/-- Example: 0 ÷_I 0 rewrites to I in the empty state. -/
example : (Term.binOp .divI (.const 0) (.const 0)).rewriteStep State.empty
    = .rewritten (.indet .base) := rfl

/-- Example: (2/1) ÷_I (4/1) rewrites to (1/2) in the empty state. -/
example : (Term.binOp .divI (.const 2) (.const 4)).rewriteStep State.empty
    = .rewritten (.const (1/2)) := rfl

/-- Example: Variable x substitutes to its exact constraint value. -/
example : (Term.var "x").rewriteStep
    (State.empty.addConstraint (.exact "x" 3)) = .rewritten (.const 3) := rfl

end Examples

end TIF
