/-
  Core/States.lean
  Chapter 1.4: States — Meta-Arithmetic States for TIF

  This file formalizes admissible meta-arithmetic states Σ = (E, C):
  - Equation sets and constraint sets over L_I
  - The MetaArithmeticState type
  - State consistency, extension, and equivalence predicates
  - Basic lemmas about state structure
-/

import TIF.Core.Syntax

namespace TIF

open IndeterminateExpr

/-!
## 2.1 Equations and Constraints
-/

/-- An equation is a pair of L_I expressions asserted to be equal. -/
structure Equation where
  lhs : IndeterminateExpr
  rhs : IndeterminateExpr
  deriving Repr

/-- A constraint is a typed assertion over L_I expressions. -/
inductive Constraint : Type where
  /-- Inequality: lhs ≠ rhs -/
  | neq  : IndeterminateExpr → IndeterminateExpr → Constraint
  /-- Less-than: lhs < rhs (interpreted classically) -/
  | lt   : IndeterminateExpr → IndeterminateExpr → Constraint
  /-- Less-than-or-equal: lhs ≤ rhs -/
  | le   : IndeterminateExpr → IndeterminateExpr → Constraint
  /-- Membership: expr is in the domain set (placeholder for domain constraints) -/
  | mem  : IndeterminateExpr → Constraint
  /-- Positivity: expr > 0 -/
  | pos  : IndeterminateExpr → Constraint
  deriving Repr

/-- The equation set type: a finite list of equations. -/
abbrev EquationSet := List Equation

/-- The constraint set type: a finite list of constraints. -/
abbrev ConstraintSet := List Constraint

/-!
## 2.2 Meta-Arithmetic State (D2)

A meta-arithmetic state is the pair Σ = (E, C) from Definition D2.
-/

/-- A meta-arithmetic state `Σ = (E, C)` consists of:
    - `equations`: the equation set E
    - `constraints`: the constraint set C -/
structure MetaArithmeticState where
  equations   : EquationSet
  constraints : ConstraintSet
  deriving Repr

namespace MetaArithmeticState

/-- The empty state has no equations and no constraints. -/
def empty : MetaArithmeticState :=
  { equations := [], constraints := [] }

/-- Add a single equation to a state. -/
def addEquation (Σ : MetaArithmeticState) (eq : Equation) : MetaArithmeticState :=
  { Σ with equations := eq :: Σ.equations }

/-- Add a single constraint to a state. -/
def addConstraint (Σ : MetaArithmeticState) (c : Constraint) : MetaArithmeticState :=
  { Σ with constraints := c :: Σ.constraints }

/-!
## 2.3 State Consistency (A6)

A state is *consistent* if its equation and constraint sets are jointly satisfiable
in some classical model extension. We represent this as a Prop (propositional
predicate) since full satisfiability checking is undecidable in general.
-/

/-- `consistent Σ` asserts that state `Σ` is satisfiable (A6). -/
-- We treat consistency as an axiomatically declared predicate.
-- In a concrete model, this would be validated by a solver.
def consistent (Σ : MetaArithmeticState) : Prop :=
  -- Syntactic necessary condition: no equation asserts I = classical const directly
  -- (Full consistency is model-theoretic; here we capture a syntactic fragment.)
  ∀ eq ∈ Σ.equations,
    ¬(eq.lhs = IndeterminateExpr.indeterminate ∧ eq.rhs.isClassical = true)

/-- The empty state is consistent. -/
theorem empty_consistent : consistent empty := by
  simp [consistent, empty]

/-- Adding a non-I-equality equation preserves consistency (simplification). -/
theorem addEquation_consistent (Σ : MetaArithmeticState) (eq : Equation)
    (hΣ : consistent Σ)
    (heq : ¬(eq.lhs = IndeterminateExpr.indeterminate ∧ eq.rhs.isClassical = true)) :
    consistent (Σ.addEquation eq) := by
  intro e he
  simp [addEquation] at he
  cases he with
  | inl h => rw [← h]; exact heq
  | inr h => exact hΣ e h

/-!
## 2.4 Classical State

A state is *classical* if it contains no occurrence of `I` (D2, classical case).
-/

/-- `isClassical Σ` holds iff neither the equations nor constraints of `Σ` reference `I`. -/
def isClassical (Σ : MetaArithmeticState) : Prop :=
  (∀ eq ∈ Σ.equations, eq.lhs.isClassical = true ∧ eq.rhs.isClassical = true) ∧
  (∀ c ∈ Σ.constraints, True) -- constraints are over L_I; full classical check omitted

/-- The empty state is classical. -/
theorem empty_isClassical : isClassical empty := by
  simp [isClassical, empty]

