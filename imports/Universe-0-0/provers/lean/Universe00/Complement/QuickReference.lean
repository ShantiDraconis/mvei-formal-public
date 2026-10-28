/-
Universe00/Complement/QuickReference.lean

Quick reference guide for the Universe00 Complement Foundation.

Version: 1.0.0
Date: 2025-12-31
-/

namespace Universe00.Complement.QuickReference

/-!
# Universe00 Complement Foundation - Quick Reference

## Core Types

```lean
-- Status of claims
inductive Status where
  | proved        -- Constructively proven
  | assumed       -- Explicit axiom
  | conjectural   -- Under investigation

-- Regimes (validity domains)
inductive Regime where
  | Classical        -- Standard math
  | Constructive     -- Witness-oriented
  | Meadow           -- Totalized operations
  | Paraconsistent   -- Non-explosive
  | Extreme          -- Boundary cases
  | Regularized      -- Extra assumptions

-- Outcome of sensitive operations
inductive Outcome (α : Type) where
  | value : α → Outcome α           -- Normal result
  | limit : LimitState → Outcome α  -- Informational limit

-- Limit information
structure LimitState where
  tag    : String  -- Identifying label
  reason : String  -- Explanation
```

## Outcome Operations

```lean
-- Functor map
def Outcome.map {α β : Type} (f : α → β) : Outcome α → Outcome β

-- Monad bind
def Outcome.bind {α β : Type} : Outcome α → (α → Outcome β) → Outcome β

-- Laws (PROVED)
theorem map_id : Outcome.map id = id
theorem map_comp (f : α → β) (g : β → γ) : map (g ∘ f) = map g ∘ map f
theorem bind_value : bind (value x) k = k x
theorem bind_limit : bind (limit ℓ) k = limit ℓ
```

## Sensitive Operators

```lean
-- Binary operator with regime awareness
class SensitiveBinOp (α : Type) where
  op : Regime → α → α → Outcome α

-- Unary operator with regime awareness
class SensitiveUnOp (α : Type) where
  op1 : Regime → α → Outcome α

-- Usage
def myOp (x y : α) : Outcome α :=
  SensitiveBinOp.op Regime.Classical x y
```

## The Seven Laws

### L0: Conservativity
```lean
axiom Law_Conservativity :
  ∀ (a b : α), SafeToContinue Regime.Classical →
    SensitiveBinOp.op Regime.Classical a b = 
    Outcome.value (ClassicalBinOp.cop a b)
```
**Meaning**: In Classical regime, sensitive ops = classical ops (when safe)

### L1: Limit Preservation
```lean
axiom Law_LimitPreservation :
  ∀ (D : Regime) (a b : α), ¬ SafeToContinue D →
    ∃ ℓ : LimitState, SensitiveBinOp.op D a b = Outcome.limit ℓ
```
**Meaning**: Unsafe operations return limits, never invented values

### L2: Non-explosion
```lean
axiom Law_NonExplosion :
  ∀ (Γ : Set UFormula), HasLimitObs Γ → 
    ¬ (∀ φ : UFormula, Γ ⊢ᵁ φ)
```
**Meaning**: Limit observations don't cause logical explosion

### L3: Anti-ad-hoc Regularization
```lean
axiom Law_AntiAdHoc :
  ∀ (r : Regularizer α) (D : Regime) (ℓ : LimitState) (x : α),
    r.apply D (Outcome.limit ℓ) = Outcome.value x →
    Declared r
```
**Meaning**: Turning limits into values requires declared regime

### L4: Status Discipline
```lean
axiom Law_StatusDiscipline :
  ∀ (c : Claim), c.status = Status.proved → HasArtifact c
```
**Meaning**: PROVED claims must have proof artifacts

### Gödel Hook
```lean
axiom Law_GodelHook :
  ∀ T : Theory, ConsistentT T → ExpressiveT T → ¬ CompleteT T
```
**Meaning**: Consistent + expressive theories are incomplete

### Turing Hook
```lean
axiom Law_TuringHook :
  ¬ (∃ d : Prog → Input → Bool, DecidesHalting d)
```
**Meaning**: Halting problem is undecidable

## Common Patterns

### Pattern 1: Safe Operation
```lean
instance : SensitiveBinOp ℝ where
  op regime x y :=
    match regime with
    | Regime.Classical =>
        if safe_condition x y then
          Outcome.value (classical_op x y)
        else
          Outcome.limit {tag := "Unsafe", reason := "..."}
    | _ => Outcome.limit {tag := "Unsupported", reason := "..."}
```

### Pattern 2: Chaining Operations
```lean
def chain (x y z : α) : Outcome α :=
  Outcome.bind (op1 x y) (fun r => op2 r z)
```

### Pattern 3: Declared Regularizer
```lean
def myRegularizer : Regularizer α :=
  { apply := fun regime outcome => ...
    declared_regime := Regime.Meadow  -- Must be non-Classical
  }
```

### Pattern 4: Creating Claims
```lean
def my_claim : Claim :=
  { regime := Regime.Classical
  , prop := ∀ x : α, P x
  , status := Status.proved  -- or .assumed or .conjectural
  , note := "Brief description"
  }
```

## Law Registry Access

```lean
-- All laws
def lawRegistry : List Law

-- Count laws
def lawCount : Nat := lawRegistry.length

-- Get law names
def lawNames : List String := lawRegistry.map (·.name)

-- Filter by status
def assumedLaws : List Law :=
  lawRegistry.filter (fun law => law.status == Status.assumed)
```

## Integration Points

### With Universe00.Foundations
- Compatible with `DeltaSpace` and `IConst`
- Can be used with Delta operator (Δ)
- Respects numeric classes (C_crit, C_anom, C_coll)

### With Existing Code
```lean
import Universe00.Complement.Foundation

-- Use in your own definitions
instance : SensitiveBinOp MyType where
  op := my_implementation

-- Access the laws
#check Law_Conservativity
#check lawRegistry
```

## Tips

1. **Always declare regimes explicitly** - Don't assume Classical
2. **Use Outcome.bind for chaining** - Limits propagate automatically
3. **Document limit reasons** - Make LimitState.reason descriptive
4. **Respect conservativity** - Classical regime should match classical math
5. **Tag claims with status** - Be honest about what's proved vs assumed
6. **Check law registry** - See what's already formalized

## See Also

- [Foundation.lean](Foundation.lean) - Full formalization
- [Examples.lean](Examples.lean) - Comprehensive examples
- [README.md](README.md) - Detailed documentation

-/

end Universe00.Complement.QuickReference
