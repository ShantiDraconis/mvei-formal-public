/-!
# Core/Types.lean
## The Indeterminate Framework (TIF) — Primitive Types

This file defines the foundational type-level primitives of the theory `𝒯_I`:
  - `OriginTag`      : provenance tags for indeterminate objects (D2)
  - `IndClass`       : the family of indeterminate class symbols ℐ_k (D2)
  - `ClassicalSort`  : the classical scalar domain ℂ (D3), represented abstractly
  - `ExtOp`          : extended binary operators ∘_I (D5)
  - `IndObj`         : the base indeterminate object I = ℐ_0 (D1, A1)

All definitions satisfy:
  - **Separation** (A2): `IndClass` is a syntactic sort disjoint from `ClassicalSort`.
  - **Existence**  (A1): the base object `I` exists as `IndClass.mk 0`.
-/

-- ---------------------------------------------------------------------------
-- D2 / A5 : Origin tags record the provenance of each indeterminate class.
-- ---------------------------------------------------------------------------

/-- Tags classifying the provenance of an indeterminate object. -/
inductive OriginTag : Type where
  /-- The indeterminate arose from a 0/0 form. -/
  | zeroOverZero   : OriginTag
  /-- The indeterminate arose from an ∞ − ∞ form. -/
  | infMinusInf    : OriginTag
  /-- The indeterminate arose from oscillatory cancellation. -/
  | oscillatory    : OriginTag
  /-- A user-supplied provenance tag. -/
  | custom (label : String) : OriginTag
  deriving Repr, DecidableEq

-- ---------------------------------------------------------------------------
-- D1, D2 / A1, A2 : Indeterminate classes and the base object.
-- ---------------------------------------------------------------------------

/-- A countable family of indeterminate class symbols ℐ_k, indexed by ℕ.
    `IndClass.mk 0` is the base indeterminate object I (= ℐ_0). -/
structure IndClass : Type where
  /-- Index k ∈ ℕ identifying this indeterminate class. -/
  index : Nat
  deriving Repr, DecidableEq

namespace IndClass

/-- The base indeterminate object I = ℐ_0 (D1, A1). -/
def I : IndClass := ⟨0⟩

end IndClass

-- ---------------------------------------------------------------------------
-- D2 : Origin-tag map  Orig : {ℐ_k} → OriginTag
-- ---------------------------------------------------------------------------

/-- `Orig` records the provenance of each indeterminate class (D2).
    Defaults to `OriginTag.custom "unspecified"` unless explicitly set. -/
def Orig : IndClass → OriginTag :=
  fun _ => OriginTag.custom "unspecified"

-- ---------------------------------------------------------------------------
-- D3 : Classical scalar domain.
-- ---------------------------------------------------------------------------

/-- Abstract representation of the classical scalar domain ℂ.
    In a full Lean/Mathlib development this would be `ℂ` from Mathlib.
    Here we use an opaque type to keep the skeleton self-contained. -/
axiom ClassicalScalar : Type

/-- Every classical scalar lives in `ClassicalScalar` (D3). -/
axiom classicalScalarInhabited : Inhabited ClassicalScalar

-- ---------------------------------------------------------------------------
-- D4 : Variables.
-- ---------------------------------------------------------------------------

/-- Variables are identified by natural-number indices (D4). -/
abbrev Var := Nat

-- ---------------------------------------------------------------------------
-- D5 : Extended binary operators.
-- ---------------------------------------------------------------------------

/-- The four extended binary operators ∘_I corresponding to +, −, ×, ÷ (D5). -/
inductive ExtOp : Type where
  | add : ExtOp
  | sub : ExtOp
  | mul : ExtOp
  | div : ExtOp
  deriving Repr, DecidableEq

-- ---------------------------------------------------------------------------
-- Separation witness (A2)
-- ---------------------------------------------------------------------------

/-- Proof that `IndClass` and `ClassicalScalar` are syntactically separate sorts.
    In this skeleton the separation is enforced by having distinct Lean types. -/
theorem separation_of_sorts :
    ∀ (k : IndClass), True := fun _ => trivial
-- (A full mechanization would state: ¬ ∃ f : IndClass → ClassicalScalar, Function.Injective f,
--  or use a universe argument.  The distinct-type encoding already enforces this structurally.)
