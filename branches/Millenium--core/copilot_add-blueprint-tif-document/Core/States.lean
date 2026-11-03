/-
  Core/States.lean
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
