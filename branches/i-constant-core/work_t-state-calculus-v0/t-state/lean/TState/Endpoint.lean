import TState.Outcome

namespace TState

universe u

/-- Closed mathematical problem after all parameters and quantifiers are fixed. -/
structure ProblemSpec where
  Carrier : Type u
  admissible : Carrier → Prop
  endpoint : Carrier → Prop

/-- Candidate positive/negative classes for the endpoint. -/
structure EndpointPartition (P : ProblemSpec) where
  positive : P.Carrier → Prop
  negative : P.Carrier → Prop

def Exhaustive (P : ProblemSpec) (D : EndpointPartition P) : Prop :=
  ∀ s, P.admissible s → D.positive s ∨ D.negative s

def Exclusive (P : ProblemSpec) (D : EndpointPartition P) : Prop :=
  ∀ s, P.admissible s → ¬ (D.positive s ∧ D.negative s)

def Adequate (P : ProblemSpec) (D : EndpointPartition P) : Prop :=
  (∀ s, P.admissible s → (D.positive s ↔ P.endpoint s)) ∧
  (∀ s, P.admissible s → (D.negative s ↔ ¬ P.endpoint s))

def ValidEndpoint (P : ProblemSpec) (D : EndpointPartition P) : Prop :=
  Exhaustive P D ∧ Exclusive P D ∧ Adequate P D

structure GapWitness (P : ProblemSpec) (D : EndpointPartition P) where
  state : P.Carrier
  admissible : P.admissible state
  notPositive : ¬ D.positive state
  notNegative : ¬ D.negative state

structure OverlapWitness (P : ProblemSpec) (D : EndpointPartition P) where
  state : P.Carrier
  admissible : P.admissible state
  positive : D.positive state
  negative : D.negative state

theorem gapWitness_refutes_exhaustive
    (P : ProblemSpec) (D : EndpointPartition P)
    (w : GapWitness P D) : ¬ Exhaustive P D := by
  intro h
  rcases h w.state w.admissible with hp | hn
  · exact w.notPositive hp
  · exact w.notNegative hn

theorem overlapWitness_refutes_exclusive
    (P : ProblemSpec) (D : EndpointPartition P)
    (w : OverlapWitness P D) : ¬ Exclusive P D := by
  intro h
  exact h w.state w.admissible ⟨w.positive, w.negative⟩

end TState
