import TState.Endpoint
import TState.Dynamics

namespace TState

universe u

/-- A bridge certificate is the exact obligation needed to validate a proposed
binary endpoint representation. It does not assert that such a certificate
exists for any open problem. -/
structure BridgeCertificate (P : ProblemSpec) (D : EndpointPartition P) where
  exhaustive : Exhaustive P D
  exclusive : Exclusive P D
  positive_iff : ∀ s, P.admissible s → (D.positive s ↔ P.endpoint s)
  negative_iff : ∀ s, P.admissible s → (D.negative s ↔ ¬ P.endpoint s)

theorem BridgeCertificate.valid
    {P : ProblemSpec} {D : EndpointPartition P}
    (c : BridgeCertificate P D) : ValidEndpoint P D := by
  refine ⟨c.exhaustive, c.exclusive, ?_⟩
  exact ⟨c.positive_iff, c.negative_iff⟩

/-- Structural bridge from an internal state system to a problem carrier. -/
structure StateBridge (sys : StateSystem) (P : ProblemSpec) where
  observe : sys.State → P.Carrier
  preservesAdmissible :
    ∀ s, sys.admissible s → P.admissible (observe s)

/-- A kernel bridge records that K is unavoidable in the model and that
observations of K-states obey a stated invariant. -/
structure KernelBridge (sys : StateSystem) (P : ProblemSpec)
    (K : StateSet sys.State) extends StateBridge sys P where
  kernel : sys.IsKernel K
  invariant : P.Carrier → Prop
  kernel_sound :
    ∀ s, sys.admissible s → K s → invariant (observe s)

end TState
