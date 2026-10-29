/-
ATK-P01-PRESERVING-UNARY-WITNESS-READ-CONTRACT-v1

Problem-specific contract for the current local blocker.

This file is an interface only. It does not assert that the contract is
inhabited. A real implementation must instantiate it with the concrete P01
machine/state types already used by the verifier construction.
-/

namespace PreservingUnaryWitnessReadContract

universe u v w

structure ReadContract
    (State : Type u)
    (Witness : Type v)
    (Frame : Type w) where
  source : State → Witness
  tail : State → List Frame
  frames : State → List Frame
  canonical : State → Prop
  stepRead : Nat → State → State
  polyBound : Nat → Nat

  preservesSource :
    ∀ (i : Nat) (s : State),
      source (stepRead i s) = source s

  preservesTail :
    ∀ (i : Nat) (s : State),
      tail (stepRead i s) = tail s

  preservesFrames :
    ∀ (i : Nat) (s : State),
      frames (stepRead i s) = frames s

  returnsCanonical :
    ∀ (i : Nat) (s : State),
      canonical s → canonical (stepRead i s)

  bounded :
    ∀ (i : Nat) (s : State),
      i ≤ polyBound i

/--
A material closure witness for the P01 local blocker.

A loop certificate alone is insufficient. The witness packages the concrete
read contract that preserves the canonical machine invariants.
-/
structure ConcreteClosureWitness
    (State : Type u)
    (Witness : Type v)
    (Frame : Type w) where
  contract : ReadContract State Witness Frame

theorem witness_is_material
    {State : Type u}
    {Witness : Type v}
    {Frame : Type w}
    (w : ConcreteClosureWitness State Witness Frame) :
    Nonempty (ReadContract State Witness Frame) :=
  ⟨w.contract⟩

end PreservingUnaryWitnessReadContract