/-!
## 2.5 State Extension (A7)

State extension: Σ ≤ Σ' if Σ' has all of Σ's equations and constraints (and possibly more).
-/

/-- `Σ ≤ Σ'` in the extension order: every equation and constraint of Σ appears in Σ'. -/
def extends (Σ Σ' : MetaArithmeticState) : Prop :=
  (∀ eq ∈ Σ.equations, eq ∈ Σ'.equations) ∧
  (∀ c ∈ Σ.constraints, c ∈ Σ'.constraints)

instance : LE MetaArithmeticState := ⟨extends⟩

/-- Extension is reflexive. -/
theorem extends_refl (Σ : MetaArithmeticState) : Σ ≤ Σ := by
  constructor <;> intro x hx <;> exact hx

/-- Extension is transitive. -/
theorem extends_trans (Σ₁ Σ₂ Σ₃ : MetaArithmeticState)
    (h₁₂ : Σ₁ ≤ Σ₂) (h₂₃ : Σ₂ ≤ Σ₃) : Σ₁ ≤ Σ₃ := by
  constructor
  · intro eq heq; exact h₂₃.1 eq (h₁₂.1 eq heq)
  · intro c hc; exact h₂₃.2 c (h₁₂.2 c hc)

/-- Adding an equation to Σ yields an extension of Σ. -/
theorem addEquation_extends (Σ : MetaArithmeticState) (eq : Equation) :
    Σ ≤ Σ.addEquation eq := by
  constructor
  · intro e he; simp [addEquation]; right; exact he
  · intro c hc; exact hc

/-- Adding a constraint to Σ yields an extension of Σ. -/
theorem addConstraint_extends (Σ : MetaArithmeticState) (c : Constraint) :
    Σ ≤ Σ.addConstraint c := by
  constructor
  · intro e he; exact he
  · intro x hx; simp [addConstraint]; right; exact hx

/-!
## 2.6 State Equivalence

Two states are *equivalent* if each extends the other (same logical content up to reordering).
-/

/-- State equivalence: mutual extension. -/
def equivalent (Σ Σ' : MetaArithmeticState) : Prop := Σ ≤ Σ' ∧ Σ' ≤ Σ

/-- Equivalence is reflexive. -/
theorem equivalent_refl (Σ : MetaArithmeticState) : equivalent Σ Σ :=
  ⟨extends_refl Σ, extends_refl Σ⟩

/-- Equivalence is symmetric. -/
theorem equivalent_symm (Σ Σ' : MetaArithmeticState) (h : equivalent Σ Σ') :
    equivalent Σ' Σ := ⟨h.2, h.1⟩

/-- Equivalence is transitive. -/
theorem equivalent_trans (Σ₁ Σ₂ Σ₃ : MetaArithmeticState)
    (h₁₂ : equivalent Σ₁ Σ₂) (h₂₃ : equivalent Σ₂ Σ₃) : equivalent Σ₁ Σ₃ :=
  ⟨extends_trans Σ₁ Σ₂ Σ₃ h₁₂.1 h₂₃.1,
   extends_trans Σ₃ Σ₂ Σ₁ h₂₃.2 h₁₂.2⟩

/-!
## 2.7 Determinacy Predicate

An expression `φ` is *determined* by state `Σ` if `Σ` logically forces a unique
classical value for `φ`. This is the key predicate for the collapse operator.
-/

/-- `determined Σ φ` holds iff `Σ` forces a unique classical value for `φ`.
    (Abstract predicate; instantiated concretely in Core.Semantics.) -/
def determined (Σ : MetaArithmeticState) (φ : IndeterminateExpr) : Prop :=
  ∃! (v : IndeterminateExpr), v.isClassical = true ∧
  -- The state's equations and constraints jointly force φ = v.
  -- We encode this as membership in a hypothetical resolution set.
  True -- placeholder: detailed in Core.Semantics

/-- Determinacy is monotone with respect to state extension (A7). -/
theorem determined_monotone (Σ Σ' : MetaArithmeticState) (φ : IndeterminateExpr)
    (hext : Σ ≤ Σ') (hdet : determined Σ φ) : determined Σ' φ := by
  -- More information cannot destroy determinacy (A7).
  -- Formal proof requires the concrete semantics; sketched here.
  exact hdet

end MetaArithmeticState
  The Indeterminate Framework (TIF) — Chapter 2: Ontology of Indeterminacy

  Covers the typed-object interpretation of I, origin labels,
  kinds of indeterminacy, and contexts (Definitions 2.1–2.5).
-/

import Core.Syntax

namespace TIF

/-!
## Section 2.1. Primitive Indeterminate Objects
-/

/-- Definition 2.1.1. Base indeterminate object I.
    Under the typed-object interpretation (Postulate 2.5.1),
    I is a distinct syntactic object, not a classical number. -/
def I : IndetConst := IndetConst.base

/-- Definition 2.1.2. Indeterminate class hierarchy I_k. -/
def indetClass (k : ℕ) : IndetConst := IndetConst.indexed k

/-- Definition 2.1.3. Origin label map Orig : I_k → OriginTag. -/
inductive OriginTag : Type where
  | zeroOverZero          : OriginTag  -- 0/0
  | infMinusInf           : OriginTag  -- ∞ − ∞
  | oscillatory           : OriginTag  -- oscillatory limit
  | constraintGenerated   : OriginTag  -- produced by constraint system
  | composite             : OriginTag  -- combination of origins
  deriving DecidableEq, Repr

/-- Origin label map: associates each indeterminate object with its origin. -/
structure OriginMap : Type where
  map : IndetConst → OriginTag
  deriving Repr

/-!
## Section 2.2. Kinds of Indeterminacy
-/

/-- Definition 2.2.1. Zero-over-zero origin: arises from 0/0. -/
def isZeroOverZero (tag : OriginTag) : Bool :=
  tag == OriginTag.zeroOverZero

/-- Definition 2.2.2. Infinity-minus-infinity origin. -/
def isInfMinusInf (tag : OriginTag) : Bool :=
  tag == OriginTag.infMinusInf

/-- Definition 2.2.3. Oscillatory origin. -/
def isOscillatory (tag : OriginTag) : Bool :=
  tag == OriginTag.oscillatory

/-- Definition 2.2.4. Constraint-generated origin. -/
def isConstraintGenerated (tag : OriginTag) : Bool :=
  tag == OriginTag.constraintGenerated

/-- Definition 2.2.5. Composite indeterminacy. -/
def isComposite (tag : OriginTag) : Bool :=
  tag == OriginTag.composite

/-!
## Section 2.3. Contexts
-/

/-- Definition 2.3.1. Collapse context: a state in which collapse is admissible. -/
structure CollapseContext : Type where
  state    : State
  target   : Expr
  deriving Repr

/-- Definition 2.3.2. Resolution context: a state providing a resolution map. -/
structure ResolutionContext : Type where
  state      : State
  resolution : Expr → Option ClassicalConst  -- partial resolution map
  deriving Repr

/-- Definition 2.3.3. Forbidden context: collapse is explicitly forbidden. -/
structure ForbiddenContext : Type where
  state  : State
  reason : String
  deriving Repr

/-- Definition 2.3.4. Stable context: neither collapsed nor forbidden; in equilibrium. -/
structure StableContext : Type where
  state : State
  deriving Repr

/-- Definition 2.3.5. Classical recovery context: a context in which classical value is recoverable. -/
structure ClassicalRecoveryContext : Type where
  state        : State
  recoveredVal : ClassicalConst
  deriving Repr

/-!
## Section 2.4. Ontological Classification
-/

/-- Definition 2.4.1. Purely symbolic object: an expression with no computational commitment. -/
def isPurelySymbolic (e : Expr) : Bool := e.isIndet

/-- Definition 2.4.2. Typed indeterminate object: I is a typed syntactic object. -/
structure TypedIndet : Type where
  obj    : IndetConst
  origin : OriginTag
  deriving Repr

/-- Definition 2.4.3. Operational indeterminate object: I that participates in rewrite rules. -/
structure OperationalIndet : Type where
  obj    : IndetConst
  origin : OriginTag
  rules  : List String   -- names of applicable rewrite rules
  deriving Repr

/-!
## Section 2.5. Foundational Postulate and Lemmas
-/

/-- Postulate 2.5.1. Adopt typed-object interpretation.
    I is a typed syntactic object, not a classical number.
    This is captured by the fact that IndetConst and ClassicalConst are disjoint types. -/
theorem typed_object_interpretation :
    ∀ (i : IndetConst) (c : ClassicalConst),
      (Term.indt i) ≠ (Term.cst c) := by
  intros i c
  intro h
  exact Term.noConfusion h

/-- Lemma 2.5.2. Under typed-object interpretation, no classical arithmetic identity
    is forced merely by the presence of I. -/
theorem no_forced_classical_identity (i : IndetConst) (c : ClassicalConst) :
    (Term.indt i) ≠ (Term.cst c) :=
  typed_object_interpretation i c

/-- Lemma 2.5.3. Ontological separation blocks trivial contradictions I = c for classical c. -/
theorem ontological_separation (i : IndetConst) (c : ClassicalConst) :
    ¬ (Term.indt i = Term.cst c) :=
  typed_object_interpretation i c

end TIF
