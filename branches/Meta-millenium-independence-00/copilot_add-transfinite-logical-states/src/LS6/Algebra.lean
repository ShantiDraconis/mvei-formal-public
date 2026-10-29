/-
# LS6 Algebra: Algebraic Operations on the Six States

This module defines the algebraic structure of LS6, including:
- Negation (duality)
- Conjunction (meet)
- Disjunction (join)
- The partial order structure
-/

import LS6.States

namespace LS6State

/-!
## Negation / Duality

The negation operation swaps dual states:
- T ↔ F (classical duality)
- I stays I (independence is self-dual)
- P ↔ Ω (transfinite duality: prime-tail vs trans-infinite)
- ∅ stays ∅ (finitist is self-dual in its universe)
-/

/-- Negation/Duality operation on states -/
def neg : LS6State → LS6State
  | Truth => Falsity
  | Falsity => Truth
  | Independence => Independence
  | PrimeTail => TransInfinite
  | TransInfinite => PrimeTail
  | Finitist => Finitist

/-- Negation is involutive -/
theorem neg_involutive (s : LS6State) : neg (neg s) = s := by
  cases s <;> rfl

instance : Neg LS6State := ⟨neg⟩

/-!
## Conjunction (Meet)

The meet operation follows these rules:
- F is the absorbing element for classical states
- ∅ is the global absorbing element (finitist collapses everything)
- T is the identity for classical states
- Non-classical states require careful handling
-/

/-- Conjunction/Meet operation -/
def meet : LS6State → LS6State → LS6State
  -- Finitist absorbs everything (no infinity means collapse)
  | Finitist, _ => Finitist
  | _, Finitist => Finitist
  -- Falsity absorbs in classical logic
  | Falsity, _ => Falsity
  | _, Falsity => Falsity
  -- Truth is identity
  | Truth, s => s
  | s, Truth => s
  -- Independence meets
  | Independence, Independence => Independence
  | Independence, PrimeTail => PrimeTail
  | Independence, TransInfinite => TransInfinite
  | PrimeTail, Independence => PrimeTail
  | TransInfinite, Independence => TransInfinite
  -- Transfinite meets
  | PrimeTail, PrimeTail => PrimeTail
  | TransInfinite, TransInfinite => TransInfinite
  | PrimeTail, TransInfinite => Independence
  | TransInfinite, PrimeTail => Independence

instance : Min LS6State := ⟨meet⟩

/-- Meet is commutative -/
theorem meet_comm (a b : LS6State) : meet a b = meet b a := by
  cases a <;> cases b <;> rfl

/-- Meet is idempotent -/
theorem meet_idem (a : LS6State) : meet a a = a := by
  cases a <;> rfl

/-!
## Disjunction (Join)

The join operation follows these rules:
- T is the absorbing element for classical states
- Ω is the global absorbing element for transfinite hierarchy
- F is the identity
-/

/-- Disjunction/Join operation -/
def join : LS6State → LS6State → LS6State
  -- Truth absorbs in classical logic
  | Truth, _ => Truth
  | _, Truth => Truth
  -- TransInfinite absorbs in transfinite hierarchy
  | TransInfinite, _ => TransInfinite
  | _, TransInfinite => TransInfinite
  -- Falsity is identity
  | Falsity, s => s
  | s, Falsity => s
  -- Finitist joins
  | Finitist, Finitist => Finitist
  | Finitist, s => s
  | s, Finitist => s
  -- Independence joins
  | Independence, Independence => Independence
  | Independence, PrimeTail => PrimeTail
  | PrimeTail, Independence => PrimeTail
  -- PrimeTail join
  | PrimeTail, PrimeTail => PrimeTail

instance : Max LS6State := ⟨join⟩

/-- Join is commutative -/
theorem join_comm (a b : LS6State) : join a b = join b a := by
  cases a <;> cases b <;> rfl

/-- Join is idempotent -/
theorem join_idem (a : LS6State) : join a a = a := by
  cases a <;> rfl

/-!
## De Morgan Laws

The algebraic structure satisfies De Morgan laws.
-/

/-- First De Morgan law: ¬(a ∧ b) = ¬a ∨ ¬b -/
theorem deMorgan1 (a b : LS6State) : neg (meet a b) = join (neg a) (neg b) := by
  cases a <;> cases b <;> rfl

/-- Second De Morgan law: ¬(a ∨ b) = ¬a ∧ ¬b -/
theorem deMorgan2 (a b : LS6State) : neg (join a b) = meet (neg a) (neg b) := by
  cases a <;> cases b <;> rfl

/-!
## Collapse Operation

The collapse operation models the "0/0" critical state transition.
When two incompatible states meet at a critical point, they collapse
to Independence or Finitist.
-/

/-- Collapse operation: models 0/0 state collapse -/
def collapse : LS6State → LS6State → LS6State
  | Truth, Falsity => Independence
  | Falsity, Truth => Independence
  | PrimeTail, TransInfinite => Independence
  | TransInfinite, PrimeTail => Independence
  | s, Finitist => Finitist
  | Finitist, s => Finitist
  | s, _ => s

/-- Collapse to Independence is symmetric for classical opposites -/
theorem collapse_classical_symmetric : collapse Truth Falsity = collapse Falsity Truth := rfl

end LS6State
