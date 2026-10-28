import TState.Outcome
import Mathlib.Logic.Relation

namespace TState

universe u

/-- Generic state-transition system used by transversal test T. -/
structure StateSystem where
  State : Type u
  admissible : State → Prop
  step : State → State → Prop
  initial : State → Prop
  terminal : State → Prop

namespace StateSystem

def Reachable (sys : StateSystem) (a b : sys.State) : Prop :=
  Relation.ReflTransGen sys.step a b

/-- K is a structural separator when every reachable initial-to-terminal pair
admits a K-state between its endpoints. -/
def IsKernel (sys : StateSystem) (K : StateSet sys.State) : Prop :=
  ∀ {a b : sys.State},
    sys.initial a →
    sys.terminal b →
    sys.Reachable a b →
    ∃ k : sys.State, K k ∧ sys.Reachable a k ∧ sys.Reachable k b

/-- Infinite trajectory; finite trajectories can be padded at a terminal state. -/
structure Trajectory (sys : StateSystem) where
  state : ℕ → sys.State
  respects : ∀ n, sys.step (state n) (state (n + 1))

def FirstHit (sys : StateSystem) (K : StateSet sys.State)
    (γ : Trajectory sys) (n : ℕ) : Prop :=
  K (γ.state n) ∧ ∀ m < n, ¬ K (γ.state m)

theorem firstHit_unique (sys : StateSystem) (K : StateSet sys.State)
    (γ : Trajectory sys) {m n : ℕ}
    (hm : FirstHit sys K γ m) (hn : FirstHit sys K γ n) : m = n := by
  rcases hm with ⟨hmK, hmFirst⟩
  rcases hn with ⟨hnK, hnFirst⟩
  by_contra hne
  rcases lt_or_gt_of_ne hne with hmn | hnm
  · exact (hnFirst m hmn) hmK
  · exact (hmFirst n hnm) hnK

end StateSystem
end TState
