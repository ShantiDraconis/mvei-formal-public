import TState.Bridge

namespace TState

inductive ClaimShape where
  | universal
  | existential
deriving DecidableEq, Repr

def UniversalClaim (P : ProblemSpec) : Prop :=
  ∀ s, P.admissible s → P.endpoint s

def ExistentialClaim (P : ProblemSpec) : Prop :=
  ∃ s, P.admissible s ∧ P.endpoint s

def Claim : ClaimShape → ProblemSpec → Prop
  | .universal, P => UniversalClaim P
  | .existential, P => ExistentialClaim P

def AllPositive (P : ProblemSpec) (D : EndpointPartition P) : Prop :=
  ∀ s, P.admissible s → D.positive s

def AllNegative (P : ProblemSpec) (D : EndpointPartition P) : Prop :=
  ∀ s, P.admissible s → D.negative s

structure PositiveClassifiedWitness
    (P : ProblemSpec) (D : EndpointPartition P) where
  state : P.Carrier
  admissible : P.admissible state
  positive : D.positive state

structure NegativeClassifiedWitness
    (P : ProblemSpec) (D : EndpointPartition P) where
  state : P.Carrier
  admissible : P.admissible state
  negative : D.negative state

/-- For a universal target, a valid semantic bridge plus positive closure
proves the target over the full admissible carrier. -/
theorem bridge_allPositive_proves_universal
    {P : ProblemSpec} {D : EndpointPartition P}
    (c : BridgeCertificate P D) (h : AllPositive P D) :
    UniversalClaim P := by
  intro s hs
  exact (c.positive_iff s hs).mp (h s hs)

/-- For an existential target, one positively classified admissible witness
plus a valid bridge proves existence. -/
theorem bridge_positiveWitness_proves_existential
    {P : ProblemSpec} {D : EndpointPartition P}
    (c : BridgeCertificate P D)
    (w : PositiveClassifiedWitness P D) :
    ExistentialClaim P := by
  exact ⟨w.state, w.admissible, (c.positive_iff w.state w.admissible).mp w.positive⟩

/-- For a universal target, one negatively classified admissible witness
plus a valid bridge refutes the universal claim. -/
theorem bridge_negativeWitness_refutes_universal
    {P : ProblemSpec} {D : EndpointPartition P}
    (c : BridgeCertificate P D)
    (w : NegativeClassifiedWitness P D) :
    ¬ UniversalClaim P := by
  intro hall
  have hneg : ¬ P.endpoint w.state :=
    (c.negative_iff w.state w.admissible).mp w.negative
  exact hneg (hall w.state w.admissible)

/-- For an existential target, negative closure plus a valid bridge refutes
existence over the admissible carrier. -/
theorem bridge_allNegative_refutes_existential
    {P : ProblemSpec} {D : EndpointPartition P}
    (c : BridgeCertificate P D) (h : AllNegative P D) :
    ¬ ExistentialClaim P := by
  rintro ⟨s, hs, hend⟩
  have hneg : ¬ P.endpoint s :=
    (c.negative_iff s hs).mp (h s hs)
  exact hneg hend

end TState
