/-
# LS6: Logic of Six Meta-Mathematical States

This module defines the six logical states that extend classical and
multi-valued logic to capture mathematical statements across different
mathematical universes.

## The Six States

1. T (Truth) - True in standard ZFC models
2. F (Falsity) - False in standard ZFC models
3. I (Independence) - Independent of ZFC (coexistence of models)
4. P (Prime-Tail) - Decidable only in non-standard arithmetic
5. Ω (Trans-Infinite) - Decidable only beyond classical infinity
6. ∅ (Finitist) - State in finite/hereditarily finite models
-/

/-- The six meta-mathematical logical states -/
inductive LS6State where
  /-- Truth: φ is true in a standard ZFC model -/
  | Truth : LS6State
  /-- Falsity: φ is false in a standard ZFC model -/
  | Falsity : LS6State
  /-- Independence: φ is independent of ZFC (neither provable nor refutable) -/
  | Independence : LS6State
  /-- Prime-Tail: φ is decidable only in non-standard arithmetic models
      (aligned to prime number tails, numbers larger than any standard integer) -/
  | PrimeTail : LS6State
  /-- Trans-Infinite: φ is decidable only beyond classical infinity
      (inaccessible cardinals, Woodin cardinals, supercompact cardinals) -/
  | TransInfinite : LS6State
  /-- Finitist: φ exists only in finite/hereditarily finite models (V_ω, HF)
      where ℵ₀ does not exist -/
  | Finitist : LS6State
  deriving Repr, DecidableEq, Inhabited

namespace LS6State

/-- Notation for states -/
notation "T" => LS6State.Truth
notation "F" => LS6State.Falsity
notation "I" => LS6State.Independence
notation "P" => LS6State.PrimeTail
notation "Ω" => LS6State.TransInfinite
notation "∅ₛ" => LS6State.Finitist

/-- The classical states are T, F, I (the original 3-valued logic subset) -/
def isClassical : LS6State → Bool
  | Truth => true
  | Falsity => true
  | Independence => true
  | _ => false

/-- The transfinite states are P, Ω (require non-standard or large cardinal models) -/
def isTransfinite : LS6State → Bool
  | PrimeTail => true
  | TransInfinite => true
  | _ => false

/-- The finite state (exists only in hereditarily finite models) -/
def isFinite : LS6State → Bool
  | Finitist => true
  | _ => false

/-- Convert to a string representation -/
def toString : LS6State → String
  | Truth => "T"
  | Falsity => "F"
  | Independence => "I"
  | PrimeTail => "P"
  | TransInfinite => "Ω"
  | Finitist => "∅"

instance : ToString LS6State := ⟨toString⟩

/-- The universe level of each state:
    - Level 0: Finitist (no infinity)
    - Level 1: Classical (standard ZFC)
    - Level 2: Non-standard arithmetic
    - Level 3: Large cardinals
-/
def universeLevel : LS6State → Nat
  | Finitist => 0
  | Truth => 1
  | Falsity => 1
  | Independence => 1
  | PrimeTail => 2
  | TransInfinite => 3

end LS6State
